Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA21463
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2001 11:19:14 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA28887
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2001 16:18:57 GMT
Received: from patan.sun.com (patan.Sun.COM [192.18.98.43])
	by jazzswing.ncsc.mil  with ESMTP id QAA28883
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2001 16:18:56 GMT
Message-Id: <200111191615.fAJGFHE02817@zurich-mail1.Swiss.Sun.COM>
Date: Mon, 19 Nov 2001 17:15:17 +0100 (MET)
From: Harald von Fellenberg - Sun Switzerland Zurich - Technology Strategy Office <Harald.Von-Fellenberg@sun.com>
Reply-To: Harald von Fellenberg - Sun Switzerland Zurich - Technology Strategy Office <Harald.Von-Fellenberg@sun.com>
Subject: Re: SELinux and non-ext[23] file systems
To: Harald.Von-Fellenberg@sun.com, sds@tislabs.com
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

IT WORKS ON REISERFS!!!

Why did you not tell me before ... :-)
I will now invest my brain cycles on making the utils compile under Suse 7.x

Thanks and regards

Harald
PS here my patch :-)

--- setfiles/Makefile.orig      Wed Jul 18 22:38:11 2001
+++ setfiles/Makefile   Mon Nov 19 16:19:18 2001
@@ -9,6 +9,7 @@
 
 relabel:  $(FILECONTEXTS) setfiles
        ./setfiles $(FILECONTEXTS) `mount | awk '/ext2/{print $$3}'`
+       ./setfiles $(FILECONTEXTS) `mount | awk '/reiserfs/{print $$3}'`
        touch relabel
 
 install:  relabel

>
>On Mon, 19 Nov 2001, Harald von Fellenberg - Sun Switzerland Zurich - 
Technology Strategy Office wrote:
>
>> This said, I would like to re-raise the importance of non-ext2 file system
>> support, notably ReiserFS. It has been pointed out before, by Stephen 
Smalley,
>> that this should in principle be easy to integrate (the per-node sec context
>> needs to be stored in a file rather than in an unused field of the on-disk 
inode
>> structure). However, I am not aware of anyone tackling this implementation.
>
>Only the original SELinux prototype was limited to the ext2 filesystem,
>due to the use of a spare field in the on-disk ext2 inode to store the
>persistent security identifier (PSID).  When we transitioned to LSM, we
>extended the persistent label mapping to maintain the inode-to-PSID
>mapping as a regular file because LSM does not provide filesystem-specific
>hooks.  Hence, the LSM-based SELinux prototype should be able to use
>ReiserFS, although we haven't tried it.
>
>--
>Stephen D. Smalley, NAI Labs
>ssmalley@nai.com
>
>
>
>
>
>--
>You have received this message because you are subscribed to the selinux list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.

**********************************************************
 Dr. Harald von Fellenberg  
 Chief Technologist        Global Sales Organisation
 Tel:    +41 1 908 9230    Sun Microsystems (Schweiz) AG
 Fax:    +41 1 908 9001    Javastr. 2 
 Mobile: +41 79 349 0393   CH-8604 Volketswil
 mailto:harald.von-fellenberg@sun.com
**********************************************************


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
