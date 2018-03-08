To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20180305225820.23610-1-nicolas.iooss@m4x.org>
 <20180305225820.23610-3-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8ce37eb3-e5e6-e9c2-9ea3-ae7333aad68a@tycho.nsa.gov>
Date: Thu, 8 Mar 2018 14:49:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180305225820.23610-3-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 3/3] libsemanage: silence clang static analyzer report
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/05/2018 05:58 PM, Nicolas Iooss wrote:
> clang's static analyzer reports an out-of-bound array access in
> semanage_user_roles() when num_roles is zero, with the following
> statement:
> 
>     strcpy(roles,roles_arr[0]);
> 
> When num_roles is zero, roles_arr[0] is not uninitialized and roles is
> the result of malloc(0) so this strcpy is dangerous. Make
> semanage_user_roles() return an empty string instead.

Applied patches 2 and 3; patch 1 will be obsoleted by James' patch when it is merged, unless there are objections to it.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsemanage/src/seusers_local.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_local.c
> index 42c3a8b662c2..413ebdddeb34 100644
> --- a/libsemanage/src/seusers_local.c
> +++ b/libsemanage/src/seusers_local.c
> @@ -35,12 +35,16 @@ static char *semanage_user_roles(semanage_handle_t * handle, const char *sename)
>  				for (i = 0; i<num_roles; i++) {
>  					size += (strlen(roles_arr[i]) + 1);
>  				}
> -				roles = malloc(size);
> -				if (roles) {
> -					strcpy(roles,roles_arr[0]);
> -					for (i = 1; i<num_roles; i++) {
> -						strcat(roles,",");
> -						strcat(roles,roles_arr[i]);
> +				if (num_roles == 0) {
> +					roles = strdup("");
> +				} else {
> +					roles = malloc(size);
> +					if (roles) {
> +						strcpy(roles,roles_arr[0]);
> +						for (i = 1; i<num_roles; i++) {
> +							strcat(roles,",");
> +							strcat(roles,roles_arr[i]);
> +						}
>  					}
>  				}
>  			}
> 
