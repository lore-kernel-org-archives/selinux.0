Subject: Re: libselinux patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <796000.76802.qm@web51502.mail.yahoo.com>
References: <796000.76802.qm@web51502.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 10:15:36 -0500
Message-Id: <1172589336.19041.344.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 08:40 -0800, Steve G wrote:
> OK, I think the attached patch does _everything _ we discussed. It:
>  
>  - removes 8 syscalls for the normal path
>  - ensures /selinux is trully an selinuxfs
>  - drops back to detecting the old way when /selinux is missing
>  - changes the old way in is_enabled to use fopen & getline for glibc internal
> retries
>  - adds retry for EINTR in mls_enabled
>  - keeps SELINUX_MAGIC private
>  
>  Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>

Thanks, applied the revised (with fsetlocking calls) patch on the trunk,
libselinux 2.0.5.  Note to Chris/Dan:  "allow $1 security_t:filesystem
getattr;" should be added to selinux_get_fs_mount() in the policy to
allow the statfs() call introduced by this patch; it won't break
anything if it is missing (since it falls back to the old logic upon
failure), but it should be allowed.

I have not merged this patch onto the stable branch (libselinux 1.x)
since the patch does include a user-visible change (the
security_t:filesystem getattr permission check upon the statfs call),
even though it does fall back gracefully upon failure there.  If
desired, we could merge the rest of the changes that have no
user-visible impact on the stable branch to pick up the use of getline,
EINTR handling, and checking of selinux_mnt by is_selinux_enabled().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
