Subject: Re: How should we handle automount.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <427640CB.80702@redhat.com>
References: <427640CB.80702@redhat.com>
Content-Type: text/plain
Date: Mon, 02 May 2005 13:12:04 -0400
Message-Id: <1115053924.1712.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-05-02 at 11:01 -0400, Daniel J Walsh wrote:
> Needs to be able to create/remove mounton arbitrary directories in 
> arbitrary locations?

Allowing it to do so on arbitrary directories doesn't seem desirable,
any more than allowing mount to mount on arbitrary directories.  Can we
identify a reasonable set of mount point directories that might be used
by automount?

> file_domain_auto_trans(automount_t, file_type, autofs_t, dir)  ????

s/domain/type

autofs_t is for the autofs inodes themselves, so I don't think you want
to apply them to the mount point directories.  Does automount always re-
create the mount point directory, or does it re-use one if it already
exists?

> Then how do we allow automount to delete the directory?

It would need permissions to the parent, so you need to be able to
enumerate or identify by attribute what directory types might be used.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
