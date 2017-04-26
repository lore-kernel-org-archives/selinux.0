Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3QIDrnL024520
 for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2017 14:13:54 -0400
Message-ID: <1493230416.17296.3.camel@trentalancia.net>
Subject: Re: [PATCH v3] libsemanage: remove lock files
From: Guido Trentalancia <guido@trentalancia.net>
To: selinux@tycho.nsa.gov
Date: Wed, 26 Apr 2017 20:13:36 +0200
In-Reply-To: <1493211369.32540.4.camel@tycho.nsa.gov>
References: <58517705.198270.1492699110308@pim.register.it>
 <100DD2AB-228E-47B5-8058-C9F030AEA665@trentalancia.net>
 <C6C00E69-C6B1-4408-B27A-C05D7B6B9D00@trentalancia.net>
 <201704251630.03844.russell@coker.com.au>
 <1493150773.12050.2.camel@trentalancia.net>
 <1493152517.17316.0.camel@trentalancia.net>
 <20170426120308.GA8528@meriadoc.perfinion.com>
 <1493211369.32540.4.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello.

On Wed, 26/04/2017 at 08.56 -0400, Stephen Smalley wrote:
> On Wed, 2017-04-26 at 20:03 +0800, Jason Zaman wrote:
> > On Tue, Apr 25, 2017 at 10:35:17PM +0200, Guido Trentalancia wrote:
> > > Do not use flock() for file locking, but instead use generic text
> > > files
> > > that keep track of the process ID (PID) of the locking process.
> > > 
> > > Remove semanage read and transaction lock files upon releasing
> > > them.
> > > 
> > > This third version fixes a bug in the previous version and also
> > > applies
> > > cleanly to the latest git tree.
> > > 
> > > Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
> > > ---
> > >  src/Makefile         |    2
> > >  src/semanage_store.c |  214
> > > +++++++++++++++++++++++++++++++++++++-
> > > -------------
> > >  2 files changed, 160 insertions(+), 56 deletions(-)
> > > 
> > > --- a/src/Makefile	2017-04-25 22:27:38.105555427 +0200
> > > +++ b/src/Makefile	2017-04-25 22:28:58.512555098 +0200
> > > @@ -91,7 +91,7 @@ $(LIBA): $(OBJS)
> > >  	$(RANLIB) $@
> > >  
> > >  $(LIBSO): $(LOBJS)
> > > -	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol
> > > -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-
> > > script=libsemanage.map,-z,defs
> > > +	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lm -lsepol
> > > -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-
> > > script=libsemanage.map,-z,defs
> > >  	ln -sf $@ $(TARGET)
> > >  
> > >  $(LIBPC): $(LIBPC).in ../VERSION
> > > --- a/src/semanage_store.c	2017-04-20 16:30:21.218209972
> > > +0200
> > > +++ b/src/semanage_store.c	2017-04-25 22:24:35.883556172
> > > +0200
> > > @@ -45,6 +45,8 @@ typedef struct dbase_policydb dbase_t;
> > >  #include <dirent.h>
> > >  #include <errno.h>
> > >  #include <fcntl.h>
> > > +#include <math.h>
> > > +#include <signal.h>
> > >  #include <stdio.h>
> > >  #include <stdio_ext.h>
> > >  #include <stdlib.h>
> > > @@ -52,11 +54,24 @@ typedef struct dbase_policydb dbase_t;
> > >  #include <unistd.h>
> > >  #include <sys/file.h>
> > >  #include <sys/stat.h>
> > > +#include <sys/sysctl.h>
> > >  #include <sys/types.h>
> > >  #include <sys/wait.h>
> > >  #include <limits.h>
> > >  #include <libgen.h>
> > >  
> > > +#include <linux/sysctl.h>
> > > +
> > > +#ifndef CONFIG_BASE_SMALL
> > > +#define CONFIG_BASE_SMALL       0
> > > +#endif
> > > +
> > > +#include <linux/threads.h>
> > > +
> > > +#ifndef PID_MAX_DEFAULT
> > > +#define PID_MAX_DEFAULT 32768
> > > +#endif
> > > +
> > >  #include "debug.h"
> > >  #include "utilities.h"
> > >  
> > > @@ -76,6 +91,8 @@ enum semanage_file_defs {
> > >  static char
> > > *semanage_paths[SEMANAGE_NUM_STORES][SEMANAGE_STORE_NUM_PATHS];
> > >  static char *semanage_files[SEMANAGE_NUM_FILES] = { NULL };
> > >  static int semanage_paths_initialized = 0;
> > > +static int pid_max;
> > > +static ssize_t pid_max_length;
> > >  
> > >  /* These are paths relative to the bottom of the module store */
> > >  static const char *semanage_relative_files[SEMANAGE_NUM_FILES] =
> > > {
> > > @@ -427,8 +442,23 @@ cleanup:
> > >  int semanage_check_init(semanage_handle_t *sh, const char
> > > *prefix)
> > >  {
> > >  	int rc;
> > > +	int fd;
> > > +	char root[PATH_MAX];
> > > +	ssize_t amount_read;
> > > +
> > >  	if (semanage_paths_initialized == 0) {
> > > -		char root[PATH_MAX];
> > > +		pid_max = PID_MAX_DEFAULT;
> > > +		pid_max_length = ceil(log10(PID_MAX_DEFAULT +
> > > 1));
> > > +
> > > +		fd = open("/proc/sys/kernel/pid_max", O_RDONLY);
> > > +		if (fd > 0) {
> > > +			char sysctlstring[pid_max_length];
> > > +			amount_read = read(fd, sysctlstring,
> > > pid_max_length);
> > > +			if (amount_read > 0) {
> > > +				pid_max = atoi(sysctlstring);
> > > +				pid_max_length =
> > > ceil(log10(pid_max + 1));
> > > +			}
> > > +		}
> > >  
> > >  		rc = snprintf(root,
> > >  			      sizeof(root),
> > > @@ -528,16 +558,23 @@ char *semanage_conf_path(void)
> > >  
> > >  /**************** functions that create module store
> > > ***************/
> > >  
> > > -/* Check that the semanage store exists.  If 'create' is non-
> > > zero
> > > then
> > > - * create the directories.  Returns 0 if module store exists
> > > (either
> > > - * already or just created), -1 if does not exist or could not
> > > be
> > > - * read, or -2 if it could not create the store. */
> > > +/* Check that the semanage store exists and that the read lock
> > > can
> > > be
> > > + * taken.  If 'create' is non-zero then it creates the
> > > directories
> > > + * and the lock file.  Returns 0 if the module store exists
> > > (either
> > > + * already or just created) and the read lock can be taken, -1
> > > if
> > > it
> > > + * does not exist or it is not possible to read from it, or -2
> > > if
> > > it
> > > + * could not create the store or it could not take the lock
> > > file.
> > > */
> > >  int semanage_create_store(semanage_handle_t * sh, int create)
> > >  {
> > >  	struct stat sb;
> > >  	int mode_mask = R_OK | W_OK | X_OK;
> > >  	const char *path = semanage_files[SEMANAGE_ROOT];
> > >  	int fd;
> > > +	pid_t pid, lock_pid;
> > > +	char *pid_string, *lock_pid_string;
> > > +	size_t pid_length;
> > > +	ssize_t pid_bytes;
> > > +	int invalid_lock = 0;
> > >  
> > >  	if (stat(path, &sb) == -1) {
> > >  		if (errno == ENOENT && create) {
> > > @@ -607,24 +644,81 @@ int semanage_create_store(semanage_handl
> > >  			return -1;
> > >  		}
> > >  	}
> > > +	pid = getpid();
> > > +	pid_string = malloc(pid_max_length * sizeof(char));
> > > +	sprintf(pid_string, "%d", pid);
> > > +	pid_length = strlen(pid_string);
> > >  	path = semanage_files[SEMANAGE_READ_LOCK];
> > >  	if (stat(path, &sb) == -1) {
> > >  		if (errno == ENOENT && create) {
> > >  			if ((fd = creat(path, S_IRUSR |
> > > S_IWUSR))
> > > == -1) {
> > >  				ERR(sh, "Could not create lock
> > > file at %s.",
> > >  				    path);
> > > +				free(pid_string);
> > >  				return -2;
> > >  			}
> > > +			pid_bytes = write(fd, pid_string,
> > > pid_length);
> > 
> > I'm pretty sure there is a race here. and another one between
> > stat()
> > and
> > creat(). you can have two processes create and truncate the file
> > then
> > one write on top of the other. leaving lock files around is
> > definitely
> > the safest option. and are 0 bytes so its not like you're wasting
> > any
> > disk space.
> > 
> > Overall I disagree with changing this just because a random file is
> > left
> > around. NFS may be a legit reason to change but as russel said, I
> > think
> > locks work somewhat over NFS too. Also, NFS mounting /home or /usr
> > is
> > common but /var is pretty commonly not NFS mounted.
> 
> I agree; absent a demonstration of an actual problem with the current
> libsemanage locking scheme, let's leave it alone.  Keeping around two
> empty files is not a problem and this is a fairly well-established
> paradigm for locking on Linux.  flock(2) works over NFS since Linux
> 2.6.12.

If I am not wrong, I found the information on the following web page:

https://linux.die.net/man/2/flock

It looks like a manual page, but I don't know if that information is
obsolete or not (there's no date, that's the bad side of some of the
web).

There are other reports online, I have not tested so I cannot tell.

As for the problem pointed out by Jason, I have improved it by removing
the code that leads to the other race condition: if you need a revised
version (v4) of the patch, please let me know, otherwise I take there
isn't enough interest in the change or the information is
wrong/outdated.

Regards,

Guido
