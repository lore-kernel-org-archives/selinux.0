Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBUJmKRI018426
	for <selinux@tycho.nsa.gov>; Wed, 30 Dec 2009 14:48:21 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id nBUJoqVW013645
	for <selinux@tycho.nsa.gov>; Wed, 30 Dec 2009 19:50:52 GMT
Date: Wed, 30 Dec 2009 14:48:17 -0500
Subject: Re: Add modules support to semanage
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C76118B1.B1584%csellers@tresys.com>
In-Reply-To: <4AFC3B9F.6070802@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/12/09 11:45 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> On 11/11/2009 01:52 PM, Chad Sellers wrote:
>> On 9/30/09 2:33 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
>> 
>>> Includes enable and disable.
>>> 
>> I presume I should hold off on this patch until you have a chance to
>> resubmit the libsemanage support that it relies on. Let me know if that's
>> not the case.
>> 
>> Thanks,
>> Chad
>> 
> 
> This patch is provided the old fashioned way since I am fighting with guilt
> right now.
> 
> Just the enable/disable changes to libsemanage.
>
> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
> index 538302b..394069a 100644
> --- a/policycoreutils/Makefile
> +++ b/policycoreutils/Makefile
> @@ -1,4 +1,4 @@
> -SUBDIRS = setfiles semanage load_policy newrole run_init secon audit2allow
> audit2why scripts sestatus semodule_package semodule semodule_link
> semodule_expand semodule_deps setsebool po
> +SUBDIRS = sandbox setfiles semanage load_policy newrole run_init secon
> audit2allow audit2why scripts sestatus semodule_package semodule semodule_link
> semodule_expand semodule_deps setsebool po
>  
>  INOTIFYH = $(shell ls /usr/include/sys/inotify.h 2>/dev/null)
>  
> diff --git a/policycoreutils/sandbox/Makefile
> b/policycoreutils/sandbox/Makefile
> new file mode 100644
> index 0000000..299276a
> --- /dev/null
> +++ b/policycoreutils/sandbox/Makefile
> @@ -0,0 +1,31 @@
> +# Installation directories.
> +PREFIX ?= ${DESTDIR}/usr
> +BINDIR ?= $(PREFIX)/bin
> +SBINDIR ?= $(PREFIX)/sbin
> +MANDIR ?= $(PREFIX)/share/man
> +LOCALEDIR ?= /usr/share/locale
> +SHAREDIR ?= $(PREFIX)/share/sandbox
> +override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include
> -DPACKAGE="\"policycoreutils\""
> +LDLIBS += -lselinux -lcap-ng
> +
> +all: sandbox seunshare sandboxX.sh
> +
> +seunshare: seunshare.o $(EXTRA_OBJS)

EXTRA_OBJS? I don't see that anywhere else.

