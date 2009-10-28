Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9SK7eQo019525
	for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2009 16:07:40 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n9SK9Vpo021141
	for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2009 20:09:31 GMT
Date: Wed, 28 Oct 2009 16:07:36 -0400
Subject: Re: [PATCH 2/2] policAycoreutils: share setfiles restore function
 with restorecond
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>,
        Joshua Brindle <method@manicmethod.com>
CC: <selinux@tycho.nsa.gov>
Message-ID: <C70E1CC8.AB9AB%csellers@tresys.com>
In-Reply-To: <4A8D8BBD.80600@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/20/09 1:45 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> On 08/20/2009 10:15 AM, Joshua Brindle wrote:
>> Daniel J Walsh wrote:
>>> On 08/19/2009 05:01 PM, Joshua Brindle wrote:
>>>> Thomas Liu wrote:
>>>>> This patch edits restorecond to use the shared restore
>>>>> 
>>>>> functions split out from the first patch in this series.
>>>>> 
>>>> Is the DBus stuff in here suppose to be here? It looks like you are
>>>> adding libdbus and include dirs but I don't see any dbus usage.
>>>> 
>> <snip>
>>>> 
>>> restorcond -u is a dbus session bus service.
>>> 
>>> The idea is to run restorecond as your UID when you log into a console
>>> session.
>>> 
>> 
>> Maybe I don't get how DBus works. Why are the include dirs added to
>> CFLAGS but no apparent dbus #includes?
>> 
>> Further, will this _only_ work with DBus after this patch? If so there
>> needs to be a way to not build it if dbus isn't present on the system
>> (embedded).
>> 
>> -- 
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> with
>> the words "unsubscribe selinux" without quotes as the message.
>> 
>> 
> Ok here is another patch with all of the dbus stuff aggregated under a
> HAVE_DBUS flag.
> 
> You can build it with or without DBUS support and it should work fine.
> 
> DBUS is really used to make sure multiple restorecond do not get started.
> diff --git a/policycoreutils/restorecond/Makefile
> b/policycoreutils/restorecond/Makefile
> index 3f235e6..24aa266 100644
> --- a/policycoreutils/restorecond/Makefile
> +++ b/policycoreutils/restorecond/Makefile
> @@ -1,17 +1,28 @@
>  # Installation directories.
>  PREFIX ?= ${DESTDIR}/usr
>  SBINDIR ?= $(PREFIX)/sbin
> +LIBDIR ?= $(PREFIX)/lib
>  MANDIR = $(PREFIX)/share/man
> +AUTOSTARTDIR = $(DESTDIR)/etc/xdg/autostart
> +DBUSSERVICEDIR = $(DESTDIR)/usr/share/dbus-1/services
> +
> +autostart_DATA = sealertauto.desktop
>  INITDIR = $(DESTDIR)/etc/rc.d/init.d
>  SELINUXDIR = $(DESTDIR)/etc/selinux
>  
> +DBUSFLAGS = -DHAVE_DBUS -I/usr/include/dbus-1.0 -I/usr/lib64/dbus-1.0/include
> -I/usr/lib/dbus-1.0/include
> +DBUSLIB = -ldbus-glib-1
> +
>  CFLAGS ?= -g -Werror -Wall -W
> -override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
> -LDLIBS += -lselinux -L$(PREFIX)/lib
> +override CFLAGS += -I$(PREFIX)/include $(DBUSFLAGS) -I/usr/include/glib-2.0
> -I/usr/lib64/glib-2.0/include -I/usr/lib/glib-2.0/include
> +
> +LDLIBS += -lselinux $(DBUSLIB) -lglib-2.0 -L$(LIBDIR)
>  
>  all: restorecond
>  
> -restorecond:  restorecond.o utmpwatcher.o stringslist.o
> +restorecond.o utmpwatcher.o stringslist.o user.o watch.o: restorecond.h

You added watch.o and user.o here but there is no user.c or watch.c in this
patch. So, it won't compile (and many functions are missing).

