Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3GHWi7C004025
	for <selinux@tycho.nsa.gov>; Sat, 16 Apr 2005 13:32:44 -0400 (EDT)
Received: from oe-im1.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3GHSdiE016955
	for <selinux@tycho.nsa.gov>; Sat, 16 Apr 2005 17:28:39 GMT
Subject: Re: [POLICY/PATCH] IA-64 Boot Partition
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: "SELinux-ML(NSA)" <selinux@tycho.nsa.gov>
In-Reply-To: <42613C72.5060408@kaigai.gr.jp>
References: <4260B74B.3000002@kaigai.gr.jp>
	 <1113666959.6081.25.camel@sgc.columbia.tresys.com>
	 <42613C72.5060408@kaigai.gr.jp>
Content-Type: text/plain
Date: Sat, 16 Apr 2005 13:28:54 -0400
Message-Id: <1113672535.6081.31.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-04-17 at 01:25 +0900, KaiGai Kohei wrote:
> BTW, what archtectures are used and checked by SELinux's people ?
> For example, kernel panic is occured on the 2.6.6 or former kernel for IA-64
> when SELinux is enabled. This phenomenon have been overlooked.
> 
> I can validate the evidence on IA64/i386 environment.
> Is there a person who can try to run SELinux on infrequent(not i386) plathome?

I have AMD64 and PPC running fine.  I know SPARC64 works too.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
