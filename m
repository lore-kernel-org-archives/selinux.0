Message-ID: <1482331059.8511.16.camel@tycho.nsa.gov>
Subject: Re: [PATCH] policycoreutils/setfiles: Mention customizable types in
 restorecon man page
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Date: Wed, 21 Dec 2016 09:37:39 -0500
In-Reply-To: <1482311029-6545-1-git-send-email-vmojzis@redhat.com>
References: <1482173368.28570.56.camel@tycho.nsa.gov>
 <1482311029-6545-1-git-send-email-vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2016-12-21 at 10:03 +0100, Vit Mojzis wrote:
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Thanks, applied

> ---
>  policycoreutils/setfiles/restorecon.8 | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/policycoreutils/setfiles/restorecon.8
> b/policycoreutils/setfiles/restorecon.8
> index fdb468b..b00bf4e 100644
> --- a/policycoreutils/setfiles/restorecon.8
> +++ b/policycoreutils/setfiles/restorecon.8
> @@ -58,6 +58,12 @@ The
>  .B \-F
>  option will force a replacement of the entire context.
>  .P
> +If a file is labeled with
> +.BR customizable
> +SELinux type (for list of customizable
> +types see /etc/selinux/{SELINUXTYPE}/contexts/customizable_types),
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
> @@ -209,4 +215,5 @@ The program was written by Dan Walsh <dwalsh@redh
> at.com>.
>  .SH "SEE ALSO"
>  .BR setfiles (8),
>  .BR load_policy (8),
> -.BR checkpolicy (8)
> +.BR checkpolicy (8),
> +.BR customizable_types (5)