> +    $(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> +
> +install: all
> +    -mkdir -p $(BINDIR)
> +    install -m 755 sandbox $(BINDIR)
> +    -mkdir -p $(MANDIR)/man8
> +    install -m 644 sandbox.8 $(MANDIR)/man8/
> +    install -m 4755 seunshare $(SBINDIR)/
> +    -mkdir -p $(SHAREDIR)
> +    install -m 755 sandboxX.sh $(SHAREDIR)
> +
> +clean:
> +    -rm -f seunshare *.o *~
> +
> +indent:
> +    ../../scripts/Lindent $(wildcard *.[ch])
> +
> +relabel:
> diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
> new file mode 100644
> index 0000000..bc257bf
> --- /dev/null
> +++ b/policycoreutils/sandbox/sandbox
> @@ -0,0 +1,242 @@
> +#!/usr/bin/python -E
> +import os, sys, getopt, socket, random, fcntl, shutil
> +import selinux
> +import signal
> +
> +PROGNAME = "policycoreutils"
> +
> +import gettext
> +gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> +gettext.textdomain(PROGNAME)
> +
> +try:
> +       gettext.install(PROGNAME,
> +                       localedir = "/usr/share/locale",
> +                       unicode=False,
> +                       codeset = 'utf-8')
> +except IOError:
> +       import __builtin__
> +       __builtin__.__dict__['_'] = unicode
> +
> +
> +DEFAULT_TYPE = "sandbox_t"
> +DEFAULT_X_TYPE = "sandbox_x_t"
> +X_FILES = {}
> +
> +random.seed(None)
> +
> +def sighandler(signum, frame):
> +    signal.signal(signum,  signal.SIG_IGN)
> +    os.kill(0, signum)
> +    raise KeyboardInterrupt
> +
> +def setup_sighandlers():
> +    signal.signal(signal.SIGHUP,  sighandler)
> +    signal.signal(signal.SIGQUIT, sighandler)
> +    signal.signal(signal.SIGTERM, sighandler)
> +
> +def error_exit(msg):
> +    sys.stderr.write("%s: " % sys.argv[0])
> +    sys.stderr.write("%s\n" % msg)
> +    sys.stderr.flush()
> +    sys.exit(1)
> +
> +def reserve(mcs):
> +    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
> +    sock.bind("\0%s" % mcs)
> +    fcntl.fcntl(sock.fileno(), fcntl.F_SETFD, fcntl.FD_CLOEXEC)
> +
> +def gen_context(setype):
> +    while True:
> +        i1 = random.randrange(0, 1024)
> +        i2 = random.randrange(0, 1024)
> +        if i1 == i2:
> +            continue
> +        if i1 > i2:
> +            tmp = i1
> +            i1 = i2
> +            i2 = tmp
> +        mcs = "s0:c%d,c%d" % (i1, i2)
> +        reserve(mcs)
> +        try:
> +            reserve(mcs)
> +        except:
> +            continue
> +        break

I'm guessing this is supposed to ensure that 2 sandboxes have different
category sets. It looks like it's supposed to bind to an abstract socket to
prevent other processes from doing the same. I don't understand why
reserve() is called twice (once outside the try block, then once inside).
Regardless, in my testing it doesn't seem to work (I switched i1 and i2 to
hardcoded values and can run multiple sandboxes with the same category sets
simultaneously). So perhaps I'm misunderstanding the intent here.

Also, assuming I'm guessing what this is supposed to do correctly, this
logic will hang when the system runs out of categories. Admittedly that's a
million sandboxes, but an error message would be much better than an
infinite loop.

> +    con = selinux.getcon()[1].split(":")
> +
> +    execcon = "%s:%s:%s:%s" % (con[0], con[1], setype, mcs)
> +    
> +    filecon = "%s:%s:%s:%s" % (con[0],
> +                               "object_r",
> +                               "%s_file_t" % setype[:-2],
> +                               mcs)
> +    return execcon, filecon
> +
> +def copyfile(file, dir, dest):
> +       import re
> +       if file.startswith(dir):
> +              dname = os.path.dirname(file)
> +              bname = os.path.basename(file)
> +              if dname == dir:
> +                     dest = dest + "/" + bname
> +              else:
> +                     newdir = re.sub(dir, dest, dname)
> +                     os.makedirs(newdir)
> +                     dest = newdir + "/" + bname
> +
> +              if os.path.isdir(file):
> +                     shutil.copytree(file, dest)
> +              else:
> +                     shutil.copy2(file, dest)
> +              X_FILES[file] = (dest, os.path.getmtime(dest))
> +
> +def copyfiles(newhomedir, newtmpdir, files):
> +       import pwd
> +       homedir=pwd.getpwuid(os.getuid()).pw_dir
> +       for f in files:
> +              copyfile(f,homedir, newhomedir)
> +              copyfile(f,"/tmp", newtmpdir)
> +
> +def savefile(new, orig):
> +       import gtk

Hmmm, this adds a gtk requirement to policycoreutils which we've never had
before. Could we wrap this in a try block and use the console if gtk is not
available? That way we could still support graphical messages if it was
available, but work anyway if not.

