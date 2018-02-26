To: Lee Stubbs <lee.stubbs@gmail.com>, selinux@tycho.nsa.gov
References: <20180218222141.95374-1-lee.stubbs@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b41c9ecd-3fe7-0a7d-ebfe-d859f44fa52f@tycho.nsa.gov>
Date: Mon, 26 Feb 2018 09:34:39 -0500
MIME-Version: 1.0
In-Reply-To: <20180218222141.95374-1-lee.stubbs@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] Minor update for bash completion. Bash completion for
 ports is missing '-' for type. Based on documentation, it should be --type,
 not -type.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/18/2018 05:21 PM, Lee Stubbs wrote:
> ---
>  python/semanage/semanage-bash-completion.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/semanage/semanage-bash-completion.sh b/python/semanage/semanage-bash-completion.sh
> index 6b53292..2d811c9 100644
> --- a/python/semanage/semanage-bash-completion.sh
> +++ b/python/semanage/semanage-bash-completion.sh
> @@ -59,7 +59,7 @@ __get_export_opts () { echo '$ALL_OPTS --f --output_file' ; }
>  __get_boolean_opts () { echo '$ALL_OPTS --on -off -1 -0' ; }
>  __get_user_opts () { echo '$ALL_OPTS $MANAGED_OPTS -L --level -r --range -R --role '; }
>  __get_login_opts () { echo '$ALL_OPTS $MANAGED_OPTS -s --seuser -r --range'; }
> -__get_port_opts () { echo '$ALL_OPTS $MANAGED_OPTS -t -type -r --range -p --proto'; }
> +__get_port_opts () { echo '$ALL_OPTS $MANAGED_OPTS -t --type -r --range -p --proto'; }
>  __get_interface_opts () { echo '$ALL_OPTS $MANAGED_OPTS -t --type '; }
>  __get_node_opts () { echo '$ALL_OPTS $MANAGED_OPTS -t --type -M --mask -p --proto'; }
>  __get_fcontext_opts () { echo '$ALL_OPTS $MANAGED_OPTS -t --type -e --equal -f --ftype '; }

Thanks, applied
