Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA28008
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 09:41:34 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA28227
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 13:40:06 GMT
Received: from mail.ispko.com ([210.16.10.89])
        by jazzband.ncsc.mil  with ESMTP id NAA28223 for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 13:40:04 GMT
Message-ID: <3D2AE806.7020106@evoworks.evoserve.com>
Date: Tue, 09 Jul 2002 21:41:26 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: selinux@tycho.nsa.gov
Subject: Re: automatic type transitions for pts in devfs
References: <Pine.GSO.4.33.0207090921010.27193-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 9 Jul 2002, Debian User wrote:
>
>  
>
>>Whats best way to go about this? Where do i look first? I will try
>>fixing this with some help.
>>    
>>
>
>You can look at how we provide labeling for the devpts filesystem.  The
>devpts filesystem uses transition SIDs to label its inodes.  Look at the
>sbsec->uses_trans case of inode_precondition in
>lsm-2.4/security/selinux/hooks.c.  The devfs filesystem uses
>genfs_contexts to label its inodes (the sbsec->uses_genfs case).  You want
>devfs to actually be a hybrid of the two methods, with /pts entries
>in devfs using transition SIDs like devpts and other entries using
>genfs_contexts.
>  
>
I see im beginning to see things clearly.  Are all the stuff involved in 
this restricted to hooks.c? Im afraid im not familiar with lsm. I have 
to look for an introduction somewhere.

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
