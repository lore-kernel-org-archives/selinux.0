Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i78FONrT020776
	for <selinux@tycho.nsa.gov>; Sun, 8 Aug 2004 11:24:23 -0400 (EDT)
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i78FNlDs026618
	for <selinux@tycho.nsa.gov>; Sun, 8 Aug 2004 15:23:47 GMT
Subject: Error: Re: Build error pam on ppc
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1091978380.14489.141.camel@debby>
References: <1091728350.2840.49.camel@debby>
	 <200408061646.12198.russell@coker.com.au> <1091835108.5709.102.camel@debby>
	 <1091978380.14489.141.camel@debby>
Content-Type: text/plain
Message-Id: <1091978650.14489.145.camel@debby>
Mime-Version: 1.0
Date: Sun, 08 Aug 2004 17:24:10 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-08-08 at 17:19, Wolfgang Pfeiffer wrote:

> I grepped the build log-files for both the stock Debian and the SE-Pam
> one with this:
> grep -iR -A 5 -B 5 " error " . > ~/pam-build-errors
                                                               ^^^^^^^^^^
should probably say:
grep -iR -A 5 -B 5 " error " . > ~/pam-build-errors.log

> 
> The resulting file is here:
> <http://www.geocities.com/wolfgangpfeiffer/pam-build-errors.log>

Sorry
Wolfgang
-- 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
