Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7FEgs8d025696
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2008 10:42:54 -0400
Received: from mail.wrs.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7FEgca8008422
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2008 14:42:38 GMT
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m7FEgj0Z009299
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2008 07:42:47 -0700 (PDT)
Message-ID: <48A595CC.2020508@windriver.com>
Date: Fri, 15 Aug 2008 10:42:20 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: file_contexts duplicates
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a problem in which file_contexts gets to 11mb (152kb unique) 
because of duplicates.

Using selinux-svn2950 and refpolicy-svn2780 I built the standard policy
distro=redhat
unknown perms=deny
no direct admin init

Now using the .pp files that got installed into /usr/share/selinux/standard

I attempted to create a 2nd policy by hand using semodule.

# export NAME=vikram
# mkdir -v -p \
   /etc/selinux/$NAME/modules/active \
   /etc/selinux/$NAME/contexts/files \
   /etc/selinux/$NAME/policy
# cd /usr/share/selinux/standard
# semodule -v -n -s $NAME -b base.pp $(for i in *.pp ; do  if [ "$i" != 
"base.pp" ] ; then echo -n "-i $i "; fi; done)

This command appears to run for eternity. But after investigation, it 
seems setfiles is getting stuck up reading file_contexts. And is 
relabeling the file system again and again because of the duplicate 
definitions.

Shorting out setfiles lets the command complete in 30mins. ie 
Transaction return 0. However because the file_contexts is 11mb of 
duplicates. It cannot be used. Doing a:

# sort /etc/selinux/$NAME/contexts/files/file_contexts | uniq > clean
# mv clean /etc/selinux/$NAME/contexts/files/file_contexts

Produces a 152kb file.
Note: /etc/selinux/standard/context/files/file_contexts is 156kb

Relabeling the file system now with the new 152kb file. Causes 
/usr/lib64 to get usr_t which causes massive denial at boot up. And 
eventually haults login.

What in the world is going on? Where would I begin to debug these 
problems: 1) Duplicates in file_contexts and 2) Missing contexts

Vikram

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
