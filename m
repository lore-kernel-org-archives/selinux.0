Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n83Kd5vS029335
	for <selinux@tycho.nsa.gov>; Thu, 3 Sep 2009 16:39:05 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n83KeMpW004694
	for <selinux@tycho.nsa.gov>; Thu, 3 Sep 2009 20:40:22 GMT
Date: Thu, 03 Sep 2009 16:39:02 -0400
Subject: Re: semodule/libsemanage patch to allow enable and disable of
 modules.
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C6C5A1A6.AA5C4%csellers@tresys.com>
In-Reply-To: <4A981AC6.4040006@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/28/09 1:58 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> The general idea is to relabel a disabled policy module as
> policymodule.pp.disabled
> 
> Then make sure -u and -i update this name.
> 
> Rebuilding policy does not include .disabled
> 
> Listing shows disabled as disabled.
> 
> semodule -r will remove disabled modules. If you reinstall they will come
> back.
> 
> # /usr/sbin/semodule -d unconfined
> # /usr/sbin/semodule -l | grep unc
> unconfined 3.0.1 Disabled
> unconfineduser 1.0.0 
> # ls -lZ /etc/selinux/targeted/modules/active/modules/unconfined.pp*
> -rw-------. root root staff_u:object_r:semanage_store_t:s0
> /etc/selinux/targeted/modules/active/modules/unconfined.pp.disabled
> # /usr/sbin/semodule -i /usr/share/selinux/targeted/unconfined.pp.bz2
> # /usr/sbin/semodule -l | grep unc
> unconfined 3.0.1 Disabled
> unconfineduser 1.0.0 
> # /usr/sbin/semodule -e unconfined
> # /usr/sbin/semodule -l | grep unc
> unconfined 3.0.1 
> unconfineduser 1.0.0 
> 
> This would allow an admin to disable a module and the module will stay
> disabled until he enables it.
<snip>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index f7d65eb..49a2357 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -53,6 +53,8 @@
>  #include "policy.h"
>  #include <sys/mman.h>
>  
> +static const char *DISABLESTR=".disabled";
> +
>  static void semanage_direct_destroy(semanage_handle_t * sh);
>  static int semanage_direct_disconnect(semanage_handle_t * sh);
>  static int semanage_direct_begintrans(semanage_handle_t * sh);
> @@ -66,6 +68,8 @@ static int semanage_direct_upgrade_file(semanage_handle_t *
> sh, const char *modu
>  static int semanage_direct_install_base(semanage_handle_t * sh, char
> *base_data,
>                      size_t data_len);
>  static int semanage_direct_install_base_file(semanage_handle_t * sh, const
> char *module_name);
> +static int semanage_direct_enable(semanage_handle_t * sh, char *module_name);
> +static int semanage_direct_disable(semanage_handle_t * sh, char
> *module_name);
>  static int semanage_direct_remove(semanage_handle_t * sh, char *module_name);
>  static int semanage_direct_list(semanage_handle_t * sh,
>                  semanage_module_info_t ** modinfo,
> @@ -83,6 +87,8 @@ static struct semanage_policy_table direct_funcs = {
>      .upgrade_file = semanage_direct_upgrade_file,
>      .install_base = semanage_direct_install_base,
>      .install_base_file = semanage_direct_install_base_file,
> +    .enable = semanage_direct_enable,
> +    .disable = semanage_direct_disable,
>      .remove = semanage_direct_remove,
>      .list = semanage_direct_list
>  };
> @@ -1002,6 +1008,17 @@ static int semanage_direct_commit(semanage_handle_t *
> sh)
>      return retval;
>  }
>  
> +static char * get_store_name(const char *file)
> +{
> +    int len = strlen(file) + strlen(DISABLESTR) + 1;
> +    char *storename = calloc(1, len);
> +    if (! storename) return NULL;
> +    snprintf(storename,len, "%s%s", file, DISABLESTR);
> +    if ( access(storename, F_OK) == 0) return storename;
> +    free(storename);
> +    return strdup(file);
> +}
> +
>  /* Writes a module to the sandbox's module directory, overwriting any
>   * previous module stored within.  Note that module data are not
>   * free()d by this function; caller is responsible for deallocating it
> @@ -1019,11 +1036,20 @@ static int semanage_direct_install(semanage_handle_t *
> sh,
>                         &filename)) != 0) {
>          goto cleanup;
>      }
> -    if (bzip(sh, filename, data, data_len) <= 0) {
> +
> +    char *storename = get_store_name(filename);
> +    if (!storename) {
> +        ERR(sh, "Could not allocate memory");
> +        retval = -1;
> +        goto cleanup;
> +    }
> +    if (bzip(sh, storename, data, data_len) <= 0) {

Should we present some sort of warning to the user if they install/upgrade a
module that is disabled? This seems to maintain the disabled status
silently, which might confuse users (e.g. "I just installed that module, why
isn't the policy working").

Also, I see that you patched direct_install, but not direct_upgrade. So,
upgrade will try to re-enable the module if it has been disabled.

>          ERR(sh, "Error while writing to %s.", filename);
>          retval = -3;
>          goto cleanup;
>      }
> +    free(storename);
> +
>      retval = 0;
>        cleanup:
>      free(version);
> @@ -1268,6 +1294,107 @@ static int
> semanage_direct_install_base_file(semanage_handle_t * sh,
>      return retval;
>  }
>  
> +/* Enables a module from the sandbox.  Returns 0 on success, -1 if out
> + * of memory, -2 if module not found or could not be enabled. */
> +static int semanage_direct_enable(semanage_handle_t * sh, char *module_name)
> +{
> +    int i, retval = -1;
> +    char **module_filenames = NULL;
> +    int num_mod_files;
> +    size_t name_len = strlen(module_name);
> +    if (semanage_get_modules_names(sh, &module_filenames, &num_mod_files) ==
> +        -1) {
> +        return -1;
> +    }
> +    for (i = 0; i < num_mod_files; i++) {
> +        char *base = strrchr(module_filenames[i], '/');
> +        if (base == NULL) {
> +            ERR(sh, "Could not read module names.");
> +            retval = -2;
> +            goto cleanup;
> +        }
> +        base++;
> +        if (memcmp(module_name, base, name_len) == 0 &&
> +            strcmp(base + name_len + 3, DISABLESTR) == 0) {
> +            int len = strlen(module_filenames[i]) - strlen(DISABLESTR);
> +            char *enabled_name = calloc(1, len+1);
> +            if (!enabled_name) {
> +                ERR(sh, "Could not allocate memory");
> +                retval = -1;
> +                goto cleanup;
> +            }
> +
> +            strncpy(enabled_name, module_filenames[i],len);
> +
> +            if (rename(module_filenames[i], enabled_name) == -1) {
> +                ERR(sh, "Could not enable module file %s.",
> +                    enabled_name);
> +                retval = -2;
> +            }
> +            retval = 0;
> +            free(enabled_name);
> +            goto cleanup;
> +        }
> +    }
> +    ERR(sh, "Module %s was not found.", module_name);
> +    retval = -2;        /* module not found */
> +      cleanup:
> +    for (i = 0; module_filenames != NULL && i < num_mod_files; i++) {
> +        free(module_filenames[i]);
> +    }
> +    free(module_filenames);
> +    return retval;
> +}
> +
> +/* Enables a module from the sandbox.  Returns 0 on success, -1 if out
> + * of memory, -2 if module not found or could not be enabled. */
> +static int semanage_direct_disable(semanage_handle_t * sh, char *module_name)
> +{
> +    int i, retval = -1;
> +    char **module_filenames = NULL;
> +    int num_mod_files;
> +    size_t name_len = strlen(module_name);
> +    if (semanage_get_modules_names(sh, &module_filenames, &num_mod_files) ==
> +        -1) {
> +        return -1;
> +    }
> +    for (i = 0; i < num_mod_files; i++) {
> +        char *base = strrchr(module_filenames[i], '/');
> +        if (base == NULL) {
> +            ERR(sh, "Could not read module names.");
> +            retval = -2;
> +            goto cleanup;
> +        }
> +        base++;
> +        if (memcmp(module_name, base, name_len) == 0 &&
> +            strcmp(base + name_len, ".pp") == 0) {
> +            char disabled_name[PATH_MAX];
> +            if (snprintf(disabled_name, PATH_MAX, "%s%s",
> +                     module_filenames[i], DISABLESTR) == PATH_MAX) {
> +                ERR(sh, "Could not disable module file %s.",
> +                    module_filenames[i]);
> +                retval = -2;
> +                goto cleanup;
> +            }
> +            if (rename(module_filenames[i], disabled_name) == -1) {
> +                ERR(sh, "Could not disable module file %s.",
> +                    module_filenames[i]);
> +                retval = -2;
> +            }
> +            retval = 0;
> +            goto cleanup;
> +        }
> +    }
> +    ERR(sh, "Module %s was not found.", module_name);
> +    retval = -2;        /* module not found */
> +      cleanup:
> +    for (i = 0; module_filenames != NULL && i < num_mod_files; i++) {
> +        free(module_filenames[i]);
> +    }
> +    free(module_filenames);
> +    return retval;
> +}
> +
While this function does succeed in renaming a file, it does not succeed in
preventing the module from being linked in. semanage_get_modules_names()
grabs everything in the modules directory, so the disabled modules here are
still linked into the policy. A quick sesearch confirms this.

To fix this, you'll either need to modify semanage_filename_select() to
filter out files ending in .disabled or perhaps just move them from the
modules directory to a disabled_modules directory (instead of the rename).
The latter option has the advantage of not requiring filtering that could go
wrong at some point, so I would lean toward it.

Thanks,
Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
