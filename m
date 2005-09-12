Subject: xfs and reiserfs broken for SELinux in latest -git (and likely
	2.6.14)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>
Content-Type: text/plain
Date: Mon, 12 Sep 2005 11:36:56 -0400
Message-Id: <1126539416.2999.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

If anyone is using xfs or reiserfs with SELinux, be aware that the
recently upstreamed patch series related to enabling atomic inode
security labeling will break the use of those filesystems with SELinux
because they have not yet been converted to the new scheme.  The changes
are in 2.6.13-git10 and later.  If this concerns you, please:
a) let us know, and
b) let the relevant maintainers of the filesystem know, encouraging them
to convert their filesystems.

I had actually suggested that the patch removing the old post hooks from
the VFS be deferred until after 2.6.14 to avoid breaking the unconverted
filesystems while still allowing the converted ones to use the new
support, but it seems my request was misunderstood.  We could possibly
ask to have the removal patch reverted, but it would be better to just
encourage the maintainers of the other filesystems to convert their code
ASAP.  We converted ext2, ext3, and tmpfs, and the jfs maintainers
converted their code in response to the original discussion on
linux-fsdevel.

See
http://marc.theaimsgroup.com/?l=linux-fsdevel&m=112082926515920&w=2
and the subsequent discussion for background on the patches.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
