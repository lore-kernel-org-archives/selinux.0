Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA05020
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 07:36:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA10298
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 11:35:43 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA10294
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 11:35:43 GMT
Date: Wed, 10 Jul 2002 07:35:38 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: cleaning psidfiles database
In-Reply-To: <20020710102149.8E9C6269F@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0207100717310.26546-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 10 Jul 2002, Russell Coker wrote:

> psidfiles_init:  error 22 in obtaining SID for context
> system_u:object_r:dmesg_exec_t (psid 9).
> psidfiles_init:  error 22 in obtaining SID for context
> system_u:object_r:mesg_exec_t (psid 107).
>
> As a follow up to my previous messages on the topic of psidfiles, if the root
> file system is mounted without a valid policy (or if an initrd is used that
> doesn't have a valid policydb) then messages such as the above appear for all
> types that used to be applied to files on the file system.  The above two
> examples are for file types that were not used for several months!

What previous messages on the topic of psidfiles?  Are you referring back
to the "Major reduction in errors" thread?

You can use 'make reset' in the policy directory to recreate the
persistent label mappings from scratch, purging any obsoleted entries.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
