Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i92AJ7rT008042
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 06:19:07 -0400 (EDT)
Message-ID: <415E8091.5000202@redhat.com>
Date: Sat, 02 Oct 2004 06:18:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
Subject: Re: policy patches
References: <200409292354.15227.russell@coker.com.au> <200410020344.04225.russell@coker.com.au> <415DC1D7.9040109@redhat.com> <200410021043.19336.russell@coker.com.au>
In-Reply-To: <200410021043.19336.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>+dontaudit $1_mozilla_t tmp_t:lnk_file read;
>
>This should not be possible.  If tmp_t:lnk_file gets generated with strict 
>policy then we have a bug somewhere else.
>
>  
>
Something seems to generate it regularly, probably when setenforce 0 in 
effect.  Have had to
do this alot because of broken kernel(s).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
