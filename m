Message-ID: <1434210494.19134.135.camel@redhat.com>
Subject: Re: [PATCH v2] selinux: reduce locking overhead in
 inode_free_security()
From: Eric Paris <eparis@redhat.com>
To: Yury <yury.norov@gmail.com>
In-Reply-To: <557BDD44.8070804@gmail.com>
References: <1434058284-56634-1-git-send-email-Waiman.Long@hp.com>
 <557A7B91.4000502@linux.vnet.ibm.com> <557AD10D.6060200@tycho.nsa.gov>
 <557B5EBF.6010105@hp.com> <557BDD44.8070804@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 13 Jun 2015 10:48:14 -0500
Mime-Version: 1.0
Cc: Waiman Long <waiman.long@hp.com>, Scott J Norton <scott.norton@hp.com>,
 Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 Douglas Hatch <doug.hatch@hp.com>, James Morris <james.l.morris@oracle.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2015-06-13 at 10:35 +0300, Yury wrote:
> 
> On 13.06.2015 01:35, Waiman Long wrote:
> > On 06/12/2015 08:31 AM, Stephen Smalley wrote:
> > > On 06/12/2015 02:26 AM, Raghavendra K T wrote:
> > > > On 06/12/2015 03:01 AM, Waiman Long wrote:
> > > > > The inode_free_security() function just took the superblock's 
> > > > > 
> > > > > isec_lock
> > > > > before checking and trying to remove the inode security 
> > > > > struct from 
> > > > > the
> > > > > linked list. In many cases, the list was empty and so the 
> > > > > lock taking
> > > > > is wasteful as no useful work is done. On multi-socket 
> > > > > systems with
> > > > > a large number of CPUs, there can also be a fair amount of 
> > > > > spinlock
> > > > > contention on the isec_lock if many tasks are exiting at the 
> > > > > same 
> > > > > time.
> > > > > 
> > > > > This patch changes the code to check the state of the list 
> > > > > first
> > > > > before taking the lock and attempting to dequeue it. As this 
> > > > > function
> > > > > is called indirectly from __destroy_inode(), there can't be 
> > > > > another
> > > > > instance of inode_free_security() running on the same inode.
> > > > > 
> > > > > Signed-off-by: Waiman Long<Waiman.Long@hp.com>
> > > > > ---
> > > > >    security/selinux/hooks.c |   15 ++++++++++++---
> > > > >    1 files changed, 12 insertions(+), 3 deletions(-)
> > > > > 
> > > > > v1->v2:
> > > > >    - Take out the second list_empty() test inside the lock.
> > > > > 
> > > > > diff --git a/security/selinux/hooks.c 
> > > > > b/security/selinux/hooks.c
> > > > > index 7dade28..e5cdad7 100644
> > > > > --- a/security/selinux/hooks.c
> > > > > +++ b/security/selinux/hooks.c
> > > > > @@ -254,10 +254,19 @@ static void inode_free_security(struct 
> > > > > inode
> > > > > *inode)
> > > > >        struct inode_security_struct *isec = inode
> > > > > ->i_security;
> > > > >        struct superblock_security_struct *sbsec = 
> > > > > inode->i_sb->s_security;
> > > > > 
> > > > > -    spin_lock(&sbsec->isec_lock);
> > > > > -    if (!list_empty(&isec->list))
> > > > > +    /*
> > > > > +     * As not all inode security structures are in a list, 
> > > > > we 
> > > > > check for
> > > > > +     * empty list outside of the lock to make sure that we 
> > > > > won't 
> > > > > waste
> > > > > +     * time taking a lock doing nothing. As 
> > > > > inode_free_security() is
> > > > > +     * being called indirectly from __destroy_inode(), there 
> > > > > is no 
> > > > > way
> > > > > +     * there can be two or more concurrent calls. So doing 
> > > > > the
> > > > > list_empty()
> > > > > +     * test outside the loop should be safe.
> > > > > +     */
> > > > > +    if (!list_empty(&isec->list)) {
> > > > > +        spin_lock(&sbsec->isec_lock);
> > > > >            list_del_init(&isec->list);
> > > > Stupid question,
> > > > 
> > > > I need to take a look at list_del_init() code, but it can so 
> > > > happen 
> > > > that
> > > > if !list_empty() check could happen simultaneously, then 
> > > > serially two
> > > > list_del_init() can happen.
> > > > 
> > > > is that not a problem()?
> > > Hmm...I suppose that's possible (sb_finish_set_opts and
> > > inode_free_security could both perform the list_del_init).  Ok, 
> > > we'll
> > > stay with the first version.
> > > 
> > 
> > Actually, list_del_init() can be applied twice with no harm being 
> > done. The first list_del_init() will set list-> next = list->prev = 
> > 
> > list. The second one will do the same thing and so it should be 
> > safe.
> > 
> > Cheers,
> > Longman
> > 
> 
> Hello, Waiman!
> 
> At first, minor.
> For me, moving the line 'if (!list_empty(&isec->list))' out of lock 
> is 
> not possible just because 'inode_free_security' is called from 
> '__destroy_inode' only. You cannot rely on it in future. It's rather 
> possible because empty list is invariant under 'list_del_init', as 
> you 
> noted here. In fact, you can call 'list_del_init' unconditionally 
> here, 
> and condition is the only optimization to decrease lock contention. 
> So, 
> I'd like to ask you reflect it in your comment.
> 
> At second, less minor.
> Now that you access list element outside of the lock, why don't you 
> use 
> 'list_empty_careful' instead of 'list_empty'? It may eliminate 
> possible 
> race between, say, 'list_add' and 'list_empty', and costs you 
> virtually 
> nothing.

Agree, the comment isn't really accurate. list_empty() outside of the
lock is safe because there is only one place one can ever get onto the
list. If you are already off (as most inodes will be!) the lock and
remove would be completely useless.

list_empty_careful() is not safe against list_add().

http://marc.info/?l=git-commits-head&m=107277005829348

I'm not even really sure what it is safe/useful for, but the comment
does seem like it would be fine for our case. I guess it might be
appropriate with the other task calling list_del_init().  In this case,
I don't believe we care to sync at all (especially since there can't be
another task, but whatever)

In any case, I agree with v2. But if people want to be 'extra safe' v1
is fine as well, the useless conditional branch will rarely ever happen
and if it does, wouldn't be in an area i'd care about one branch
performance hit.

-Eric
