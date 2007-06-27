Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5RJdoCK006753
	for <selinux@tycho.nsa.gov>; Wed, 27 Jun 2007 15:39:51 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5RJdnTr013351
	for <selinux@tycho.nsa.gov>; Wed, 27 Jun 2007 19:39:49 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCHv2 0/5] Labeled network policy patches
Date: Wed, 27 Jun 2007 15:38:49 -0400
Cc: selinux@tycho.nsa.gov
References: <20070621231507.402982591@hp.com> <1182958680.14634.9.camel@gorn>
In-Reply-To: <1182958680.14634.9.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706271538.49996.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, June 27 2007 11:38:00 am Christopher J. PeBenito wrote:
> On Thu, 2007-06-21 at 19:15 -0400, Paul Moore wrote:
> > The latest revision of the labeled policy patches which enable both
> > labeled and unlabeled policy support for NetLabel.  This revision takes
> > into account Chris' feedback from the first version and reduces the
> > number of interface calls in each domain down to two at present: one for
> > unlabeled access, one for NetLabel access.  The older, transport layer
> > specific interfaces, are still present for use by third-party modules but
> > are not used in the default policy modules.
>
> Merged.

Thanks Chris, I'll re-base the kernel patch against a more current kernel and 
send it to the list before the end of the week.

> The existing corenetwork interfaces still have to remain for
> compatibility, I just put them back.  There were also some places that
> still were using the old interfaces, which I also fixed.

Sorry about that, I thought I caught all the changes but it looked like I 
missed a few.  Thanks again.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
