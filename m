Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5FNXSrT029089
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 19:33:28 -0400 (EDT)
Received: from smtp-bedford.mitre.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5FNXJRI015956
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 23:33:19 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i5FNXQi03138
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 19:33:26 -0400
To: "Kratzer, James R." <JamesK@xetron.com>
Cc: "SE Linux Mail List (E-mail)" <selinux@tycho.nsa.gov>
Subject: Re: Fedora Core 2 policy source
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4AD5@s3cin>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 15 Jun 2004 19:33:23 -0400
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4AD5@s3cin>
Message-ID: <ogtr7sgs8fw.fsf@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Kratzer, James R." <JamesK@xetron.com> writes:

> Where are the source policy files for Fedora Core 2?  The source directory
> "/etc/security/selinux/src/policy" appears to be missing from the install.
> Thanks.

In the RPM directory of Disk three of FC2, search for *selinux*, *policy*, 
and *setools*, and I think you'll find the SE Linux relevant RPMs.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
