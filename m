Date: Sun, 25 Sep 2016 23:41:55 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libsemanage: use pp module headers as a source for a
 module name
Message-ID: <20160925214154.4phfbn5szkkj2los@rhel-at-redhat.localdomain>
References: <1474622600-22721-1-git-send-email-plautrba@redhat.com>
 <cde8f8f7-002a-d5d9-57d3-d8978c98b8aa@tycho.nsa.gov>
 <cc78c259-7c85-6f91-bba3-003b83fe3c29@redhat.com>
 <a853ebf7-5c55-2abf-2d22-02ca17e391c7@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a853ebf7-5c55-2abf-2d22-02ca17e391c7@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 23, 2016 at 01:37:26PM -0400, James Carter wrote:
> On 09/23/2016 12:05 PM, Petr Lautrbach wrote:
> > On 09/23/2016 05:31 PM, James Carter wrote:
> > > On 09/23/2016 05:23 AM, Petr Lautrbach wrote:
> > > > When a user installs a module, the filename is used as the module name.
> > > > This change was introduced with CIL language where a module name is not
> > > > stored in the module itself. It means that when a pp module has
> > > > different filename and stored module name, the filename is used instead
> > > > of the stored module name. It brings problems with compatibility for
> > > > scripts and modules which were built and used on older system and were
> > > > migrated to the new userspace.
> > > > 
> > > > This patch changes the behavior of semanage_direct_install_file() which
> > > > is used by 'semodule -i' so that when a module with pp language
> > > > extension is installed, it tries to get and use a stored module name
> > > > instead of a filename.
> > > > 
> > > > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > > 
> > > I am not in favor of this for several reasons:
> > > 1) There would be conflicts if a module name is the same as a different
> > > module's file name.
> > 
> > Do you mean a case where you try to install two modules moduleA.pp
> > moduleB.pp, where moduleA.pp uses "module moduleB 1.0;" ?
> > 
> > 
> > > 2) It would be confusing to have some modules referred to by their
> > > module name and other modules by their file name.
> > 
> > It's only pp modules specific and only for the initial install. 2.3
> > userspace used the same concept.
> > 
> 
> Looking closer at the patch and libsemange, it looks like this will use the
> module name of a pp file as the filename. After installation the module name
> and filename would be the same. Is that correct?
> 
> If so, then I don't have a problem with the approach at all. I thought you
> were proposing that pp modules would use their module name for operations
> while being saved in the module store by their filename.
> 
> 
> > > 3) In practice, very few modules use a module name that is different
> > > from their file name.
> > 
> > I've already seen few reports related to this problem. We fixed it in
> > Fedora and RHEL but there are 3rd party modules which have this problem
> > 
> > > In April checkmodule was modified to fail compiling a module when the
> > > module name was different from the file name and pp (which does pp to
> > > CIL conversion) will give a warning message when converting a pp file to
> > > CIL. Is that not sufficient?
> > > 
> > 
> > Unfortunately it doesn't affect semodule itself, there's no warning:
> > 
> > # /usr/libexec/selinux/hll/pp testfile.pp testfile.out
> > Warning: SELinux userspace will refer to the module from testfile.pp as
> > testfile rather than testmod
> > 
> > # semodule -l | grep test
> > # semodule -i testfile.pp
> > # semodule -l | grep test
> > testfile
> > 
> > # /usr/libexec/selinux/hll/pp testfile.pp testfile.out
> > Warning: SELinux userspace will refer to the module from testfile.pp as
> > testfile rather than testmod
> > 
> > 
> > The same warning should be either part of the patch and I' ready to add
> > it to the patch. Or at least there should be warning that the module
> > will use its filename not a name specified in the module.
> > 
> > 
> 
> I tested pp, but must not have tested how it worked when used by semodule.
> We should have a warning here and I would appreciate you adding it to the
> patch.
> 

Sent as [PATCH v2] libsemanage: Use pp module name instead of filename.
There's a warning now and I changed the warning in hll/pp to reflect
this change as well.

But I guess your objections still apply.

I'll be offline for next 7 days and I won't be able respond to anything.

Thanks,

Petr


