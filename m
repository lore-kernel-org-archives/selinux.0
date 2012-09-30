Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8UId73b021198
	for <selinux@tycho.nsa.gov>; Sun, 30 Sep 2012 14:39:07 -0400
Message-ID: <506891B8.5080200@schaufler-ca.com>
Date: Sun, 30 Sep 2012 11:38:48 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v4] LSM: Multiple concurrent LSMs
References: <50662C6A.7000400@schaufler-ca.com> <201209301510.HGJ56292.FJOQOMVSHFOtLF@I-love.SAKURA.ne.jp>
In-Reply-To: <201209301510.HGJ56292.FJOQOMVSHFOtLF@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 9/29/2012 11:10 PM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> I still think that loading modules outside of __init is not a
>> great idea in the general case.
> I guess modules loaded outside of __init are as simple as Yama.
> Major protection is provided by one of SELinux, SMACK, TOMOYO or AppArmor, and
> additional minor protection is provided by modules loaded after __init.
> Those who want to use none of SELinux, SMACK, TOMOYO or AppArmor, they will use
> their own protection modules loaded after __init.
>
>> The Smack LSM behavior has been tested. AppArmor, TOMOYO,
>> Yama and SELinux have been shown to boot, but have not been
>> functionally tested beyond the lack of obvious error messages
>> and complaints from kernel debugging facilities. The kernels
>> have been tested with Ubuntu 12.04 and Fedora 17.
> The TOMOYO LSM behaviour has been tested with AppArmor enabled
> (SELinux automatically disabled due to testing on CentOS6.3).
>
>
>
>  int security_inode_alloc(struct inode *inode)
>  {
> +       int rc;
> +       struct lsm_blob tblob;
> +
> +       memset(&tblob, 0, sizeof(tblob));
> +       inode->i_security = &tblob;
> +       call_alloc_hook(rc, inode_alloc_security, inode);
> +
>         inode->i_security = NULL;
> -       return security_ops->inode_alloc_security(inode);
> +       if (tblob.lsm_setcount > 0) {
> +               if (rc == 0)
> +                       inode->i_security = lsm_alloc_blob(GFP_KERNEL);
> +               if (inode->i_security == NULL) {
> +                       call_void_hook(inode_free_security, inode);
> +                       if (rc == 0)
> +                               rc = -ENOMEM;
> +                       lsm_blob_cleanup(rc, &tblob, __func__);
> +               } else
> +                       memcpy(inode->i_security, &tblob, sizeof(tblob));
> +       }
> +       return rc;
>  }
>
> Are all LSM modules ready for _free_ hooks being called without successful
> _alloc_ hooks?

Possibly. What's more important is that not all LSMs would be tolerant of
calls to _access_ check hooks where there had been on subsequent _alloc_
hook called. The _file_, _inode_ and _sock_ hooks in particular.

> If one of LSM modules in call_alloc_hook() fails, that module
> will get called with failed _alloc_ call (e.g. NULL security context) because
> call_void_hooks() will unconditionally call all enabled LSM modules.

I don't think so. In the composer scheme (per Stephen's suggestion) the alloc
hooks will fail if any of the allocations fail. So security_alloc_inode will
fail if any of smack_alloc_inode, selinux_alloc_inode or wonderlsm_alloc_inode
fails.

> If not ready, something like
>   call_alloc_hook(rc, inode_alloc_security, inode_free_security, inode)
> will be needed.

The code in security_inode_alloc is taking care of that. 

> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
