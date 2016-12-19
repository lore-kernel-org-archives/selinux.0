Message-ID: <1482159099.28570.22.camel@tycho.nsa.gov>
Subject: Re: [PATCH] policycoreutils/setfiles: Mention customizable types in
 restorecon man page
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Date: Mon, 19 Dec 2016 09:51:39 -0500
In-Reply-To: <1482149576-13771-1-git-send-email-vmojzis@redhat.com>
References: <1482149576-13771-1-git-send-email-vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2016-12-19 at 13:12 +0100, Vit Mojzis wrote:
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  policycoreutils/setfiles/restorecon.8 | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/setfiles/restorecon.8
> b/policycoreutils/setfiles/restorecon.8
> index fdb468b..1803c12 100644
> --- a/policycoreutils/setfiles/restorecon.8
> +++ b/policycoreutils/setfiles/restorecon.8
> @@ -58,6 +58,12 @@ The
>  .B \-F
>  option will force a replacement of the entire context.
>  .P
> +If a file is labeled with
> +.BR customizable
> +SELinux type (for list of customizable
> +types see /etc/selinux/targeted/contexts/customizable_types), 

Should use {SELINUXTYPE} as we do in other man pages since not everyone
is running targeted, and probably add a see also for the
customizable_types man page.

> restorecon
> +won't reset the label unless the \-F option is used.
> +.P
>  It is the same executable as
>  .BR setfiles
>  but operates in a slightly different manner depending on its
> argv[0].
> @@ -124,7 +130,7 @@ change files and directories file labels
> recursively (descend directories).
>  .br
>  .TP
>  .B \-v
> -show changes in file labels. Note that the
> +show changes in file labels. Multiple -v options increase the
> verbosity. Note that the
>  .B \-v
>  and
>  .B \-p
