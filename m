Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA28517
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 10:19:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA14172
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 14:19:20 GMT
Received: from mail.ispko.com ([210.16.10.89])
	by jazzswing.ncsc.mil  with ESMTP id OAA14168
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 14:19:19 GMT
Message-ID: <3D2AF105.8080008@evoworks.evoserve.com>
Date: Tue, 09 Jul 2002 22:19:49 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: selinux@tycho.nsa.gov
Subject: Re: automatic type transitions for pts in devfs
References: <Pine.GSO.4.33.0207091011390.27193-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 9 Jul 2002, Debian User wrote:
>
>  
>
>>So I focus on hooks.c. This is basically getting the inodes labelled
>>correctly.
>>Either we add some new fields(?) in the inode structure or we insert a
>>condition that would make the inode get the proper label. Is that correct?
>>    
>>
>
>You could add a test within the sbsec->uses_genfs case to see whether the
>filesystem type is devfs and whether the inode corresponds to a /pts node.
>If so, then you want to use a transition SID as with the sbsec->uses_trans
>case.  Otherwise, you would use genfs_contexts as usual.
>  
>
cool! i see it now. this is great. this is the first time i hacked devfs 
and selinux!
Thanks!

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
