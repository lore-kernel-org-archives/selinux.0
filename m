Date: Wed, 27 Mar 2002 10:23:10 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: newrole passwords (Was:  Fractal Based Encryption)
In-Reply-To: <20020327144257.CEF8341F4A@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203271012340.8022-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 27 Mar 2002, Russell Coker wrote:

> This brings me to another issue I have been considering, that of newrole
> passwords.  It's standard proceedure to have root and user passwords be
> different even if you only login as a regular user for the purpose of "su -".
> Therefore I am concerned that we are limited by the utility programs only
> supporting the regular password for doing a "newrole -r sysadm_r".
>
> I would like the option to be able to enforce that a login only gets the
> default role (no prompting for other roles or domains) and then have
> different passwords needed to get to roles or domains that have more privs.

At present, authorization for roles is completely orthogonal to
authentication.  Users are authorized for roles by the policy/users file.
If a user is authorized for a given role in policy/users, then that user
can enter that role, either at login time (via login or gdm case, but
not currently ssh) or subsequently via newrole.  At login time, we
authenticate the user as usual.  With newrole, we re-authenticate the user
originally authenticated at login time to protect against invocation of
newrole by malicious code accidentally run by the user.  The newrole
authentication is merely to verify the user's intent, not as an
authorization mechanism for the role.

At present, SELinux doesn't modify PAM at all, and newrole uses PAM to
perform the authentication.  We could modify PAM to support per-role
per-user passwords, checked both at login time and by newrole, but I'm
not sure that this is desirable.  If you are concerned about the
limitations of passwords, then you can always use a stronger
authentication mechanism through your PAM configuration.

With regard to forcing a particular role at login time, this is already
the case for ssh (always uses the default context for the user).  For
local logins, you can limit all users to entering a particular domain
(e.g. user_t) by restricting domain transitions from local_login_t in the
policy.  Per-user restrictions for local logins would require changing
login to simply use the default context, like sshd.

> Another thing, it would be nice if the run_init and newrole programs prompted
> you for which user's password they expected.  Often when I've su'd to root I
> forget which account I originally logged in with, then newrole and run_init
> fail because I entered the password for the wrong account.  In my Debian
> package I've added the account name to the error message so at least you can
> get it right the second time.

Good point.  Thanks for the suggestion.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
