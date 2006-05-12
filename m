Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4CD0xxl007010
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 09:01:00 -0400
Received: from e4.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4CD0x6C004231
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 13:00:59 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4CD0uaR018910
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 09:00:56 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4CD0uxo254744
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 09:00:56 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k4CD0u43014715
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 09:00:56 -0400
Message-ID: <44648700.5070002@us.ibm.com>
Date: Fri, 12 May 2006 09:00:48 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>, Ram Pai <linuxram@us.ibm.com>
Subject: Re: [Fwd: [PATCH 1/1] mount: shared-subtree support for mount]
References: <4460A6DA.1040407@us.ibm.com> <200605122236.27664.russell@coker.com.au>
In-Reply-To: <200605122236.27664.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am copying Ram Pai on this since he created the patch.

Russell Coker wrote:

>On Wednesday 10 May 2006 00:27, Janak Desai <janak@us.ibm.com> wrote:
>  
>
>>As per Russell's request, I am posting this patch here as well, so
>>broader selinux
>>community can also play with the shared tree feature.
>>    
>>
>
>Thanks for that.
>
>I just built mount with that patch and tried it out but it doesn't seem to 
>work.  I run the following command from root login:
>mount --make-private --bind /tmp/tmp.inst-user-user /tmp
>
>Then when I inspect /tmp from other sessions it seems that the change is 
>global.
>
>Does the rawhide kernel 2.6.16-1.2196_FC6 lack support for this or did I get 
>the command-line wrong?
>  
>
Shared subtree support went into main line from 2.6.15 so the rawhide 
kernel should
have support for this.

>Also from the documentation it seems that such a private mount does all we 
>need without any need to call unshare().  Is my understanding of this 
>correct?
>  
>
Yes, that's correct. Shared sub-tree feature does not need unshare() 
system call.

-Janak


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
