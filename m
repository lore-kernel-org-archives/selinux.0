Subject: Re: [Patch 1/3] Loadable policy module infrastructure
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <1117128423.3483.19.camel@localhost>
References: <1117128423.3483.19.camel@localhost>
Content-Type: text/plain
Date: Tue, 31 May 2005 14:38:23 -0400
Message-Id: <1117564703.28924.243.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-05-26 at 13:27 -0400, Joshua Brindle wrote:
> diff -burNd a1/libsepol/src/util.c b/libsepol/src/util.c
> --- a1/libsepol/src/util.c	1969-12-31 19:00:00.000000000 -0500
> +++ b/libsepol/src/util.c	2005-05-25 13:11:19.488060776 -0400
> +int type_set_or(type_set_t *dst, type_set_t *a, type_set_t *b)
> +{
> +        type_set_init(dst);
> +
> +        if (ebitmap_or(&dst->types, &a->types, &b->types)) {
> +                fprintf(stderr, "Memory error\n");
> +                return -1;
> +        }
> +        if (ebitmap_or(&dst->negset, &a->negset, &b->negset)) {
> +                fprintf(stderr, "Memory error\n");
> +                return -1;
> +        }
> +
> +        dst->flags |= a->flags;
> +        dst->flags |= b->flags;
> +
> +        return 0;
> +}

I don't see any users of this function or even an exported function
prototype for it (or for a number of other functions), but am uncertain
about its semantics if it is going to be used.  The simple or'ing of the
negset and flags means that:
- anything excluded from either set will be excluded from the result
even if it was present in the other set,
- if either set is a set complement, then the result will be the
complement of the union.

That's quite different from an ebitmap_or() of the expanded type sets.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
