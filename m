Date: Thu, 24 Mar 2005 22:11:08 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>, Russell Coker <russell@coker.com.au>
Subject: Re: I would like to propose some kind of consolidation of tmpfs_t and tmp_t
Message-ID: <20050324221107.GD8553@lkcl.net>
References: <4242CABC.70400@redhat.com> <1111675057.12486.39.camel@moss-spartans.epoch.ncsc.mil> <1111685458.13486.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1111685458.13486.61.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Mar 24, 2005 at 12:30:58PM -0500, Stephen Smalley wrote:
> On Thu, 2005-03-24 at 09:37 -0500, Stephen Smalley wrote:
> > For /tmp, a fscontext= mount seems to have an issue in that it is still
> > using type transitions for labeling inodes (including the root), so we
> > end up with mount_tmp_t on /tmp at least under strict policy.  Possibly
> > we could/should change the way that works for the root inode.
> 
> Possible workaround - mount with fscontext=, then run restorecon /tmp
> (not recursively, just on the top-level directory) from rc.sysinit.

 i found that i had to do this for /dev on debian, when running udev.

 bearing in mind that udev on debian is NOT started from the
 initrd like wot it is in fedora, it's started from /etc/init.d
 very early on (priority 2 or 3).

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
