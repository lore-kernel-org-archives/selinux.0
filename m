Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7D3UBxA032581
	for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 23:30:11 -0400
Received: from mail-yx0-f177.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7D3VFtt019848
	for <selinux@tycho.nsa.gov>; Thu, 13 Aug 2009 03:31:15 GMT
Received: by yxe7 with SMTP id 7so639445yxe.32
        for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 20:30:10 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 12 Aug 2009 20:30:10 -0700
Message-ID: <dd18b0c30908122030l3e950054r1f3907a6dcde8db0@mail.gmail.com>
Subject: error: too many arguments to function 'security_getenforce'
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
I've spent the past few days trying to
find a correct patch for sysvinit-2.86 to load
the policy. but seems to keep hitting errors.

I've made it as far as this:
gcc -c -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE -DWITH_SELINUX  init.c
init.c: In function 'load_policy':
init.c:107:3: error: too many arguments to function 'security_getenforce'
init.c:120:0: warning: "MNT_DETACH" redefined
/usr/include/sys/mount.h:102:0: note: this is the location of the
previous definition
init.c:130:7: warning: too many arguments for format
init.c:206:3: warning: passing argument 3 of 'sepol_genbools' discards
qualifiers from pointer target type
/usr/include/sepol/booleans.h:16:12: note: expected 'char *' but
argument is of type 'const char *'
init.c: In function 're_exec':
init.c:2040:2: warning: missing sentinel in function call
make: *** [init.o] Error 1
make: Leaving directory `/home/justin/LFS/sysv/sysvinit-2.86/src'

seems this is the only error showing up if I use the -i option
from make.

the patch looks like this:
(only init.c/Makefile for now until I can get this
correct)

starting at line 83

		} while(0)

#ifdef WITH_SELINUX
#include <sys/mman.h>
#include <selinux/selinux.h>
#include <sepol/sepol.h>
#include <sys/mount.h>

/* Mount point for selinuxfs. */
#define SELINUXMNT "/selinux/"
int enforcing = -1;            /* SELinux enforcing mode */


static int load_policy(int *enforce)
{
  int fd=-1,ret=-1;
  int rc=0, orig_enforce;
  struct stat sb;
  void *map;
  char policy_file[PATH_MAX];
  int policy_version=0;
  extern char *selinux_mnt;
  FILE *cfg;
  char buf[4096];
  int seconfig = -2;

  security_getenforce(&seconfig);

  mount("none", "/proc", "proc", 0, 0);
 cfg = fopen("/proc/cmdline","r");
  if (cfg) {
    char *tmp;
    if (fgets(buf,4096,cfg) && (tmp = strstr(buf,"enforcing="))) {
      if (tmp == buf || isspace(*(tmp-1))) {
        enforcing=atoi(tmp+10);
      }
    }
    fclose(cfg);
  }
#define MNT_DETACH 2
  umount2("/proc",MNT_DETACH);

  if (enforcing >=0)
    *enforce = enforcing;
  else if (seconfig == 1)
    *enforce = 1;

  if (mount("none", SELINUXMNT, "selinuxfs", 0, 0) < 0) {
    if (errno == ENODEV) {
      printf("SELinux not supported by kernel:
%s\n",SELINUXMNT,strerror(errno));
      *enforce = 0;
    } else {
      printf("Failed to mount %s: %s\n",SELINUXMNT,strerror(errno));
    }
    return ret;
  }

  selinux_mnt = SELINUXMNT; /* set manually since we mounted it */

  policy_version=security_policyvers();
  if (policy_version < 0) {
    printf( "Can't get policy version: %s\n", strerror(errno));
    goto UMOUNT;
  }

  orig_enforce = rc = security_getenforce();
  if (rc < 0) {
    printf( "Can't get SELinux enforcement flag: %s\n", strerror(errno));
    goto UMOUNT;
  }
  if (enforcing >= 0) {
    *enforce = enforcing;
  } else if (seconfig == -1) {
    *enforce = 0;
    rc = security_disable();
    if (rc == 0) umount(SELINUXMNT);
   if (rc < 0) {
     rc = security_setenforce(0);
     if (rc < 0) {
       printf("Can't disable SELinux: %s\n", strerror(errno));
       goto UMOUNT;
      }
    }
    ret = 0;
    goto UMOUNT;
  } else if (seconfig >= 0) {
    *enforce = seconfig;
    if (orig_enforce != *enforce) {
      rc = security_setenforce(seconfig);
      if (rc < 0) {
        printf("Can't set SELinux enforcement flag: %s\n", strerror(errno));
        goto UMOUNT;
      }
   }
  }

  snprintf(policy_file,sizeof(policy_file),"%s.%d",selinux_binary_policy_path(),policy_version);
  fd = open(policy_file, O_RDONLY);
  if (fd < 0) {
    /* Check previous version to see if old policy is available
     */
    snprintf(policy_file,sizeof(policy_file),"%s.%d",selinux_binary_policy_path(),policy_version-1);
    fd = open(policy_file, O_RDONLY);
    if (fd < 0) {
      printf( "Can't open '%s.%d':  %s\n",
          selinux_binary_policy_path(),policy_version,strerror(errno));
      goto UMOUNT;
    }
  }

  if (fstat(fd, &sb) < 0) {
  printf("Can't stat '%s':  %s\n",
        policy_file, strerror(errno));
   goto UMOUNT;
 }

  map = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
  if (map == MAP_FAILED) {
    printf( "Can't map '%s':  %s\n",
       policy_file, strerror(errno));
    goto UMOUNT;
  }


  /* Set booleans based on a booleans configuration file. */
  ret = sepol_genbools(map, sb.st_size, selinux_booleans_path());
  if (ret < 0) {
    if (errno == ENOENT || errno == EINVAL) {
      /* No booleans file or stale booleans in the file; non-fatal. */
      printf("Warning!  Error while setting booleans:  %s\n"
          , strerror(errno));
    } else {
      printf("Error while setting booleans:  %s\n",
          strerror(errno));
      goto UMOUNT;
    }
 }
  printf("Loading security policy\n");
  ret=security_load_policy(map, sb.st_size);
  if (ret < 0) {
    printf("security_load_policy failed\n");
  }

 UMOUNT:
  /*umount(SELINUXMNT); */
  if ( fd >= 0) {
    close(fd);
 }
  return(ret);
}
#endif

/* Version information */


line 2818
#ifdef WITH_SELINUX
       if (getenv("SELINUX_INIT") == NULL) {
         putenv("SELINUX_INIT=YES");
         if (load_policy(&enforcing) == 0 ) {
           execv(myname, argv);
         } else {
           if (enforcing > 0) {
             /* SELinux in enforcing mode but load_policy failed */
             /* At this point, we probably can't open /dev/console, so
log() won't work */
                   fprintf(stderr,"Enforcing mode requested but no
policy loaded. Halting now.\n");
             exit(1);
           }
         }
       }
#endif



and the Makefile has these in it:

line 12
CFLAGS	= -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE -DWITH_SELINUX

line 52

ifeq ($(WITH_SELINUX),yes)
  SELINUX_DEF=-DWITH_SELINUX
  INIT_SELIBS=-lsepol -lselinux
  SULOGIN_SELIBS=-lselinux
else
  SELINUX_DEF=
  INIT_SELIBS=
  SULOGIN_SELIBS=
endif


line 71
init:		init.o init_utmp.o
		$(CC) $(LDFLAGS) $(STATIC) -o $@ init.o init_utmp.o $(INIT_SELIBS)

line 103
init.o:		init.c init.h set.h reboot.h initreq.h
		$(CC) -c $(CFLAGS) $(SELINUX_DEF) init.c


Seems I found a patch from 2003 that
did load the policy but segfaulted after that.

should I even bother with this since there are
newer approaches?


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
