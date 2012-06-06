Message-ID: <1339008346.4365.14.camel@lenny>
Subject: Re: [PATCH]: allow standard compilation of GIT development tree
 (was Re: [PATCH]: do not link static libraries from the system library
 directory)
From: Colin Walters <walters@verbum.org>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: SELinux@tycho.nsa.gov
Date: Wed, 06 Jun 2012 14:45:46 -0400
In-Reply-To: <1339005512.4365.10.camel@lenny>
References: <201206061755.q56HtHFF004774@vivaldi48.register.it>
	 <1339005512.4365.10.camel@lenny>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-06-06 at 13:58 -0400, Colin Walters wrote:

> What I was actually saying is that your patch should explicitly
> separate BUILD_INTERNAL_CFLAGS from CFLAGS.  Automake calls the former
> AM_CFLAGS, but you can call it whatever you want in your Makefile.

http://marc.info/?l=selinux&m=105830780118085&w=2

9 years later, discussing the CFLAGS handling again =)

Some things change (I now get binaries in .rpm form instead of .debs,
libselinux has migrated from cvs to svn to git), some things stay the
same...



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
