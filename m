Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA21333
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 08:52:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA00840
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 12:51:49 GMT
Received: from mail.ispko.com ([210.16.10.89])
	by jazzswing.ncsc.mil  with ESMTP id MAA00830
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 12:51:34 GMT
Message-ID: <3D13215A.6060109@evoworks.evoserve.com>
Date: Fri, 21 Jun 2002 20:51:38 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: selinux@tycho.nsa.gov
Subject: Re: selinux cramfs
References: <Pine.GSO.4.33.0206210844000.12888-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Great! I was planning to hack away already.

Stephen Smalley wrote:

>On Fri, 21 Jun 2002, Stephen Smalley wrote:
>
>>You might be able to handle cramfs to some degree using the new
>>genfs_contexts configuration, which is a generalization of devfs_contexts.
>>That isn't in the current release, but will be in the next one.
>>
>
>I just tried using genfs_contexts to specify a context for cramfs and
>then mounting a cramfs image, and it appears to work correctly.  So this
>will hopefully be addressed by the next public release.
>
>--
>Stephen D. Smalley, NAI Labs
>ssmalley@nai.com
>
>




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
