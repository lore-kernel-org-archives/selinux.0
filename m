Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA05993
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 09:48:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA16835
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 13:47:38 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id NAA16831
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 13:47:38 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        "'Russell Coker'" <russell@coker.com.au>
Cc: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: cleaning psidfiles database
Date: Wed, 10 Jul 2002 09:48:12 -0400
Message-ID: <007601c22818$6ee1e7a0$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.33.0207100717310.26546-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Speaking of make relabel.  Would it not be a good idea to run a relabel
at boot time?

Ed

=> -----Original Message-----
=> From: owner-selinux@tycho.nsa.gov
[mailto:owner-selinux@tycho.nsa.gov] On
=> Behalf Of Stephen Smalley
=> Sent: Wednesday, July 10, 2002 7:36 AM
=> To: Russell Coker
=> Cc: SE Linux
=> Subject: Re: cleaning psidfiles database
=> 
=> 
=> On Wed, 10 Jul 2002, Russell Coker wrote:
=> 
=> > psidfiles_init:  error 22 in obtaining SID for context
=> > system_u:object_r:dmesg_exec_t (psid 9).
=> > psidfiles_init:  error 22 in obtaining SID for context
=> > system_u:object_r:mesg_exec_t (psid 107).
=> >
=> > As a follow up to my previous messages on the topic of psidfiles,
if
=> the root
=> > file system is mounted without a valid policy (or if an initrd is
used
=> that
=> > doesn't have a valid policydb) then messages such as the above
appear
=> for all
=> > types that used to be applied to files on the file system.  The
above
=> two
=> > examples are for file types that were not used for several months!
=> 
=> What previous messages on the topic of psidfiles?  Are you referring
back
=> to the "Major reduction in errors" thread?
=> 
=> You can use 'make reset' in the policy directory to recreate the
=> persistent label mappings from scratch, purging any obsoleted
entries.
=> 
=> --
=> Stephen D. Smalley, NAI Labs
=> ssmalley@nai.com
=> 
=> 
=> 
=> 
=> --
=> You have received this message because you are subscribed to the
selinux
=> list.
=> If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov
=> with
=> the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
