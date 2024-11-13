const User = require('../model/user.model');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const errorHandler = require('../utils/error');
var nodemailer = require('nodemailer');

const signup = async (req, res, next) => {
  try {
    console.log('req.query')
    console.log(req.body)
    console.log('req.query')

    const {
      firstName,
      lastName,
      email,
      password,
      numTel,
      lat,
      lng,
      admin,
    } = req.body
    const profilePicture = req.file ? req.file.path : null
    const hashedPassword = bcryptjs.hashSync(password, 10)
    const newUser = new User({
      firstName,
      lastName,
      email,
      password: hashedPassword,
      numTel,
      lat,
      lng,
      admin,
      profilePicture,
    })
    await newUser.save()
    res.status(201).json({ success: true, message: 'user created successfully' })
  }
  catch (error) {
    console.log('field')
    console.log(error)
    console.log('field')
    if (error.code === 11000) {
      // Duplicate key error
      const field = Object.keys(error.keyValue)[0]

      const message = field === 'email' ? 'Email already exists' : 'Username already exists';
      console.log(message)

      res.status(400).json({ success: false, message: message })
    }
    else {
      console.log(error.message)
      next(error)
    }
  }
}

const signin = async (req, res, next) => {
  console.log(req.body)
  const { email, password } = req.body
  try {
    console.log(email)
    const validUser = await User.findOne({ email: email })
    if (!validUser) return next(errorHandler(404, 'User not Found'))

    const validPassword = bcryptjs.compareSync(password, validUser.password)
    if (!validPassword) return next(errorHandler(401, 'Wrong credentials'))

    const { password: hashedPassword, ...rest } = validUser._doc

    const token = jwt.sign(rest, process.env.JWT_SECRET, { expiresIn: "1h" })

    console.log("this is our token :", token);

    if (password) {
      console.log({ token: token })
      res.status(200).json({ token: token })
    }
    else {
      console.log({ token: token, connectionMethod: 'google' })
      res.status(200).json({ token: token, connectionMethod: 'google' })
    }
  }
  catch (error) {
    next(error)
  }
}

const google = async (req, res, next) => {
  try {
    const user = await User.findOne({ email: req.body.email })

    if (user != null) {
      const { password: hashedPassword, ...rest } = user._doc
      const token = jwt.sign(rest, process.env.JWT_SECRET, { expiresIn: "1h" })

      console.log(user._doc.password)
      // Set the cookie and respond with user data
      console.log('//////////////////')
      if (user._doc.password != null) {
        console.log({ token: token })
        res.status(200).json({ token: token })
      }
      else {
        console.log({ token: token, connectionMethod: 'google' })
        res.status(200).json({ token: token, connectionMethod: 'google' })
      }
      console.log('//////////////////')
      console.log('Token created successfully for existing user:', token)
    }
    else {
      const newUser = new User({
        firstName: req.body.firstName,
        email: req.body.email,
        profilePicture: req.body.profilePicture,
        admin: req.body.admin,
      })

      await newUser.save()
      console.log('newUser')
      console.log(newUser)
      console.log('newUser')
      console.log(newUser._doc);
      const token = jwt.sign(newUser._doc, process.env.JWT_SECRET, { expiresIn: "1h" })
      res.status(200).json({ token: token, connectionMethod: 'google' })
    }
  } catch (error) {
    console.log(error)
    next(error)
  }
}



