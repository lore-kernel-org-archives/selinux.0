Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8DLJvLY005444
 for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2016 17:19:57 -0400
Received: by mail-oi0-f67.google.com with SMTP id y2so230959oie.0
 for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2016 14:19:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1473493428-26786-1-git-send-email-weiyj.lk@gmail.com>
References: <1473493428-26786-1-git-send-email-weiyj.lk@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Sep 2016 17:19:54 -0400
Message-ID: <CAHC9VhRRcv_tU6H4rD=oLXg698yeaCEgC-kd=yOLzoaF6zSWdw@mail.gmail.com>
Subject: Re: [PATCH -next] SELinux: fix error return code in policydb_read()
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 William Roberts <william.c.roberts@intel.com>,
 Wei Yongjun <weiyongjun1@huawei.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Sep 10, 2016 at 3:43 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Fix to return error code -EINVAL from the error handling case instead
> of 0(rc is overwrite to 0 when policyvers >= POLICYDB_VERSION_ROLETRANS),
> as done elsewhere in this function.
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  security/selinux/ss/policydb.c | 1 +
>  1 file changed, 1 insertion(+)

Nice catch, thanks for the patch; it has been merged into the
selinux#next branch.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 8c661f0..ace6838 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2417,6 +2417,7 @@ int policydb_read(struct policydb *p, void *fp)
>                 } else
>                         tr->tclass = p->process_class;
>
> +               rc = -EINVAL;
>                 if (!policydb_role_isvalid(p, tr->role) ||
>                     !policydb_type_isvalid(p, tr->type) ||
>                     !policydb_class_isvalid(p, tr->tclass) ||
>

-- 
paul moore
www.paul-moore.com
