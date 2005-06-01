Subject: Re: [Patch 2/3] Loadable policy module infrastructure
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <1117128424.3482.20.camel@localhost>
References: <1117128424.3482.20.camel@localhost>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 08:25:36 -0400
Message-Id: <1117628736.32745.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-05-26 at 13:27 -0400, Joshua Brindle wrote:
> diff -burNd a1/libsepol/src/expand.c b/libsepol/src/expand.c
> --- a1/libsepol/src/expand.c	1969-12-31 19:00:00.000000000 -0500
> +++ b/libsepol/src/expand.c	2005-05-25 13:11:19.526055000 -0400
> +        new_type->isattr = type->isattr;
> +        if (!type->isattr) {
> +                new_type->value = ++state->out->p_types.nprim;
> +                /* FIX ME: temp fix here */
> +                new_type->value = type->order;
> +                new_type->primary = 1;
> +        }

Is this an attempt to preserve type value ordering to allow easier
comparison of the resulting binary policies before and after the patch?
Shouldn't matter if using sediff, right?  I'd advise just dropping it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
