Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81C2FrT020204
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 08:02:15 -0400 (EDT)
Received: from rwcrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81C2Deu027331
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 12:02:14 GMT
Message-ID: <4135BA45.80902@gentoo.org>
Date: Wed, 01 Sep 2004 08:02:13 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: automount policy
References: <200409011238.15293.russell@coker.com.au> <4135433D.1090506@gentoo.org> <200409011822.16392.russell@coker.com.au>
In-Reply-To: <200409011822.16392.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Wed, 1 Sep 2004 13:34, Joshua Brindle <method@gentoo.org> wrote:
>  
>
>>>-allow initrc_t automount_etc_t:file getattr;
>>>+allow initrc_t automount_etc_t:file { getattr read };
>>>      
>>>
>>Why add this allow for everyone if it's just for rawhide?
>>    
>>
>
>It appears to also be necessary for Debian.  If Gentoo is different then we 
>could have ifdef(`distro_gentoo', `', ` before it.
>
>  
>
alright, fair enough.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
