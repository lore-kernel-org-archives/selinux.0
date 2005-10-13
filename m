Subject: Re: Non-PAM Policycoreutils
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Timothy <timothy@diyab.net>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <434EB30B.4080606@diyab.net>
References: <434EA0C1.7050706@diyab.net>
	 <1129227395.13490.8.camel@moss-spartans.epoch.ncsc.mil>
	 <434EB30B.4080606@diyab.net>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 15:39:03 -0400
Message-Id: <1129232343.13490.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-13 at 15:18 -0400, Timothy wrote:
> Fixed and tested against CVS.  New patch attached.

Thanks.  Why do you need to define __USE_XOPEN?  And should that always
be done or just in the non-PAM case, i.e. CFLAGS+=-D__USE_XOPEN in the
else clause of the Makefiles?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
