Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA21370
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 08:54:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA00982
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 12:54:16 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA00978
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 12:54:14 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>,
        Debian User <rogelio@evoworks.evoserve.com>
Subject: Re: selinux cramfs
Date: Fri, 21 Jun 2002 14:54:26 +0200
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0206210844000.12888-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0206210844000.12888-100000@raven>
MIME-Version: 1.0
Message-Id: <20020621125427.228C41EE0@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 21 Jun 2002 14:45, Stephen Smalley wrote:
> On Fri, 21 Jun 2002, Stephen Smalley wrote:
> > You might be able to handle cramfs to some degree using the new
> > genfs_contexts configuration, which is a generalization of
> > devfs_contexts. That isn't in the current release, but will be in the
> > next one.
>
> I just tried using genfs_contexts to specify a context for cramfs and
> then mounting a cramfs image, and it appears to work correctly.  So this
> will hopefully be addressed by the next public release.

Excellent!

Howard, when is the next release scheduled?


Stephen,  I'm just about to test those patches you sent me.



Russell Coker

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
