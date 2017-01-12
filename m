Message-ID: <1484251293.16361.3.camel@tycho.nsa.gov>
Subject: Re: [PATCH] restorecon manpage: link back to fixfiles
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>, selinux@tycho.nsa.gov
Date: Thu, 12 Jan 2017 15:01:33 -0500
In-Reply-To: <20170111124110.5721-2-alan.christopher.jenkins@gmail.com>
References: <20170111124110.5721-1-alan.christopher.jenkins@gmail.com>
 <20170111124110.5721-2-alan.christopher.jenkins@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-01-11 at 12:41 +0000, Alan Jenkins wrote:
> fixfiles links to restorecon.  However if you start with restorecon
> "restore file(s) default SELinux security contexts", you can easily
> miss the fixfiles script.  fixfiles is more generally useful than
> `restorecon -R`.   For example `restorecon -R /` is not as good as
> `fixfiles restore`, because the restorecon command will try to
> relabel
> `/sys` and fail noisily.

Thanks, applied both patches.  Wondering though about the behavior
you describe above; restorecon -R /sys only issues one error message
for me and otherwise works fine,
# restorecon -R /sys
Could not set context for /sys/fs/cgroup:  Read-only file system

> 
> Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
> ---
>  policycoreutils/setfiles/restorecon.8 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/policycoreutils/setfiles/restorecon.8
> b/policycoreutils/setfiles/restorecon.8
> index b00bf4e..bd27113 100644
> --- a/policycoreutils/setfiles/restorecon.8
> +++ b/policycoreutils/setfiles/restorecon.8
> @@ -214,6 +214,7 @@ The program was written by Dan Walsh <dwalsh@redh
> at.com>.
>  
>  .SH "SEE ALSO"
>  .BR setfiles (8),
> +.BR fixfiles (8),
>  .BR load_policy (8),
>  .BR checkpolicy (8),
>  .BR customizable_types (5)
