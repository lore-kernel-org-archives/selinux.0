Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k26ICWjg005760
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 13:12:32 -0500
Received: from authusersmtp.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k26ICUuY013320
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 18:12:30 GMT
Message-ID: <440C7B88.7090800@cornell.edu>
Date: Mon, 06 Mar 2006 13:12:24 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: jvdias@redhat.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: named SELinux policy
References: <200603061121.49118.jvdias@redhat.com> <440C73BA.4050503@redhat.com>
In-Reply-To: <440C73BA.4050503@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> File context that differs from parent directory is especially hard to 
> maintain and can give the impression that SELinux is difficult.  We 
> can not predict which tools a user will use to maintain the named.conf 
> file so leaving it etc_t is better in my opinion.  If you want to 
> prevent secret data then you should not store a file in /etc with 
> default context (etc_t, etc_runtime_t).  (You probably should not 
> store the file there in the  first place.)
I see this as one of the fundamental problems of SELinux to solve before 
it becomes mainstream...

Should automatic type transitions be treated as a hack, placed there 
until the app starts using setfscreatecon? Should they instead be 
treated as the way to do things, with applications being modified to 
better organize their files into folders, and the folders pre-created as 
appropriate.

Automated transitions have already proved difficult when mixing files of 
different types in the same folder, and also with shared libraries 
creating files.

It seems like the app has much more knowledge about the file than the 
kernel's (src_context, target_class) pair. However, should we be 
incorporating selinux contexts into applications [ as is already done in 
consolehelper ]? How reliable are those context? The rwx of chmod() are 
pretty much set in stone. Policy changes all the time. Is it better to 
keep selinux logic out of applications instead?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
