Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB5JqGRb007564
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 14:52:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB5JqFRV011875
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 19:52:15 GMT
Received: from smtp-1.llnl.gov (smtp-1.llnl.gov [128.115.250.81])
        by jazzband.ncsc.mil  with ESMTP id hB5JqEta011872 for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 19:52:14 GMT
Received: from hooper.llnl.gov (localhost [127.0.0.1])
	by smtp-1.llnl.gov (8.12.3p2-20030917/8.12.3/LLNL evision: 1.13 $) with ESMTP id hB5JqD1o010083
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 11:52:14 -0800 (PST)
Message-Id: <5.2.1.1.2.20031205115049.05a5f110@popcorn.llnl.gov>
Date: Fri, 05 Dec 2003 11:52:11 -0800
To: selinux@tycho.nsa.gov
From: Mark Shakespeare <mshakes@llnl.gov>
Subject: new to the list
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



>Just downloaded the latest se-linux 2.6-2003100110
>Everything going ok so far.
>
>I'am at step 4 in the "Building and Installing " section and would like 
>some additional information.
>
>
>
>4) Create an initrd with load_policy, the binary policy file, and a 
>/linuxrc that will perform the initial policy load prior to mounting the 
>root filesystem.
>
>I ran the patch for the Mkinitrd script,  then created an initrd using the 
>command " mkinitrd  /boot/2.6.0-test6-selinx1.img 2.6.0-test6-selinux1
>
>  it mentions a /linuxrc file.....but gives no samples...
>
>Is there a sample /linuxrc file?    Where does it go?
>
>Does anyone have a cookbook installation guide for installing SE-Linux on RH9?
>
>any help would be appreciated....
>
>Thanks...
>                                                                 Mark
>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
