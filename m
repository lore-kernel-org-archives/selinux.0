Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4DKaiRb007122
	for <selinux@tycho.nsa.gov>; Thu, 13 May 2004 16:36:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4DKagMi004865
	for <selinux@tycho.nsa.gov>; Thu, 13 May 2004 20:36:42 GMT
Received: from lakermmtao10.cox.net (lakermmtao10.cox.net [68.230.240.29])
        by jazzband.ncsc.mil  with ESMTP id i4DKafpI004862 for <selinux@tycho.nsa.gov>; Thu, 13 May 2004 20:36:41 GMT
Message-ID: <40A3DC4D.1030401@snu.edu>
Date: Thu, 13 May 2004 15:36:29 -0500
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Valdis.Kletnieks@vt.edu, selinux@tycho.nsa.gov
Subject: Re: Linux 2.6.6-rc3-mm2 and SELinux support of stacked modules
References: <200405100238.i4A2cDRW027971@turing-police.cc.vt.edu> <1084470920.14586.119.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1084470920.14586.119.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Sun, 2004-05-09 at 22:38, Valdis.Kletnieks@vt.edu wrote:
>  
>
>>I've attached a patch that does the secondary_ops callback for essentially
>>everything used by either my already-written code, in-progress code, or the
>>BSDJail module.
>>    
>>
>
>A couple of notes regarding your insertion of secondary_ops calls:
>
>1) Joshua Brindle (cc'd) posted a patch to this list earlier to likewise
>add secondary ops for another security module.  There were two points of
>overlap:  inode_permission and file_mmap.  In the case of
>inode_permission, you both inserted the secondary hook call after the
>null mask test (existence test).  Are you sure that you will never want
>to see such calls in a secondary module?  In the case of file_mmap,
>Joshua's diff only calls the secondary module if there is a file struct,
>whereas your diff always calls the secondary module.  The latter offers
>greater flexibility to the secondary module, so I'm inclined to use it,
>but thought I should note it as it means that the secondary module will
>need to test for the null file case and act accordingly.
>
>2) Neither the post_mountroot nor pivotroot hooks are likely to survive
>long term IMHO, so I don't plan on adding them to the SELinux module.
> 
>  
>
It might be a better idea for other modules to call the secondary module 
before the check, I wasn't too concerned about it for the module I was 
working on but it might be an issue for others.

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
