Date: Tue, 26 Jan 2010 16:53:30 -0500
Subject: Re: [PATCH] [src-policy] libsemanage: semanage_get_modules_names
 should get CIL path
From: Chad Sellers <csellers@tresys.com>
To: Caleb Case <ccase@tresys.com>, <selinux@tycho.nsa.gov>
CC: <kmacmillan@tresys.com>, <jwcart2@tycho.nsa.gov>, <jbrindle@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <C784CE8A.B3061%csellers@tresys.com>
In-Reply-To: <1264541191-18125-1-git-send-email-ccase@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/26/10 4:26 PM, "Caleb Case" <ccase@tresys.com> wrote:

> semanage_get_modules_names should be returning the path for the CIL
> instead of the HLL path since it is the CIL that is used during commit.
> ---
>  libsemanage/src/semanage_store.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/libsemanage/src/semanage_store.c
> b/libsemanage/src/semanage_store.c
> index 4ac5b5b..f077ac3 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -1085,7 +1085,7 @@ int semanage_get_modules_names(semanage_handle_t * sh,
> char ***filenames,
> ret = semanage_module_get_path(
> sh,
> &modinfos[i],
> -    SEMANAGE_MODULE_PATH_HLL,
> +    SEMANAGE_MODULE_PATH_CIL,
> path,
> sizeof(path));
> if (ret != 0) {

Signed-off-by: Chad Sellers <csellers@tresys.com>

Merged into src-policy branch


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
