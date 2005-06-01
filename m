Subject: Re: [Patch 1/3] Loadable policy module infrastructure
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <1117128423.3483.19.camel@localhost>
References: <1117128423.3483.19.camel@localhost>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 11:13:25 -0400
Message-Id: <1117638805.32745.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-05-26 at 13:27 -0400, Joshua Brindle wrote:
> diff -burNd a1/libsepol/src/assertion.c b/libsepol/src/assertion.c
> --- a1/libsepol/src/assertion.c	1969-12-31 19:00:00.000000000 -0500
> +++ b/libsepol/src/assertion.c	2005-05-25 13:11:20.410920480 -0400
> +                if ((avdatump->specified & AVTAB_ALLOWED) && (avtab_allowed(avdatump) & curperm->data)) {
> +                        fprintf(stderr, "assertion on line %lu violated by allow %s %s:%s ;\n",
> +                                line, p->p_type_val_to_name[stype], p->p_type_val_to_name[ttype],
> +                                p->p_class_val_to_name[curperm->class - 1]);
> +                        return -1;

The original code in checkpolicy also displayed the access vector as a
string, which this omits.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
