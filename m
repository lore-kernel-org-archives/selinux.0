Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA23888
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 12:49:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA12197
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 17:47:54 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA12193
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 17:47:53 GMT
Date: Wed, 20 Mar 2002 12:48:40 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
In-Reply-To: <20020320171217.2BF8A3CF33@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203201230580.11981-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 20 Mar 2002, Russell Coker wrote:

> I don't like that idea at all.  Having two sources for the same data is
> guaranteed to cause you trouble.
>
> What benefit is there to using chsid instead of a hacked setfiles?

Perhaps there isn't any.

setfiles was designed to set the security contexts for the entire
filesystem in accordance with an overall configuration.  The intent was to
only use it during installation to initialize the mappings and optionally
later to reset the mappings to the initial state again.  You might also
use it to implement wholesale changes to the mappings due to a major
policy change.

Once you've initialized the mappings and are running a SELinux kernel, the
mappings are maintained dynamically by the kernel to reflect create,
delete, and relabel (chsid) operations.  At that point, you can set the
security context for particular files in a similar manner to the Unix
ownership and mode via chcon or the modified file utilities.  Even apart
from chsid operations, there will be some drift from the original setfiles
configuration as new files are created, particularly when file type
transition rules are defined that deviate from the parent directory's
type.

When a new package is installed on a system running SELinux, I expected
chcon or the modified file utilities to be used to set the security
context appropriately for its files in a similar manner to the use
of chown/chmod or the existing file utilities for setting the Unix
attributes.  But it also seems necessary to update the setfiles
configuration for future installations, resets, or major policy changes.
So perhaps a hacked setfiles is a good idea.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
