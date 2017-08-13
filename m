Date: Sun, 13 Aug 2017 11:22:33 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Daniel Jurgens <danielj@mellanox.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Junil Lee <junil0814.lee@lge.com>, Paul Moore <paul@paul-moore.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <20170813162233.GB4515@mail.hallyn.com>
References: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
 <05edc763-dddd-fe48-b98c-21e4ad5463a3@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <05edc763-dddd-fe48-b98c-21e4ad5463a3@users.sourceforge.net>
Subject: Re: [PATCH 1/4] selinux: Delete eight unnecessary variable assignments
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Quoting SF Markus Elfring (elfring@users.sourceforge.net):
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 13 Aug 2017 14:17:48 +0200
> 
> One local variable was reset to zero at the end of these functions.
> This value will also be set by a previous call of a function if it was
> executed successfully. Thus omit an extra assignment there.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/selinux/selinuxfs.c   |  1 -
>  security/selinux/ss/avtab.c    |  2 --
>  security/selinux/ss/ebitmap.c  |  4 +---
>  security/selinux/ss/policydb.c | 10 ++--------
>  4 files changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 00eed842c491..7565c312a198 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1724,7 +1724,6 @@ static int sel_make_classes(void)
>  		if (rc)
>  			goto out;
>  	}
> -	rc = 0;
>  out:
>  	for (i = 0; i < nclasses; i++)
>  		kfree(classes[i]);
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 3628d3a868b6..a8218905e286 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -587,8 +587,6 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
>  			goto bad;
>  		}
>  	}
> -
> -	rc = 0;
>  out:
>  	return rc;
>  
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index ad38299164c3..ccf372db689c 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -373,7 +373,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>  
>  	if (!e->highbit) {
>  		e->node = NULL;
> -		goto ok;
> +		goto out;
>  	}
>  
>  	if (e->highbit && !count)
> @@ -436,8 +436,6 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>  			map = EBITMAP_SHIFT_UNIT_SIZE(map);
>  		}
>  	}
> -ok:
> -	rc = 0;
>  out:
>  	return rc;
>  bad:
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index aa6500abb178..a2356fc263c6 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -599,7 +599,6 @@ static int policydb_index(struct policydb *p)
>  		if (rc)
>  			goto out;
>  	}
> -	rc = 0;
>  out:
>  	return rc;
>  }
> @@ -903,10 +902,10 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>  
>  	head = p->ocontexts[OCON_ISID];
>  	for (c = head; c; c = c->next) {
> -		rc = -EINVAL;
>  		if (!c->context[0].user) {
>  			printk(KERN_ERR "SELinux:  SID %s was never defined.\n",
>  				c->u.name);
> +			rc = -EINVAL;
>  			goto out;
>  		}
>  
> @@ -917,7 +916,6 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>  			goto out;
>  		}
>  	}
> -	rc = 0;
>  out:
>  	return rc;
>  }
> @@ -1074,13 +1072,12 @@ static int context_read_and_validate(struct context *c,
>  		}
>  	}
>  
> -	rc = -EINVAL;
>  	if (!policydb_context_isvalid(p, c)) {
>  		printk(KERN_ERR "SELinux:  invalid security context\n");
>  		context_destroy(c);
> +		rc = -EINVAL;
>  		goto out;
>  	}
> -	rc = 0;
>  out:
>  	return rc;
>  }
> @@ -1900,7 +1897,6 @@ static int range_read(struct policydb *p, void *fp)
>  		r = NULL;
>  	}
>  	hash_eval(p->range_tr, "rangetr");
> -	rc = 0;
>  out:
>  	kfree(rt);
>  	kfree(r);
> @@ -2550,8 +2546,6 @@ int policydb_read(struct policydb *p, void *fp)
>  	rc = policydb_bounds_sanity_check(p);
>  	if (rc)
>  		goto bad;
> -
> -	rc = 0;
>  out:
>  	return rc;
>  bad:
> -- 
> 2.14.0
