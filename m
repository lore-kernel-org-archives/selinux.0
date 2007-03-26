Subject: Re: [PATCH 3/3] Refpolicy: allow netlabelctl to be run at boot
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com, sds@tycho.nsa.gov
In-Reply-To: <20070309203513.357373998@hp.com>
References: <20070309203327.709750017@hp.com>
	 <20070309203513.357373998@hp.com>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 11:18:23 -0400
Message-Id: <1174922303.28830.24.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-09 at 16:33 -0400, Paul Moore wrote:
> Allow the NetLabel management tools to be run at boot from the init
> scripts.

Is this actually a daemon or just a regular application?  If its not a
daemon it should be using init_system_domain() instead.

> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
>  policy/modules/system/netlabel.te |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Index: refpolicy/policy/modules/system/netlabel.te
> ===================================================================
> --- refpolicy.orig/policy/modules/system/netlabel.te
> +++ refpolicy/policy/modules/system/netlabel.te
> @@ -8,8 +8,7 @@ policy_module(netlabel,1.0.0)
> 
>  type netlabel_mgmt_t;
>  type netlabel_mgmt_exec_t;
> -domain_type(netlabel_mgmt_t)
> -domain_entry_file(netlabel_mgmt_t,netlabel_mgmt_exec_t)
> +init_daemon_domain(netlabel_mgmt_t,netlabel_mgmt_exec_t)
> 
>  ########################################
>  #
> 
> --
> paul moore
> linux security @ hp
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
