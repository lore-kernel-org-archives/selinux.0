Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA10478
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 14:10:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA00191
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 18:09:27 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id SAA00186
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 18:09:27 GMT
Date: Thu, 22 Aug 2002 14:10:17 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "M. H." <metalhead00@hotmail.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: restrict access by user identity
In-Reply-To: <F41O9vchHWvVZ9YbfAd0000ccf5@hotmail.com>
Message-ID: <Pine.GSO.4.33.0208221358250.29931-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 22 Aug 2002, M. H. wrote:

> I would like to be able to do the following thing:
> Let's assume I set the type of a file to type_a.
> I would like to be able to ensure that users who can read files of type_a
> can only do so for files which are labeled with their name (so the scontext
> of the file is <username>:object_r:type_a.) So userA would then not be able
> to read a file labeled with userB:object_r:type_a.
> Is this possible?

You could try to implement such a restriction via the policy/constraints
configuration (see the Configuring the SELinux Policy report).  However, I
wouldn't recommend this approach.  The preferred approach would be to
define separate types for userA's objects and userB's objects, with
separate domains and roles for userA and userB.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
