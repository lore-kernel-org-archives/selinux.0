Date: Fri, 15 Mar 2002 10:31:04 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: =?iso-8859-1?Q?Vanuxem_gr=E9gory?= <gvanuxem@club-internet.fr>
cc: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: your mail
In-Reply-To: <ADEEIKPBIEHIINPOFGAOIECBCBAA.gvanuxem@club-internet.fr>
Message-ID: <Pine.GSO.4.33.0203150952010.15480-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 15 Mar 2002, [iso-8859-1] Vanuxem grégory wrote:

> I try to record the PSID directly in some attribute of inodes. Particularly
> in xfs.
> What do you think about that ?

This has come up previously on the mailing list, so you might want to
review the mailing list archives.  A brief review:

In the original SELinux kernel patch, we stored the PSID directly in a
spare field of the on-disk ext2 inode.  When SELinux was re-implemented to
use the LSM kernel patch, the persistent label mapping was changed to
maintain the inode-to-PSID mapping in a regular file rather than using a
field in the inode since LSM does not provide any low-level
filesystem-specific hooks.  That change allows SELinux to support other
filesystem types more easily, but has disadvantages in terms of
performance and consistency.

As support for extended attributes becomes mainstreamed, I'd like to see
SELinux enhanced to optionally use them for persistent labeling when they
are supported by the filesystem type.  This seems reasonable for XFS (but
see my earlier email regarding other issues with using XFS -
http://marc.theaimsgroup.com/?l=selinux&m=101300861319394&w=2).

Storing PSIDs via extended attributes is certainly one option.  Another
option would be to directly store file security contexts using extended
attributes, completely eliminating the separate persistent label mapping.
Regardless, you need to ensure that any changes you make don't prevent
SELinux from continuing to work with filesystems that do not support EAs.

> Another question, why the mapping inode->psid is always record in the file
> ...security/inode.
> For example, if I mount a file system that contained 50 differents types of
> files (context),the SECFILES keep all the mapping. Now I have just three
> types for the initialization, the root dir type, the fs type and the
> "file_t" type but the avc keep the precedent mapping (50 psids and
> contexts).

I'm not sure what you are asking.  The SELinux kernel module opens the
mapping files and does an initial load of the PSID-to-context mapping at
mount time.  The incore cache for the PSID-to-context mapping is for
performance.  The inode-to-PSID mapping would be too large to keep incore.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
