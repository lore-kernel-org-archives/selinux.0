Subject: Re: [PATCH] libsemanage: don't destroy the sepol handle if the
	connection fails
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Athey <jathey@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588052619@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588052619@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 11:01:03 -0400
Message-Id: <1159542063.8496.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-28 at 17:37 -0400, James Athey wrote:
> This patch removes the call to sepol_handle_destroy() if the connection to the semanage store fails.  Without this patch, if a connection fails for any reason, any later connection attempts on the same semanage handle will dump core.  semanage_handle_create() is responsible for creating the sepol handle, and semanage_handle_destroy() already destroys it.
> 
> Index: libsemanage/src/direct_api.c
> ===================================================================
> --- libsemanage/src/direct_api.c        (revision 2032)
> +++ libsemanage/src/direct_api.c        (working copy)
> @@ -218,7 +218,6 @@
> 
>        err:
>         ERR(sh, "could not establish direct connection");
> -       sepol_handle_destroy(sh->sepolh);
>         return STATUS_ERR;
>  }

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
