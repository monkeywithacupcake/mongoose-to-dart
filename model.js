// model.js
// this is the mongoose model for test
// assume it is from a larger project

var mongoose = require('mongoose');
var bcrypt   = require('bcrypt-nodejs');

const userSchema = mongoose.Schema({
    email: {
        type: String,
        required: true,
        unique: true
      },
    password: { type: String },
    name: { type: String},
    colors: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Color',
            required: true
        }
    ]
});

// methods ======================
// generating a hash
userSchema.methods.generateHash = function(password) {
    return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

// checking if password is valid
userSchema.methods.validPassword = function(password) {
    return bcrypt.compareSync(password, this.password);
};

// create the model for users and expose it to our app
module.exports = mongoose.model('User', userSchema);
