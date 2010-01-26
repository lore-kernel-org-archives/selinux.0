Date: Tue, 26 Jan 2010 16:53:08 -0500
Subject: Re: [PATCH] [src-policy] libsemanage: fix
 semanage_module_get_module_info export in map
From: Chad Sellers <csellers@tresys.com>
To: Caleb Case <ccase@tresys.com>, <selinux@tycho.nsa.gov>
CC: <kmacmillan@tresys.com>, <jwcart2@tycho.nsa.gov>, <jbrindle@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <C784CE74.B3060%csellers@tresys.com>
In-Reply-To: <1264541058-17845-1-git-send-email-ccase@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/26/10 4:24 PM, "Caleb Case" <ccase@tresys.com> wrote:

> This patch fixes libsemanage.map which has the wrong export line for
> semanage_module_get_module_info.
> ---
>  libsemanage/src/libsemanage.map |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
> index 3526256..1414ce5 100644
> --- a/libsemanage/src/libsemanage.map
> +++ b/libsemanage/src/libsemanage.map
> @@ -37,7 +37,7 @@ LIBSEMANAGE_1.0 {
>  semanage_module_key_get_name;
>  semanage_module_key_set_priority;
>  semanage_module_key_set_name;
> -   semanage_module_get_module;
> +   semanage_module_get_module_info;
>  semanage_module_list_all;
>  semanage_module_get_enabled;
>  semanage_module_set_enabled;

Signed-off-by: Chad Sellers <csellers@tresys.com>

Merged into src-policy branch.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
