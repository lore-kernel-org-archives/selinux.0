Subject: Re: [PATCH 2/3] libsepol: test for ebitmap_read() negative return
 value
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161115230723.20043-1-nicolas.iooss@m4x.org>
 <20161115230723.20043-2-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fde6c664-f627-3669-a783-cec0f98e2103@tycho.nsa.gov>
Date: Wed, 16 Nov 2016 09:11:06 -0500
MIME-Version: 1.0
In-Reply-To: <20161115230723.20043-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/15/2016 06:07 PM, Nicolas Iooss wrote:
> While fuzzing hll/pp, the fuzzer (AFL) crafted a policy which triggered
> the following message without making the policy loading fail (the
> program crashed with a segmentation fault later):
> 
>     security: ebitmap: map size 192 does not match my size 64 (high bit
>     was 0)
> 
> This is because ebitmap_read() returned -EINVAL and this value was
> handled as a successful return value by scope_index_read() because it
> was not -1.

I'll apply this, but this is a symptom of a wider problem within
libsepol with respect to mixed error return values that we should
someday fix.  It is a historical result of the fact that originally the
core checkpolicy/libsepol code was shared in common between the kernel
security server and checkpolicy/libsepol, and therefore used kernel
return code conventions.  We should probably convert it all to set errno
and return -1 but that obviously will take time.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/policydb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index e36d82f0a1e8..b112fd5465b5 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -3447,7 +3447,7 @@ static int scope_index_read(scope_index_t * scope_index,
>  	int rc;
>  
>  	for (i = 0; i < num_scope_syms; i++) {
> -		if (ebitmap_read(scope_index->scope + i, fp) == -1) {
> +		if (ebitmap_read(scope_index->scope + i, fp) < 0) {
>  			return -1;
>  		}
>  	}
> @@ -3465,7 +3465,7 @@ static int scope_index_read(scope_index_t * scope_index,
>  		return -1;
>  	}
>  	for (i = 0; i < scope_index->class_perms_len; i++) {
> -		if (ebitmap_read(scope_index->class_perms_map + i, fp) == -1) {
> +		if (ebitmap_read(scope_index->class_perms_map + i, fp) < 0) {
>  			return -1;
>  		}
>  	}
> 
