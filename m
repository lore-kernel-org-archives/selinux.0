Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IDlqRb001406
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:47:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IDlnAR020135
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:47:49 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4IDllHn020033 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:47:48 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: suggestion to help transition to selinux: dynamic loading of libselinux
Date: Tue, 18 May 2004 23:46:36 +1000
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, selinux@tycho.nsa.gov
References: <20040515232606.GA9378@lkcl.net> <200405180510.40047.russell@coker.com.au> <1084879917.28966.11.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1084879917.28966.11.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405182346.36628.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 18 May 2004 21:31, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Mon, 2004-05-17 at 15:10, Russell Coker wrote:
> > The first candidate for such changes would be init.  We would have to
> > hard-code a check for selinux=0 in the init source to avoid having init
> > just not enable SE Linux if file system corruption causes libselinux.so
> > to disappear.
> >
> > I think that init is the program that needs such changes most, the
> > current situation makes libselinux one of the most important packages in
> > the system (can't boot without it).
>
> I'm surprised that /sbin/init isn't statically linked in Fedora.
> Rationale?

When fsck, getty, login, /bin/sh, cat etc, and all the other programs that are 
necessary for booting and allowing a root login are dynamically linked it 
doesn't seem to provide much benefit to have init statically linked.

To have all those programs dynamically linked would significantly increase 
disk space for small systems, or require having two versions of each with the 
static version being optional.  So in ancient Linux history it was decided to 
use dynamically linked programs for all of those and almost everyone has 
followed.  Some people have built custom distributions at various times to 
have statically linked /sbin programs but have not apparently received a 
benefit to justify the effort.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
