Subject: Re: I would like to propose some kind of consolidation of tmpfs_t
	and tmp_t
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <1111675057.12486.39.camel@moss-spartans.epoch.ncsc.mil>
References: <4242CABC.70400@redhat.com>
	 <1111675057.12486.39.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 12:30:58 -0500
Message-Id: <1111685458.13486.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-24 at 09:37 -0500, Stephen Smalley wrote:
> For /tmp, a fscontext= mount seems to have an issue in that it is still
> using type transitions for labeling inodes (including the root), so we
> end up with mount_tmp_t on /tmp at least under strict policy.  Possibly
> we could/should change the way that works for the root inode.

Possible workaround - mount with fscontext=, then run restorecon /tmp
(not recursively, just on the top-level directory) from rc.sysinit.
That would get us tmp_t on the superblock and tmp_t on the root
directory.  Then you just need a few policy modifications like allow
tmpfile_t tmp_t:filesystem associate;, and you still can perform
[gs]etfilecon and setfscreatecon on the filesystem.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