> 
> > 
> > Petr
> > 
> > 
> > > 
> > > > ---
> > > >  libsemanage/src/direct_api.c | 62
> > > > +++++++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 61 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> > > > index 2187b65..f98d3d1 100644
> > > > --- a/libsemanage/src/direct_api.c
> > > > +++ b/libsemanage/src/direct_api.c
> > > > @@ -363,6 +363,48 @@ static int
> > > > semanage_direct_begintrans(semanage_handle_t * sh)
> > > > 
> > > >  /********************* utility functions *********************/
> > > > 
> > > > +/* Takes a module stored in 'module_data' and parses its headers.
> > > > + * Sets reference variables 'module_name' to module's name, and
> > > > + * 'version' to module's version.  The caller is responsible for
> > > > + * free()ing 'module_name', and 'version'; they will be
> > > > + * set to NULL upon entering this function.  Returns 0 on success, -1
> > > > + * if out of memory, or -2 if data did not represent a module.
> > > > + */
> > > > +static int parse_module_headers(semanage_handle_t * sh, char
> > > > *module_data,
> > > > +                               size_t data_len, char **module_name,
> > > > +                               char **version)
> > > > +{
> > > > +       struct sepol_policy_file *pf;
> > > > +       int file_type;
> > > > +       *module_name = *version = NULL;
> > > > +
> > > > +       if (sepol_policy_file_create(&pf)) {
> > > > +               ERR(sh, "Out of memory!");
> > > > +               return -1;
> > > > +       }
> > > > +       sepol_policy_file_set_mem(pf, module_data, data_len);
> > > > +       sepol_policy_file_set_handle(pf, sh->sepolh);
> > > > +       if (module_data == NULL ||
> > > > +           data_len == 0 ||
> > > > +           sepol_module_package_info(pf, &file_type, module_name,
> > > > +                                     version) == -1) {
> > > > +               sepol_policy_file_free(pf);
> > > > +               ERR(sh, "Could not parse module data.");
> > > > +               return -2;
> > > > +       }
> > > > +       sepol_policy_file_free(pf);
> > > > +       if (file_type != SEPOL_POLICY_MOD) {
> > > > +               if (file_type == SEPOL_POLICY_BASE)
> > > > +                       ERR(sh,
> > > > +                           "Received a base module, expected a
> > > > non-base module.");
> > > > +               else
> > > > +                       ERR(sh, "Data did not represent a module.");
> > > > +               return -2;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  #include <stdlib.h>
> > > >  #include <bzlib.h>
> > > >  #include <string.h>
> > > > @@ -1524,7 +1566,9 @@ static int
> > > > semanage_direct_install_file(semanage_handle_t * sh,
> > > >      char *path = NULL;
> > > >      char *filename;
> > > >      char *lang_ext = NULL;
> > > > +    char *module_name = NULL;
> > > >      char *separator;
> > > > +    char *version = NULL;
> > > > 
> > > >      if ((data_len = map_file(sh, install_filename, &data,
> > > > &compressed)) <= 0) {
> > > >          ERR(sh, "Unable to read file %s\n", install_filename);
> > > > @@ -1564,10 +1608,26 @@ static int
> > > > semanage_direct_install_file(semanage_handle_t * sh,
> > > >          lang_ext = separator + 1;
> > > >      }
> > > > 
> > > > -    retval = semanage_direct_install(sh, data, data_len, filename,
> > > > lang_ext);
> > > > +    if (strcmp(lang_ext, "pp") != 0)
> > > > +        module_name = strdup(filename);
> > > > +    else {
> > > > +        if (parse_module_headers(sh, data, data_len, &module_name,
> > > > &version) != 0) {
> > > > +            free(module_name);
> > > > +            module_name = strdup(filename);
> > > > +        }
> > > > +        free(version);
> > > > +    }
> > > > +    if (module_name == NULL) {
> > > > +        ERR(sh, "No memory available for module_name.\n");
> > > > +        retval = -1;
> > > > +        goto cleanup;
> > > > +    }
> > > > +
> > > > +    retval = semanage_direct_install(sh, data, data_len, module_name,
> > > > lang_ext);
> > > > 
> > > >  cleanup:
> > > >      if (data_len > 0) munmap(data, data_len);
> > > > +    free(module_name);
> > > >      free(path);
> > > > 
> > > >      return retval;
> > > > 
> > > 
> > > 
> 
> 
> -- 
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency

-- 
Petr Lautrbach
