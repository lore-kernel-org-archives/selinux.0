Subject: Re: Non-PAM Policycoreutils
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Timothy <timothy@diyab.net>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <434EA0C1.7050706@diyab.net>
References: <434EA0C1.7050706@diyab.net>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 14:16:35 -0400
Message-Id: <1129227395.13490.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-13 at 14:00 -0400, Timothy wrote:
> This patch against policycoreutils 1.26 will make it compile and install
> correctly based on the presence of PAM.  Please apply.

Thanks.   However:

> +PAMH = $(shell ls /usr/include/pam.h 2>/dev/null)

/usr/include/pam.h is unrelated to PAM on my systems.  It is a header
provided by the netpbm library containing a Portable Arbitrary Map image
format definition.   PAM headers are under /usr/include/security, e.g.
see the #include's in newrole.c or run_init.c.

Also, while not strictly necessary, it is preferable to submit patches
generated against the sourceforge CVS tree - less likely to end up with
rejects that way.  Anonymous pserver access is available, see
http://sourceforge.net/cvs/?group_id=21266

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
