MIME-Version: 1.0
In-Reply-To: <1460041566-7173-2-git-send-email-jwcart2@tycho.nsa.gov>
References: <1460041566-7173-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1460041566-7173-2-git-send-email-jwcart2@tycho.nsa.gov>
Date: Thu, 7 Apr 2016 12:41:28 -0400
Message-ID: <CAHut7+0yD-cGAEMAkYMuiHqG4wT0-EX5b9iJzEWnSnAasyDPzw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] policycoreutils/hll/pp: Warn if module name
 different than output filename
From: Thomas Hurd <toml.hurd@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Apr 7, 2016 at 11:06 AM, James Carter <jwcart2@tycho.nsa.gov> wrote:
>
> Since CIL treats files as modules and does not have a separate
> module statement it can cause confusion when a Refpolicy module
> has a name that is not the same as its base filename because older
> SELinux userspaces will refer to the module by its module name while
> a CIL-based userspace will refer to it by its filename.
>
> Because of this, provide a warning message when converting a policy
> package to CIL and the output filename is different than the module
> name.
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  policycoreutils/hll/pp/pp.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
> index 866734f..8621b50 100644
> --- a/policycoreutils/hll/pp/pp.c
> +++ b/policycoreutils/hll/pp/pp.c
> @@ -28,6 +28,7 @@
>
>  #include <sepol/module.h>
>  #include <sepol/module_to_cil.h>
> +#include <sepol/policydb/module.h>
>
>  char *progname;
>
> @@ -68,6 +69,8 @@ int main(int argc, char **argv)
>                 { NULL, 0, NULL, 0 }
>         };
>         struct sepol_module_package *mod_pkg = NULL;
> +       char *ifile = NULL;
> +       char *ofile = NULL;
>         FILE *in = NULL;
>         FILE *out = NULL;
>         int outfd = -1;
> @@ -89,20 +92,23 @@ int main(int argc, char **argv)
>         }
>
>         if (argc >= optind + 1 && strcmp(argv[1], "-") != 0) {
> -               in = fopen(argv[1], "rb");
> +               ifile = argv[1];
> +               in = fopen(ifile, "rb");
>                 if (in == NULL) {
> -                       log_err("Failed to open %s: %s", argv[1], strerror(errno));
> +                       log_err("Failed to open %s: %s", ifile, strerror(errno));
>                         rc = -1;
>                         goto exit;
>                 }
>         } else {
> +               ifile = "stdin";
>                 in = stdin;
>         }
>
>         if (argc >= optind + 2 && strcmp(argv[2], "-") != 0) {
> -               out = fopen(argv[2], "w");
> +               ofile = argv[2];
> +               out = fopen(ofile, "w");
>                 if (out == NULL) {
> -                       log_err("Failed to open %s: %s", argv[2], strerror(errno));
> +                       log_err("Failed to open %s: %s", ofile, strerror(errno));
>                         rc = -1;
>                         goto exit;
>                 }
> @@ -122,6 +128,20 @@ int main(int argc, char **argv)
>         fclose(in);
>         in = NULL;
>
> +       if (ofile) {
> +               char *mod_name = mod_pkg->policy->p.name;
> +               char *cil_path = strdup(ofile);

Check if strdup fails here and also in the checkmodule patch?

> +               char *cil_name = basename(cil_path);
> +               char *separator = strrchr(cil_name, '.');
> +               if (separator) {
> +                       *separator = '\0';
> +               }
> +               if (strcmp(mod_name, cil_name) != 0) {
> +                       fprintf(stderr, "Warning: SELinux userspace will refer to the module from %s as %s rather than %s\n", ifile, cil_name, mod_name);
> +               }
> +               free(cil_path);
> +       }
> +
>         rc = sepol_module_package_to_cil(out, mod_pkg);
>         if (rc != 0) {
>                 goto exit;
> --
> 2.5.5
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
