Subject: Re: [PATCH] Fast status update interface (/selinux/status)
From: Eric Paris <eparis@redhat.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov,
        ewalsh@tycho.nsa.gov
In-Reply-To: <4C7F5D45.4040901@ak.jp.nec.com>
References: <4C76455E.6000504@ak.jp.nec.com>
	 <4C76FDD2.4070800@ak.jp.nec.com>	<4C777958.4060500@ak.jp.nec.com>
	 <AANLkTimX8uFSE_twBw9KrUQA9+U6zLCeTZN_P0N8mT_A@mail.gmail.com>
	 <AANLkTi=SJEG45e2MZN2Cj0S4SrXqoTWtJdKXqkLKeLiV@mail.gmail.com>
	 <4C78817F.9040909@kaigai.gr.jp>  <4C7F5D45.4040901@ak.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 13 Sep 2010 16:45:01 -0400
Message-ID: <1284410701.2703.31.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-09-02 at 17:16 +0900, KaiGai Kohei wrote:
> (2010/08/28 12:24), KaiGai Kohei wrote:
> > (2010/08/28 1:19), Eric Paris wrote:
> >> On Fri, Aug 27, 2010 at 11:48 AM, Eric Paris<eparis@parisplace.org>   wrote:
> >>> 2010/8/27 KaiGai Kohei<kaigai@ak.jp.nec.com>:
> >>>> I revised the /selinux/status implementation.
> >>>>
> >>>> * It becomes to report 'deny_unknown'. Userspace object manager
> >>>>    also reference this flag to decide its behavior when the loaded
> >>>>    policy does not support expected object classes.
> >>>> * It provided PAGE_READONLY to remap_pfn_range() as page protection
> >>>>    flag independent from argument of mmap(2), but it was uncommon.
> >>>>    I fixed to pass vma->vm_page_prot instead of the hardwired flag
> >>>>    according to any other implementation style.
> >>>>    Now it returns an error, if user tries to map /selinux/status as
> >>>>    writable pages.
> >>>
> >>> I really hate blowing 4k of memory on every system to show 40 bytes of
> >>> data on just a few systems.  Is there any change we could allocate the
> >>> page the first time it is needed rather that at boot?  I know compared
> >>> to the size of policy and other memory usage in SELinux it's odd for
> >>> me to complain, but I've decided to get on a reduction if possible
> >>> kick.
> >>>
> >>> Only other comment is that __initcall() is deprecated and we are
> >>> supposed to use device_initcall() now.
> >>>
> >>> If you plan to use it, I'll ack if you change both of those things....
> >>
> >> actually if you move to dynamic allocation of the status page and use
> >> static DEFINE_SPINLOCK instead of static spinlock_t you can get rid of
> >> the __init() code altogether....
> >>
> > 
> > I revised the patch.
> > It was changed the selinux_kernel_page being allocated at the first time
> > when application tries to reference the /selinux/status.
> > At the same time, it declares selinux_status_lock using DEFINE_MUTEX(),
> > so whole of the __init section has gone.
> > 
> > In addition, I changed first member of the selinux_kernel_status from
> > 'length' to 'version', because sizeof(struct ...) is aligned to 64bit
> > boundary (24bytes) on x86_64 system, although it is actually 20bytes.
> > If we want to add a 32bit member in the future, 'length' may not inform
> > applications enough.
> > 
> How about getting the feature?
> Although I've not found out this idea for a long time, it is quite helpful
> feature to implement SE-PostgreSQL (and other upcoming userspace object
> managers) in less invasive way.
> 
> I fixed up two minor points in the patch, as follows:
> * The 4K of status page becomes allocated at the file_operations::open()
>   method, because it seems to me a bit unnatural that either read() or
>   mmap() fails due to memory allocation error.
> * I forgot to eliminate an unnecessary declaration of extern variable.
> 
>  Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>

Sorry I was on vacation for the last 2 weeks.  I'm happy with it so:

Acked-by: Eric Paris <eparis@redhat.com>

As to one comment in the code:

+ * In addition, application should also checks the sequence number at
+ * tail of the access control routine. If it is changed from the value
+ * on the head, it means kernel status was changed under processing the
+ * routine. In this case, application should repeat to run the routine
+ * from head, but we expect it is much rare case.

Is this just to eliminate the race where:

userspace checks seqno
				kernel loads new policy
userspace avc responds to request

but the response 'should' have been different thanks to the policy load
that the userspace object manager didn't hear?  I claim there is no race
here, since he request had to be made before the policy load, even if
the userspace AVC didn't respond until after the load.

I just don't see where closing that 'race' actually improves security.
The application is going to actually do the privileged operation some
time after the access check.  So what we have today seems just as good
when we consider the set of operations

userspace checks seqno
userspace avc respond to request
userspace checks seqno
				kernel loads new policy
userspace actually performs priv operation.

Doesn't change the patch at all, I just think it makes your test case
looks a lot worse than it needs to.

I wonder what your results are when you use the separate thread method
which doesn't have anything expect 1,000,000 calls to avc_has_perm().
Doesn't matter just me wondering out loud and wondering if there is any
reason to use the separate thread implementation if this is just about
as fast.

-Eric



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
