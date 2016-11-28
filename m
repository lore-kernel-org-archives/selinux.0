Subject: Re: [PATCH 2/5] libsepol: do not check decl->symtab[i].nprim
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161123220646.23504-1-nicolas.iooss@m4x.org>
 <20161123220646.23504-2-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e4e661fc-4a2e-ef19-28f4-c7ecd974f7eb@tycho.nsa.gov>
Date: Mon, 28 Nov 2016 09:20:16 -0500
MIME-Version: 1.0
In-Reply-To: <20161123220646.23504-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/23/2016 05:06 PM, Nicolas Iooss wrote:
> Commit 02a7d77ef2bf ("libsepol: make parsing symbol table headers more
> robust") broke refpolicy build, because checkmodule generates avrule
> decl blocks with "decl->symtab[i].nprim = 0" for all possible i, even
> when decl->symtab[SYM_ROLES] and decl->symtab[SYM_TYPES] are not
> empty.
> 
> More precisely, decl->symtab[i].nprim seems to be only updated in
> libsepol/src/link.c (in *_copy_callback() functions).
> 
> Revert the buggy part of commit 02a7d77ef2bf to fix this regression.

Thanks, applied.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/policydb.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index d1019e42de16..f9b2ec379c33 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -3510,10 +3510,6 @@ static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
>  			return -1;
>  		nprim = le32_to_cpu(buf[0]);
>  		nel = le32_to_cpu(buf[1]);
> -		if (nel && !nprim) {
> -			ERR(fp->handle, "unexpected items in decl symbol table with no symbol");
> -			return -1;
> -		}
>  		for (j = 0; j < nel; j++) {
>  			if (read_f[i] (p, decl->symtab[i].table, fp)) {
>  				return -1;
> 
