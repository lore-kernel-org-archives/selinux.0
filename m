Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7RLAKrT023064
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 17:10:20 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7RL9XpX023150
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 21:09:33 GMT
Subject: Re: patch for firefox
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: russell@coker.com.au
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200408242147.44485.russell@coker.com.au>
References: <20040823215636.GD13677@lkcl.net>
	 <200408242147.44485.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093640980.24188.47.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 27 Aug 2004 17:09:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged changes.

On Tue, 2004-08-24 at 07:47, Russell Coker wrote:
> On Tue, 24 Aug 2004 07:56, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > the attached patch is required for firefox 0.9.3 to run under debian
> > (and other oses?)
> >
> > the reason for the patch is because someone decided to write a
> > script around firefox called firefox-bin that does some LD_LIBRARY_PATH
> > messing to keep /usr/lib/mozilla/blah separate.
> >
> > that this [script] messes up kde from being able to re-run firefox-bin
> > for session management because the real binary is fired up without the
> > correct LD_LIBRARY_PATH doesn't seem to have occurred to anyone, but
> > that's another story...
> 
> Try the attached mozilla.fc.  It's got the latest stuff from the CVS plus a 
> change equivalent to the one you made.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
