Subject: Re: [PATCH] libselinux: save errno value in avc_has_perm()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <47BF5DCA.60601@tycho.nsa.gov>
References: <47BF5DCA.60601@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 25 Feb 2008 08:31:45 -0500
Message-Id: <1203946305.2804.148.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-02-22 at 18:42 -0500, Eamon Walsh wrote:
> The errno value set by avc_has_perm_noaudit() is being lost somewhere in 
> the bowels of avc_audit().  This patch saves it off so it doesn't get lost.
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will.

Seems suitable for the stable branch too.

> ---
> 
>  libselinux/src/avc.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> 
> Index: libselinux/src/avc.c
> ===================================================================
> --- libselinux/src/avc.c	(revision 2811)
> +++ libselinux/src/avc.c	(working copy)
> @@ -874,10 +874,12 @@
>  		 struct avc_entry_ref *aeref, void *auditdata)
>  {
>  	struct av_decision avd = { 0, 0, 0, 0, 0 };
> -	int rc;
> +	int errsave, rc;
>  
>  	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, aeref, &avd);
> +	errsave = errno;
>  	avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
> +	errno = errsave;
>  	return rc;
>  }
>  
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
