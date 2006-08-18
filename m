Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7IJwxIm022730
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 15:58:59 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k7IJwlmr014047
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 19:58:47 GMT
Subject: Re: refpoliy issues
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1155916251.14563.5.camel@wintermute.xmldesign.de>
References: <1155863972.7443.36.camel@wintermute.xmldesign.de>
	 <1155910539.14126.17.camel@sgc.columbia.tresys.com>
	 <1155916251.14563.5.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 15:59:05 -0400
Message-Id: <1155931146.14126.39.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-08-18 at 17:50 +0200, Erich Schubert wrote:
> Hi Christopher,
> > > - sxid not in role system_r, missing access to /dev
> > Already fixed the role.  You'll have to be more specific about access
> > to /dev.
> 
> How about /dev/*
> sxid by nature tries to getattr all files there.

Still more specific.  The typically the only files in /dev are
in /dev/.udev.  Or do you mean the device nodes and character nodes?

> > I believe setrans is in fedora cvs.  The access looks like its only due
> > to libselinux's init; however, if you're using MLS or MCS, you're really
> > going to want the translation daemon anyway.
> 
> I agree that I want setrans if I manage to get it from somewhere and
> some docs how to set it up... still we should probably handle these
> errors. I don't know if they occur on non-MLS-non-MCS systems, though.
> But right now, I guess more people might be affected by this.

It doesn't affect standard setups.  If MLS is disabled, then all of
functions in question return success immediately.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
