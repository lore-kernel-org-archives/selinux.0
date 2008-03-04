MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Re: [patch] libsepol:  drop unused buffer field from policy_file
Date: Tue, 4 Mar 2008 12:48:24 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880195CF5A@exchange.columbia.tresys.com>
In-Reply-To: <1204642602.23738.101.camel@moss-spartans.epoch.ncsc.mil>
References: <1204642602.23738.101.camel@moss-spartans.epoch.ncsc.mil>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Cc: "Joshua Brindle" <method@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Remove the buffer array from struct policy_file; it is unused.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Acked-by:  Todd C. Miller <tmiller@tresys.com>

> 
> ---
> 
>  libsepol/include/sepol/policydb/policydb.h |    1 -
>  1 file changed, 1 deletion(-)
> 
> Index: trunk/libsepol/include/sepol/policydb/policydb.h
> ===================================================================
> --- trunk/libsepol/include/sepol/policydb/policydb.h	(revision 2830)
> +++ trunk/libsepol/include/sepol/policydb/policydb.h	(working copy)
> @@ -561,7 +561,6 @@
>  	size_t size;
>  	FILE *fp;
>  	struct sepol_handle *handle;
> -	unsigned char buffer[BUFSIZ];
>  } policy_file_t;
> 
>  struct sepol_policy_file {



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
