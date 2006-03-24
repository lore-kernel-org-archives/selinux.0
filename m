Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2OGnN8h018962
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 11:49:23 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2OGnLah010026
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 16:49:22 GMT
Subject: Re: Misc policy fixes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20060324122554.GB7306@thorium.jmh.mhn.de>
References: <20060324122554.GB7306@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 11:49:37 -0500
Message-Id: <1143218978.3962.59.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-24 at 13:25 +0100, Thomas Bleher wrote:
> Some fixes for policy:
> * CUPS doesn't need inetd to function.
> * There are still systems without udev out there.
> * Some Debian/Ubuntu specific paths.

Merged except for:

> * Remove .SECONDARY because it causes build failures with current CVS
>   make (I already sent a mail about this; I think this is a bug in make,
>   but removing this line makes it work and doesn't cause negative side
>   effects AFAIK).

Actually, .SECONDARY provides an important feature, it prevents make
from deleting intermediate files from implicit targets (e.g., the final
source file used with checkmodule), which is very useful for debugging.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
