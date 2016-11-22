Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAMN0ett022304
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 18:00:40 -0500
Received: by mail-vk0-f67.google.com with SMTP id p9so3344568vkd.1
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 15:00:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1479204400-24557-1-git-send-email-agruenba@redhat.com>
References: <1478812710-17190-1-git-send-email-agruenba@redhat.com>
 <1478812710-17190-5-git-send-email-agruenba@redhat.com>
 <CAHC9VhSrDfGOBrw+hV8xfZ-COOjHpW_73sz7VYLMnem-szWRWA@mail.gmail.com>
 <1479204400-24557-1-git-send-email-agruenba@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Nov 2016 18:00:02 -0500
Message-ID: <CAHC9VhT6kgK9YW5F0hFuc-xqjr3AG3DqrYn+=OMqXF0dR8cHCg@mail.gmail.com>
Subject: Re: [PATCH 4/4] selinux: Convert isec->lock into a spinlock
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Nov 15, 2016 at 5:06 AM, Andreas Gruenbacher
<agruenba@redhat.com> wrote:
> On Mon, Nov 14, 2016 at 11:22 PM, Paul Moore <paul@paul-moore.com> wrote:
>> We shouldn't need the spinlocks on the socket_post_create() and the
>> socket_accept() hooks as the callers should still have exclusive
>> access to the socket/inode at that point.
>>
>> I didn't check all the callers of the inode_init_security(), but it
>> looks like the same idea applies.
>
> Indeed.  An updated patch with the unnecessary locking removed follows.
>
> Thanks,
> Andreas
>
> --
>
> Convert isec->lock from a mutex into a spinlock.  Instead of holding the
> lock while sleeping in inode_doinit_with_dentry, set isec->initialized
> to LABEL_PENDING and release the lock.  Then, when the sid has been
> determined, re-acquire the lock.  If isec->initialized is still set to
> LABEL_PENDING, set isec->sid; otherwise, the sid has been set by another
> task (LABEL_INITIALIZED) or invalidated (LABEL_INVALID) in the meantime.
>
> This fixes a deadlock on gfs2 where
>
>  * one task is in inode_doinit_with_dentry -> gfs2_getxattr, holds
>    isec->lock, and tries to acquire the inode's glock, and
>
>  * another task is in do_xmote -> inode_go_inval ->
>    selinux_inode_invalidate_secctx, holds the inode's glock, and tries
>    to acquire isec->lock.
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  security/selinux/hooks.c          | 102 +++++++++++++++++++++++---------------
>  security/selinux/include/objsec.h |   5 +-
>  2 files changed, 66 insertions(+), 41 deletions(-)

Merged with some minor tweaks to keep ./scripts/checkpatch.pl happy,
e.g. use "spinlock_t".

-- 
paul moore
www.paul-moore.com
