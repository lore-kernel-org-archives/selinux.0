To: Yuli Khodorkovskiy <ykhodo@gmail.com>, selinux@tycho.nsa.gov
References: <20180325193455.12140-1-ykhodo@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <afa564bc-d419-f63d-1dbf-66f082cbce2c@tycho.nsa.gov>
Date: Mon, 26 Mar 2018 09:20:10 -0400
MIME-Version: 1.0
In-Reply-To: <20180325193455.12140-1-ykhodo@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] libselinux: verify file_contexts when using restorecon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/25/2018 03:34 PM, Yuli Khodorkovskiy wrote:
> In permissive mode, calling restorecon with a bad label in file_contexts
> does not verify the label's existence in the loaded policy. This
> results in any label successfully applying to a file, as long as the
> file exists.
> 
> This issue has two assumptions:
> 1) file_contexts must be manually updated with the invalid label.
> Running `semanage fcontext` will error when attempting to add
> an invalid label to file_contexts.
> 2) the system must be in permissive. Although applying an invalid label
> in enforcing gives an error and fails, successfully labeling a file with a
> bad label could cause issues during policy development in permissive.
> 
> Instead of the current behavior, mimic setfiles' -c flag, and verify the labels
> against the loaded policy binary.
> 
> Behavior before patch:
> 
> $ sudo -s
> $ setenforce 0
> $ echo '/test.txt       --      system_u:object_r:foo_bar_baz:s0' >> /etc/selinux/targeted/contexts/files/file_contexts
> $ restorecon -v /test.txt
> Relabeled /test.txt from system_u:object_r:etc_runtime_t:s0 to system_u:object_r:foo_bar_baz:s0
> 
> Behavior after patch:
> 
> $ sudo -s
> $ setenforce 0
> $ echo '/test.txt       --      system_u:object_r:foo_bar_baz:s0' >> /etc/selinux/targeted/contexts/files/file_contexts
> $ restorecon -v /test.txt
> restorecon: /etc/selinux/targeted/contexts/files/file_contexts: line 6123 has invalid context system_u:object_r:foo_bar_baz:s0
> Invalid argument
> 
> Signed-off-by: Yuli Khodorkovskiy <ykhodo@gmail.com>
> ---
>  policycoreutils/setfiles/setfiles.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
> index bc83c27b..ce1e4324 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -217,7 +217,7 @@ int main(int argc, char **argv)
>  		 * Do not abort on errors during the file tree walk,
>  		 * Do not try to track inode associations for conflict detection,
>  		 * Follows mounts,
> -		 * Does lazy validation of contexts upon use.
> +		 * Validates all file contexts at init time.

I think this was intentional; the reason they didn't want to validate all file contexts at init time for restorecon was that they didn't want a single error in file_contexts to prevent restorecon from working at all (e.g. one typo could kill restorecon -R /dev during boot, even if the erroneous entry had nothing to do with /dev).  Instead, I think we were doing validation lazily for the context to be used, e.g. matchpathcon() or selabel_lookup() would validate the context before returning it.  Looking at the code, we do call compat_validate() in selabel_fini(), which occurs just prior to returning a result from lookup.  And this will call selabel_validate() unless the caller has set an invalidcon or canoncon callback (legacy matchpathcon support).  And selabel_validate() has a check to see if the individual context has already been validated (contexts->validated), but it also presently returns immediately if the caller did not set validation up front. Meanwhile, process_line() and load_mmap() don't even call selabel_validate() if !rec->validating.  I think it is a bug in selabel_validate() that it is returning immediately if !rec->validating.  During initialization (i.e. loading of file_contexts or file_contexts.bin by process_line() or load_mmap() respectively), we should only call selabel_validate() if rec->validating (as is presently done).  But at lookup, selabel_fini() should call selabel_validate() and that should validate the context unless it has already been validated (based on contexts->validated), irrespective of rec->validating.  That's the lazy validation part.  Then we get validation before any context gets used but we don't break entirely if there is a single bad entry in file_contexts.  Sound reasonable?

>  		 */
>  		if (strcmp(base, RESTORECON))
>  			fprintf(stderr, "Executed with unrecognized name (%s), defaulting to %s behavior.\n",
> @@ -230,7 +230,7 @@ int main(int argc, char **argv)
>  		r_opts.add_assoc = 0;
>  		r_opts.xdev = 0;
>  		r_opts.ignore_mounts = 0;
> -		ctx_validate = 0;
> +		ctx_validate = 1;
>  		opts = ropts;
>  
>  		/* restorecon only:  silent exit if no SELinux.
> 
