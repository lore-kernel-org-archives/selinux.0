Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l173gb2C028509
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2007 22:42:37 -0500
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l173hhbD015339
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 03:43:44 GMT
Message-ID: <45C94B5B.30800@ak.jp.nec.com>
Date: Wed, 07 Feb 2007 12:45:31 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: libselinux utilities applets - please test
References: <200702062029.33013.vda.linux@googlemail.com> <45C8ED5A.30907@kaigai.gr.jp>
In-Reply-To: <45C8ED5A.30907@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry, so confusable spelling miss.

> The first serious of SELinux'ed-busybox patches (libselinux utilities)
            ^^^^^^^ ... series
> are merged. It enables the following facilities:
> 
>  - When ENABLE_SELINUX=1, '-lselinux -lsepol' was added as a LDFLAGS
>  - "Selinux Utilities" group was added onto menuconfig list.
>  - 'getenforce' new applet was added.
>  - 'getsebool' new applet was added.
>  - 'matchpathcon' new applet was added.
>  - 'selinuxenabled' new applet was added.
>  - 'setenforce' new applet was added.
> 
> Now, we are preparing to submit next serious of patches.
> see, http://code.google.com/p/sebusybox/
> 
> Thanks,
-- 
Open Source Software Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
