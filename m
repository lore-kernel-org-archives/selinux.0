Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i813YUrT017944
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 23:34:30 -0400 (EDT)
Received: from rwcrmhc13.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i813XfGh010018
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 03:33:41 GMT
Message-ID: <4135433D.1090506@gentoo.org>
Date: Tue, 31 Aug 2004 23:34:21 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: automount policy
References: <200409011238.15293.russell@coker.com.au>
In-Reply-To: <200409011238.15293.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>The attached patch is needed for the latest rawhide automount.
>
>  
>
>------------------------------------------------------------------------
>
>--- /usr/src/se/policy/domains/program/unused/automount.te	2004-08-28 12:05:01.000000000 +1000
>+++ domains/program/unused/automount.te	2004-09-01 12:36:44.000000000 +1000
>@@ -66,4 +66,4 @@
> allow automount_t home_root_t:dir { getattr };
> allow automount_t mnt_t:dir { getattr search };
> 
>-allow initrc_t automount_etc_t:file getattr;
>+allow initrc_t automount_etc_t:file { getattr read };
>  
>
Why add this allow for everyone if it's just for rawhide?


Joshua Brindle
Hardened Gentoo

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
