Subject: RE: Problems with MCS/Targeted policy update.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>, SELinux-dev@tresys.com,
   "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>,
   "'James Morris'" <jmorris@redhat.com>, "'SELinux'" <SELinux@tycho.nsa.gov>
In-Reply-To: <200508251519.j7PFJTss003144@gotham.columbia.tresys.com>
References: <200508251519.j7PFJTss003144@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 12:14:40 -0400
Message-Id: <1124986480.3873.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-08-25 at 11:19 -0400, Karl MacMillan wrote:
> This is a problem in other places as well - particularly when the on-disk
> contexts are invalid. It would be ideal to have interfaces to retrieve both the
> on-disk label (for relabeling based on old, possibly invalid contexts) and the
> label being used by the kernel.

Yes, that has been discussed in the past, but no real consensus on the
right approach.  The generic VFS fallback for security xattrs patch
seems to be going forward, so that at least allows us to get the incore
inode security label for filesystems that do not support xattrs, but it
doesn't help with the inconsistent xattr/label problem on filesystems
that do support xattrs.

In general we don't want applications to have to deal with the notion
that there are two distinct labels at all, so we'd just like to ensure
consistency whenever possible.  We could possibly export a selinuxfs
interface for querying the incore inode security label of a given file,
but it seems rather ugly, and most applications are just going to call
getfilecon/getxattr for normal work.

>  Resetting the on-disk xattr seems like the
> better choice of the two you gave to me because it could be generalized to
> handle the invalid context case, but we would lose the ability to change the
> label based on the previous label.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
