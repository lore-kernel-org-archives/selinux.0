Date: Mon, 17 Dec 2001 07:29:44 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Hans Reiser <reiser@namesys.com>
cc: forrest whitcher <fw@fwsystems.com>, <SELinux@tycho.nsa.gov>
Subject: Re: persistent labelling on afs, jfs, xfs?
In-Reply-To: <3C1B64C5.4000207@namesys.com>
Message-ID: <Pine.GSO.4.33.0112170709420.10438-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 15 Dec 2001, Hans Reiser wrote:

> We currently have unique and persistent inode numbers (at least until we
> someday write a repacker that will optimize key assignments for better
> layout), but you can't use them for finding files that are not in the
> cache.  To find such files requires a key.

SELinux uses the inode number as an identifier for the file in the
persistent label mapping in each filesystem.   So it doesn't find files
based on the inode number, but it needs each file in a filesystem to have
a unique and persistent inode number.  It sounds like reiserfs does
currently provide this property.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
