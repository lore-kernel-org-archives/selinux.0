Subject: Re: [PATCH 3/3] libsepol: make parsing symbol table headers more
 robust
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161115230723.20043-1-nicolas.iooss@m4x.org>
 <20161115230723.20043-3-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <786aed42-b323-3cc7-932d-bcb078fea4ea@tycho.nsa.gov>
Date: Wed, 16 Nov 2016 09:15:20 -0500
MIME-Version: 1.0
In-Reply-To: <20161115230723.20043-3-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/15/2016 06:07 PM, Nicolas Iooss wrote:
> When hll/pp loads a policy file which has been modified so that the
> nprim field of one of its non-empty symbol table was changed to zero, it
> crashes with a segmentation fault. A quick analysis leads to
> "p->sym_val_to_name[i] = (char **)alloc(p->symtab[i].nprim, sizeof(char
> *));" in policydb_index_others(), which is not executed when
> p->symtab[i].nprim is zero even though there are items in
> p->symtab[i].table.
> 
> Detect such an oddity in the policy file early to exit with a clean
> error message.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied all three.

> ---
>  libsepol/src/policydb.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index b112fd5465b5..d1019e42de16 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -3510,6 +3510,10 @@ static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
>  			return -1;
>  		nprim = le32_to_cpu(buf[0]);
>  		nel = le32_to_cpu(buf[1]);
> +		if (nel && !nprim) {
> +			ERR(fp->handle, "unexpected items in decl symbol table with no symbol");
> +			return -1;
> +		}
>  		for (j = 0; j < nel; j++) {
>  			if (read_f[i] (p, decl->symtab[i].table, fp)) {
>  				return -1;
> @@ -3881,6 +3885,10 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
>  			goto bad;
>  		nprim = le32_to_cpu(buf[0]);
>  		nel = le32_to_cpu(buf[1]);
> +		if (nel && !nprim) {
> +			ERR(fp->handle, "unexpected items in symbol table with no symbol");
> +			goto bad;
> +		}
>  		for (j = 0; j < nel; j++) {
>  			if (read_f[i] (p, p->symtab[i].table, fp))
>  				goto bad;
> 
