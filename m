Subject: Re: [PATCH 1/1] genhomedircon: support policies using RBACSEP
To: Gary Tierney <gary.tierney@gmx.com>, selinux@tycho.nsa.gov
References: <cover.1474639773.git.gary.tierney@gmx.com>
 <1062ebe32922aec79a0232acfdd0005e9ce124da.1474639773.git.gary.tierney@gmx.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7be4daef-ca03-da40-0fb0-79bf39e3ce18@tycho.nsa.gov>
Date: Fri, 23 Sep 2016 15:36:47 -0400
MIME-Version: 1.0
In-Reply-To: <1062ebe32922aec79a0232acfdd0005e9ce124da.1474639773.git.gary.tierney@gmx.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/23/2016 10:28 AM, Gary Tierney wrote:
> Introduces support for generating homedir/user contexts for policies
> that implement RBACSEP.  The support works by taking the prefix of a
> logins seuser and replacing the role field in their context
> specifications with the prefix.  A new option "genhomedircon-rbacsep"
> was added to /etc/selinux/semanage.conf to allow toggling this behavior.

The user prefix was previously used as a prefix for types, e.g. you
could have:
HOME_DIR/\.gnupg(/.+)?  system_u:object_r:ROLE_gpg_secret_t
and get it replaced with:
/home/[^/]+/\.gnupg(/.+)?       system_u:object_r:user_gpg_secret_t
/root/\.gnupg(/.+)?             system_u:object_r:sysadm_gpg_secret_t

So I guess you could use it for the role field too, but for consistency
you would want it to be:
HOME_DIR/\.gnupg(/.+)?  system_u:ROLE_r:ROLE_gpg_secret_t

and the prefix would still just be "user".

> 
> The user prefix can be set from both standard kernel policy and CIL:
> 
> CIL:
>     (user user_u)
>     (role user_r)
>     (userrole user_u user_r)
>     (userprefix user_u user_r)
> 
> kernel policy language:
>     role user_r;
>     user user_u roles { user_r } prefix user_r;
> 
> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
> ---
>  libsemanage/src/conf-parse.y    | 14 +++++++++++++-
>  libsemanage/src/conf-scan.l     |  1 +
>  libsemanage/src/genhomedircon.c | 30 +++++++++++++++++++++++++++++-
>  libsemanage/src/semanage_conf.h |  1 +
>  4 files changed, 44 insertions(+), 2 deletions(-)
> 
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index 3fc9e7a..98f9ebd 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -857,7 +866,7 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
>  	int errors = 0;
>  
>  	retval = semanage_seuser_list(s->h_semanage, &seuser_list, &nseusers);
> -	if (retval < 0 || (nseusers < 1)) {
> +	if (retval < 0 || (nseusers < 2)) {

Why did this test change?

>  		/* if there are no users, this function can't do any other work */
>  		return errors;
>  	}
> @@ -886,6 +895,17 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
>  					level = FALLBACK_LEVEL;
>  			}
>  
> +			if (u && s->h_semanage->conf->genhomedircon_rbacsep &&
> +			    !semanage_user_has_role(u, prefix)) {

I don't think you want to use prefix alone here, since it may be a
prefix rather than a role name.

The kernel policy contains the list of authorized roles for the user, so
libsepol could export that, but that won't tell you anything about a
default.

libselinux get_default_context() and friends are context-sensitive (the
result depends on the caller's context, such that it may differ for
login vs sshd vs gdm and even among multiple distinct instances of any
of these, e.g. if they have different levels), so I don't think you can
use those.

I don't think we presently provide a good way to find this information,
which is why we added the user prefix in the first place.  But it is
intended to be a prefix, not a role.
