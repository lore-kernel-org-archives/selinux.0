Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA25067
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 08:35:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA29721
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 12:35:13 GMT
Received: from mail.ispko.com ([210.16.10.89])
	by jazzswing.ncsc.mil  with ESMTP id MAA29717
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 12:35:12 GMT
Message-ID: <3D1B0694.7030506@evoworks.evoserve.com>
Date: Thu, 27 Jun 2002 20:35:32 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: blacknet@simplyaquatics.com
CC: selinux@tycho.nsa.gov
Subject: Re: modifying utilities to use libselinux
References: <004601c21dd2$b6cc86b0$0a01a8c0@ed>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

No im using woody. Im playing with busybox and I wonder what should be 
done to make it work with selinux.

Ed Street wrote:

>Hello,
>
>I am going to assume you are using potato :)  Perhaps the best thing to
>do, if this assumption is true, is go update to woody and use mr coker's
>woody deb's located at http://www.coker.com.au/selinux/  you'll need to
>do a kernel reconfiguration as well with the kernel-lsm patch
>
>Ed
>
>-----Original Message-----
>From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
>On Behalf Of Debian User
>Sent: Thursday, June 27, 2002 2:28 AM
>To: selinux@tycho.nsa.gov
>Subject: modifying utilities to use libselinux
>
>is it wise to modify utiliies to use libsecure? what kind of utilities 
>besides login and ssh should use libsecure? how about screen? I had a 
>big problem making it work in selinux. 
>
>
>--
>You have received this message because you are subscribed to the selinux
>list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>with
>the words "unsubscribe selinux" without quotes as the message.
>  
>




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
