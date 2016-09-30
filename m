Message-ID: <1475250942.14127.10.camel@btinternet.com>
Subject: Re: [PATCH] policycoreutils: setfiles: reverse the sense of -D
From: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Date: Fri, 30 Sep 2016 16:55:42 +0100
In-Reply-To: <1475248051-14729-1-git-send-email-sds@tycho.nsa.gov>
References: <1475248051-14729-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2016-09-30 at 11:07 -0400, Stephen Smalley wrote:
> Reverse the sense of the -D option, from disabling setting/use of
> security.restorecon_last to enabling it, making disabled the default
> state.
> 
> Rationale:
> 1) Users often use restorecon to fix labels on files whose labels are
> wrong even through nothing has changed in file_contexts, e.g. after
> copying/moving files to a different location.  They won't expect
> restorecon to suddenly stop relabeling by default because the hash of
> file_contexts hasn't changed.
> 
> 2) Only processes running with CAP_SYS_ADMIN can set
> security.restorecon_last, so this will fail for non-root users
> anyway.

Only a couple of minor points concerning both man pages that need
updates:
1) In the SYNOPSIS I have [-I|-D]. These should now be [-I] [-D]
2) As -I and -D would now be used together to force an update would it
be worth adding some text at the -I option, for example:

... "This option must be used with the -D option." See the NOTES....

> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  policycoreutils/setfiles/restorecon.8 | 16 +++++++++-------
>  policycoreutils/setfiles/setfiles.8   | 18 ++++++++++--------
>  policycoreutils/setfiles/setfiles.c   |  9 +++++----
>  3 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/policycoreutils/setfiles/restorecon.8
> b/policycoreutils/setfiles/restorecon.8
> index f996467..fdb468b 100644
> --- a/policycoreutils/setfiles/restorecon.8
> +++ b/policycoreutils/setfiles/restorecon.8
> @@ -92,12 +92,10 @@ there are no errors. See the
>  section for further details.
>  .TP
>  .B \-D
> -do not set or update any directory SHA1 digests. Use this option to
> -effectively disable usage of the
> +Set or update any directory SHA1 digests. Use this option to
> +enable usage of the
>  .IR security.restorecon_last
> -extended attribute. Note that using this option will override the
> -.B \-I
> -option.
> +extended attribute.
>  .TP
>  .B \-m
>  do not read
> @@ -174,15 +172,19 @@ To improve performance when relabeling file
> systems recursively (i.e. the
>  or
>  .B \-r
>  option is set),
> +the
> +.B \-D
> +option to
>  .B restorecon
> -will write an SHA1 digest of the default specfiles set to an
> extended
> +will cause it to store a SHA1 digest of the default specfiles set in
> an extended
>  attribute named
>  .IR security.restorecon_last
> -to the directory specified in each
> +on the directory specified in each
>  .IR pathname \ ...
>  once the relabeling has been completed successfully. This digest
> will be
>  checked should
>  .B restorecon
> +.B \-D
>  be rerun with the same
>  .I pathname
>  parameters. See
> diff --git a/policycoreutils/setfiles/setfiles.8
> b/policycoreutils/setfiles/setfiles.8
> index 11bc335..6901e13 100644
> --- a/policycoreutils/setfiles/setfiles.8
> +++ b/policycoreutils/setfiles/setfiles.8
> @@ -88,12 +88,10 @@ there are no errors. See the
>  section for further details.
>  .TP
>  .B \-D
> -do not set or update any directory SHA1 digests. Use this option to
> -effectively disable usage of the
> +Set or update any directory SHA1 digests. Use this option to
> +enable usage of the
>  .IR security.restorecon_last
> -extended attribute. Note that using this option will override the
> -.B \-I
> -option.
> +extended attribute.
>  .TP
>  .B \-l
>  log changes in file labels to syslog.
> @@ -223,16 +221,20 @@ message label
>  .BR FS_RELABEL .
>  .IP "3." 4
>  To improve performance when relabeling file systems recursively
> +the
> +.B \-D
> +option to
>  .B setfiles
> -will write an SHA1 digest of the
> +will cause it to store a SHA1 digest of the
>  .B spec_file
> -set to an extended attribute named
> +set in an extended attribute named
>  .IR security.restorecon_last
> -to the directory specified in each
> +on the directory specified in each
>  .IR pathname \ ...
>  once the relabeling has been completed successfully. This digest
> will be
>  checked should
>  .B setfiles
> +.B \-D
>  be rerun
>  with the same
>  .I spec_file
> diff --git a/policycoreutils/setfiles/setfiles.c
> b/policycoreutils/setfiles/setfiles.c
> index 520866e..22eba0f 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -157,7 +157,7 @@ int main(int argc, char **argv)
>  	altpath = NULL;
>  	null_terminated = 0;
>  	warn_no_match = 0;
> -	request_digest = 1;
> +	request_digest = 0;
>  	policyfile = NULL;
>  	nerr = 0;
>  
> @@ -281,11 +281,12 @@ int main(int argc, char **argv)
>  					   SELINUX_RESTORECON_IGNORE
> _DIGEST;
>  			break;
>  		case 'D': /*
> -			   * Don't request file_contexts digest in
> selabel_open
> -			   * This will effectively disable usage of
> the
> +			   * Request file_contexts digest in
> selabel_open
> +			   * This will effectively enable usage of
> the
>  			   * security.restorecon_last extended
> attribute.
>  			   */
> -			request_digest = 0;
> +			request_digest = 1;
> +			break;
>  		case 'l':
>  			r_opts.syslog_changes =
>  					   SELINUX_RESTORECON_SYSLOG
> _CHANGES;
