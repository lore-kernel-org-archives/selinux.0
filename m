Subject: Re: [PATCH v2] libsemanage: Use pp module name instead of filename
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1474839243-22096-1-git-send-email-plautrba@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <f1ebb001-c4a7-c3d2-e08d-93a0181bb8dc@tycho.nsa.gov>
Date: Mon, 26 Sep 2016 11:49:33 -0400
MIME-Version: 1.0
In-Reply-To: <1474839243-22096-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/25/2016 05:34 PM, Petr Lautrbach wrote:
> When a user installs a module, the filename is used as the module name.
> This change was introduced with CIL language where a module name is not
> stored in the module itself. It means that when a pp module has
> different filename and stored module name, the filename is used instead
> of the stored module name. It brings problems with compatibility for
> scripts and modules which were built and used on older system and were
> migrated to the new userspace.
>
> This patch changes the behavior of semanage_direct_install_file() which
> is used by 'semodule -i' so that when a module with pp language
> extension is installed, it tries to get and use a stored module name
> instead of a filename. A warning message is provided.
>
> The warning message in policycoreutils/hll/pp is updated to reflect this
> change:
>
> $ semodule -X 400 -i /root/testfile.pp
> Warning: SELinux userspace will refer to the module from /root/testfile.pp as testmod rather than testfile
>
> $ /usr/libexec/selinux/hll/pp /root/testfile.pp testfile.cil
> Warning: SELinux userspace will refer to the module from /root/testfile.pp as testmod rather than testfile
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Applied.

Thanks,

> ---
>  libsemanage/src/direct_api.c | 61 +++++++++++++++++++++++++++++++++++++++++++-
>  policycoreutils/hll/pp/pp.c  |  2 +-
>  2 files changed, 61 insertions(+), 2 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 2187b65..4320f43 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -363,6 +363,48 @@ static int semanage_direct_begintrans(semanage_handle_t * sh)
>
>  /********************* utility functions *********************/
>
> +/* Takes a module stored in 'module_data' and parses its headers.
> + * Sets reference variables 'module_name' to module's name, and
> + * 'version' to module's version.  The caller is responsible for
> + * free()ing 'module_name', and 'version'; they will be
> + * set to NULL upon entering this function.  Returns 0 on success, -1
> + * if out of memory, or -2 if data did not represent a module.
> + */
> +static int parse_module_headers(semanage_handle_t * sh, char *module_data,
> +                               size_t data_len, char **module_name,
> +                               char **version)
> +{
> +       struct sepol_policy_file *pf;
> +       int file_type;
> +       *module_name = *version = NULL;
> +
> +       if (sepol_policy_file_create(&pf)) {
> +               ERR(sh, "Out of memory!");
> +               return -1;
> +       }
> +       sepol_policy_file_set_mem(pf, module_data, data_len);
> +       sepol_policy_file_set_handle(pf, sh->sepolh);
> +       if (module_data == NULL ||
> +           data_len == 0 ||
> +           sepol_module_package_info(pf, &file_type, module_name,
> +                                     version) == -1) {
> +               sepol_policy_file_free(pf);
> +               ERR(sh, "Could not parse module data.");
> +               return -2;
> +       }
> +       sepol_policy_file_free(pf);
> +       if (file_type != SEPOL_POLICY_MOD) {
> +               if (file_type == SEPOL_POLICY_BASE)
> +                       ERR(sh,
> +                           "Received a base module, expected a non-base module.");
> +               else
> +                       ERR(sh, "Data did not represent a module.");
> +               return -2;
> +       }
> +
> +       return 0;
> +}
> +
>  #include <stdlib.h>
>  #include <bzlib.h>
>  #include <string.h>
> @@ -1524,7 +1566,9 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
>  	char *path = NULL;
>  	char *filename;
>  	char *lang_ext = NULL;
> +	char *module_name = NULL;
>  	char *separator;
> +	char *version = NULL;
>
>  	if ((data_len = map_file(sh, install_filename, &data, &compressed)) <= 0) {
>  		ERR(sh, "Unable to read file %s\n", install_filename);
> @@ -1564,10 +1608,25 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
>  		lang_ext = separator + 1;
>  	}
>
> -	retval = semanage_direct_install(sh, data, data_len, filename, lang_ext);
> +	if (strcmp(lang_ext, "pp") != 0) {
> +		module_name = strdup(filename);
> +		if (module_name == NULL) {
> +			ERR(sh, "No memory available for module_name.\n");
> +			retval = -1;
> +			goto cleanup;
> +		}
> +	} else {
> +		if ((retval = parse_module_headers(sh, data, data_len, &module_name, &version)) != 0)
> +			goto cleanup;
> +
> +		fprintf(stderr, "Warning: SELinux userspace will refer to the module from %s as %s rather than %s\n", install_filename, module_name, filename);
> +		free(version);
> +	}
> +	retval = semanage_direct_install(sh, data, data_len, module_name, lang_ext);
>
>  cleanup:
>  	if (data_len > 0) munmap(data, data_len);
> +	free(module_name);
>  	free(path);
>
>  	return retval;
> diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
> index 9245975..2c9f53f 100644
> --- a/policycoreutils/hll/pp/pp.c
> +++ b/policycoreutils/hll/pp/pp.c
> @@ -142,7 +142,7 @@ int main(int argc, char **argv)
>  			*separator = '\0';
>  		}
>  		if (strcmp(mod_name, cil_name) != 0) {
> -			fprintf(stderr,	"Warning: SELinux userspace will refer to the module from %s as %s rather than %s\n", ifile, cil_name, mod_name);
> +			fprintf(stderr,	"Warning: SELinux userspace will refer to the module from %s as %s rather than %s\n", ifile, mod_name, cil_name);
>  		}
>  		free(cil_path);
>  	}
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
