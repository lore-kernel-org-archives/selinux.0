Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3RNaYGQ023996
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 19:36:34 -0400
Received: from cp-out8.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3RNaX1e027926
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 23:36:34 GMT
Subject: Re: Is there difference betweek sefiles and restorecon in terms of
 labels
From: Guido Trentalancia <guido@trentalancia.com>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 28 Apr 2011 01:36:32 +0200
In-Reply-To: <BANLkTi=23O4bO-mDgKectp3_xXpCOXFxmw@mail.gmail.com>
References: <BANLkTi=23O4bO-mDgKectp3_xXpCOXFxmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1303947392.2648.30.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In short, the label ultimately depends on the file context
specification, not the tool you use. Therefore as long as the file
context specification is the same, then I suppose both setfiles and
restorecon produce the same label on the file.

Regards,

Guido

On Wed, 2011-04-27 at 15:59 -0700, Sam Gandhi wrote:
> Looking at man pages of sefiles and restorecon , both mention that
> they initialize security context database ( extended attributes) on
> one or more filesystems.
> 
> There are certainly differences between command line arguments, but
> can these programs be used interchangeably as far as extended
> attributes they assign to files?
> 
> -Sam
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
