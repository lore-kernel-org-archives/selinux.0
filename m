Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8DIo4ss005981
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 14:50:04 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8DIndPt029264
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 18:49:39 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: More policy changes from Debian
Date: Wed, 13 Sep 2006 14:17:24 -0400
Message-ID: <1158171444.26420.80.camel@sgc.columbia.tresys.com>
In-Reply-To: <20060913172124.GE11017@aragorn>
References: <1158157098.1594.29.camel@wintermute.xmldesign.de> <20060913172124.GE11017@aragorn>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Uwe Hermann" <uwe@hermann-uwe.de>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-13 at 19:21 +0200, Uwe Hermann wrote:
> On Wed, Sep 13, 2006 at 04:18:18PM +0200, Erich Schubert wrote:
> > # just for /etc/localtime symlink, but I mean... it's just etc_t
> [...]  
> > +files_read_etc_files(sxid_t)
> 
> I'm pretty new to SELinux, so maybe I'm wrong, but isn't the general goal
> of SELinux + refpolicy to implement the strictest possible ruleset
> per default where-ever possible? If yes, I'd rather explicitly only
> allow access to that single file, rather than all of /etc.

Agreed.  The correct thing to do in this case was to fix
miscfiles_read_localization(), as it was missing the etc_t:lnk_file
read.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
