Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA28690
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 10:33:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA01515
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 14:31:43 GMT
Received: from mail.ispko.com ([210.16.10.89])
        by jazzband.ncsc.mil  with ESMTP id OAA01505 for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 14:31:42 GMT
Message-ID: <3D2AF420.50708@evoworks.evoserve.com>
Date: Tue, 09 Jul 2002 22:33:04 +0800
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
That would mean checking if the inode's super block magic number is DEVPTS.
Is that going to be enough?

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
