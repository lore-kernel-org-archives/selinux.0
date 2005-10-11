Subject: Re: Makefiles
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Timothy <timothy@diyab.net>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <434BDC2E.6050106@diyab.net>
References: <434BDC2E.6050106@diyab.net>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 11:57:35 -0400
Message-Id: <1129046255.3308.176.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-11 at 11:37 -0400, Timothy wrote:
> What would be the preferred method of maintaining the Makefiles for
> building between pam and non-pam builds?  I was thinking of just making
> another Makefile named Makefile.nopam that could be specified when
> running make.  Suggestions?

That is certainly simpler for us, but less likely to be maintained by us
for any future changes to the main Makefiles.  Introducing a USEPAM= or
similar Makefile variable into the existing Makefiles and having it
adjust the CFLAGS and LDLIBS accordingly seems more maintainable long
term.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
