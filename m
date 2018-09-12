Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8CN4JS0026747
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 19:04:19 -0400
Received: by mail-yb1-f196.google.com with SMTP id e18-v6so2500081ybq.5
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 16:04:13 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com.
 [209.85.219.179])
 by smtp.gmail.com with ESMTPSA id l69-v6sm690788ywe.40.2018.09.12.16.04.11
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Sep 2018 16:04:11 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id e18-v6so2500048ybq.5
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 16:04:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <18c20c50-3ec5-0c85-93ef-58a3dbf3498c@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <18c20c50-3ec5-0c85-93ef-58a3dbf3498c@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 12 Sep 2018 16:04:10 -0700
Message-ID: <CAGXu5jLZaDxv140w5L48yNLikUs-=JMJ82oDW-sP=4b3tRC_bA@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, LKLM <linux-kernel@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 02/10] Smack: Abstract use of cred security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 11, 2018 at 9:41 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the cred->security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/smack/smack.h        | 14 +++++++--
>  security/smack/smack_access.c |  4 +--
>  security/smack/smack_lsm.c    | 57 +++++++++++++++++------------------
>  security/smack/smackfs.c      | 18 +++++------
>  4 files changed, 50 insertions(+), 43 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index f7db791fb566..0b55d6a55b26 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -356,6 +356,11 @@ extern struct list_head smack_onlycap_list;
>  #define SMACK_HASH_SLOTS 16
>  extern struct hlist_head smack_known_hash[SMACK_HASH_SLOTS];
>
> +static inline struct task_smack *smack_cred(const struct cred *cred)
> +{
> +       return cred->security;
> +}
> +
>  /*
>   * Is the directory transmuting?
>   */
> @@ -382,13 +387,16 @@ static inline struct smack_known *smk_of_task(const struct task_smack *tsp)
>         return tsp->smk_task;
>  }
>
> -static inline struct smack_known *smk_of_task_struct(const struct task_struct *t)
> +static inline struct smack_known *smk_of_task_struct(
> +                                               const struct task_struct *t)
>  {
>         struct smack_known *skp;
> +       const struct cred *cred;
>
>         rcu_read_lock();
> -       skp = smk_of_task(__task_cred(t)->security);
> +       cred = __task_cred(t);
>         rcu_read_unlock();
> +       skp = smk_of_task(smack_cred(cred));

Hm, why is this safe? (i.e. what is pinning the cred?) I would expect
get_cred()/put_cred() since this is not for "current"? And then what
controls the skp lifetime?

Everything else looks to be mechanical replacement, so that's fine.
Did you use some tooling to do the mechanical replacement or was it
done by hand?

-Kees

-- 
Kees Cook
Pixel Security
