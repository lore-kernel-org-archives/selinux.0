Message-ID: <1526405695.5019.2.camel@btinternet.com>
From: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Date: Tue, 15 May 2018 18:34:55 +0100
In-Reply-To: <2775c733-c8e8-f25b-884f-0a03d6e26b9a@tycho.nsa.gov>
References: <20180515082553.30310-1-richard_c_haines@btinternet.com>
 <0c5025b1-b90e-3e8f-b6f9-7ff080f5f772@tycho.nsa.gov>
 <0193e640-4792-57b1-2408-a6944731baf4@tycho.nsa.gov>
 <f662a095-582f-3e00-1e53-e4c3ba1f6ed3@tycho.nsa.gov>
 <2775c733-c8e8-f25b-884f-0a03d6e26b9a@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC PATCH 1/1] selinux-testsuite: Add binder tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2018-05-15 at 12:56 -0400, Stephen Smalley wrote:
> On 05/15/2018 12:38 PM, Stephen Smalley wrote:
> > On 05/15/2018 09:43 AM, Stephen Smalley wrote:
> > > On 05/15/2018 09:36 AM, Stephen Smalley wrote:
> > > > This test is failing for me (with or without -v):
> > > > # ./test -v
> > > > 1..6
> > > > Manager PID: 5608 Process context:
> > > > 	unconfined_u:unconfined_r:test_binder_mgr_t:s0-
> > > > s0:c0.c1023
> > > > Client PID: 5609 Process context:
> > > > 	unconfined_u:unconfined_r:test_binder_client_t:s0-
> > > > s0:c0.c1023
> > > > Client read_consumed: 28
> > > > Manager read_consumed: 72
> > > > Client command: BR_NOOP
> > > > Manager command: BR_NOOP
> > > > Client command: BR_INCREFS
> > > > Manager command: BR_TRANSACTION
> > > > Client command: BR_TRANSACTION_COMPLETE
> > > > BR_TRANSACTION data:
> > > > 	handle: 0
> > > > 	cookie: 0
> > > > 	code: 0
> > > > 	flag: TF_ACCEPT_FDS
> > > > 	sender pid: 5609
> > > > 	sender euid: 0
> > > > 	data_size: 24
> > > > 	offsets_size: 8
> > > > Sending BC_REPLY
> > > > Manager read_consumed: 8
> > > > Manager command: BR_NOOP
> > > > Manager command: BR_TRANSACTION_COMPLETE
> > > > Client read_consumed: 72
> > > > Client command: BR_NOOP
> > > > Client command: BR_REPLY
> > > > BR_REPLY data:
> > > > 	handle: 0
> > > > 	cookie: 0
> > > > 	code: 0
> > > > 	flag: TF_ACCEPT_FDS
> > > > 	sender pid: 0
> > > > 	sender euid: 0
> > > > 	data_size: 24
> > > > 	offsets_size: 8
> > > > Retrieved Managers fd: 4 st_dev: 6
> > > > Client read_consumed: 8
> > > > Client using Managers FD command: BR_NOOP
> > > > Client using Managers FD command: BR_FAILED_REPLY
> > > > Client using Managers received FD failed response
> > > > Manager read_consumed: 4
> > > > Manager command: BR_NOOP
> > > > not ok 1
> > > > #   Failed test at ./test line 36.
> > > 
> > > Just realized that I was testing with a kernel that still had
> > > Casey's stacking support enabled.
> > > Will re-try without that.
> > 
> > Still fails for me on F28 with stock/linus 4.17.0-rc5.  No AVC
> > messages from the failing test itself,
> > just the other ones.
> 
> Traced the client and saw that it was getting BR_FAILED_REPLY from
> the kernel.
> Looked at /sys/kernel/debug/binder/failed_transaction_log and saw
> that the failure
> occurs on line 2847.  Did a git blame on that line and found this
> commit,
> 
> commit 7aa135fcf26377f92dc0680a57566b4c7f3e281b
> Author: Martijn Coenen <maco@android.com>
> Date:   Wed Mar 28 11:14:50 2018 +0200
> 
>     ANDROID: binder: prevent transactions into own process.
>     
>     This can't happen with normal nodes (because you can't get a ref
>     to a node you own), but it could happen with the context manager;
>     to make the behavior consistent with regular nodes, reject
>     transactions into the context manager by the process owning it.
>     
>     Reported-by: syzbot+09e05aba06723a94d43d@syzkaller.appspotmail.co
> m
>     Signed-off-by: Martijn Coenen <maco@android.com>
>     Cc: stable <stable@vger.kernel.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 764b63a5aade..e578eee31589 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2839,6 +2839,14 @@ static void binder_transaction(struct
> binder_proc *proc,
>                         else
>                                 return_error = BR_DEAD_REPLY;
>                         mutex_unlock(&context-
> >context_mgr_node_lock);
> +                       if (target_node && target_proc == proc) {
> +                               binder_user_error("%d:%d got
> transaction to context manager from process owning it\n",
> +                                                 proc->pid, thread-
> >pid);
> +                               return_error = BR_FAILED_REPLY;
> +                               return_error_param = -EINVAL;
> +                               return_error_line = __LINE__;
> +                               goto err_invalid_target_handle;
> +                       }
>                 }
>                 if (!target_node) {
>                         /*
> 
> 
> So that's a change in kernel behavior in v4.17-rc3 and later that
> breaks your test code.

Thanks for the info. I'll get a new kernel and see how far I can get.

> 