> +
> +restorecond:  ../setfiles/restore.o restorecond.o utmpwatcher.o stringslist.o
> user.o watch.o
>      $(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
>  
>  install: all
> @@ -22,7 +33,12 @@ install: all
>      -mkdir -p $(INITDIR)
>      install -m 755 restorecond.init $(INITDIR)/restorecond
>      -mkdir -p $(SELINUXDIR)
> -    install -m 600 restorecond.conf $(SELINUXDIR)/restorecond.conf
> +    install -m 644 restorecond.conf $(SELINUXDIR)/restorecond.conf
> +    install -m 644 restorecond_user.conf $(SELINUXDIR)/restorecond_user.conf
> +    -mkdir -p $(AUTOSTARTDIR)
> +    install -m 644 restorecond.desktop $(AUTOSTARTDIR)/restorecond.desktop
> +    -mkdir -p $(DBUSSERVICEDIR)
> +    install -m 600 org.selinux.Restorecond.service
> $(DBUSSERVICEDIR)/org.selinux.Restorecond.service
>  
>  relabel: install
>      /sbin/restorecon $(SBINDIR)/restorecond
> diff --git a/policycoreutils/restorecond/restorecond.c
> b/policycoreutils/restorecond/restorecond.c
> index 58774e6..384f13e 100644
> --- a/policycoreutils/restorecond/restorecond.c
> +++ b/policycoreutils/restorecond/restorecond.c
> @@ -48,294 +48,38 @@
>  #include <signal.h>
>  #include <string.h>
>  #include <unistd.h>
> -#include <ctype.h>
> +#include "../setfiles/restore.h"
>  #include <sys/types.h>
> -#include <sys/stat.h>
>  #include <syslog.h>
>  #include <limits.h>
> +#include <pwd.h>
> +#include <sys/stat.h>
> +#include <string.h>
> +#include <stdio.h>
>  #include <fcntl.h>
> -
>  #include "restorecond.h"
> -#include "stringslist.h"
>  #include "utmpwatcher.h"
>  
> -extern char *dirname(char *path);
> +const char *homedir;
>  static int master_fd = -1;
> -static int master_wd = -1;
> -static int terminate = 0;
> -
> -#include <selinux/selinux.h>
> -#include <utmp.h>
> -
> -/* size of the event structure, not counting name */
> -#define EVENT_SIZE  (sizeof (struct inotify_event))
> -/* reasonable guess as to size of 1024 events */
> -#define BUF_LEN        (1024 * (EVENT_SIZE + 16))
> -
> -static int debug_mode = 0;
> -static int verbose_mode = 0;
> -
> -static void restore(const char *filename, int exact);
> -
> -struct watchList {
> -    struct watchList *next;
> -    int wd;
> -    char *dir;
> -    struct stringsList *files;
> -};
> -struct watchList *firstDir = NULL;
> -
> -/* Compare two contexts to see if their differences are "significant",
> - * or whether the only difference is in the user. */
> -static int only_changed_user(const char *a, const char *b)
> -{
> -    char *rest_a, *rest_b;    /* Rest of the context after the user */
> -    if (!a || !b)
> -        return 0;
> -    rest_a = strchr(a, ':');
> -    rest_b = strchr(b, ':');
> -    if (!rest_a || !rest_b)
> -        return 0;
> -    return (strcmp(rest_a, rest_b) == 0);
> -}
> -
> -/* 
> -   A file was in a direcroty has been created. This function checks to
> -   see if it is one that we are watching.
> -*/
> -
> -static int watch_list_find(int wd, const char *file)
> -{
> -    struct watchList *ptr = NULL;
> -    ptr = firstDir;
> -
> -    if (debug_mode)
> -        printf("%d: File=%s\n", wd, file);
> -    while (ptr != NULL) {
> -        if (ptr->wd == wd) {
> -            int exact=0;
> -            if (strings_list_find(ptr->files, file, &exact) == 0) {
> -                char *path = NULL;
> -                if (asprintf(&path, "%s/%s", ptr->dir, file) <
> -                    0)
> -                    exitApp("Error allocating memory.");
> -                restore(path, exact);
> -                free(path);
> -                return 0;
> -            }
> -            if (debug_mode)
> -                strings_list_print(ptr->files);
> -
> -            /* Not found in this directory */
> -            return -1;
> -        }
> -        ptr = ptr->next;
> -    }
> -    /* Did not find a directory */
> -    return -1;
> -}
> -
> -static void watch_list_free(int fd)
> -{
> -    struct watchList *ptr = NULL;
> -    struct watchList *prev = NULL;
> -    ptr = firstDir;
> -
> -    while (ptr != NULL) {
> -        inotify_rm_watch(fd, ptr->wd);
> -        strings_list_free(ptr->files);
> -        free(ptr->dir);
> -        prev = ptr;
> -        ptr = ptr->next;
> -        free(prev);
> -    }
> -    firstDir = NULL;
> -}
> -
> -/* 
> -   Set the file context to the default file context for this system.
> -   Same as restorecon.
> -*/
> -static void restore(const char *filename, int exact)
> -{
> -    int retcontext = 0;
> -    security_context_t scontext = NULL;
> -    security_context_t prev_context = NULL;
> -    struct stat st;
> -    int fd = -1;
> -    if (debug_mode)
> -        printf("restore %s\n", filename);
> -
> -    fd = open(filename, O_NOFOLLOW | O_RDONLY);
> -    if (fd < 0) {
> -        if (verbose_mode)
> -            syslog(LOG_ERR, "Unable to open file (%s) %s\n",
> -                   filename, strerror(errno));
> -        return;
> -    }
> -
> -    if (fstat(fd, &st) != 0) {
> -        syslog(LOG_ERR, "Unable to stat file (%s) %s\n", filename,
> -               strerror(errno));
> -        close(fd);
> -        return;
> -    }
> -
> -    if (!(st.st_mode & S_IFDIR) && st.st_nlink > 1) {
> -        if (exact) {
> -            syslog(LOG_ERR,
> -                   "Will not restore a file with more than one hard link (%s)
> %s\n",
> -                   filename, strerror(errno));
> -        }
> -        close(fd);
> -        return;
> -    }
> -
> -    if (matchpathcon(filename, st.st_mode, &scontext) < 0) {
> -        if (errno == ENOENT)
> -            return;
> -        syslog(LOG_ERR, "matchpathcon(%s) failed %s\n", filename,
> -               strerror(errno));
> -        return;
> -    }
> -    retcontext = fgetfilecon_raw(fd, &prev_context);
> -
> -    if (retcontext >= 0 || errno == ENODATA) {
> -        if (retcontext < 0)
> -            prev_context = NULL;
> -        if (retcontext < 0 || (strcmp(prev_context, scontext) != 0)) {
> -
> -            if (only_changed_user(scontext, prev_context) != 0) {
> -                free(scontext);
> -                free(prev_context);
> -                close(fd);
> -                return;
> -            }
> -
> -            if (fsetfilecon(fd, scontext) < 0) {
> -                if (errno != EOPNOTSUPP)
> -                    syslog(LOG_ERR,
> -                           "set context %s->%s failed:'%s'\n",
> -                           filename, scontext, strerror(errno));
> -                if (retcontext >= 0)
> -                    free(prev_context);
> -                free(scontext);
> -                close(fd);
> -                return;
> -            }
> -            syslog(LOG_WARNING, "Reset file context %s: %s->%s\n",
> -                   filename, prev_context, scontext);
> -        }
> -        if (retcontext >= 0)
> -            free(prev_context);
> -    } else {
> -        if (errno != EOPNOTSUPP)
> -            syslog(LOG_ERR, "get context on %s failed: '%s'\n",
> -                   filename, strerror(errno));
> -    }
> -    free(scontext);
> -    close(fd);
> -}
> -
> -static void process_config(int fd, FILE * cfg)
> -{
> -    char *line_buf = NULL;
> -    size_t len = 0;
> -
> -    while (getline(&line_buf, &len, cfg) > 0) {
> -        char *buffer = line_buf;
> -        while (isspace(*buffer))
> -            buffer++;
> -        if (buffer[0] == '#')
> -            continue;
> -        int l = strlen(buffer) - 1;
> -        if (l <= 0)
> -            continue;
> -        buffer[l] = 0;
> -        if (buffer[0] == '~')
> -            utmpwatcher_add(fd, &buffer[1]);
> -        else {
> -            watch_list_add(fd, buffer);
> -        }
> -    }
> -    free(line_buf);
> -}
> -
> -/* 
> -   Read config file ignoring Comment lines
> -   Files specified one per line.  Files with "~" will be expanded to the
> logged in users
> -   homedirs.
> -*/
> -
> -static void read_config(int fd)
> -{
> -    char *watch_file_path = "/etc/selinux/restorecond.conf";
>  
> -    FILE *cfg = NULL;
> -    if (debug_mode)
> -        printf("Read Config\n");
> -
> -    watch_list_free(fd);
> -
> -    cfg = fopen(watch_file_path, "r");
> -    if (!cfg)
> -        exitApp("Error reading config file.");
> -    process_config(fd, cfg);
> -    fclose(cfg);
> -
> -    inotify_rm_watch(fd, master_wd);
> -    master_wd =
> -        inotify_add_watch(fd, watch_file_path, IN_MOVED_FROM | IN_MODIFY);
> -    if (master_wd == -1)
> -        exitApp("Error watching config file.");
> -}
> +static char *server_watch_file  = "/etc/selinux/restorecond.conf";
> +static char *user_watch_file  = "/etc/selinux/restorecond_user.conf";
> +static char *watch_file;
> +static struct restore_opts r_opts;
>  
> -/* 
> -   Inotify watch loop
> -*/
> -static int watch(int fd)
> -{
> -    char buf[BUF_LEN];
> -    int len, i = 0;
> -    len = read(fd, buf, BUF_LEN);
> -    if (len < 0) {
> -        if (terminate == 0) {
> -            syslog(LOG_ERR, "Read error (%s)", strerror(errno));
> -            return 0;
> -        }
> -        syslog(LOG_ERR, "terminated");
> -        return -1;
> -    } else if (!len)
> -        /* BUF_LEN too small? */
> -        return -1;
> -    while (i < len) {
> -        struct inotify_event *event;
> -        event = (struct inotify_event *)&buf[i];
> -        if (debug_mode)
> -            printf("wd=%d mask=%u cookie=%u len=%u\n",
> -                   event->wd, event->mask,
> -                   event->cookie, event->len);
> -        if (event->wd == master_wd)
> -            read_config(fd);
> -        else {
> -            switch (utmpwatcher_handle(fd, event->wd)) {
> -            case -1:    /* Message was not for utmpwatcher */
> -                if (event->len)
> -                    watch_list_find(event->wd, event->name);
> -                break;
> +#include <selinux/selinux.h>
>  
> -            case 1:    /* utmp has changed need to reload */
> -                read_config(fd);
> -                break;
> +int debug_mode = 0;
> +int terminate = 0;
> +int master_wd = -1;
> +int run_as_user = 0;
>  
> -            default:    /* No users logged in or out */
> -                break;
> -            }
> -        }
> -
> -        i += EVENT_SIZE + event->len;
> -    }
> -    return 0;
> +static void done(void) {
> +    watch_list_free(master_fd);
> +    close(master_fd);
> +    utmpwatcher_free();
> +    matchpathcon_fini();
>  }
>  
>  static const char *pidfile = "/var/run/restorecond.pid";
> @@ -374,7 +118,7 @@ static void term_handler()
>  
>  static void usage(char *program)
>  {
> -    printf("%s [-d] [-v] \n", program);
> +    printf("%s [-d] [-s] [-f restorecond_file ] [-v] \n", program);
>      exit(0);
>  }
>  
Could you limit the refactoring patch to just refactor? Adding functionality
(like the new -s and -f options) should be part of a separate patch.

Also, you list a -s option here, but don't use it below, while you use a -u
option below that's not listed here.

> @@ -390,74 +134,35 @@ void exitApp(const char *msg)
>     to see if it is one that we are watching.
>  */
>  
> -void watch_list_add(int fd, const char *path)
> -{
> -    struct watchList *ptr = NULL;
> -    struct watchList *prev = NULL;
> -    char *x = strdup(path);
> -    if (!x)
> -        exitApp("Out of Memory");
> -    char *dir = dirname(x);
> -    char *file = basename(path);
> -    ptr = firstDir;
> -
> -    restore(path, 1);
> -
> -    while (ptr != NULL) {
> -        if (strcmp(dir, ptr->dir) == 0) {
> -            strings_list_add(&ptr->files, file);
> -            free(x);
> -            return;
> -        }
> -        prev = ptr;
> -        ptr = ptr->next;
> -    }
> -    ptr = calloc(1, sizeof(struct watchList));
> -
> -    if (!ptr)
> -        exitApp("Out of Memory");
> -
> -    ptr->wd = inotify_add_watch(fd, dir, IN_CREATE | IN_MOVED_TO);
> -    if (ptr->wd == -1) {
> -        free(ptr);
> -        syslog(LOG_ERR, "Unable to watch (%s) %s\n",
> -               path, strerror(errno));
> -        return;
> -    }
> -
> -    ptr->dir = strdup(dir);
> -    if (!ptr->dir)
> -        exitApp("Out of Memory");
> -
> -    strings_list_add(&ptr->files, file);
> -    if (prev)
> -        prev->next = ptr;
> -    else
> -        firstDir = ptr;
> -
> -    if (debug_mode)
> -        printf("%d: Dir=%s, File=%s\n", ptr->wd, ptr->dir, file);
> -
> -    free(x);
> -}
> -
>  int main(int argc, char **argv)
>  {
>      int opt;
>      struct sigaction sa;
>  
> -#ifndef DEBUG
> -    /* Make sure we are root */
> -    if (getuid() != 0) {
> -        fprintf(stderr, "You must be root to run this program.\n");
> -        return 1;
> -    }
> -#endif
> -    /* Make sure we are root */
> -    if (is_selinux_enabled() != 1) {
> -        fprintf(stderr, "Daemon requires SELinux be enabled to run.\n");
> -        return 1;
> -    }
> +    memset(&r_opts, 0, sizeof(r_opts));
> +
> +    r_opts.progress = 0;
> +    r_opts.count = 0;
> +    r_opts.debug = 0;
> +    r_opts.change = 1;
> +    r_opts.verbose = 0;
> +    r_opts.logging = 0;
> +    r_opts.rootpath = NULL;
> +    r_opts.expand_realpath = 0;
> +    r_opts.rootpathlen = 0;
> +    r_opts.outfile = NULL;
> +    r_opts.force = 0;
> +    r_opts.hard_links = 0;
> +    r_opts.expand_realpath = 1;
> +    r_opts.abort_on_error = 0;
> +    r_opts.add_assoc = 0;
> +    r_opts.fts_flags = FTS_PHYSICAL;
> +    r_opts.selabel_opt_validate = NULL;
> +    r_opts.selabel_opt_path = NULL;
> +    
> +    restore_init(&r_opts);
> +    /* If we are not running SELinux then just exit */
> +    if (is_selinux_enabled() != 1) return 0;
>  
>      /* Register sighandlers */
>      sa.sa_flags = 0;
> @@ -467,38 +172,59 @@ int main(int argc, char **argv)
>  
>      set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
>  
> -    master_fd = inotify_init();
> -    if (master_fd < 0)
> -        exitApp("inotify_init");
> -
> -    while ((opt = getopt(argc, argv, "dv")) > 0) {
> +    atexit( done );
> +    while ((opt = getopt(argc, argv, "uf:dv")) > 0) {
>          switch (opt) {
>          case 'd':
>              debug_mode = 1;
>              break;
> +        case 'f':
> +            watch_file = optarg;
> +            break;
> +        case 'u':
> +            run_as_user = 1;
> +            break;
>          case 'v':
> -            verbose_mode = 1;
> +            r_opts.verbose++;
>              break;
>          case '?':
>              usage(argv[0]);
>          }
>      }
> -    read_config(master_fd);
> +
> +    master_fd = inotify_init();
> +    if (master_fd < 0)
> +        exitApp("inotify_init");
> +
> +    uid_t uid = getuid();
> +    struct passwd *pwd = getpwuid(uid);
> +    homedir = pwd->pw_dir;
> +    if (uid != 0) {
> +        if (run_as_user)
> +            return server(master_fd, user_watch_file);
> +        if (start() != 0)
> +            return server(master_fd, user_watch_file);
> +        return 0;
> +    }
> +
> +    watch_file = server_watch_file;
> +    read_config(master_fd, watch_file);
>  
>      if (!debug_mode)
>          daemon(0, 0);
>  
>      write_pid_file();
>  
> -    while (watch(master_fd) == 0) {
> +    while (watch(master_fd, watch_file) == 0) {
>      };
>  
>      watch_list_free(master_fd);
>      close(master_fd);
>      matchpathcon_fini();
> -    utmpwatcher_free();
>      if (pidfile)
>          unlink(pidfile);
>  
>      return 0;
>  }
> +
> +
> diff --git a/policycoreutils/restorecond/restorecond.conf
> b/policycoreutils/restorecond/restorecond.conf
> index 3fc9376..58b723a 100644
> --- a/policycoreutils/restorecond/restorecond.conf
> +++ b/policycoreutils/restorecond/restorecond.conf
> @@ -4,8 +4,5 @@
>  /etc/mtab
>  /var/run/utmp
>  /var/log/wtmp
> -~/*
> -/root/.ssh
> +/root/*
>  /root/.ssh/*
> -
> -
> diff --git a/policycoreutils/restorecond/restorecond.h
> b/policycoreutils/restorecond/restorecond.h
> index e1666bf..f6452ea 100644
> --- a/policycoreutils/restorecond/restorecond.h
> +++ b/policycoreutils/restorecond/restorecond.h
> @@ -24,7 +24,21 @@
>  #ifndef RESTORED_CONFIG_H
>  #define RESTORED_CONFIG_H
>  
> -void exitApp(const char *msg);
> -void watch_list_add(int inotify_fd, const char *path);
> +extern int debug_mode;
> +extern const char *homedir;
> +extern int terminate;
> +extern int master_wd;
> +extern int run_as_user;
> +
> +extern int start(void);
> +extern int server(int, const char *watch_file);
> +
> +extern void exitApp(const char *msg);
> +extern void read_config(int fd,    const char *watch_file);
> +
> +extern int watch(int fd, const char *watch_file);
> +extern void watch_list_add(int inotify_fd, const char *path);
> +extern int watch_list_find(int wd, const char *file);
> +extern void watch_list_free(int fd);
>  
>  #endif


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