var verificationCode;
const forgotpassword = async (req, res, next) => {
  try {
    const { email } = req.body
    if (!email) {
      return res.status(400).send({ Status: 'Email is required' })
    }
    const user = await User.findOne({ email })
    if (!user) {
      return next(errorHandler(404, 'User not Found'))
    }

    //verification code : 
    verificationCode = Math.floor(1000 + Math.random() * 9000);

    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '1h', });

    var transporter = nodemailer.createTransport({
      service: 'gmail',
      host: 'smtp.gmail.com',
      port: 587,
      secure: false, // true for 465 , false for other ports
      auth: {
        user: 'belloumiaziz1@gmail.com',
        pass: 'zwfe slxu optj krpy',
      },
    })
    var mailOptions = {
      from: {
        name: 'aziz',
        adress: 'belloumiaziz1@gmail.com',
      },
      to: email,
      subject: 'Reset your password',
      text: `here's your verification code : ${verificationCode}`,
    }

    // Send the email
    await transporter.sendMail(mailOptions);
    console.log('Email sent successfully');
    return res.status(200).json({ Status: 'Success', Message: 'Password reset email sent', token: token });

  } catch (error) {
    console.error('Error in forgotpassword function:', error);

    // Handle specific errors
    if (error instanceof jwt.JsonWebTokenError) {
      return res.status(500).send({ Status: 'Error', Message: 'Token generation failed' });
    } else if (error.code === 'ECONNREFUSED') {
      return res.status(500).send({ Status: 'Error', Message: 'Email service not reachable' });
    } else if (error.message.includes('Invalid login')) {
      return res.status(500).send({ Status: 'Error', Message: 'Email or password for email service is incorrect' });
    } else if (error.message.includes('sendMail')) {
      return res.status(500).send({ Status: 'Error', Message: 'Failed to send email. Please try again later' });
    } else {
      return res.status(500).send({ Status: 'Error', Message: 'Internal server error' });
    }

  }
}

const verifyCode = (req, res) => {
  const { code, token } = req.body;
  try {
    jwt.verify(token, process.env.JWT_SECRET, async (err, decoded) => {
      if (err) {
        res.status(400).json({ Status: 'Error with token', message: 'Invalid or expired token.' });
      }
      else if (code == verificationCode) {
        const userId = decoded.id
        console.log(userId)
        res.status(200).json({ Status: "code is verified", id: userId })
      }
      else {
        res.status(400).json({ Status: "Wrong code , try again" })
      }
    });
  }
  catch (err) {
    res.status(500).json({ Status: 'Error', message: 'An unexpected error occurred. Please try again later.' });
  }

}

const resetPassword = async (req, res, next) => {
  const { password, id } = req.body;

  try {
    // Hash the new password
    const hashedPassword = await bcryptjs.hash(password, 10);

    // Update the user's password
    const user = await User.findByIdAndUpdate(id, { password: hashedPassword }, { new: true });

    if (!user) {
      res.status(404).json({ Status: 'Error', message: 'User not found.' });
    }

    res.status(200).json({ Status: 'Success', message: 'Password reseted successful.' });
  }
  catch (err) {
    console.error('Error resetting password:', err);
    res.status(500).json({ Status: 'Error', message: 'An unexpected error occurred. Please try again later.' });
  }
};


const facebook = async (req, res, next) => {
  try {
    const user = await User.findOne({ email: req.body.email })

    if (user != null) {
      const { password: hashedPassword, ...rest } = user._doc
      const token = jwt.sign(rest, process.env.JWT_SECRET, { expiresIn: "1h" })

      console.log(user._doc.password)
      // Set the cookie and respond with user data
      console.log('//////////////////')
      if (user._doc.password != null) {
        console.log({ token: token })
        res.status(200).json({ token: token })
      }
      else {
        console.log({ token: token, connectionMethod: 'facebook' })
        res.status(200).json({ token: token, connectionMethod: 'facebook' })
      }
      console.log('//////////////////')
      console.log('Token created successfully for existing user:', token)
    }
    else {
      const newUser = new User({
        firstName: req.body.firstName,
        email: req.body.email,
        profilePicture: req.body.profilePicture,
        admin: req.body.admin,
      })

      await newUser.save()
      console.log('newUser')
      console.log(newUser)
      console.log('newUser')
      console.log(newUser._doc);
      const token = jwt.sign(newUser._doc, process.env.JWT_SECRET, { expiresIn: "1h" })
      res.status(200).json({ token: token, connectionMethod: 'facebook' })
    }
  } catch (error) {
    console.log(error)
    next(error)
  }
}


module.exports = {
  signup,
  signin,
  google,
  forgotpassword,
  verifyCode,
  resetPassword,
  facebook
}
