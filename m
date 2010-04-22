Date: Fri, 23 Apr 2010 08:44:10 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 1/3] SELinux: standardize return code handling in
 policydb.c
In-Reply-To: <20100422173632.23830.10834.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1004230833200.18002@tundra.namei.org>
References: <20100422173632.23830.10834.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 Apr 2010, Eric Paris wrote:

> policydb.c has lots of different standards on how to handle return paths on
> error.  For the most part transition to
> 
> 	rc=errno
> 	if (failure)
> 		goto out;
> [...]
> out:
> 	cleanup()
> 	return rc;
> 
> Instead of doing cleanup mid function, or having multiple returns or other
> options.  This doesn't do that for every function, but most of the complex
> functions which have cleanup routines on error.

I think the idea is that the 'goto out' paradigm is used when multiple 
return points need the same cleanup, otherwise, just use return normally.

> +++ b/security/selinux/ss/policydb.c
> @@ -144,35 +144,33 @@ static int roles_init(struct policydb *p)
>  {
>  	char *key = NULL;
>  	int rc;
> -	struct role_datum *role;
> +	struct role_datum *role = NULL;

Why is this being initialized to NULL?  The kzalloc call will assign it a 
definite value.  Initializing variables unnecessarily can hide bugs in the 
code.

> +	rc = -ENOMEM;
>  	role = kzalloc(sizeof(*role), GFP_KERNEL);

I'm not sure what the point is of assigning the error code first -- 
perhaps if all or most of the error cases use that error, but they don't.

> -out:
> -	return rc;
> +	return 0;
>  
>  out_free_symtab:
>  	for (i = 0; i < SYM_NUM; i++)
>  		hashtab_destroy(p->symtab[i].table);
> -	goto out;
> +	return rc;
>  }

Also, I think part of the point of this approach is that you reduce, not 
increase, the number of return statements, to make reading the code 
simpler.  It also forces you to account for 'rc' properly at all times.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
