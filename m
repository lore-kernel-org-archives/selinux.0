Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA25138
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 08:41:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA09882
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 12:40:26 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
        by jazzband.ncsc.mil  with ESMTP id MAA09878 for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 12:40:25 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Debian User'" <rogelio@evoworks.evoserve.com>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: modifying utilities to use libselinux
Date: Thu, 27 Jun 2002 08:41:50 -0400
Message-ID: <005001c21dd8$02617cc0$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3D1B0694.7030506@evoworks.evoserve.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Well your in luck if your using woody.  I would urge you to grab the
debs from cokers url http://www.coker.com.au/selinux/  there's some
decent docs on how to install it.  I can attest that it is a very simple
painless install. (assuming kernel config/compile is a somewhat simple
matter for you)

Ed

-----Original Message-----
From: Debian User [mailto:rogelio@evoworks.evoserve.com] 
Sent: Thursday, June 27, 2002 8:36 AM
To: blacknet@simplyaquatics.com
Cc: selinux@tycho.nsa.gov
Subject: Re: modifying utilities to use libselinux

No im using woody. Im playing with busybox and I wonder what should be 
done to make it work with selinux.

Ed Street wrote:

>Hello,
>
>I am going to assume you are using potato :)  Perhaps the best thing to
>do, if this assumption is true, is go update to woody and use mr
coker's
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
>You have received this message because you are subscribed to the
selinux
>list.
>If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov
>with
>the words "unsubscribe selinux" without quotes as the message.
>  
>




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
