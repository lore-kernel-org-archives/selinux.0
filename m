Subject: Re: Ver3(Re: [patch] reducing size of libselinux(ver 2)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <20070510181218.0499cd05.ynakam@hitachisoft.jp>
References: <20070507133423.3bd2463a.ynakam@hitachisoft.jp>
	 <1178738679.3504.25.camel@moss-spartans.epoch.ncsc.mil>
	 <20070510181218.0499cd05.ynakam@hitachisoft.jp>
Content-Type: text/plain
Date: Thu, 10 May 2007 09:06:54 -0400
Message-Id: <1178802414.3504.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-10 at 18:12 +0900, Yuichi Nakamura wrote:
> Thank you for review and idea !
> 
> On Wed, 09 May 2007 15:24:39 -0400
> Stephen Smalley wrote:
> <snip>
> > Remove the fixed dependency on libsepol from libselinux by
> > having it use dlopen() and friends and provide graceful fallbacks
> > in the absence of libsepol.
> <snip>
> > -	if (vers > kernvers) {
> > +	if (vers > kernvers && policydb_to_image) {
> Here, 
> I think policydb_to_image is not so good to indicate whether libsepol is used or not. 
> I think  it is better to prepare flag that indicates whether libsepol functions are used or not.
> I prepared "int usesepol" flag to indicate whether libsepol functions are used or not.

That's true - dlsym() technically can return NULL even upon success.

> Please see new patch.

Looks mostly sane to me.  Some comments:
- libselinux/utils/Makefile needs to properly handle the DISABLE_AVC and
DISABLE_BOOLS options - some of those utilities won't build with your
cut-down version of libselinux so a make EMBEDDED=y at the top of
libselinux will fail.
- Is DISABLE_BOOLS still worthwhile?  Especially since I removed much of
that code already as part of removing the legacy booleans/users support
for setlocaldefs?
- Could likely introduce a DISABLE_SETRANS that reduces setrans_client.c
to trivial stubs in the embedded case (no translation daemon likely
there, right?).
- Could likely introduce a DISABLE_RPM that drops rpm.o from the
library.
- With the elimination of libsepol as a fixed dependency for libselinux,
we can go back and remove -lsepol from a number of the Makefiles (e.g.
libselinux/utils, several of the policycoreutils) and we can later
eliminate it for the patched selinux userland packages (like coreutils -
it would be nice if things like mv worked without libsepol present as
they don't need it).

> > -	vers = vers_max();
> > -	minvers = vers_min();
> > +	if (vers_max)
> > +		vers = vers_max();
> > +	if (vers_min)
> > +		minvers = vers_min();
> I think we can write
> if (usesepol){
> 	vers = vers_max();
> 	minvers = vers_min();
> }
> 
> And I cross-compiled your code with your patch in my ARM environment, and 
> load_policy in poilcycoreutils worked in my ARM device: 
> * /selinux/policyvers -> 20
> * /etc/selinux/policy/policy.19 exists
> then policy.19 was loaded successfully.
> 
> Regards,
> -- 
> Yuichi Nakamura
> Hitachi Software Engineering Co., Ltd.
> Japan SELinux Users Group(JSELUG)
> SELinux Policy Editor: http://seedit.sourceforge.net/
> 
> Below is patch version 3.
> 
>  Makefile      |   26 +++++++++++++-
>  load_policy.c |  102 ++++++++++++++++++++++++++++++++++++++++++++++++----------
>  policy.h      |    2 +
>  policyvers.c  |    2 -
>  4 files changed, 110 insertions(+), 22 deletions(-)
> Index: policyrep/libselinux/src/policyvers.c
> ===================================================================
> --- policyrep/libselinux/src/policyvers.c	(revision 2435)
> +++ policyrep/libselinux/src/policyvers.c	(working copy)
> @@ -10,8 +10,6 @@
>  #include "dso.h"
>  #include <limits.h>
>  
> -#define DEFAULT_POLICY_VERSION 15
> -
>  int security_policyvers(void)
>  {
>  	int fd, ret;
> Index: policyrep/libselinux/src/policy.h
> ===================================================================
> --- policyrep/libselinux/src/policy.h	(revision 2435)
> +++ policyrep/libselinux/src/policy.h	(working copy)
> @@ -20,4 +20,6 @@
>  
>  #define FILECONTEXTS "/etc/security/selinux/file_contexts"
>  
> +#define DEFAULT_POLICY_VERSION 15
> +
>  #endif
> Index: policyrep/libselinux/src/Makefile
> ===================================================================
> --- policyrep/libselinux/src/Makefile	(revision 2435)
> +++ policyrep/libselinux/src/Makefile	(working copy)
> @@ -18,8 +18,28 @@
>  SWIGSO=_selinux.so
>  SWIGFILES=$(SWIGSO) selinux.py 
>  LIBSO=$(TARGET).$(LIBVERSION)
> -OBJS= $(patsubst %.c,%.o,$(filter-out $(SWIGCOUT),$(wildcard *.c))) 
> -LOBJS= $(patsubst %.c,%.lo,$(filter-out $(SWIGCOUT),$(wildcard *.c)))
> +
> +DISABLE_AVC ?= n
> +DISABLE_BOOL ?= n
> +
> +ifeq ($(EMBEDDED),y)
> +	override DISABLE_AVC=y
> +	override DISABLE_BOOL=y
> +endif
> +
> +SRCS=$(filter-out $(SWIGCOUT),$(wildcard *.c))
> +ifeq ($(DISABLE_AVC),y)
> +	UNUSED_SRCS=avc.c avc_internal.c avc_sidtab.c
> +	SRCS= $(filter-out $(UNUSED_SRCS), $(filter-out $(SWIGCOUT),$(wildcard *.c)))
> +endif
> +ifeq ($(DISABLE_BOOL),y)
> +	UNUSED_SRCS+=booleans.c
> +
> +	SRCS= $(filter-out $(UNUSED_SRCS), $(filter-out $(SWIGCOUT),$(wildcard *.c)))
> +endif
> +
> +OBJS= $(patsubst %.c,%.o,$(SRCS))
> +LOBJS= $(patsubst %.c,%.lo,$(SRCS))
>  CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
>  override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
>  RANLIB=ranlib
> @@ -48,7 +68,7 @@
>  	$(CC) $(LDFLAGS) -shared -o $@ $< -L. -lselinux -L$(LIBDIR) -Wl,-soname,$@
>  
>  $(LIBSO): $(LOBJS)
> -	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -lsepol -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
> +	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
>  	ln -sf $@ $(TARGET) 
>  
>  %.o:  %.c policy.h
> Index: policyrep/libselinux/src/load_policy.c
> ===================================================================
> --- policyrep/libselinux/src/load_policy.c	(revision 2435)
> +++ policyrep/libselinux/src/load_policy.c	(working copy)
> @@ -12,6 +12,7 @@
>  #include "selinux_internal.h"
>  #include <sepol/sepol.h>
>  #include <sepol/policydb.h>
> +#include <dlfcn.h>
>  #include "policy.h"
>  #include <limits.h>
>  
> @@ -41,8 +42,8 @@
>  
>  int selinux_mkload_policy(void)
>  {
> -	int vers = sepol_policy_kern_vers_max();
>  	int kernvers = security_policyvers();
> +	int vers = kernvers, minvers = DEFAULT_POLICY_VERSION;
>  	char path[PATH_MAX];
>  	struct stat sb;
>  	size_t size;
> @@ -50,20 +51,80 @@
>  	int fd, rc = -1;
>  	sepol_policydb_t *policydb;
>  	sepol_policy_file_t *pf;
> +	int usesepol = 0;
> +	int (*vers_max)(void) = NULL;
> +	int (*vers_min)(void) = NULL;
> +	int (*policy_file_create)(sepol_policy_file_t **) = NULL;
> +	void (*policy_file_free)(sepol_policy_file_t *) = NULL;
> +	void (*policy_file_set_mem)(sepol_policy_file_t *, char*, size_t) = NULL;
> +	int (*policydb_create)(sepol_policydb_t **) = NULL;
> +	void (*policydb_free)(sepol_policydb_t *) = NULL;
> +	int (*policydb_read)(sepol_policydb_t *, sepol_policy_file_t *) = NULL;
> +	int (*policydb_set_vers)(sepol_policydb_t *, unsigned int) = NULL;
> +	int (*policydb_to_image)(sepol_handle_t *, sepol_policydb_t *, void **, size_t *) = NULL;
> +#ifdef SHARED
> +	char *errormsg = NULL;
> +	void *libsepolh = NULL;
> +	libsepolh = dlopen("libsepol.so", RTLD_NOW);
> +	if (libsepolh) {
> +		usesepol = 1;
> +		dlerror();
> +#define DLERR() if ((errormsg = dlerror())) goto dlclose;
> +		vers_max = dlsym(libsepolh, "sepol_policy_kern_vers_max");
> +		DLERR();
> +		vers_min = dlsym(libsepolh, "sepol_policy_kern_vers_min");
> +		DLERR();
>  
> +		policy_file_create = dlsym(libsepolh, "sepol_policy_file_create");
> +		DLERR();
> +		policy_file_free = dlsym(libsepolh, "sepol_policy_file_free");
> +		DLERR();
> +		policy_file_set_mem = dlsym(libsepolh, "sepol_policy_file_set_mem");
> +		DLERR();
> +		policydb_create = dlsym(libsepolh, "sepol_policydb_create");
> +		DLERR();
> +		policydb_free = dlsym(libsepolh, "sepol_policydb_free");
> +		DLERR();
> +		policydb_read = dlsym(libsepolh, "sepol_policydb_read");
> +		DLERR();
> +		policydb_set_vers = dlsym(libsepolh, "sepol_policydb_set_vers");
> +		DLERR();
> +		policydb_to_image = dlsym(libsepolh, "sepol_policydb_to_image");
> +		DLERR();
> +#undef DLERR
> +	}
> +#else
> +	usesepol = 1;
> +	vers_max = sepol_policy_kern_vers_max;
> +	vers_min = sepol_policy_kern_vers_min;
> +	policy_file_create = sepol_policy_file_create;
> +	policy_file_free = sepol_policy_file_free;
> +	policy_file_set_mem = sepol_policy_file_set_mem;
> +	policydb_create = sepol_policydb_create;
> +	policydb_free = sepol_policydb_free;
> +	policydb_read = sepol_policydb_read;
> +	policydb_set_vers = sepol_policydb_set_vers;
> +	policydb_to_image = sepol_policydb_to_image;
> +#endif
> +
> +	if (usesepol) {
> +		vers = vers_max();
> +		minvers = vers_min();
> +	}
> +
>        search:
>  	snprintf(path, sizeof(path), "%s.%d",
>  		 selinux_binary_policy_path(), vers);
>  	fd = open(path, O_RDONLY);
>  	while (fd < 0 && errno == ENOENT
> -	       && --vers >= sepol_policy_kern_vers_min()) {
> +	       && --vers >= minvers) {
>  		/* Check prior versions to see if old policy is available */
>  		snprintf(path, sizeof(path), "%s.%d",
>  			 selinux_binary_policy_path(), vers);
>  		fd = open(path, O_RDONLY);
>  	}
>  	if (fd < 0)
> -		return -1;
> +		goto dlclose;
>  
>  	if (fstat(fd, &sb) < 0)
>  		goto close;
> @@ -73,32 +134,32 @@
>  	if (map == MAP_FAILED)
>  		goto close;
>  
> -	if (vers > kernvers) {
> +	if (vers > kernvers && usesepol) {
>  		/* Need to downgrade to kernel-supported version. */
> -		if (sepol_policy_file_create(&pf))
> +		if (policy_file_create(&pf))
>  			goto unmap;
> -		if (sepol_policydb_create(&policydb)) {
> -			sepol_policy_file_free(pf);
> +		if (policydb_create(&policydb)) {
> +			policy_file_free(pf);
>  			goto unmap;
>  		}
> -		sepol_policy_file_set_mem(pf, data, size);
> -		if (sepol_policydb_read(policydb, pf)) {
> -			sepol_policy_file_free(pf);
> -			sepol_policydb_free(policydb);
> +		policy_file_set_mem(pf, data, size);
> +		if (policydb_read(policydb, pf)) {
> +			policy_file_free(pf);
> +			policydb_free(policydb);
>  			goto unmap;
>  		}
> -		if (sepol_policydb_set_vers(policydb, kernvers) ||
> -		    sepol_policydb_to_image(NULL, policydb, &data, &size)) {
> +		if (policydb_set_vers(policydb, kernvers) ||
> +		    policydb_to_image(NULL, policydb, &data, &size)) {
>  			/* Downgrade failed, keep searching. */
> -			sepol_policy_file_free(pf);
> -			sepol_policydb_free(policydb);
> +			policy_file_free(pf);
> +			policydb_free(policydb);
>  			munmap(map, sb.st_size);
>  			close(fd);
>  			vers--;
>  			goto search;
>  		}
> -		sepol_policy_file_free(pf);
> -		sepol_policydb_free(policydb);
> +		policy_file_free(pf);
> +		policydb_free(policydb);
>  	}
>  
>  	rc = security_load_policy(data, size);
> @@ -109,6 +170,13 @@
>  	munmap(map, sb.st_size);
>        close:
>  	close(fd);
> +      dlclose:
> +#ifdef SHARED
> +	if (errormsg)
> +		fprintf(stderr, "libsepol:  %s\n", errormsg);
> +	if (libsepolh)
> +		dlclose(libsepolh);
> +#endif
>  	return rc;
>  }
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
