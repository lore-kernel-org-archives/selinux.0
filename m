Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA08344
	for <selinux@tycho.nsa.gov>; Fri, 5 Jul 2002 08:28:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA13277
	for <selinux@tycho.nsa.gov>; Fri, 5 Jul 2002 12:27:36 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA13273
	for <selinux@tycho.nsa.gov>; Fri, 5 Jul 2002 12:27:36 GMT
Date: Fri, 5 Jul 2002 08:28:03 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: using genfs_context and cramfs
In-Reply-To: <3D240BFE.4000909@evoworks.evoserve.com>
Message-ID: <Pine.GSO.4.33.0207050824590.29942-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 4 Jul 2002, Debian User wrote:

> i can already mount a cramfs_file and it get labeled with "cramfs_t"
> i relabeled the directory where i built the cramfs from but when i mount
> it via loopback. the labels are still cramfs. How do we use the fs image
> as a root fs then?

You need to fully specify your desired security contexts in the
genfs_contexts configuration for cramfs.  This will likely be a subset of
the portion of the file_contexts configuration for the root filesystem,
except that you need to specify pathname prefixes rather than pathname
regular expressions.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
