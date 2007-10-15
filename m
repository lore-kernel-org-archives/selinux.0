MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [PATCH] refpolicy: gdm file context
Date: Mon, 15 Oct 2007 13:40:24 -0400
Message-ID: <1192470024.13098.130.camel@gorn>
In-Reply-To: <470FF79D.7000003@tycho.nsa.gov>
References: <470FF79D.7000003@tycho.nsa.gov>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Cc: "SELinux List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-10-12 at 18:39 -0400, Eamon Walsh wrote:
> Looks like gdm has moved to /usr/sbin, at least on my rawhide box.

Merged.

> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> ---
> 
>  xserver.fc |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> Index: policy/modules/services/xserver.fc
> ===================================================================
> --- policy/modules/services/xserver.fc	(revision 2451)
> +++ policy/modules/services/xserver.fc	(working copy)
> @@ -63,7 +63,7 @@
>  #
>  
>  /usr/(s)?bin/gdm-binary	--	gen_context(system_u:object_r:xdm_exec_t,s0)
> -/usr/bin/[xgkw]dm	--	gen_context(system_u:object_r:xdm_exec_t,s0)
> +/usr/(s)?bin/[xgkw]dm	--	gen_context(system_u:object_r:xdm_exec_t,s0)
>  /usr/bin/gpe-dm		--	gen_context(system_u:object_r:xdm_exec_t,s0)
>  /usr/bin/iceauth		--	gen_context(system_u:object_r:iceauth_exec_t,s0)
>  /usr/bin/Xair		--	gen_context(system_u:object_r:xserver_exec_t,s0)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
