Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7TNLVuK009990
 for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2016 19:21:31 -0400
Received: by mail-oi0-f67.google.com with SMTP id e80so255306oig.2
 for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2016 16:21:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1471985365-1197-1-git-send-email-william.c.roberts@intel.com>
References: <1471985365-1197-1-git-send-email-william.c.roberts@intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Aug 2016 19:21:19 -0400
Message-ID: <CAHC9VhSJ58N=f_jJO3Q3TY7JKViT4RS3N2Ly4iHVBj3pTHHxXw@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: detect invalid ebitmap
To: william.c.roberts@intel.com
Cc: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 23, 2016 at 4:49 PM,  <william.c.roberts@intel.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> When count is 0 and the highbit is not zero, the ebitmap is not
> valid and the internal node is not allocated. This causes issues
> when routines, like mls_context_isvalid() attempt to use the
> ebitmap_for_each_bit() and ebitmap_node_get_bit() as they assume
> a highbit > 0 will have a node allocated.
> ---
>  security/selinux/ss/ebitmap.c | 3 +++
>  1 file changed, 3 insertions(+)

Hi William,

This patch looks good to me, but do I have your permission to add your sign-off?

> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 894b6cd..7d10e5d 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -374,6 +374,9 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>                 goto ok;
>         }
>
> +       if (e->highbit && !count)
> +               goto bad;
> +
>         for (i = 0; i < count; i++) {
>                 rc = next_entry(&startbit, fp, sizeof(u32));
>                 if (rc < 0) {
> --
> 1.9.1
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
paul moore
www.paul-moore.com
