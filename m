Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAAASpSf002970
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 05:28:51 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAAASoKl026303
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 10:28:50 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
        by jazzband.ncsc.mil  with ESMTP id hAAASn5m026294 for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 10:28:49 GMT
Message-ID: <3FAF68E0.1020008@ipen.br>
Date: Mon, 10 Nov 2003 08:30:56 -0200
From: Carlos Anisio Monteiro <monteiro@ipen.br>
MIME-Version: 1.0
To: Dhruv Gami <dgami@uncc.edu>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Invalid Security Context error
References: <200311090545.hA95j16H029965@ns3.biznetindia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dhruv Gami wrote:

>Hello Everyone,
>
>finally i managed to compile everything, though some of the patches
>needed manual changes (will post a list of patches that didnt work
>properly).
>
>Now, when i rebooted the machine for the first time after compiling
>everything, and following the README doc step by step, i was asked
>
>-------------
>login: root
>password: *****
>
>would you like to enter a security context? [y]
>       Enter role sysadm_r
>       Enter type sysadm_t
>Not a valid security context
>-------------
>
>have i missed some context setting somewhere ?
>
>regards,
>Gami
>
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>
>  
>
You need load the policies in  the initrd. The initrd is executed before 
the init process.
Otherwise, the SElinux not load the context correctly.



-- 
Carlos Anisio Monteiro  <monteiro@ipen.br>
IPEN/CNEN-SP
Sao Paulo - Brasil




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
