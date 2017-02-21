Subject: Re: [RFC 4/7] selinux: mark __ro_mostly_after_init for
 selinux_hooks/selinux_nf_ops
To: Hoeun Ryu <hoeun.ryu@gmail.com>, kernel-hardening@lists.openwall.com,
 linux-kernel@vger.kernel.org
References: <1487498660-16600-1-git-send-email-hoeun.ryu@gmail.com>
 <1487498660-16600-4-git-send-email-hoeun.ryu@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <cb0dcc3e-509f-613c-5593-85d5455b10d2@I-love.SAKURA.ne.jp>
Date: Tue, 21 Feb 2017 19:35:21 +0900
MIME-Version: 1.0
In-Reply-To: <1487498660-16600-4-git-send-email-hoeun.ryu@gmail.com>
Content-Type: text/plain; charset=iso-2022-jp
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 2017/02/19 19:04, Hoeun Ryu wrote:
>  It would be good that selinux hooks objects are marked as
> `__ro_mostly_after_init`. They can not be simply marked as `__ro_after_init'
> because they should be writable during selinux_disable procedure.
> `__ro_mostly_after_init` section is temporarily read-write during
> selinux_disable procedure via set_ro_mostly_after_init_rw/ro pair. Now that
> they can be read-only except during the procedure.
> 
> -static struct security_hook_list selinux_hooks[] = {
> +static struct security_hook_list selinux_hooks[] __ro_mostly_after_init = {

This won't work. This variable is array of "struct list_head".
You need to set same attribute to variables pointed by
"struct list_head"->next and "struct list_head"->prev .

>  	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
>  	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
>  	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
