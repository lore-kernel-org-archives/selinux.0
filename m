From: Andrew Perepechko <anserper@ya.ru>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-security-module@vger.kernel.org, andrew.perepechko@seagate.com,
 selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: export validatetrans decisions
Date: Tue, 27 Oct 2015 22:25:50 +0300
Message-ID: <1906418.tuE4tFhnmG@panda-pc>
In-Reply-To: <562FC685.503@tycho.nsa.gov>
References: <1445965643-30900-1-git-send-email-anserper@ya.ru>
 <3826370.MZ6nvm2ybe@panda-pc> <562FC685.503@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday 27 Oct 2015 14:46:29 Stephen Smalley wrote:
> >> Why PAGE_SIZE-1?
> > 
> > This is to avoid allocation of more than a single page.
> 
> Yes, but you don't need PAGE_SIZE - 1 for that.  The check can just be
> 
>  >= PAGE_SIZE, as used elsewhere in selinuxfs.c.

A sequence of bytes passed to a write handler may not be 0-terminated,
so it cannot be used directly as a scanf argument.

As far as I can see, compute_av and similar handlers use transaction ops,
which have more or less similar condition:

char *simple_transaction_get(struct file *file, const char __user *buf, size_t size)
{
        struct simple_transaction_argresp *ar;
        static DEFINE_SPINLOCK(simple_transaction_lock);

        if (size > SIMPLE_TRANSACTION_LIMIT - 1)
                return ERR_PTR(-EFBIG);

SIMPLE_TRANSACTION_LIMIT is PAGE_SIZE subtracted by sizeof(ssize_t).

Since the buffer is the result of get_zeroed_page(), it is guaranteed to
be 0-terminated: [ssize_t][SIMPLE_TRANSACTION_LIMIT-1][\0].

On the other hand, e.g. sel_write_checkreqprot() does not look correct, since
the only reason that it won't access beyond page boundary on incorrect
4096-byte input is if sscanf stops parsing a number after integer overflow
happens.