> +       dlg = gtk.MessageDialog(None, 0, gtk.MESSAGE_INFO,
> +                               gtk.BUTTONS_YES_NO,
> +                               _("Do you want to save changes to '%s' (Y/N):
> ") % orig)
> +       dlg.set_title(_("Sandbox Message"))
> +       dlg.set_position(gtk.WIN_POS_MOUSE)
> +       dlg.show_all()
> +       rc = dlg.run()
> +       dlg.destroy()
> +       if rc == gtk.RESPONSE_YES:
> +              shutil.copy2(new,orig)
> +
copyfile() above allows for copying individual files or full directory trees
into the sandbox, but savefile() here seems to only allow copying individual
files out of it. I'm guessing this will blow up if someone clicks Yes on a
changed directory.

> +if __name__ == '__main__':
> +    setup_sighandlers()
> +    if selinux.is_selinux_enabled() != 1:
> +        error_exit("Requires an SELinux enabled system")
> +        
> +    init_files = []
> +
> +    def usage(message = ""):
> +        text = _("""
> +sandbox [-h] [-I includefile ] [[-i file ] ...] [ -t type ] command
> +""")
> +        error_exit("%s\n%s" % (message, text))
> +
> +    setype = DEFAULT_TYPE
> +    X_ind = False
> +    try:
> +           gopts, cmds = getopt.getopt(sys.argv[1:], "i:ht:XI:",
> +                                       ["help",
> +                                        "include=",
> +                                        "includefile=",
> +                                        "type="
> +                                        ])

This does not agree with the usage message above or the man page (and they
don't agree with each other either). The usage leaves out -X. The man page
leaves out -h and -I.

> +           for o, a in gopts:
> +                  if o == "-t" or o == "--type":
> +                         setype = a
> +                
> +                  if o == "-i" or o == "--include":
> +                         rp = os.path.realpath(a)
> +                         if rp not in init_files:
> +                                init_files.append(rp)
> +                
> +                  if o == "-I" or o == "--includefile":
> +                         fd = open(a, "r")
> +                         for i in fd.read().split("\n"):
> +                                if os.path.exists(i):
> +                                       rp = os.path.realpath(i)
> +                                       if rp not in init_files:
> +                                              init_files.append(rp)
> +                
> +                         fd.close
> +                
> +                  if o == "-X":
> +                         if DEFAULT_TYPE == setype:
> +                                setype = DEFAULT_X_TYPE
> +                         X_ind = True
> +
> +                  if o == "-h" or o == "--help":
> +                         usage(_("Usage"));
> +            
> +           if len(cmds) == 0:
> +                  usage(_("Command required"))
> +
> +           execcon, filecon = gen_context(setype)
> +           rc = -1
> +
> +           if cmds[0][0] != "/" and cmds[0][:2] != "./" and cmds[0][:3] !=
> "../":
> +                  for i in  os.environ["PATH"].split(':'):
> +                         f = "%s/%s" % (i, cmds[0])
> +                         if os.access(f, os.X_OK):
> +                                cmds[0] = f
> +                                break
> +
> +           try:
> +                  newhomedir = None
> +                  newtmpdir = None
> +                  if X_ind:
> +                         if not os.path.exists("/usr/sbin/seunshare"):
> +                                raise ValueError("""/usr/sbin/seunshare
> required for sandbox -X, to install you need to execute
> +#yum install /usr/sbin/seunshare""")
> +                         import warnings
> +                         warnings.simplefilter("ignore")
> +                         newhomedir = os.tempnam(".", ".sandbox%s")
> +                         os.mkdir(newhomedir)
> +                         selinux.setfilecon(newhomedir, filecon)
> +                         newtmpdir = os.tempnam("/tmp", ".sandbox")
> +                         os.mkdir(newtmpdir)
> +                         selinux.setfilecon(newtmpdir, filecon)
> +                         warnings.resetwarnings()
> +                         paths = []
> +                         for i in cmds:
> +                                f = os.path.realpath(i)
> +                                if os.path.exists(f):
> +                                       paths.append(f)
> +                                else:
> +                                       paths.append(i)
> +                
> +                         copyfiles(newhomedir, newtmpdir, init_files + paths)
> +                         execfile = newhomedir + "/.sandboxrc"
> +                         fd = open(execfile, "w+")
> +                         fd.write("""#! /bin/sh
> +%s
> +""" % " ".join(paths))
> +                         fd.close()
> +                         os.chmod(execfile, 0700)
> +                
> +                         cmds =  ("/usr/sbin/seunshare -t %s -h %s -- %s
> /usr/share/sandbox/sandboxX.sh" % (newtmpdir, newhomedir, execcon)).split()
> +                         rc = os.spawnvp(os.P_WAIT, cmds[0], cmds)
> +                         for i in paths:
> +                                if i not in X_FILES:
> +                                       continue
> +                                (dest, mtime) = X_FILES[i]
> +                                if os.path.getmtime(dest) > mtime:
> +                                       savefile(dest, i)
> +                  else:
> +                         selinux.setexeccon(execcon)
> +                         rc = os.spawnvp(os.P_WAIT, cmds[0], cmds)
> +                         selinux.setexeccon(None)
> +           finally:
> +                  if X_ind:
> +                         if newhomedir:
> +                                shutil.rmtree(newhomedir)
> +                         if newtmpdir:
> +                                shutil.rmtree(newtmpdir)
> +                
> +    except getopt.GetoptError, error:
> +           usage(_("Options Error %s ") % error.msg)
> +    except OSError, error:
> +           error_exit(error.args[1])
> +    except ValueError, error:
> +           error_exit(error.args[0])
> +    except KeyError, error:
> +           error_exit(_("Invalid value %s") % error.args[0])
> +    except IOError, error:
> +           error_exit(error.args[1])
> +    except KeyboardInterrupt:
> +           rc = 0
> +           
> +    sys.exit(rc)
> +

The other potential problem I see with this utility is that it makes some
assumptions about the configuration (and mostly policy) of the system. These
include:
1) The system is using an mcs policy
2) The sandbox file type is foo_file_t if the sandbox type is foo_t
3) There are 1024 categories
4) seunshare is found in /usr/sbin

