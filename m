Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5G1PGrT029576
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 21:25:16 -0400 (EDT)
Received: from smtp-bedford.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5G1PDs1006000
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 01:25:13 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i5G1PEi09491
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 21:25:14 -0400
Received: from divan.mitre.org (divan.mitre.org [129.83.10.75])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i5G1PEv09484
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 21:25:14 -0400
Received: from divan.mitre.org (localhost [127.0.0.1])
	by divan.mitre.org (8.12.11/8.12.10) with ESMTP id i5G1PDJU026360
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 21:25:13 -0400
To: selinux@tycho.nsa.gov
Subject: Re: Fedora Core 2 policy source
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4AD5@s3cin>
	<ogtr7sgs8fw.fsf@mitre.org>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 15 Jun 2004 21:25:13 -0400
In-Reply-To: <ogtr7sgs8fw.fsf@mitre.org>
Message-ID: <ogt3c4w70qu.fsf@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I meant to say:

In the RPM directory of Disk three of FC2, search for file names that
contain the strings, "selinux", "policy", and "setools", and I think
you'll find the SE Linux relevant RPMs.

Actually, in my original message, I typed in file name patterns that
both started and ended with an asterisk.  Of course, the asterisks
cause the text in between to be displayed in bold--not what I wanted.

John

ramsdell@mitre.org (John D. Ramsdell) writes:

> "Kratzer, James R." <JamesK@xetron.com> writes:
> 
> > Where are the source policy files for Fedora Core 2?  The source directory
> > "/etc/security/selinux/src/policy" appears to be missing from the install.
> > Thanks.
> 
> In the RPM directory of Disk three of FC2, search for *selinux*, *policy*, 
> and *setools*, and I think you'll find the SE Linux relevant RPMs.
> 
> John
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
