Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7PDRxd2020627
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 09:27:59 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k7PDRgNs007233
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 13:27:42 GMT
Subject: Re: [PATCH] add fs_use_xattr on jffs2
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <44EEE4DD.5080301@kaigai.gr.jp>
References: <44EEE4DD.5080301@kaigai.gr.jp>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 09:28:12 -0400
Message-Id: <1156512493.3199.2.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-08-25 at 20:54 +0900, KaiGai Kohei wrote:
> This patch enables to use xattr on jffs2 filesystem.
> 
> The jffs2 filesystem is a filesystem for memory technology
> devices (MTD), and xattr supporting on jffs2 is neccesary
> to use SELinux with a small diskless PDA and so on.
> This facility is queued for kernel 2.6.18 now, so I hope
> to merge this small patch into the refpolicy repository.

Thanks, merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
