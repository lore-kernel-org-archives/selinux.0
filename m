Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA27565
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 09:00:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA09333
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 12:59:46 GMT
Received: from mail.ispko.com ([210.16.10.89])
	by jazzswing.ncsc.mil  with ESMTP id MAA09329
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 12:59:44 GMT
Message-ID: <3D2ADE5C.4000102@evoworks.evoserve.com>
Date: Tue, 09 Jul 2002 21:00:12 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: selinux@tycho.nsa.gov
Subject: Re: sshd_devpts_t
References: <Pine.GSO.4.33.0207090849460.27193-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 9 Jul 2002, Debian User wrote:
>
>  
>
>>Has this been fixed yet? I cant ssh into my pc anymore. Where should
>>this be fixed?
>>    
>>
>
>I'm not sure what you are asking.  If you are using devfs, you will likely
>need some additional allow rules for access to devpts_t, since the
>per-domain pty labeling that we support for the devpts filesystem is not
>implemented for the devfs filesystem.  If people want more complete devfs
>support, the best way to get it would be to contribute some patches.
>  
>
I added allow rules for devpts but i prefer adding complete devfs 
support. Im not familiar with devfs but I guess there is no other way 
but to dig in and try to fix it.

>--
>Stephen D. Smalley, NAI Labs
>ssmalley@nai.com
>
>
>  
>




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
