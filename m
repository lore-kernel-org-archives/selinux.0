Date: Fri, 22 Jun 2001 16:15:23 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Matt Jezorek <mjezorek@usa.net>
cc: SELinux@tycho.nsa.gov
Subject: Re: [Re: selinux included in new distro]
In-Reply-To: <20010622184131.27121.qmail@nwcst287.netaddress.usa.net>
Message-ID: <Pine.SOL.3.95.1010622155240.10847O-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 22 Jun 2001, Matt Jezorek wrote:

> P.S. anyone successfully patched selinux with XFS?

The SELinux kernel patch only provides file labeling support
for ext2 file systems.  To use the SELinux kernel patch with XFS 
(or any other file system type other than ext2), you would need to
implement support for binding persistent security identifiers (PSIDs) 
to files in that file system type. Otherwise, your files won't be labeled 
with security information.  With ext2, we used a spare field in the on-disk 
inode to store the PSID - see our changes to the files under
slinux/kernel-2.4/fs/ext2.  Using a spare field in the existing on-disk
inode avoids the need to maintain a separate on-disk mapping between
inodes and PSIDs.  With XFS, you would probably implement equivalent
support using extended attributes.  Our expectation was that the
persistent label mapping would ultimately be replaced by
extended attributes if/when extended attributes become part of the
mainstream Linux kernel.

The new LSM-based SELinux loadable kernel module uses a different
approach than the SELinux kernel patch since LSM does not provide us with
access to the on-disk inode.  It maintains a separate on-disk mapping
between inodes and PSIDs, costing us in performance but providing more
general support for a variety of file systems.  We also used this
same approach in the predecessor of SELinux, the Flask prototype.
This support could also be integrated into the SELinux kernel patch.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
