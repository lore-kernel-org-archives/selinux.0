Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v04N4jDX008061
 for <selinux@tycho.nsa.gov>; Wed, 4 Jan 2017 18:04:46 -0500
Received: by mail-oi0-f67.google.com with SMTP id f201so76827202oib.0
 for <selinux@tycho.nsa.gov>; Wed, 04 Jan 2017 15:04:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170104220229.26497-1-nicolas.iooss@m4x.org>
References: <20170104220229.26497-1-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 4 Jan 2017 15:04:40 -0800
Message-ID: <CAFftDdqs7zQWCm85YZSmtZ=0fiwXxXsT7JSS=Lr2OxKUwhOfbQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol: make capability index an unsigned int
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jan 4, 2017 at 2:02 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> When sepol_polcap_getname() is called with a negative capnum, it
> dereferences polcap_names[capnum] which produces a segmentation fault
> most of the time.
>
> For information, here is a gdb session when hll/pp loads a policy module
> which has been mutated by American Fuzzy Lop:
>
>     Program received signal SIGSEGV, Segmentation fault.
>     sepol_polcap_getname (capnum=capnum@entry=-4259840) at polcaps.c:34
>     34      return polcap_names[capnum];
>     => 0x00007ffff7a8da07 <sepol_polcap_getname+135>:   48 8b 04 f8 mov
>     (%rax,%rdi,8),%rax
>
>     (gdb) bt
>     #0  sepol_polcap_getname (capnum=capnum@entry=-4259840) at
>     polcaps.c:34
>     #1  0x00007ffff7a7c440 in polcaps_to_cil (pdb=0x6042e0) at
>     module_to_cil.c:2492
>     #2  sepol_module_policydb_to_cil (fp=fp@entry=0x7ffff79c75e0
>     <_IO_2_1_stdout_>, pdb=0x6042e0, linked=linked@entry=0) at
>     module_to_cil.c:4039
>     #3  0x00007ffff7a7e695 in sepol_module_package_to_cil
>     (fp=fp@entry=0x7ffff79c75e0 <_IO_2_1_stdout_>, mod_pkg=0x604280) at
>     module_to_cil.c:4087
>     #4  0x0000000000401acc in main (argc=<optimized out>,
>     argv=<optimized out>) at pp.c:150
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/include/sepol/policydb/polcaps.h | 2 +-
>  libsepol/src/polcaps.c                    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
> index c9e40f62048d..623818ab10f5 100644
> --- a/libsepol/include/sepol/policydb/polcaps.h
> +++ b/libsepol/include/sepol/policydb/polcaps.h
> @@ -19,7 +19,7 @@ enum {
>  extern int sepol_polcap_getnum(const char *name);
>
>  /* Convert a capability number to name. */
> -extern const char *sepol_polcap_getname(int capnum);
> +extern const char *sepol_polcap_getname(unsigned int capnum);

unsigned is definitely a way to fix this, but now I see that
sepol_polcap_getnum() wouldn't be able
to use the full range of unsigned as its return of < 0 indicates error.

Perhaps use the enum types in both cases? However, based on compiler
flags, IIRC, enums may be treated as signed or unsigned int.

 It's really likely never a problem, but just something to
mention.

>
>  #ifdef __cplusplus
>  }
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index 3924cb83f29c..248d2f525185 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -26,7 +26,7 @@ int sepol_polcap_getnum(const char *name)
>         return -1;
>  }
>
> -const char *sepol_polcap_getname(int capnum)
> +const char *sepol_polcap_getname(unsigned int capnum)
>  {
>         if (capnum > POLICYDB_CAPABILITY_MAX)
>                 return NULL;

There is a possibility that this enum and the strings could get out of
sync and then we would also want
to bound this value (sizeof(polcap_names)/sizeof(polcap_names[0]))) -1
We would be able to drop the -1 if the NULL on polcap_names can go away...

We could also detect this mismatch at compile time:
typedef int WRONG_POLCAP_SIZE
[((sizeof(polcap_names)/sizeof(polcap_names[0]))) -1 ==
POLICYDB_CAPABILITY_MAX) - 1];
-1 size arrays are illegal in C, so we want the array to be 0 length
on correct size, -1 on bad size. That above code snippet might not be
100% but that should be close.



> --
> 2.11.0
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Respectfully,

William C Roberts
