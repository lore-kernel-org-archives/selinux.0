Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA18720
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 07:34:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA07019
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 11:33:39 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA07015
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 11:33:39 GMT
Date: Mon, 8 Jul 2002 07:33:46 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: problem with "-" in libraries
In-Reply-To: <20020706040722.CF93D814D2@coffeesaur2.evoserve.com>
Message-ID: <Pine.GSO.4.33.0207080726530.19100-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 6 Jul 2002, Debian User wrote:

> Im developing a policy for a cramfs based selinux system. I cant specify the
> contexts for libraries with a "-" in the names like "libpthread-0.9.11.so".
> Checkpolicy does not accept such names int genfs_contexts. I am trying to work
> around this by recompiling everything using modified library names. Can the
> checkpolicy compiler be modified to accept this names?

This is a bug in the checkpolicy scanner's definition of a path token.
We'll fix it.

> Is there a way to make a setfiles like program for genfs_contexts? Im
> considering writing software to that.

I'm not sure what you mean.  If you want genfs_contexts to be more like
the file_contexts configuration, then you need something like regex(3)
in the kernel security server to perform regular expression matching.
genfs_contexts is part of the kernel policy configuration, and is used
for filesystems that do not support persistent label mappings or one of
the fixed schemes.  setfiles is an application program that creates or
updates persistent label mappings in filesystems that support them.  It
doesn't make sense to have a setfiles-like program for genfs_contexts.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
