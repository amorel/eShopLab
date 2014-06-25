using eShopLab.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using WebMatrix.WebData;

namespace eShopLab.Provider
{
    public class CustomMembershipProvider : ExtendedMembershipProvider
    {
        public override bool ConfirmAccount(string accountConfirmationToken)
        {
            throw new NotImplementedException();
        }

        public override bool ConfirmAccount(string userName, string accountConfirmationToken)
        {
            throw new NotImplementedException();
        }

        public override string CreateAccount(string userName, string password, bool requireConfirmationToken)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// Create an account
        /// </summary>
        /// <param name="newUser">New user to create</param>
        /// <param name="errors">list of errors</param>
        /// <returns></returns>
        public bool CreateAccount(RegisterViewModel newUser, out List<string> errors, out User user)
        {
            using (eShopDBEntities db = new eShopDBEntities())
            {
                user = new User();
                errors = new List<string>();
                try
                {
                    bool valid = true;
                    if (GetUser(newUser.UserName) != null)
                    {
                        errors.Add("The user name " + newUser.UserName + " exists !");
                        valid = false;
                    }
                    if (GetEmail(newUser.Email) != null)
                    {
                        errors.Add("The email " + newUser.Email + " exists !");
                        valid = false;
                    }
                    if (valid)
                    {
                        string salt = GenerateSalt();
                        user = new User()
                        {
                            UserUsername = newUser.UserName.Trim(),
                            UserPassword = MD5Hash(newUser.Password + salt),
                            UserEmail = newUser.Email,
                            UserRegisterDate = DateTime.Now,
                            UserLastLoginDate = DateTime.Now,
                            UserSalt = salt
                        };
                        db.Users.Add(user);
                        db.SaveChanges();
                    }
                    return valid;
                }
                catch (Exception e)
                {
                    return false;
                }
            }
        }

        /// <summary>
        /// Generate salt
        /// </summary>
        /// <returns></returns>
        public string GenerateSalt()
        {
            int lng = 10;
            string salt = Guid.NewGuid().ToString();
            if (lng >= salt.Length)
                return salt;
            return salt.Substring(salt.Length - lng);
        }

        /// <summary>
        /// Generate MD5 hash
        /// </summary>
        /// <param name="text">text to hash</param>
        /// <returns>MD5 hash</returns>
        public string MD5Hash(string text)
        {
            MD5 md5 = new MD5CryptoServiceProvider();

            //compute hash from the bytes of text
            md5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(text));

            //get hash result after compute it
            byte[] result = md5.Hash;

            StringBuilder strBuilder = new StringBuilder();
            for (int i = 0; i < result.Length; i++)
            {
                //change it into 2 hexadecimal digits
                //for each byte
                strBuilder.Append(result[i].ToString("x2"));
            }

            return strBuilder.ToString();
        }

        public override string CreateUserAndAccount(string userName, string password, bool requireConfirmation, IDictionary<string, object> values)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteAccount(string userName)
        {
            throw new NotImplementedException();
        }

        public override string GeneratePasswordResetToken(string userName, int tokenExpirationInMinutesFromNow)
        {
            throw new NotImplementedException();
        }

        public override ICollection<OAuthAccountData> GetAccountsForUser(string userName)
        {
            throw new NotImplementedException();
        }

        public override DateTime GetCreateDate(string userName)
        {
            throw new NotImplementedException();
        }

        public override DateTime GetLastPasswordFailureDate(string userName)
        {
            throw new NotImplementedException();
        }

        public override DateTime GetPasswordChangedDate(string userName)
        {
            throw new NotImplementedException();
        }

        public override int GetPasswordFailuresSinceLastSuccess(string userName)
        {
            throw new NotImplementedException();
        }

        public override int GetUserIdFromPasswordResetToken(string token)
        {
            throw new NotImplementedException();
        }

        public override bool IsConfirmed(string userName)
        {
            throw new NotImplementedException();
        }

        public override bool ResetPasswordWithToken(string token, string newPassword)
        {
            throw new NotImplementedException();
        }

