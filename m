Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA01049
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 10:37:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA19935
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 14:35:56 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA19923
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 14:35:54 GMT
Date: Tue, 8 Oct 2002 10:36:38 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: /proc file context
In-Reply-To: <20021008162610.B5457@lemuria.org>
Message-ID: <Pine.GSO.4.33.0210081035310.25356-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 8 Oct 2002, Tom wrote:

> I noticed that the Debian sid default policy seems to be lacking
> file_context entries for /proc. Not a problem if you are using procfs.
> If you don't, maybe this patch to file_contexts/types.fc is useful
> (all types taken from the procfs.te file).
> I'm almost certain these file contexts were present in an earlier
> default policy, so it's likely that they just were ommitted.

If you aren't using procfs, why would you have /proc entries at all?
procfs contexts are handled via genfs_contexts.  It doesn't make sense to
have file contexts entries for /proc, as they are only used for creating
persistent label mappings on persistent filesystems.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
