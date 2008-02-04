Subject: Re: checkpolicy patch: avoid warning in rawhide
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com
In-Reply-To: <200802041911.m14JB6eR017794@cadmus.columbia.tresys.com>
References: <200802041911.m14JB6eR017794@cadmus.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 04 Feb 2008 15:29:32 -0500
Message-Id: <1202156972.3070.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-04 at 14:11 -0500, Todd C. Miller wrote:
> It turns out the same issue also exists in policy_scan.l
> 
> Signed-off-by: Todd C. Miller <tmiller@tresys.com>

Looks fine, merge at will.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> 
>  - todd
> 
>  checkpolicy/policy_scan.l   |    2 +-
>  libsemanage/src/conf-scan.l |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: trunk/libsemanage/src/conf-scan.l
> ===================================================================
> --- trunk/libsemanage/src/conf-scan.l	(revision 2783)
> +++ trunk/libsemanage/src/conf-scan.l	(working copy)
> @@ -32,7 +32,7 @@
>  %}
>  
>  %option stack prefix="semanage_"
> -%option nounput noyy_push_state noyy_pop_state noyy_top_state
> +%option noinput nounput noyy_push_state noyy_pop_state noyy_top_state
>  
>  %x arg
>  
> Index: trunk/checkpolicy/policy_scan.l
> ===================================================================
> --- trunk/checkpolicy/policy_scan.l	(revision 2783)
> +++ trunk/checkpolicy/policy_scan.l	(working copy)
> @@ -43,7 +43,7 @@
>  unsigned int policydb_errors = 0;
>  %}
>  
> -%option nounput
> +%option noinput nounput
>  
>  %array
>  letter  [A-Za-z]
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
