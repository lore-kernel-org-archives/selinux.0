Subject: Re: [PATCH] Fast status update interface (/selinux/status)
From: Eric Paris <eparis@redhat.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov,
        ewalsh@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <4C8F4047.5020107@ak.jp.nec.com>
References: <4C76455E.6000504@ak.jp.nec.com>
	 <4C76FDD2.4070800@ak.jp.nec.com>	<4C777958.4060500@ak.jp.nec.com>
	 <AANLkTimX8uFSE_twBw9KrUQA9+U6zLCeTZN_P0N8mT_A@mail.gmail.com>
	 <AANLkTi=SJEG45e2MZN2Cj0S4SrXqoTWtJdKXqkLKeLiV@mail.gmail.com>
	 <4C78817F.9040909@kaigai.gr.jp>  <4C7F5D45.4040901@ak.jp.nec.com>
	 <1284410701.2703.31.camel@localhost.localdomain>
	 <4C8F4047.5020107@ak.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 14 Sep 2010 09:25:28 -0400
Message-ID: <1284470728.2703.72.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-09-14 at 18:28 +0900, KaiGai Kohei wrote:

> <--------------------------------( cut here )-------------------------------->
> 
> This patch provides a new /selinux/status entry which allows applications
> read-only mmap(2).
> This region reflects selinux_kernel_status structure in kernel space.
>   struct selinux_kernel_status
>   {
>           u32     length;         /* length of this structure */
>           u32     sequence;       /* sequence number of seqlock logic */
>           u32     enforcing;      /* current setting of enforcing mode */
>           u32     policyload;     /* times of policy reloaded */
>           u32     deny_unknown;   /* current setting of deny_unknown */
>   };
> 
> When userspace object manager caches access control decisions provided
> by SELinux, it needs to invalidate the cache on policy reload and setenforce
> to keep consistency.
> However, the applications need to check the kernel state for each accesses
> on userspace avc, or launch a background worker process.
> In heuristic, frequency of invalidation is much less than frequency of
> making access control decision, so it is annoying to invoke a system call
> to check we don't need to invalidate the userspace cache.
> If we can use a background worker thread, it allows to receive invalidation
> messages from the kernel. But it requires us an invasive coding toward the
> base application in some cases; E.g, when we provide a feature performing
> with SELinux as a plugin module, it is unwelcome manner to launch its own
> worker thread from the module.
> 
> If we could map /selinux/status to process memory space, application can
> know updates of selinux status; policy reload or setenforce.
> 
> A typical application checks selinux_kernel_status::sequence when it tries
> to reference userspace avc. If it was changed from the last time when it
> checked userspace avc, it means something was updated in the kernel space.
> Then, the application can reset userspace avc or update current enforcing
> mode, without any system call invocations.
> This sequence number is updated according to the seqlock logic, so we need
> to wait for a while if it is odd number.
> 
> Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>

Acked-by: Eric Paris <eparis@redhat.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
