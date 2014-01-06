Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s06MFHAR028374
 for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2014 17:15:17 -0500
Received: by mail-qa0-f52.google.com with SMTP id cm18so3553042qab.11
 for <selinux@tycho.nsa.gov>; Mon, 06 Jan 2014 14:15:15 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] SELinux: Fix memory leak upon loading policy
Date: Mon, 06 Jan 2014 17:12:50 -0500
Message-ID: <2121445.eP5ZhhDIJm@sifl>
In-Reply-To: <201401062128.EGC13224.HOFMOVFLFQJOtS@I-love.SAKURA.ne.jp>
References: <201401062128.EGC13224.HOFMOVFLFQJOtS@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 eparis@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Monday, January 06, 2014 09:28:15 PM Tetsuo Handa wrote:
> Hello.
> 
> I got below leak with linux-3.10.0-54.0.1.el7.x86_64 .
> 
> [  681.903890] kmemleak: 5538 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> 
> Below is a patch, but I don't know whether we need special handing for
> undoing ebitmap_set_bit() call.
> ----------
> 
> >From fe97527a90fe95e2239dfbaa7558f0ed559c0992 Mon Sep 17 00:00:00 2001
> 
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Mon, 6 Jan 2014 16:30:21 +0900
> Subject: [PATCH] SELinux: Fix memory leak upon loading policy
> 
> Commit 2463c26d "SELinux: put name based create rules in a hashtable" did
> not check return value from hashtab_insert() in filename_trans_read(). It
> leaks memory if hashtab_insert() returns error.
> 
>   unreferenced object 0xffff88005c9160d0 (size 8):
>     comm "systemd", pid 1, jiffies 4294688674 (age 235.265s)
>     hex dump (first 8 bytes):
>       57 0b 00 00 6b 6b 6b a5                          W...kkk.
>     backtrace:
>       [<ffffffff816604ae>] kmemleak_alloc+0x4e/0xb0
>       [<ffffffff811cba5e>] kmem_cache_alloc_trace+0x12e/0x360
>       [<ffffffff812aec5d>] policydb_read+0xd1d/0xf70
>       [<ffffffff812b345c>] security_load_policy+0x6c/0x500
>       [<ffffffff812a623c>] sel_write_load+0xac/0x750
>       [<ffffffff811eb680>] vfs_write+0xc0/0x1f0
>       [<ffffffff811ec08c>] SyS_write+0x4c/0xa0
>       [<ffffffff81690419>] system_call_fastpath+0x16/0x1b
>       [<ffffffffffffffff>] 0xffffffffffffffff
> 
> However, we should not return EEXIST error to the caller, or the systemd
> will show below message and the boot sequence freezes.
> 
>   systemd[1]: Failed to load SELinux policy. Freezing.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/selinux/ss/policydb.c |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index f6195eb..c8985db 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1941,7 +1941,19 @@ static int filename_trans_read(struct policydb *p,
> void *fp) if (rc)
>  			goto out;
> 
> -		hashtab_insert(p->filename_trans, ft, otype);
> +		rc = hashtab_insert(p->filename_trans, ft, otype);
> +		if (rc) {
> +			/*
> +			 * Do not return -EEXIST to the caller, or the system
> +			 * will not boot.
> +			 */
> +			if (rc != -EEXIST)
> +				goto out;
> +			/* But free memory to avoid memory leak. */
> +			kfree(ft);
> +			kfree(name);
> +			kfree(otype);
> +		}
>  	}
>  	hash_eval(p->filename_trans, "filenametr");
>  	return 0;

Thanks for sending this patch.  Mimi found a similar issue a little while ago 
and found a number of hashtab_insert() failures which were causing a fair 
number of memory leaks.

I'm not going to merge this patch at the moment.  While we should check the 
return value of hashtab_insert(), and fix the memory leaks when it fails, I 
still want to better understand why that hashtab_insert() function is failing 
in the first place on what would appear to be a "normal" operation.  Ideally 
we would first resolve the hashtab_insert() failures, then we could check the 
return value, release the memory when necessary, and return errors to the 
caller.

-- 
paul moore
www.paul-moore.com
