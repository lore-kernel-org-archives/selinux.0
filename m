Subject: Re: Regarding SELinux User mapping
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BANLkTikr=mJPfq5FJUkL9=s5e4Xn6+WMsw@mail.gmail.com>
References: <BANLkTikr=mJPfq5FJUkL9=s5e4Xn6+WMsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 May 2011 09:00:14 -0400
Message-ID: <1306501214.1432.10.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-05-27 at 18:20 +0530, c.r.madhusudhanan@gmail.com wrote:
> I am trying to map Linux user to different SELinux user (user_u,
> guest_u, xguest_u), but when I login it shows only as
> system_u:system_r:local_login_t for all users.   I used semanage to
> map. 
> 
> # semange login -l
> 
> Login Name     SELinux User
> 
> __default__     user_u
> root                root
> system_u       system_u 
> 
> 
> I am using selinux enabled kernel in Meego 1.2 , built user space
> packages 
> from http://userspace.selinuxproject.org and using
> refpolicy-2.20101213.

Do you have pam_selinux in your pam configuration for login?  Fedora has
the following session modules in /etc/pam.d/login:

# pam_selinux.so close should be the first session rule
session    required     pam_selinux.so close
session    required     pam_loginuid.so
session    optional     pam_console.so
# pam_selinux.so open should only be followed by sessions to be executed
in the user context
session    required     pam_selinux.so open
session    required     pam_namespace.so
session    optional     pam_keyinit.so force revoke
session    include      system-auth

Note that they call pam_selinux twice in the stack, once with 'close'
and once with 'open', in order to distinguish what session modules
should run with the login program's context vs what session modules
should run with the user's context.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
