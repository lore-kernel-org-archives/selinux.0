Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5CEbSrT010751
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 10:37:28 -0400 (EDT)
Received: from ms-smtp-04.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5CEbMP2023148
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 10:37:23 -0400 (EDT)
Received: from sasami.localdomain (CPE-24-31-241-155.kc.rr.com [24.31.241.155])
	by ms-smtp-04.rdc-kc.rr.com (8.12.8p1/8.12.7) with ESMTP id i5CEZJ8Z010763
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 09:35:22 -0500 (CDT)
Date: Sat, 12 Jun 2004 09:37:15 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040612143714.GA28996@yggdrasil.localdomain>
References: <20040609144404.GJ5477@philips.com> <200406111413.40262.russell@coker.com.au> <20040611232613.GA10019@yggdrasil.localdomain> <200406121819.57709.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406121819.57709.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jun 12, 2004 at 06:19:57PM +1000, Russell Coker wrote:
> What version of the policy package?  I think I've fixed that in recent 
> versions...

adric@sasami[~]$ dpkg -l selinux-policy-default | tail -1
iF  selinux-policy 1.12-3         Policy config files and management for NSA S

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
