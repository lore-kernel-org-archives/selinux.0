Subject: Re: [PATCH] libsepol: new capability to support open permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1204211394.3206.67.camel@localhost.localdomain>
References: <1204211394.3206.67.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 11:29:13 -0500
Message-Id: <1204216153.31790.153.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-28 at 10:09 -0500, Eric Paris wrote:
> This patch adds support for the new open_perms policy capability.
> Simple yet true.  I would like to point out that after this change
> checkpolicy will also need to be rebuilt with the new libsepol-static
> installed.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> -Eric
> 
> ---
> 
> diff -Naupr libsepol-2.0.21/include/sepol/policydb/polcaps.h libsepol-2.0.21.new/include/sepol/policydb/polcaps.h
> --- libsepol-2.0.21/include/sepol/policydb/polcaps.h	2008-02-20 13:47:52.000000000 -0500
> +++ libsepol-2.0.21.new/include/sepol/policydb/polcaps.h	2008-02-26 18:58:23.000000000 -0500
> @@ -4,6 +4,7 @@
>  /* Policy capabilities */
>  enum {
>  	POLICYDB_CAPABILITY_NETPEER,
> +	POLICYDB_CAPABILITY_OPENPERM,
>  	__POLICYDB_CAPABILITY_MAX
>  };
>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> diff -Naupr libsepol-2.0.21/src/polcaps.c libsepol-2.0.21.new/src/polcaps.c
> --- libsepol-2.0.21/src/polcaps.c	2008-02-20 13:47:51.000000000 -0500
> +++ libsepol-2.0.21.new/src/polcaps.c	2008-02-26 18:57:56.000000000 -0500
> @@ -7,6 +7,7 @@
>  
>  static const char *polcap_names[] = {
>  	"network_peer_controls",	/* POLICYDB_CAPABILITY_NETPEER */
> +	"open_perms",			/* POLICYDB_CAPABILITY_OPENPERM */
>  	NULL
>  };
>  
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
