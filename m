Date: Wed, 6 Feb 2002 12:32:51 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Scott Shealy <sshealy@asgnet.psc.sc.edu>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: NFS Volumes
In-Reply-To: <MILLuxUv7NXraBMOkKj00000025@mill>
Message-ID: <Pine.GSO.4.33.0202061149510.27827-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 6 Feb 2002, Scott Shealy wrote:

> At the current time with the current default installation how are NFS mounted
> volumes treated?  What are my options....

If you mount a NFS filesystem, all files will initially appear with a
default security context (system_u:object_r:nfs_t).  You can subsequently
relabel the files via setfiles, but any such changes will be
local to the client (not visible elsewhere) and transient (not persisting
across reboots).  If you have an essentially static file security contexts
mapping, you can have the clients apply it during bootup by running
setfiles on an appropriate file_contexts configuration from an rc script.
This will be more complicated if your root filesystem is NFS.  In any
event, it will likely require some policy changes.

Even if you have created a persistent label mapping on the filesystem (by
running setfiles on the NFS server), a SELinux kernel on the NFS client
won't try to use it at present.  This is because there is no mechanism
implemented to coordinate updates to the mapping among the clients, so it
would not be safe to access it.  Furthermore, the mapping may not even be
accessible to clients due to either mount restrictions or mounting a
subdirectory of the filesystem.


--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
