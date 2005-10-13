Subject: Re: Non-PAM Policycoreutils
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Timothy <timothy@diyab.net>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <434EBBDD.6040503@diyab.net>
References: <434EA0C1.7050706@diyab.net>
	 <1129227395.13490.8.camel@moss-spartans.epoch.ncsc.mil>
	 <434EB30B.4080606@diyab.net>
	 <1129232343.13490.35.camel@moss-spartans.epoch.ncsc.mil>
	 <434EBBDD.6040503@diyab.net>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 16:02:40 -0400
Message-Id: <1129233760.13490.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-13 at 15:56 -0400, Timothy wrote:
> The crypt defined in unistd.h is only read if __USE_XOPEN is defined so
> it's required or make will fail for non-pam builds because the function
> authenticate_via_shadow_passwd uses crypt.  I tried to add that define
> to the CFLAGS in the makefile but it does not see that it is defined for
> some reason and still errors out.

Hmm...actually, since it is wrapped by the #else for USE_PAM, it isn't a
problem to have it in the .c file, but I noticed that the man page for
crypt(3) on my system says to define _XOPEN_SOURCE instead of directly
defining __USE_XOPEN (features.h enables the latter when the former is
enabled).  Note that the former only has a single leading underscore,
unlike the latter.  Does #define'ing _XOPEN_SOURCE work for you there
instead of __USE_XOPEN?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
