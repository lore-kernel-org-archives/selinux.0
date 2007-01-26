Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0QJXxoh018878
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 14:33:59 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l0QJYwaF026956
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 19:34:58 GMT
Subject: Re: [PATCH 0/8] busybox -- libselinux utilities applets
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: busybox@busybox.net, selinux@tycho.nsa.gov, rob@landley.net,
        dwalsh@redhat.com, russell@coker.com.au, busybox@kaigai.gr.jp
In-Reply-To: <45B8C039.10907@kaigai.gr.jp>
References: <45B8C039.10907@kaigai.gr.jp>
Content-Type: text/plain
Date: Fri, 26 Jan 2007 19:36:33 +0000
Message-Id: <1169840193.25290.1.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-01-25 at 23:35 +0900, KaiGai Kohei wrote:
> [1/8] busybox-libselinux-01-common.patch
>   The common part of libselinux package
>   - modification of Makefile
>   - add '-lselinux', if CONFIG_SELINUX enabled

Also need -lsepol, otherwise you'll get missing symbols if you compile
it static.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
