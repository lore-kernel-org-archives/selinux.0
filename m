Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJKwQRb020619
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 15:58:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAJKvtp5006220
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 20:57:55 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id hAJKvrt0006217
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 20:57:54 GMT
Date: Wed, 19 Nov 2003 15:58:12 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?= <monteiro@ipen.br>
cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: Extended attributes and ACLs in SELinux
In-Reply-To: <3FBBB2F1.6020505@ipen.br>
Message-ID: <Xine.LNX.4.44.0311191556340.11537-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Nov 2003, Carlos Anísio Monteiro wrote:

> Helo.
> 
> Please, I need of a information, how SELinux use "extended attributes 
> and ACLs". Thus, I will can understand why enable this options in the 
> kernel configuration.

SELinux uses extended attributes to store security contexts for files, in 
the security.selinux namespace.

It does not use ACLs.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