I think #1 and #2 are necessary assumptions, and hard to avoid. #3 could be
solved with an optional command line arg. #4 probably isn't a big deal, but
I'd move it to a variable at the top so other distros can easily change it
if necessary.

> diff --git a/policycoreutils/sandbox/sandbox.8
> b/policycoreutils/sandbox/sandbox.8
> new file mode 100644
> index 0000000..c3f8a1f
> --- /dev/null
> +++ b/policycoreutils/sandbox/sandbox.8
> @@ -0,0 +1,26 @@
> +.TH SANDBOX "8" "May 2009" "chcat" "User Commands"
> +.SH NAME
> +sandbox \- Run cmd under an SELinux sandbox
> +.SH SYNOPSIS
> +.B sandbox
> +[-X] [[-i file ]...] [ -t type ] cmd

This should probably be:
[-X [-i file ]...] [ -t type ] cmd
or something similar to indicate that -i is only valid if you're using -X.

Speaking of which, any reason you chose not to allow the unshared tmp/home
for non-X apps? It seems like useful functionality for command-line programs
as well.

> +.br
> +.SH DESCRIPTION
> +.PP
> +Run application within a tightly confined SELinux domain,   The default
> sandbox allows the application to only read and write stdin and stdout along
> with files handled to it by the shell.
> +Additionaly a -X qualifier allows you to run sandboxed X applications.  These
> apps will start up their own X Server and create a temporary homedir and /tmp.
> The default policy does not allow any capabilities or network access.  Also
> prevents all access to the users other processes and files.  Any file
> specified on the command line will be copied into the sandbox.
> +.PP
> +.TP
> +\fB\-t type\fR
> +Use alternate sandbox type, defaults to sandbox_t or sandbox_x_t for -X.
> +.TP
> +\fB\-i file\fR
> +Copy this file into the temporary sandbox homedir. Command can be repeated.
> +.TP
> +\fB\-X\fR
> +Create an X based Sandbox for gui apps, temporary files for $HOME and /tmp,
> seconday Xserver, defaults to sandbox_x_t
> +.TP
> +.SH "SEE ALSO"
> +.TP
> +runcon(1)
> +.PP
> diff --git a/policycoreutils/sandbox/sandboxX.sh
> b/policycoreutils/sandbox/sandboxX.sh
> new file mode 100644
> index 0000000..21e6b0d
> --- /dev/null
> +++ b/policycoreutils/sandbox/sandboxX.sh
> @@ -0,0 +1,16 @@
> +#!/bin/bash 
> +export TITLE="Sandbox: `/usr/bin/tail -1 ~/.sandboxrc | /usr/bin/cut -b1-70`"
> +export SCREEN=`/usr/bin/xdpyinfo -display $DISPLAY | /bin/awk '/dimensions/ {
> print $2 }'`
> +
> +(/usr/bin/Xephyr -title "$TITLE" -terminate -screen 1000x700 -displayfd 5
> 5>&1 2>/dev/null) | while read D; do
> +    export DISPLAY=:$D
> +    /usr/bin/matchbox-window-manager -use_titlebar no &
> +    WM_PID=$!
> +    ~/.sandboxrc &
> +    CLIENT_PID=$!
> +    wait $CLIENT_PID
> +    export EXITCODE=$?
> +    kill -TERM $WM_PID
> +    kill -HUP 0
> +    break
> +done
> diff --git a/policycoreutils/sandbox/seunshare.c
> b/policycoreutils/sandbox/seunshare.c
> new file mode 100644
> index 0000000..ddf6bf1
> --- /dev/null
> +++ b/policycoreutils/sandbox/seunshare.c
> @@ -0,0 +1,265 @@
> +#include <signal.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <syslog.h>
> +#include <sys/mount.h>
> +#include <pwd.h>
> +#define _GNU_SOURCE
> +#include <sched.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <cap-ng.h>
> +#include <getopt.h>        /* for getopt_long() form of getopt() */
> +#include <limits.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +
> +#include <selinux/selinux.h>
> +#include <selinux/context.h>    /* for context-mangling functions */
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
> +/**
> + * This function will drop all capabilities
> + * Returns zero on success, non-zero otherwise
> + */
> +static int drop_capabilities(uid_t uid)
> +{
> +    capng_clear(CAPNG_SELECT_BOTH);
> +
> +    if (capng_lock() < 0)
> +        return -1;
> +    /* Change uid */
> +    if (setresuid(uid, uid, uid)) {
> +        fprintf(stderr, "Error changing uid, aborting.\n");
> +        return -1;
> +    }
> +    return capng_apply(CAPNG_SELECT_BOTH);
> +}
> +
> +#define DEFAULT_PATH "/usr/bin:/bin"
> +#define TRUE 1
> +#define FALSE 0
> +
> +/**
> + * Take care of any signal setup
> + */
> +static int set_signal_handles(void)
> +{
> +    sigset_t empty;
> +
> +    /* Empty the signal mask in case someone is blocking a signal */
> +    if (sigemptyset(&empty)) {
> +        fprintf(stderr, "Unable to obtain empty signal set\n");
> +        return -1;
> +    }
> +
> +    (void)sigprocmask(SIG_SETMASK, &empty, NULL);
> +
> +    /* Terminate on SIGHUP. */
> +    if (signal(SIGHUP, SIG_DFL) == SIG_ERR) {
> +        perror("Unable to set SIGHUP handler");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +#define USAGE_STRING "USAGE: seunshare [ -t tmpdir ] [ -h homedir ] --
> CONTEXT executable [args] "
> +
> +
> +
> +static int verify_mount(const char *mntdir, struct passwd *pwd) {
> +    struct stat sb;
> +    if (stat(mntdir, &sb) == -1) {
> +        perror("Invalid mount point");
> +        return -1;
> +    }
> +    if (sb.st_uid != pwd->pw_uid) {
> +        errno = EPERM;
> +        syslog(LOG_AUTHPRIV | LOG_ALERT, "%s attempted to mount an invalid
> directory, %s", pwd->pw_name, mntdir);
> +        perror("Invalid mount point, reporting to administrator");
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +/**
> + * This function checks to see if the shell is known in /etc/shells.
> + * If so, it returns 1. On error or illegal shell, it returns 0.
> + */
> +static int verify_shell(const char *shell_name)
> +{
> +    int found = 0;
> +    const char *buf;
> +
> +    if (!(shell_name && shell_name[0]))
> +        return found;
> +
> +    while ((buf = getusershell()) != NULL) {
> +        /* ignore comments */
> +        if (*buf == '#')
> +            continue;
> +
> +        /* check the shell skipping newline char */
> +        if (!strcmp(shell_name, buf)) {
> +            found = 1;
> +            break;
> +        }
> +    }
> +    endusershell();
> +    return found;
> +}
> +
> +int main(int argc, char **argv) {
> +    int rc;
> +    int status = -1;
> +
> +    security_context_t scontext;
> +
> +    int flag_index;        /* flag index in argv[] */
> +    int clflag;        /* holds codes for command line flags */
> +    char *tmpdir_s = NULL;    /* tmpdir spec'd by user in argv[] */
> +    char *homedir_s = NULL;    /* homedir spec'd by user in argv[] */
> +
> +    const struct option long_options[] = {
> +        {"homedir", 1, 0, 'h'},
> +        {"tmpdir", 1, 0, 't'},
> +        {NULL, 0, 0, 0}
> +    };
> +
> +    uid_t uid = getuid();
> +
> +    if (!uid) {
> +        fprintf(stderr, "Must not be root");
> +        return -1;
> +    }
> +
Why? Root can't run graphical things in a sandbox? Seems like an unnecessary
restriction.

> +    struct passwd *pwd=getpwuid(uid);
> +    if (!pwd) {
> +        perror("getpwduid failed");
> +        return -1;
> +    }
> +
> +    if (verify_shell(pwd->pw_shell) == 0) {
> +        fprintf(stderr, "Error!  Shell is not valid.\n");
> +        return -1;
> +    }
> +
> +    while (1) {
> +        clflag = getopt_long(argc, argv, "h:t:", long_options,
> +                     &flag_index);
> +        if (clflag == -1)
> +            break;
> +
> +        switch (clflag) {
> +        case 't':
> +            tmpdir_s = optarg;
> +            if (verify_mount(tmpdir_s, pwd) < 0) return -1;
> +            break;
> +        case 'h':
> +            homedir_s = optarg;
> +            if (verify_mount(homedir_s, pwd) < 0) return -1;
> +            if (verify_mount(pwd->pw_dir, pwd) < 0) return -1;
> +            break;
> +        default:
> +            fprintf(stderr, "%s\n", USAGE_STRING);
> +            return -1;
> +        }
> +    }
> +
> +    if (! homedir_s && ! tmpdir_s) {
> +        fprintf(stderr, "Error: tmpdir and/or homedir required \n"
> +            "%s\n", USAGE_STRING);
> +        return -1;
> +    }
> +
> +    if (argc - optind < 2) {
> +        fprintf(stderr, "Error: executable required \n"
> +            "%s\n", USAGE_STRING);
> +        return -1;
> +    }
> +
> +    scontext = argv[optind++];
> +    
> +    if (set_signal_handles())
> +        return -1;
> +
> +        if (unshare(CLONE_NEWNS) < 0) {
> +        perror("Failed to unshare");
> +        return -1;
> +    }
> +
> +    if (homedir_s && mount(homedir_s, pwd->pw_dir, NULL, MS_BIND, NULL) < 0)
> {
> +        perror("Failed to mount HOMEDIR");
> +        return -1;
> +    }
> +
> +    if (homedir_s && verify_mount(pwd->pw_dir, pwd) < 0)
> +        return -1;
> +
> +    if (tmpdir_s && mount(tmpdir_s, "/tmp", NULL, MS_BIND, NULL) < 0) {
> +        perror("Failed to mount /tmp");
> +        return -1;
> +    }
> +
> +    if (tmpdir_s && verify_mount("/tmp", pwd) < 0)
> +        return -1;
> +
> +    if (drop_capabilities(uid)) {
> +        perror("Failed to drop all capabilities");
> +        return -1;
> +    }
> +
> +    int child = fork();
> +    if (!child) {
> +        char *display=NULL;
> +        /* Construct a new environment */
> +        char *d = getenv("DISPLAY");
> +        if (d) {
> +            display =  strdup(d);
> +            if (!display) {
> +                perror("Out of memory");
> +                exit(-1);
> +            }
> +        }
> +
> +        if ((rc = clearenv())) {
> +            perror("Unable to clear environment");
> +            free(display);
> +            exit(-1);
> +        }
> +        
> +        if (setexeccon(scontext)) {
> +            fprintf(stderr, "Could not set exec context to %s.\n",
> +                scontext);
> +            free(display);
> +            exit(-1);
> +        }
> +
> +        if (display)
> +            rc |= setenv("DISPLAY", display, 1);
> +        rc |= setenv("HOME", pwd->pw_dir, 1);
> +        rc |= setenv("SHELL", pwd->pw_shell, 1);
> +        rc |= setenv("USER", pwd->pw_name, 1);
> +        rc |= setenv("LOGNAME", pwd->pw_name, 1);
> +        rc |= setenv("PATH", DEFAULT_PATH, 1);
> +        
> +        if (chdir(pwd->pw_dir)) {
> +            perror("Failed to change dir to homedir");
> +            exit(-1);
> +        }
> +        setsid();
> +        execv(argv[optind], argv + optind);
> +        free(display);
> +        perror("execv");
> +        exit(-1);
> +    } else {
> +        waitpid(child, &status, 0);
> +    }
> +
> +    return status;
> +}
> 
> 
Thanks for submitting this. I'm think it will be great to get it upstream,
as it's such a useful utility. I'd be happy to help out with any changes to
it that are necessary once I understand a few of the things I asked about.
Just let me know.

Chad Sellers


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
