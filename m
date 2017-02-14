Message-ID: <1487103470.29417.21.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: Perform access check using euid instead of
 uid
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Date: Tue, 14 Feb 2017 15:17:50 -0500
In-Reply-To: <1487085930.29417.9.camel@tycho.nsa.gov>
References: <20170214131448.22837-1-vmojzis@redhat.com>
 <1487085107.29417.4.camel@tycho.nsa.gov>
 <1487085930.29417.9.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-02-14 at 10:25 -0500, Stephen Smalley wrote:
> On Tue, 2017-02-14 at 10:11 -0500, Stephen Smalley wrote:
> > 
> > On Tue, 2017-02-14 at 14:14 +0100, Vit Mojzis wrote:
> > > 
> > > 
> > > Use faccessat() with AT_EACCESS instead of accesss() in order to
> > > check
> > > permissions of effective user. access() calls checking existence
> > > of
> > > a file (F_OK) were left untouched since they work correctly.
> > > 
> > > This enables setuid programs to use libsemanage.
> > 
> > Not sure we want setuid programs using libsemanage.  Is there a use
> > case for that?  I wouldn't warrant it to be safe.
> > 
> > AT_EACCESS is not implemented by the kernel, so this seems to rely
> > on
> > some libc magic to support?  Is that done in a safe way?
> 
> Per the man page glibc notes, AT_EACCESS is implemented by the glibc
> wrapper function by using fstatat(2) and emulating the permission
> check
> in userspace.  This however is not equivalent to access(2), since the
> latter will perform SELinux checks too.  It is also seemingly glibc-
> specific and thus non-portable.

Looked at the glibc implementation and it seems very broken; it
hardcodes legacy Unix permission checking without consideration of
Linux capabilities, POSIX ACLs, or anything else including SELinux
permissions.  Someone really ought to consider removing that.

musl implementation is perhaps more reliable but has to use a complex
workaround (clones a child that call setuid(), setgid() and then
faccessat() under the new uid/gid and reports the status to the parent
via a pipe).

