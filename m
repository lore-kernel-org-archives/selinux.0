Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TFbPQr007995
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 11:37:25 -0400
Received: by mail-vk0-f68.google.com with SMTP id j137so2744572vke.0
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 08:37:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b71e766c-a9a2-cd9c-8f87-7aaeaaf896f0@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <b71e766c-a9a2-cd9c-8f87-7aaeaaf896f0@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 11:37:20 -0400
Message-ID: <CAHC9VhQaCFirdVRBnd9UsbHZzdmfrEc5ZtzzSvru7uXqCeLL8Q@mail.gmail.com>
Subject: Re: [PATCH 38/46] selinux: One function call less in five functions
 after null pointer detection
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Jan 15, 2017 at 10:38 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 11:28:02 +0100
>
> Call the function "kfree" at the end only after it was determined
> that the passed parameter contained a non-null pointer.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index faa6ecc2450d..88730b372277 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -620,8 +620,8 @@ static int common_destroy(void *key, void *datum, void *p)
>                 comdatum = datum;
>                 hashtab_map(comdatum->permissions.table, perm_destroy, NULL);
>                 hashtab_destroy(comdatum->permissions.table);
> +               kfree(datum);
>         }
> -       kfree(datum);
>         return 0;
>  }

I'm dropping this patch because it really doesn't do much other than
add some code churn.  I suppose you can argue it removes one
conditional if datum is NULL, but that is such a corner case I'm not
worried about it.

If I were to merge this, I would probably expect "kfree(datum)" to be
converted to "kfree(comdatum)" (and similar in the cases below).

> @@ -675,8 +675,8 @@ static int cls_destroy(void *key, void *datum, void *p)
>                         kfree(ctemp);
>                 }
>                 kfree(cladatum->comkey);
> +               kfree(datum);
>         }
> -       kfree(datum);
>         return 0;
>  }
>
> @@ -689,8 +689,8 @@ static int role_destroy(void *key, void *datum, void *p)
>                 role = datum;
>                 ebitmap_destroy(&role->dominates);
>                 ebitmap_destroy(&role->types);
> +               kfree(datum);
>         }
> -       kfree(datum);
>         return 0;
>  }
>
> @@ -712,8 +712,8 @@ static int user_destroy(void *key, void *datum, void *p)
>                 ebitmap_destroy(&usrdatum->range.level[0].cat);
>                 ebitmap_destroy(&usrdatum->range.level[1].cat);
>                 ebitmap_destroy(&usrdatum->dfltlevel.cat);
> +               kfree(datum);
>         }
> -       kfree(datum);
>         return 0;
>  }
>
> @@ -726,8 +726,8 @@ static int sens_destroy(void *key, void *datum, void *p)
>                 levdatum = datum;
>                 ebitmap_destroy(&levdatum->level->cat);
>                 kfree(levdatum->level);
> +               kfree(datum);
>         }
> -       kfree(datum);
>         return 0;
>  }
>
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
