Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6U1nldm003072
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2013 21:49:47 -0400
Message-ID: <51F71BB5.2050101@schaufler-ca.com>
Date: Mon, 29 Jul 2013 18:49:41 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Kees Cook <keescook@chromium.org>
CC: LKLM <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v14 1/6] LSM: Security blob abstraction
References: <51F16CFB.6040603@schaufler-ca.com> <51F16F21.3020305@schaufler-ca.com> <CAGXu5jJUiwjtEuCUB89NG9EQpxNytaaPT9PdPyHN_qUhwa+YUw@mail.gmail.com>
In-Reply-To: <CAGXu5jJUiwjtEuCUB89NG9EQpxNytaaPT9PdPyHN_qUhwa+YUw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/29/2013 2:15 PM, Kees Cook wrote:
> On Thu, Jul 25, 2013 at 11:32 AM, Casey Schaufler
> <casey@schaufler-ca.com> wrote:
>> Subject: [PATCH v14 1/6] LSM: Security blob abstraction
>>
>> Create an abstracted interface for security blobs.
>> Instead of directly accessing security blob pointers
>> Use lsm_get and lsm_set functions that hide the actual
>> mechanism used to maintain the security blobs. This
>> affects most uses of inode->i_security, file->f_security,
>> cred->security and similar fields in keys, sockets,
>> superblocks, ipc and keys.
>>
>> The use of a single 32 bit integer to refer to a security blob
>> does not scale to the case where there may be more than one
>> relevant security blob. Where it is possible to do so the use
>> of secids (u32) has been replaced with a struct secids, which
>> provides for multiple u32 values. There are components where
>> u32 secids remain at the request of the maintainer of that
>> component.
> If I boot with "security=apparmor", lsm_set_blob ends up with a NULL
> "bp" and Oopses the kernel. Still happens with
> "security=yama,apparmor". As soon as I add smack anywhere in the list,
> everything is fine. It seems like the AppArmor init needs to be
> changed to:
>
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 78b271a..512f430 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -875,9 +875,9 @@ static int __init set_init_cxt(void)
>                 return -ENOMEM;
>
>         cxt->profile = aa_get_profile(root_ns->unconfined);
> -       lsm_set_cred(cred, cxt, &apparmor_ops);
> -
> -       return 0;
> +       printk(KERN_INFO "AA: cred:%p cxt:%p &apparmor_ops:%p\n",
> +               cred, cxt, &apparmor_ops);
> +       return lsm_set_init_cred(cred, cxt, &apparmor_ops);

I've incorporated this fix (without the printk) and she looks good.

>  }
>
>  static int __init apparmor_init(void)
>
> Or maybe it still needs lsm_set_cred, but an earlier
> lsm_set_init_cred? It's not clear to me yet.
>
> -Kees
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