        public override string ApplicationName
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
        }

        public override bool ChangePassword(string username, string oldPassword, string newPassword)
        {
            throw new NotImplementedException();
        }

        public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
        {
            throw new NotImplementedException();
        }

        public override System.Web.Security.MembershipUser CreateUser(string username, string password, string email, string passwordQuestion, string passwordAnswer, bool isApproved, object providerUserKey, out System.Web.Security.MembershipCreateStatus status)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteUser(string username, bool deleteAllRelatedData)
        {
            throw new NotImplementedException();
        }

        public override bool EnablePasswordReset
        {
            get { throw new NotImplementedException(); }
        }

        public override bool EnablePasswordRetrieval
        {
            get { throw new NotImplementedException(); }
        }

        public override System.Web.Security.MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override System.Web.Security.MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override System.Web.Security.MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override int GetNumberOfUsersOnline()
        {
            throw new NotImplementedException();
        }

        public override string GetPassword(string username, string answer)
        {
            throw new NotImplementedException();
        }

        public override System.Web.Security.MembershipUser GetUser(string username, bool userIsOnline)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// Return the user with certain user name if exists.
        /// </summary>
        /// <param name="username">user name</param>
        /// <returns>user found</returns>
        public User GetUser(string username)
        {
            using (eShopDBEntities db = new eShopDBEntities())
            {
                return db.Users.Where(u => u.UserUsername == username).FirstOrDefault();
            }
        }

        /// <summary>
        /// Return the user with certain email if exists. 
        /// </summary>
        /// <param name="email">email</param>
        /// <returns>user found</returns>
        public User GetEmail(string email)
        {
            using (eShopDBEntities db = new eShopDBEntities())
            {
                return db.Users.Where(u => u.UserEmail == email).FirstOrDefault();
            }
        }

        public override System.Web.Security.MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            throw new NotImplementedException();
        }

        public override string GetUserNameByEmail(string email)
        {
            throw new NotImplementedException();
        }

        public override int MaxInvalidPasswordAttempts
        {
            get { throw new NotImplementedException(); }
        }

        public override int MinRequiredNonAlphanumericCharacters
        {
            get { throw new NotImplementedException(); }
        }

        public override int MinRequiredPasswordLength
        {
            get { throw new NotImplementedException(); }
        }

        public override int PasswordAttemptWindow
        {
            get { throw new NotImplementedException(); }
        }

        public override System.Web.Security.MembershipPasswordFormat PasswordFormat
        {
            get { throw new NotImplementedException(); }
        }

        public override string PasswordStrengthRegularExpression
        {
            get { throw new NotImplementedException(); }
        }

        public override bool RequiresQuestionAndAnswer
        {
            get { throw new NotImplementedException(); }
        }

        public override bool RequiresUniqueEmail
        {
            get { throw new NotImplementedException(); }
        }

        public override string ResetPassword(string username, string answer)
        {
            throw new NotImplementedException();
        }

        public override bool UnlockUser(string userName)
        {
            throw new NotImplementedException();
        }

        public override void UpdateUser(System.Web.Security.MembershipUser user)
        {
            throw new NotImplementedException();
        }

        public override bool ValidateUser(string username, string password)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// Return if user exists or not
        /// </summary>
        /// <param name="userOrigin">user to validate</param>
        /// <param name="user">user found</param>
        /// <returns></returns>
        public bool ValidateUser(LoginViewModel userOrigin, out User user)
        {
            using (eShopDBEntities db = new eShopDBEntities())
            {
                user = db.Users.Where(u => u.UserUsername == userOrigin.UserName).FirstOrDefault();
                if (user != null)
                {
                    string salt = user.UserSalt;
                    string password = MD5Hash(userOrigin.Password + salt);
                    if (db.Users.Any(a => a.UserUsername == userOrigin.UserName && a.UserPassword == password))
                    {
                        user = db.Users.First(a => a.UserUsername == userOrigin.UserName && a.UserPassword == password);
                        user.UserLastLoginDate = DateTime.Now;  
                        return true;
                    }
                    else
                    {
                        user = new User();
                        return false;
                    }
                }
                else
                {
                    user = new User();
                    return false;
                }
            }
        }
    }
}