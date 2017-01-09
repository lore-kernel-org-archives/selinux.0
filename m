Message-ID: <1483995852.20858.99.camel@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] libsepol: make capability index an unsigned int
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Mon, 09 Jan 2017 16:04:12 -0500
In-Reply-To: <20170104220229.26497-1-nicolas.iooss@m4x.org>
References: <20170104220229.26497-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-01-04 at 23:02 +0100, Nicolas Iooss wrote:
> When sepol_polcap_getname() is called with a negative capnum, it
> dereferences polcap_names[capnum] which produces a segmentation fault
> most of the time.
> 
> For information, here is a gdb session when hll/pp loads a policy
> module
> which has been mutated by American Fuzzy Lop:
> 
>     Program received signal SIGSEGV, Segmentation fault.
>     sepol_polcap_getname (capnum=capnum@entry=-4259840) at
> polcaps.c:34
>     34      return polcap_names[capnum];
>     => 0x00007ffff7a8da07 <sepol_polcap_getname+135>:   48 8b 04 f8
> mov
>     (%rax,%rdi,8),%rax
> 
>     (gdb) bt
>     #0  sepol_polcap_getname (capnum=capnum@entry=-4259840) at
>     polcaps.c:34
>     #1  0x00007ffff7a7c440 in polcaps_to_cil (pdb=0x6042e0) at
>     module_to_cil.c:2492
>     #2  sepol_module_policydb_to_cil (fp=fp@entry=0x7ffff79c75e0
>     <_IO_2_1_stdout_>, pdb=0x6042e0, linked=linked@entry=0) at
>     module_to_cil.c:4039
>     #3  0x00007ffff7a7e695 in sepol_module_package_to_cil
>     (fp=fp@entry=0x7ffff79c75e0 <_IO_2_1_stdout_>, mod_pkg=0x604280)
> at
>     module_to_cil.c:4087
>     #4  0x0000000000401acc in main (argc=<optimized out>,
>     argv=<optimized out>) at pp.c:150
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied.

> ---
>  libsepol/include/sepol/policydb/polcaps.h | 2 +-
>  libsepol/src/polcaps.c                    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libsepol/include/sepol/policydb/polcaps.h
> b/libsepol/include/sepol/policydb/polcaps.h
> index c9e40f62048d..623818ab10f5 100644
> --- a/libsepol/include/sepol/policydb/polcaps.h
> +++ b/libsepol/include/sepol/policydb/polcaps.h
> @@ -19,7 +19,7 @@ enum {
>  extern int sepol_polcap_getnum(const char *name);
>  
>  /* Convert a capability number to name. */
> -extern const char *sepol_polcap_getname(int capnum);
> +extern const char *sepol_polcap_getname(unsigned int capnum);
>  
>  #ifdef __cplusplus
>  }
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index 3924cb83f29c..248d2f525185 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -26,7 +26,7 @@ int sepol_polcap_getnum(const char *name)
>  	return -1;
>  }
>  
> -const char *sepol_polcap_getname(int capnum)
> +const char *sepol_polcap_getname(unsigned int capnum)
>  {
>  	if (capnum > POLICYDB_CAPABILITY_MAX)
>  		return NULL;