> 
> > 
> > 
> > libsemanage usage of access() is not for security purposes; it is
> > just
> > to test for existence/location of various files and to confirm that
> > the
> > policy store is writable by the caller before beginning any real
> > work.
> >  So arguments about access() being insecure are not relevant here.
> > 
> > > 
> > > 
> > > 
> > > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431
> > > 
> > > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> > > ---
> > >  libsemanage/src/conf-parse.y     |  7 ++++---
> > >  libsemanage/src/semanage_store.c | 18 +++++++++---------
> > >  2 files changed, 13 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-
> > > parse.y
> > > index b527e89..d72a0c2 100644
> > > --- a/libsemanage/src/conf-parse.y
> > > +++ b/libsemanage/src/conf-parse.y
> > > @@ -30,6 +30,7 @@
> > >  #include <stdio.h>
> > >  #include <stdlib.h>
> > >  #include <string.h>
> > > +#include <fcntl.h>
> > >  
> > >  extern int semanage_lex(void);                /* defined in
> > > conf-
> > > scan.c */
> > >  extern int semanage_lex_destroy(void);        /* defined in
> > > conf-
> > > scan.c */
> > > @@ -361,7 +362,7 @@ static int semanage_conf_init(semanage_conf_t
> > > *
> > > conf)
> > >  		return -1;
> > >  	}
> > >  
> > > -	if (access("/sbin/load_policy", X_OK) == 0) {
> > > +	if (faccessat(AT_FDCWD, "/sbin/load_policy", X_OK,
> > > AT_EACCESS) == 0) {
> > >  		conf->load_policy->path =
> > > strdup("/sbin/load_policy");
> > >  	} else {
> > >  		conf->load_policy->path =
> > > strdup("/usr/sbin/load_policy");
> > > @@ -375,7 +376,7 @@ static int semanage_conf_init(semanage_conf_t
> > > *
> > > conf)
> > >  	     calloc(1, sizeof(*(current_conf->setfiles)))) ==
> > > NULL)
> > > {
> > >  		return -1;
> > >  	}
> > > -	if (access("/sbin/setfiles", X_OK) == 0) {
> > > +	if (faccessat(AT_FDCWD, "/sbin/setfiles", X_OK,
> > > AT_EACCESS)
> > > == 0) {
> > >  		conf->setfiles->path = strdup("/sbin/setfiles");
> > >  	} else {
> > >  		conf->setfiles->path =
> > > strdup("/usr/sbin/setfiles");
> > > @@ -389,7 +390,7 @@ static int semanage_conf_init(semanage_conf_t
> > > *
> > > conf)
> > >  	     calloc(1, sizeof(*(current_conf-
> > > > 
> > > > sefcontext_compile)))) 
> > > == NULL) {
> > >  		return -1;
> > >  	}
> > > -	if (access("/sbin/sefcontext_compile", X_OK) == 0) {
> > > +	if (faccessat(AT_FDCWD, "/sbin/sefcontext_compile",
> > > X_OK,
> > > AT_EACCESS) == 0) {
> > >  		conf->sefcontext_compile->path =
> > > strdup("/sbin/sefcontext_compile");
> > >  	} else {
> > >  		conf->sefcontext_compile->path =
> > > strdup("/usr/sbin/sefcontext_compile");
> > > diff --git a/libsemanage/src/semanage_store.c
> > > b/libsemanage/src/semanage_store.c
> > > index f468fab..805bd60 100644
> > > --- a/libsemanage/src/semanage_store.c
> > > +++ b/libsemanage/src/semanage_store.c
> > > @@ -517,7 +517,7 @@ char *semanage_conf_path(void)
> > >  	snprintf(semanage_conf, len + 1, "%s%s%s",
> > > semanage_root(),
> > > selinux_path(),
> > >  		 SEMANAGE_CONF_FILE);
> > >  
> > > -	if (access(semanage_conf, R_OK) != 0) {
> > > +	if (faccessat(AT_FDCWD, semanage_conf, R_OK, AT_EACCESS)
> > > !=
> > > 0) {
> > >  		snprintf(semanage_conf, len + 1, "%s%s",
> > > selinux_path(), SEMANAGE_CONF_FILE);
> > >  	}
> > >  
> > > @@ -552,7 +552,7 @@ int semanage_create_store(semanage_handle_t *
> > > sh,
> > > int create)
> > >  			return -1;
> > >  		}
> > >  	} else {
> > > -		if (!S_ISDIR(sb.st_mode) || access(path,
> > > mode_mask)
> > > == -1) {
> > > +		if (!S_ISDIR(sb.st_mode) || faccessat(AT_FDCWD,
> > > path, mode_mask, AT_EACCESS) == -1) {
> > >  			ERR(sh,
> > >  			    "Could not access module store at
> > > %s,
> > > or
> > > it is not a directory.",
> > >  			    path);
> > > @@ -575,7 +575,7 @@ int semanage_create_store(semanage_handle_t *
> > > sh,
> > > int create)
> > >  			return -1;
> > >  		}
> > >  	} else {
> > > -		if (!S_ISDIR(sb.st_mode) || access(path,
> > > mode_mask)
> > > == -1) {
> > > +		if (!S_ISDIR(sb.st_mode) || faccessat(AT_FDCWD,
> > > path, mode_mask, AT_EACCESS) == -1) {
> > >  			ERR(sh,
> > >  			    "Could not access module store
> > > active
> > > subdirectory at %s, or it is not a directory.",
> > >  			    path);
> > > @@ -598,7 +598,7 @@ int semanage_create_store(semanage_handle_t *
> > > sh,
> > > int create)
> > >  			return -1;
> > >  		}
> > >  	} else {
> > > -		if (!S_ISDIR(sb.st_mode) || access(path,
> > > mode_mask)
> > > == -1) {
> > > +		if (!S_ISDIR(sb.st_mode) || faccessat(AT_FDCWD,
> > > path, mode_mask, AT_EACCESS) == -1) {
> > >  			ERR(sh,
> > >  			    "Could not access module store
> > > active
> > > modules subdirectory at %s, or it is not a directory.",
> > >  			    path);
> > > @@ -619,7 +619,7 @@ int semanage_create_store(semanage_handle_t *
> > > sh,
> > > int create)
> > >  			return -1;
> > >  		}
> > >  	} else {
> > > -		if (!S_ISREG(sb.st_mode) || access(path, R_OK |
> > > W_OK) == -1) {
> > > +		if (!S_ISREG(sb.st_mode) || faccessat(AT_FDCWD,
> > > path, R_OK | W_OK, AT_EACCESS) == -1) {
> > >  			ERR(sh, "Could not access lock file at
> > > %s.",
> > > path);
> > >  			return -1;
> > >  		}
> > > @@ -639,7 +639,7 @@ int semanage_store_access_check(void)
> > >  
> > >  	/* read access on active store */
> > >  	path = semanage_path(SEMANAGE_ACTIVE,
> > > SEMANAGE_TOPLEVEL);
> > > -	if (access(path, R_OK | X_OK) != 0)
> > > +	if (faccessat(AT_FDCWD, path, R_OK | X_OK, AT_EACCESS)
> > > !=
> > > 0)
> > >  		goto out;
> > >  
> > >  	/* we can read the active store meaning it is managed
> > > @@ -650,13 +650,13 @@ int semanage_store_access_check(void)
> > >  	 * write access necessary if the lock file does not
> > > exist
> > >  	 */
> > >  	path = semanage_files[SEMANAGE_READ_LOCK];
> > > -	if (access(path, R_OK) != 0) {
> > > +	if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS) != 0) {
> > >  		if (access(path, F_OK) == 0) {
> > >  			goto out;
> > >  		}
> > >  
> > >  		path = semanage_files[SEMANAGE_ROOT];
> > > -		if (access(path, R_OK | W_OK | X_OK) != 0) {
> > > +		if (faccessat(AT_FDCWD, path, R_OK | W_OK |
> > > X_OK,
> > > AT_EACCESS) != 0) {
> > >  			goto out;
> > >  		}
> > >  	}
> > > @@ -666,7 +666,7 @@ int semanage_store_access_check(void)
> > >  
> > >  	/* check the modules directory */
> > >  	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
> > > -	if (access(path, R_OK | W_OK | X_OK) != 0)
> > > +	if (faccessat(AT_FDCWD, path, R_OK | W_OK | X_OK,
> > > AT_EACCESS) != 0)
> > >  		goto out;
> > >  
> > >  	rc = SEMANAGE_CAN_WRITE;
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tyc
> > ho
> > .nsa.gov.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho
> .nsa.gov.
