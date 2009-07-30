Subject: Re: is it safe to use ext4 for SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4A7083DB.4000003@gmail.com>
References: <4A7083DB.4000003@gmail.com>
Content-Type: text/plain
Date: Thu, 30 Jul 2009 09:02:16 -0400
Message-Id: <1248958936.11627.122.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-29 at 10:16 -0700, Justin P. Mattock wrote:
> I've just downloaded the fedora 11 livecd and am installing it on an
> imac. during the partition scheme should I use ext4,
> or stick with ext3 for SELinux to function properly?

The current policy is configured to use xattrs on any of these
filesystems:
$ grep '^fs_use_xattr' policy.conf 
fs_use_xattr btrfs system_u:object_r:fs_t;
fs_use_xattr encfs system_u:object_r:fs_t;
fs_use_xattr ext2 system_u:object_r:fs_t;
fs_use_xattr ext3 system_u:object_r:fs_t;
fs_use_xattr ext4 system_u:object_r:fs_t;
fs_use_xattr ext4dev system_u:object_r:fs_t;
fs_use_xattr gfs system_u:object_r:fs_t;
fs_use_xattr gfs2 system_u:object_r:fs_t;
fs_use_xattr jffs2 system_u:object_r:fs_t;
fs_use_xattr jfs system_u:object_r:fs_t;
fs_use_xattr lustre system_u:object_r:fs_t;
fs_use_xattr xfs system_u:object_r:fs_t;

As to whether or not they all truly work, I don't know.
I have used ext4 though without any selinux problems, and btrfs has been
reported to work as well.

I also saw some fixes for reiserfs support for security.* attributes get
committed earlier this year, so possibly we could move reiserfs back to
the fs_use_xattr list.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
