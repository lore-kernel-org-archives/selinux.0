Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5DG3NrT014062
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 12:03:24 -0400 (EDT)
Received: from ms-smtp-04.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5DG3Kkj026528
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 12:03:21 -0400 (EDT)
Received: from sasami.localdomain (CPE-24-31-241-155.kc.rr.com [24.31.241.155])
	by ms-smtp-04.rdc-kc.rr.com (8.12.8p1/8.12.7) with ESMTP id i5DG1C8Z014425
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 11:01:15 -0500 (CDT)
Received: from yggdrasil.localdomain ([192.168.0.2])
	by sasami.localdomain with esmtp (Exim 4.34)
	id 1BZXRu-0001ZU-AJ
	for selinux@tycho.nsa.gov; Sun, 13 Jun 2004 11:03:10 -0500
Received: from adric by yggdrasil.localdomain with local (Exim 4.34)
	id 1BZXRu-0002nt-8s
	for selinux@tycho.nsa.gov; Sun, 13 Jun 2004 11:03:10 -0500
Date: Sun, 13 Jun 2004 11:03:10 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040613160310.GA10763@yggdrasil.localdomain>
References: <20040609144404.GJ5477@philips.com> <200406121819.57709.russell@coker.com.au> <20040612143714.GA28996@yggdrasil.localdomain> <200406131029.35825.russell@coker.com.au> <20040613012852.GA4210@yggdrasil.localdomain> <20040613075427.GZ2861@lkcl.net> <20040613154033.GA10171@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040613154033.GA10171@yggdrasil.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 13, 2004 at 10:40:33AM -0500, Greg Norris wrote:
> I did try purging and re-installing last night, but that didn't seem to
> change anything.  I'll go ahead and give it another shot, in case I
> overlooked some cleanup.  Do you know if anything other than
> /etc/selinux and /usr/share/selinux/policy needs to be removed
> manually?

It doesn't seem to have made any significant difference...

   Installing the new SE Linux policy
   /usr/bin/checkpolicy:  loading policy configuration from policy.conf
   domains/admin.te:19:ERROR 'unknown type sysadm_chkpwd_t' at token ';' on line 11746:
   allow sysadm_su_t sysadm_chkpwd_t:process transition;
   #line 19
   /usr/bin/checkpolicy:  error(s) encountered while parsing configuration

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
