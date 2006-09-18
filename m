Subject: Re: awk, isatty(), libc and ioctl()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
In-Reply-To: <1158601304.14335.12.camel@wintermute.xmldesign.de>
References: <1158185710.1594.94.camel@wintermute.xmldesign.de>
	 <200609162208.13198.russell@coker.com.au>
	 <1158410236.10929.8.camel@wintermute.xmldesign.de>
	 <1158598780.18951.254.camel@moss-spartans.epoch.ncsc.mil>
	 <1158601304.14335.12.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 14:26:07 -0400
Message-Id: <1158603967.18951.287.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-18 at 19:41 +0200, Erich Schubert wrote:
> Hello Stephen,
> So what should we do - add the missing dontaudit/allow rules, provide
> patches for awk/perl (and likely others) to not use isatty() on regular
> files but stat() first, or ask the glibc maintainers to modify isatty()?

I'm doubtful that the latter two options are viable.  More likely:
1) Add dontaudit rules as needed for now,
2) Reconsider the SELinux ioctl checking in the future.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
