Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h549JTI4021253
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 05:19:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h549JStV006792
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 09:19:28 GMT
Received: from mail.vegaa.de (mail.vegaa.de [213.203.196.181])
        by jazzband.ncsc.mil  with ESMTP id h549JRal006789 for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 09:19:28 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
To: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: postfix rules
Date: Wed, 4 Jun 2003 11:19:15 +0200
MIME-Version: 1.0
Message-Id: <200306041119.15601.carsten.grohmann@raumbildsysteme.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Russel,

I get the follow 3 messages.

Jun  4 10:17:21 comundo kernel: avc:  denied  { execute } for  
pid=528 exe=/bin/bash path=/usr/sbin/postqueue dev=03:09 ino=24929 
scontext=system_u:system_r:postfix_master_t 
tcontext=system_u:object_r:postfix_postqueue_exec_t tclass=file
Jun  4 10:17:21 comundo kernel: avc:  denied  { execute_no_trans } 
for  pid=528 exe=/bin/bash path=/usr/sbin/postqueue dev=03:09 
ino=24929 scontext=system_u:system_r:postfix_master_t 
tcontext=system_u:object_r:postfix_postqueue_exec_t tclass=file
Jun  4 10:17:21 comundo kernel: avc:  denied  { read } for  pid=528 
path=/usr/sbin/postqueue dev=03:09 ino=24929 
scontext=system_u:system_r:postfix_master_t 
tcontext=system_u:object_r:postfix_postqueue_exec_t tclass=file

I would add domain_auto_trans(postfix_master_t, 
postfix_postqueue_exec_t, postfix_postqueue_t)
,but I'm not sure.
 What do you thing?

Used postfix version 1.11

Carsten


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
