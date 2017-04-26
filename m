Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3QC3FVI006966
 for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2017 08:03:15 -0400
Received: by mail-pf0-f196.google.com with SMTP id c198so16510530pfc.0
 for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2017 05:03:13 -0700 (PDT)
Date: Wed, 26 Apr 2017 20:03:08 +0800
From: Jason Zaman <jason@perfinion.com>
To: Guido Trentalancia <guido@trentalancia.net>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH v3] libsemanage: remove lock files
Message-ID: <20170426120308.GA8528@meriadoc.perfinion.com>
References: <58517705.198270.1492699110308@pim.register.it>
 <100DD2AB-228E-47B5-8058-C9F030AEA665@trentalancia.net>
 <C6C00E69-C6B1-4408-B27A-C05D7B6B9D00@trentalancia.net>
 <201704251630.03844.russell@coker.com.au>
 <1493150773.12050.2.camel@trentalancia.net>
 <1493152517.17316.0.camel@trentalancia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493152517.17316.0.camel@trentalancia.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Apr 25, 2017 at 10:35:17PM +0200, Guido Trentalancia wrote:
> Do not use flock() for file locking, but instead use generic text files
> that keep track of the process ID (PID) of the locking process.
> 
> Remove semanage read and transaction lock files upon releasing
> them.
> 
> This third version fixes a bug in the previous version and also applies
> cleanly to the latest git tree.
> 
> Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
> ---
>  src/Makefile         |    2
>  src/semanage_store.c |  214 +++++++++++++++++++++++++++++++++++++--------------
>  2 files changed, 160 insertions(+), 56 deletions(-)
> 
> --- a/src/Makefile	2017-04-25 22:27:38.105555427 +0200
> +++ b/src/Makefile	2017-04-25 22:28:58.512555098 +0200
> @@ -91,7 +91,7 @@ $(LIBA): $(OBJS)
>  	$(RANLIB) $@
>  
>  $(LIBSO): $(LOBJS)
> -	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
> +	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lm -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
>  	ln -sf $@ $(TARGET)
>  
>  $(LIBPC): $(LIBPC).in ../VERSION
> --- a/src/semanage_store.c	2017-04-20 16:30:21.218209972 +0200
> +++ b/src/semanage_store.c	2017-04-25 22:24:35.883556172 +0200
> @@ -45,6 +45,8 @@ typedef struct dbase_policydb dbase_t;
>  #include <dirent.h>
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <math.h>
> +#include <signal.h>
>  #include <stdio.h>
>  #include <stdio_ext.h>
>  #include <stdlib.h>
> @@ -52,11 +54,24 @@ typedef struct dbase_policydb dbase_t;
>  #include <unistd.h>
>  #include <sys/file.h>
>  #include <sys/stat.h>
> +#include <sys/sysctl.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
>  #include <limits.h>
>  #include <libgen.h>
>  
> +#include <linux/sysctl.h>
> +
> +#ifndef CONFIG_BASE_SMALL
> +#define CONFIG_BASE_SMALL       0
> +#endif
> +
> +#include <linux/threads.h>
> +
> +#ifndef PID_MAX_DEFAULT
> +#define PID_MAX_DEFAULT 32768
> +#endif
> +
>  #include "debug.h"
>  #include "utilities.h"
>  
> @@ -76,6 +91,8 @@ enum semanage_file_defs {
>  static char *semanage_paths[SEMANAGE_NUM_STORES][SEMANAGE_STORE_NUM_PATHS];
>  static char *semanage_files[SEMANAGE_NUM_FILES] = { NULL };
>  static int semanage_paths_initialized = 0;
> +static int pid_max;
> +static ssize_t pid_max_length;
>  
>  /* These are paths relative to the bottom of the module store */
>  static const char *semanage_relative_files[SEMANAGE_NUM_FILES] = {
> @@ -427,8 +442,23 @@ cleanup:
>  int semanage_check_init(semanage_handle_t *sh, const char *prefix)
>  {
>  	int rc;
> +	int fd;
> +	char root[PATH_MAX];
> +	ssize_t amount_read;
> +
>  	if (semanage_paths_initialized == 0) {
> -		char root[PATH_MAX];
> +		pid_max = PID_MAX_DEFAULT;
> +		pid_max_length = ceil(log10(PID_MAX_DEFAULT + 1));
> +
> +		fd = open("/proc/sys/kernel/pid_max", O_RDONLY);
> +		if (fd > 0) {
> +			char sysctlstring[pid_max_length];
> +			amount_read = read(fd, sysctlstring, pid_max_length);
> +			if (amount_read > 0) {
> +				pid_max = atoi(sysctlstring);
> +				pid_max_length = ceil(log10(pid_max + 1));
> +			}
> +		}
>  
>  		rc = snprintf(root,
>  			      sizeof(root),
> @@ -528,16 +558,23 @@ char *semanage_conf_path(void)
>  
>  /**************** functions that create module store ***************/
>  
> -/* Check that the semanage store exists.  If 'create' is non-zero then
> - * create the directories.  Returns 0 if module store exists (either
> - * already or just created), -1 if does not exist or could not be
> - * read, or -2 if it could not create the store. */
> +/* Check that the semanage store exists and that the read lock can be
> + * taken.  If 'create' is non-zero then it creates the directories
> + * and the lock file.  Returns 0 if the module store exists (either
> + * already or just created) and the read lock can be taken, -1 if it
> + * does not exist or it is not possible to read from it, or -2 if it
> + * could not create the store or it could not take the lock file. */
>  int semanage_create_store(semanage_handle_t * sh, int create)
>  {
>  	struct stat sb;
>  	int mode_mask = R_OK | W_OK | X_OK;
>  	const char *path = semanage_files[SEMANAGE_ROOT];
>  	int fd;
> +	pid_t pid, lock_pid;
> +	char *pid_string, *lock_pid_string;
> +	size_t pid_length;
> +	ssize_t pid_bytes;
> +	int invalid_lock = 0;
>  
>  	if (stat(path, &sb) == -1) {
>  		if (errno == ENOENT && create) {
> @@ -607,24 +644,81 @@ int semanage_create_store(semanage_handl
>  			return -1;
>  		}
>  	}
> +	pid = getpid();
> +	pid_string = malloc(pid_max_length * sizeof(char));
> +	sprintf(pid_string, "%d", pid);
> +	pid_length = strlen(pid_string);
>  	path = semanage_files[SEMANAGE_READ_LOCK];
>  	if (stat(path, &sb) == -1) {
>  		if (errno == ENOENT && create) {
>  			if ((fd = creat(path, S_IRUSR | S_IWUSR)) == -1) {
>  				ERR(sh, "Could not create lock file at %s.",
>  				    path);
> +				free(pid_string);
>  				return -2;
>  			}
> +			pid_bytes = write(fd, pid_string, pid_length);

I'm pretty sure there is a race here. and another one between stat() and
creat(). you can have two processes create and truncate the file then
one write on top of the other. leaving lock files around is definitely
the safest option. and are 0 bytes so its not like you're wasting any
disk space.

Overall I disagree with changing this just because a random file is left
around. NFS may be a legit reason to change but as russel said, I think
locks work somewhat over NFS too. Also, NFS mounting /home or /usr is
common but /var is pretty commonly not NFS mounted.

-- Jason

>  			close(fd);
> +			free(pid_string);
> +			if (pid_bytes == (ssize_t) pid_length)
> +				return 0;
> +			else {
> +				ERR(sh, "Could not create lock file at %s.", path);
> +				return -2;
> +			}
>  		} else {
>  			ERR(sh, "Could not read lock file at %s.", path);
> +			free(pid_string);
>  			return -1;
>  		}
>  	} else {
>  		if (!S_ISREG(sb.st_mode) || access(path, R_OK | W_OK) == -1) {
>  			ERR(sh, "Could not access lock file at %s.", path);
> +			free(pid_string);
>  			return -1;
> -		}
> +		} else {
> +			fd = open(path, O_RDWR);
> +			if (fd > 0) {
> +				lock_pid_string = malloc(pid_max_length * sizeof(char));
> +				pid_bytes = read(fd, lock_pid_string, pid_max_length);
> +				if (pid_bytes > 0) {
> +					lock_pid = (pid_t) atoi(lock_pid_string);
> +					if (lock_pid > pid_max)
> +						invalid_lock = 1;
> +					else if (kill(lock_pid, 0) != 0)
> +						if (errno == ESRCH)
> +							invalid_lock = 1;
> +
> +					if (!invalid_lock) {
> +						ERR(sh, "Could not create lock file at %s.", path);
> +						close(fd);
> +						free(pid_string);
> +						free(lock_pid_string);
> +						return -2;
> +					}
> +				} else
> +					invalid_lock = 1;
> +
> +				if (invalid_lock) {
> +					pid_bytes = pwrite(fd, pid_string, pid_length, 0);
> +					close(fd);
> +					free(pid_string);
> +					free(lock_pid_string);
> +					if (pid_bytes == (ssize_t) pid_length)
> +						return 0;
> +					else {
> +						ERR(sh, "Could not create lock file at %s.", path);
> +						return -2;
> +					}
> +				} else {
> +					ERR(sh, "Could not create lock file at %s.", path);
> +					close(fd);
> +					free(pid_string);
> +					free(lock_pid_string);
> +					return -2;
> +				}
> +			}
> +		}	
>  	}
>  	return 0;
>  }
> @@ -1795,64 +1884,74 @@ int semanage_install_sandbox(semanage_ha
>  static int semanage_get_lock(semanage_handle_t * sh,
>  			     const char *lock_name, const char *lock_file)
>  {
> +	pid_t pid, lock_pid;
> +	char *pid_string, *lock_pid_string;
>  	int fd;
> -	struct timeval origtime, curtime;
> +	size_t pid_length;
> +	ssize_t pid_bytes;
>  	int got_lock = 0;
> +	int overwritten_lock = 0;
>  
> -	if ((fd = open(lock_file, O_RDONLY)) == -1) {
> -		if ((fd =
> -		     open(lock_file, O_RDWR | O_CREAT | O_TRUNC,
> -			  S_IRUSR | S_IWUSR)) == -1) {
> +	pid = getpid();
> +	pid_string = malloc(pid_max_length * sizeof(char));
> +	sprintf(pid_string, "%d", pid);
> +	pid_length = strlen(pid_string);
> +	if ((fd = open(lock_file, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR)) == -1) {
>  			ERR(sh, "Could not open direct %s at %s.", lock_name,
>  			    lock_file);
> +			free(pid_string);
>  			return -1;
> +	} else {
> +		lock_pid_string = malloc(pid_max_length * sizeof(char));
> +		pid_bytes = pread(fd, lock_pid_string, pid_max_length, 0);
> +		if (pid_bytes == 0) {
> +			overwritten_lock = 1;
> +			pid_bytes = write(fd, pid_string, pid_length);
> +			if (pid_bytes == (ssize_t) pid_length)
> +				got_lock = 1;
> +		} else {
> +			lock_pid = (pid_t) atoi(lock_pid_string);
> +			if (lock_pid > pid_max) {
> +				overwritten_lock = 1;
> +				pid_bytes = pwrite(fd, pid_string, pid_length, 0);
> +				if (pid_bytes == (ssize_t) pid_length)
> +					got_lock = 1;
> +			} else {
> +				if (lock_pid == pid)
> +				       got_lock = 1;
> +				else if (kill(lock_pid, 0) != 0)
> +					if (errno == ESRCH) {
> +						overwritten_lock = 1;
> +						pid_bytes = pwrite(fd, pid_string, pid_length, 0);
> +						if (pid_bytes == (ssize_t) pid_length)
> +							got_lock = 1;
> +					}
> +			}
>  		}
>  	}
> -	if (fcntl(fd, F_SETFD, FD_CLOEXEC) < 0) {
> -		ERR(sh, "Could not set close-on-exec for %s at %s.", lock_name,
> -		    lock_file);
> +
> +	if (!got_lock) {
>  		close(fd);
> +		free(pid_string);
> +		free(lock_pid_string);
> +		if (overwritten_lock)
> +			unlink(lock_file);
> +		ERR(sh, "Could not get direct %s at %s.", lock_name, lock_file);
>  		return -1;
>  	}
>  
> -	if (sh->timeout == 0) {
> -		/* return immediately */
> -		origtime.tv_sec = 0;
> -	} else {
> -		origtime.tv_sec = sh->timeout;
> -	}
> -	origtime.tv_usec = 0;
> -	do {
> -		curtime.tv_sec = 1;
> -		curtime.tv_usec = 0;
> -		if (flock(fd, LOCK_EX | LOCK_NB) == 0) {
> -			got_lock = 1;
> -			break;
> -		} else if (errno != EAGAIN) {
> -			ERR(sh, "Error obtaining direct %s at %s.", lock_name,
> -			    lock_file);
> -			close(fd);
> -			return -1;
> -		}
> -		if (origtime.tv_sec > 0 || sh->timeout == -1) {
> -			if (select(0, NULL, NULL, NULL, &curtime) == -1) {
> -				if (errno == EINTR) {
> -					continue;
> -				}
> -				ERR(sh,
> -				    "Error while waiting to get direct %s at %s.",
> -				    lock_name, lock_file);
> -				close(fd);
> -				return -1;
> -			}
> -			origtime.tv_sec--;
> -		}
> -	} while (origtime.tv_sec > 0 || sh->timeout == -1);
> -	if (!got_lock) {
> -		ERR(sh, "Could not get direct %s at %s.", lock_name, lock_file);
> +	if (fcntl(fd, F_SETFD, FD_CLOEXEC) < 0) {
> +		ERR(sh, "Could not set close-on-exec for %s at %s.", lock_name,
> +		    lock_file);
>  		close(fd);
> +		free(pid_string);
> +		free(lock_pid_string);
> +		unlink(lock_file);
>  		return -1;
>  	}
> +
> +	free(pid_string);
> +	free(lock_pid_string);
>  	return fd;
>  }
>  
> @@ -1901,29 +2000,27 @@ int semanage_get_active_lock(semanage_ha
>  	}
>  }
>  
> -/* Releases the transaction lock.  Does nothing if there was not one already
> - * there. */
> +/* Releases the transaction lock: the lock file is removed */
>  void semanage_release_trans_lock(semanage_handle_t * sh)
>  {
>  	int errsv = errno;
>  	if (sh->u.direct.translock_file_fd >= 0) {
> -		flock(sh->u.direct.translock_file_fd, LOCK_UN);
>  		close(sh->u.direct.translock_file_fd);
>  		sh->u.direct.translock_file_fd = -1;
>  	}
> +	unlink(semanage_files[SEMANAGE_TRANS_LOCK]);
>  	errno = errsv;
>  }
>  
> -/* Releases the read lock.  Does nothing if there was not one already
> - * there. */
> +/* Releases the read lock: the lock file is removed */
>  void semanage_release_active_lock(semanage_handle_t * sh)
>  {
>  	int errsv = errno;
>  	if (sh->u.direct.activelock_file_fd >= 0) {
> -		flock(sh->u.direct.activelock_file_fd, LOCK_UN);
>  		close(sh->u.direct.activelock_file_fd);
>  		sh->u.direct.activelock_file_fd = -1;
>  	}
> +	unlink(semanage_files[SEMANAGE_READ_LOCK]);
>  	errno = errsv;
>  }
>  
