Subject: Re: Where is the AVC?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Salvo Giuffrida <giuffsalvo@hotmail.it>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BAY114-F1FFF391047B48196CAC48AF180@phx.gbl>
References: <BAY114-F1FFF391047B48196CAC48AF180@phx.gbl>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 13:20:52 -0400
Message-Id: <1159550452.8496.152.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-29 at 18:08 +0200, Salvo Giuffrida wrote:
> >From reading the book "SELinux by example", it seems that the AVC is managed 
> by the Security Server (figure 3-2). Instead, by reading the paper "The 
> Flask Security Architecture: System support for Diverse Security Policies" 
> in the NSA website, it looks like the AVC is managed by the Object Managers 
> (why the plural? I though that there was just one object manager, but maybe 
> it's because I was thinking only about files...So, there's an object manager 
> for every macro-class of objects (files, processes, network objects?)?). Who 
> is wrong and who is right?

An object manager gets access decisions from its AVC, which consults the
security server when the decision isn't already cached.  Meanwhile, if a
policy change occurs, the security server needs to notify the AVCs of
all object managers of the change so that their state can be updated (in
simplest form, by flushing the caches).  There can be any number of
object managers.  In Linux, the entire kernel is really a single object
manager, but in earlier microkernel-based systems, there were separate
object managers for process management, filesystems, and networking.
Further, even in Linux, there are userspace object managers that need to
enforce policy over their own objects and operations, like D-BUS, X,
Postgres, etc.  The architecture itself is general and widely
applicable.  I doubt there is any real contradiction between the book
and the paper, but the paper is obviously the more authoritative
description of the architecture.  When in doubt, I'm always right ;)

> Another thing: the security context of files, in ext2/ext3/jfs/xfs 
> filesystems is memorized in the xattr space of inodes, in the attribute 
> security.selinux. But, is it memorized in the string form (user:role:type), 
> or in the PSID form (the 32-integer which is mapped by the Security Server 
> into a "true" security context)? Doing "getfattr -n security.selinux file" 
> on a file gives me the string rapresentation of the Security Context, but 
> also on objects like /dev/men...

String form.  To clarify:
1) PSIDs or persistent SIDs were an artifact of the original SELinux
implementation before we migrated to using extended attributes (which
were not yet in the mainline kernel at the time we first developed
SELinux).  They do not exist at all in the current SELinux.  They were
integers that indexed to security contexts in a mapping database in each
filesystem, with the integers then stored in a field of the on-disk
inode.  The security server had no awareness of them.
2) SIDs are non-persistent, local handles (integers) that refer to
security contexts and are mapped by the security server.  They still
exist, but the kernel SIDs are now private to the kernel and not
exported to userspace, unlike the original SELinux.  Userspace programs
can create their own userspace SID mappings via the libselinux AVC,
which is used by e.g. D-BUS and XSELinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
