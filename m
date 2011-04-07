MIME-Version: 1.0
In-Reply-To: <1302156777-30393-2-git-send-email-qingtao.cao@windriver.com>
References: <1302156777-30393-1-git-send-email-qingtao.cao@windriver.com>
	<1302156777-30393-2-git-send-email-qingtao.cao@windriver.com>
Date: Thu, 7 Apr 2011 14:35:47 -0400
Message-ID: <BANLkTindppe7GbuTFbcwew5XQAcWjCLMNQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Initialize policydb.process_class eariler.
From: Eric Paris <eparis@parisplace.org>
To: Harry Ciao <qingtao.cao@windriver.com>
Cc: sds@tycho.nsa.gov, jmorris@namei.org, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks, applied and pushed!

On Thu, Apr 7, 2011 at 2:12 AM, Harry Ciao <qingtao.cao@windriver.com> wrote:
> Initialize policydb.process_class once all symtabs read from policy image,
> so that it could be used to setup the role_trans.tclass field when a lower
> version policy.X is loaded.
>
> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> ---
>  security/selinux/ss/policydb.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index a493eae..82373eb 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2275,6 +2275,11 @@ int policydb_read(struct policydb *p, void *fp)
>                p->symtab[i].nprim = nprim;
>        }
>
> +       rc = -EINVAL;
> +       p->process_class = string_to_security_class(p, "process");
> +       if (!p->process_class)
> +               goto bad;
> +
>        rc = avtab_read(&p->te_avtab, fp, p);
>        if (rc)
>                goto bad;
> @@ -2359,11 +2364,6 @@ int policydb_read(struct policydb *p, void *fp)
>                goto bad;
>
>        rc = -EINVAL;
> -       p->process_class = string_to_security_class(p, "process");
> -       if (!p->process_class)
> -               goto bad;
> -
> -       rc = -EINVAL;
>        p->process_trans_perms = string_to_av_perm(p, p->process_class, "transition");
>        p->process_trans_perms |= string_to_av_perm(p, p->process_class, "dyntransition");
>        if (!p->process_trans_perms)
> --
> 1.7.0.4
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
