Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4IIwYCQ016268
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2010 14:58:34 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o4IIxnpN006414
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2010 18:59:49 GMT
Subject: Re: Updated sandbox patch.
From: Steve Lawrence <slawrence@tresys.com>
Reply-To: slawrence@tresys.com
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 18 May 2010 14:58:32 -0400
Message-Id: <1274209112.2751.70.camel@gorgon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad asked me to take a look at this patch. My comments are inline.

- Steve

> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
> index 538302b..b5b97bc 100644
> --- a/policycoreutils/Makefile
> +++ b/policycoreutils/Makefile
> @@ -1,4 +1,4 @@
> -SUBDIRS = setfiles semanage load_policy newrole run_init secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po
> +SUBDIRS = setfiles semanage load_policy newrole run_init sandbox secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po 
>  
>  INOTIFYH = $(shell ls /usr/include/sys/inotify.h 2>/dev/null)
>  
> diff --git a/policycoreutils/sandbox/Makefile b/policycoreutils/sandbox/Makefile
> new file mode 100644
> index 0000000..ff0ee7c
> --- /dev/null
> +++ b/policycoreutils/sandbox/Makefile
> @@ -0,0 +1,41 @@
> +# Installation directories.
> +PREFIX ?= ${DESTDIR}/usr
> +INITDIR ?= ${DESTDIR}/etc/rc.d/init.d/
> +SYSCONFDIR ?= ${DESTDIR}/etc/sysconfig
> +BINDIR ?= $(PREFIX)/bin
> +SBINDIR ?= $(PREFIX)/sbin
> +MANDIR ?= $(PREFIX)/share/man
> +LOCALEDIR ?= /usr/share/locale
> +SHAREDIR ?= $(PREFIX)/share/sandbox
> +override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\""
> +LDLIBS += -lselinux -lcap-ng 
> +
> +all: sandbox seunshare sandboxX.sh 
> +
> +seunshare: seunshare.o $(EXTRA_OBJS)
> +	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> +
> +install: all
> +	-mkdir -p $(BINDIR)
> +	install -m 755 sandbox $(BINDIR)
> +	-mkdir -p $(MANDIR)/man8
> +	install -m 644 sandbox.8 $(MANDIR)/man8/
> +	-mkdir -p $(SBINDIR)
> +	install -m 4755 seunshare $(SBINDIR)/
> +	-mkdir -p $(SHAREDIR)
> +	install -m 755 sandboxX.sh $(SHAREDIR)
> +	-mkdir -p $(INITDIR)
> +	install -m 755 sandbox.init $(INITDIR)/sandbox
> +	-mkdir -p $(SYSCONFDIR)
> +	install -m 644 sandbox.config $(SYSCONFDIR)/sandbox
> +
> +test:
> +	@python test_sandbox.py -v
> +
> +clean:
> +	-rm -f seunshare *.o *~
> +
> +indent:
> +	../../scripts/Lindent $(wildcard *.[ch])
> +
> +relabel:
> diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
> new file mode 100644
> index 0000000..051fa39
> --- /dev/null
> +++ b/policycoreutils/sandbox/sandbox
> @@ -0,0 +1,420 @@
> +#! /usr/bin/python -E
> +# Authors: Dan Walsh <dwalsh@redhat.com>
> +# Authors: Josh Cogliati
> +#
> +# Copyright (C) 2009,2010  Red Hat
> +# see file 'COPYING' for use and warranty information
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; version 2 only
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write to the Free Software
> +# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> +#
> +
> +import os, sys, socket, random, fcntl, shutil, re, subprocess
> +import selinux
> +import signal
> +from tempfile import mkdtemp
> +import pwd
> +
> +PROGNAME = "policycoreutils"
> +HOMEDIR=pwd.getpwuid(os.getuid()).pw_dir
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
> +DEFAULT_TYPE = "sandbox_t"
> +DEFAULT_X_TYPE = "sandbox_x_t"
> +X_FILES = {}

The name X_FILES is a little confusing. It makes me think it is only for
the -X option, but it is for everything. Maybe something like SAVE_FILES
would be more clear?

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
> +def copyfile(file, dir, dest):
> +       import re
> +       if file.startswith(dir):
> +              dname = os.path.dirname(file)
> +              bname = os.path.basename(file)
> +              if dname == dir:
> +                     dest = dest + "/" + bname
> +              else:
> +                     newdir = re.sub(dir, dest, dname)
> +                     if not os.path.exists(newdir):
> +                            os.makedirs(newdir)
> +                     dest = newdir + "/" + bname
> +
> +              if os.path.isdir(file):
> +                     shutil.copytree(file, dest)
> +              else:
> +                     shutil.copy2(file, dest)
> +              X_FILES[file] = (dest, os.path.getmtime(dest))
> +
> +def savefile(new, orig, X_ind):
> +       copy = False
> +       if(X_ind):
> +              import gtk
> +              dlg = gtk.MessageDialog(None, 0, gtk.MESSAGE_INFO,
> +                                      gtk.BUTTONS_YES_NO,
> +                                      _("Do you want to save changes to '%s' (Y/N): ") % orig)
> +              dlg.set_title(_("Sandbox Message"))
> +              dlg.set_position(gtk.WIN_POS_MOUSE)
> +              dlg.show_all()
> +              rc = dlg.run()
> +              dlg.destroy()
> +              if rc == gtk.RESPONSE_YES:
> +                     copy = True
> +       else:
> +              ans = raw_input(_("Do you want to save changes to '%s' (y/N): ") % orig)
> +              if(re.match(_("[yY]"),ans)):
> +                     copy = True
> +       if(copy):
> +              shutil.copy2(new,orig)
> +
> +def reserve(level):
> +    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
> +    sock.bind("\0%s" % level)
> +    fcntl.fcntl(sock.fileno(), fcntl.F_SETFD, fcntl.FD_CLOEXEC)
> +
> +def gen_mcs():
> +       while True:
> +              i1 = random.randrange(0, 1024)
> +              i2 = random.randrange(0, 1024)
> +              if i1 == i2:
> +                     continue
> +              if i1 > i2:
> +                     tmp = i1
> +                     i1 = i2
> +                     i2 = tmp
> +                     level = "s0:c%d,c%d" % (i1, i2)

Unnecessary assignment. The above line can be removed.

> +              level = "s0:c%d,c%d" % (i1, i2)
> +              try:
> +                     reserve(level)
> +              except socket.error:
> +                     continue
> +              break
> +       return level
> +
> +def fullpath(cmd):
> +       for i in [ "/", "./", "../" ]:
> +              if cmd.startswith(i):
> +                     return cmd
> +       for i in  os.environ["PATH"].split(':'):
> +              f = "%s/%s" % (i, cmd)
> +              if os.access(f, os.X_OK):
> +                     return f
> +       return cmd
> +
> +class Sandbox:
> +    VERSION = "sandbox .1"
> +    SYSLOG = "/var/log/messages"
> +
> +    def __init__(self):
> +        self.__options = None
> +        self.__cmds = None
> +        self.__init_files = []
> +        self.__paths = []
> +        self.__mount = False
> +        self.__level = None
> +        self.__homedir = None
> +        self.__tmpdir = None
> +
> +    def __validate_mount(self):
> +           if self.__options.level:
> +                  if not self.__options.homedir or not self.__options.tmpdir:
> +                         self.usage(_("Homedir and tempdir required for level mounts"))
> +
> +           if not os.path.exists("/usr/sbin/seunshare"):
> +                  raise ValueError("""
> +/usr/sbin/seunshare required for sandbox -M, to install you need to execute 
> +#yum install /usr/sbin/seunshare
> +""")

There are other cases where seunshare is required (e.g. -X, -H or -T). I
would add those to the error message, or maybe just have a more generic
message like "/usr/sbin/seunshare is required for the actions you want
to perform."

> Also, seunshare isn't specific to rpm based distros, I wouldn't mention yum here.
> 
> +           homedir=pwd.getpwuid(os.getuid()).pw_dir
> +           fd = open("/proc/self/mountinfo", "r")
> +           recs = fd.readlines()
> +           fd.close()
> +           for i in recs:
> +                  x = i.split() 
> +                  if x[3] == x[4] and homedir.startswith(x[3]+"/"):
> +                         return
> +           raise ValueError(_("""
> +'%s' is required to be a shared mount point for this tool to run.  
> +'%s' can be added to the HOMEDIR variable in /etc/sysconfig/sandbox
> + along with a reboot will fix the problem.
> +""" % ((os.path.dirname(homedir)), os.path.dirname(homedir))))
> +        
> +    def __mount_callback(self, option, opt, value, parser):
> +           self.__mount = True
> +
> +    def __x_callback(self, option, opt, value, parser):
> +           self.__mount = True
> +           setattr(parser.values, option.dest, True)
> +
> +    def __validdir(self, option, opt, value, parser):
> +           if not os.path.isdir(value):
> +                  raise IOError("Directory "+value+" not found")
> +           self.__mount = True

Since your using the callback __validdir for the homedir and tmpdir
options, the options.dest needs to be set manually via setattr.
Otherwise the -H and -T options are ignored. The following should fix
it:

setattr(parser.values, option.dest, value)

> +
> +    def __include(self, option, opt, value, parser):
> +           rp = os.path.realpath(os.path.expanduser(value))
> +           if not os.path.exists(rp):
> +                  raise IOError(value+" not found")
> +
> +           if rp not in self.__init_files:
> +                  self.__init_files.append(rp)
> +
> +    def __includefile(self, option, opt, value, parser):
> +           fd = open(value, "r")
> +           for i in fd.readlines():
> +                  rp = os.path.realpath(os.path.expanduser(i[:-1]))
> +                  if rp not in self.__init_files and os.path.exists(rp):
> +                         self.__init_files.append(rp)

This should probably throw an error like __include if rp doesn't exist.
In fact, how about just reuse __include, e.g:

for i in fd.readlines():
    self.__include(option, opt, i[:-1], parser)

> +           fd.close()
> +
> +    def __copyfiles(self):
> +           files = self.__init_files + self.__paths
> +           homedir=pwd.getpwuid(os.getuid()).pw_dir
> +           for f in files:
> +                  copyfile(f, homedir, self.__homedir)
> +                  copyfile(f, "/tmp", self.__tmpdir)
> +
> +    def __setup_sandboxrc(self, wm = "/usr/bin/matchbox-window-manager -use_titlebar no"):
> +           execfile =self.__homedir + "/.sandboxrc"
> +           fd = open(execfile, "w+") 
> +           if self.__options.session:
> +                  fd.write("""#!/bin/sh
> +#TITLE: /etc/gdm/Xsession
> +/etc/gdm/Xsession
> +""")
> +           else:
> +                  command = " ".join(self.__paths)
> +                  fd.write("""#! /bin/sh
> +#TITLE: %s
> +/usr/bin/test -r ~/.xmodmap && /usr/bin/xmodmap ~/.xmodmap
> +%s &
> +WM_PID=$!
> +%s
> +kill -TERM $WM_PID  2> /dev/null
> +""" % (command, wm, command))
> +           fd.close()
> +           os.chmod(execfile, 0700)
> +
> +    def usage(self, message = ""):
> +           error_exit("%s\n%s" % (self.__parser.usage, message))
> +
> +    def __parse_options(self):
> +        from optparse import OptionParser
> +        usage = _("""
> +sandbox [-h] [-[X|M] [-l level ] [-H homedir] [-T tempdir]] [-I includefile ] [-W windowmanager ] [[-i file ] ...] [ -t type ] command
> +
> +sandbox [-h] [-[X|M] [-l level ] [-H homedir] [-T tempdir]] [-I includefile ] [-W windowmanager ] [[-i file ] ...] [ -t type ] -S
> +""")
> +        
> +        parser = OptionParser(version=self.VERSION, usage=usage)
> +        parser.disable_interspersed_args()
> +        parser.add_option("-i", "--include", 
> +                          action="callback", callback=self.__include, 
> +                          type="string",
> +                          help="include file in sandbox")
> +        parser.add_option("-I", "--includefile",  action="callback", callback=self.__includefile,
> +                          type="string",
> +                          help="include contents of file in sandbox")

This description is a little confusing, what about something like "read
list of files to include in sandbox from INCLUDEFILE"?

> +        parser.add_option("-t", "--type", dest="setype", action="store", default=DEFAULT_TYPE,
> +                          help="Run sandbox with SELinux type")

Lowercase "run" to have consistent capitalization across help text

> +        parser.add_option("-M", "--mount", 
> +                          action="callback", callback=self.__mount_callback, 
> +                          help="Mount new home and tmp Dir")
> +

How about "mount new home and temporary directories"

> +        parser.add_option("-S", "--session", action="store_true",  dest="session", 
> +                          default=False,  help="Run complete desktop session within sandbox")

Lower case "run" for consistent capitalization

> +        parser.add_option("-X", dest="X_ind", 
> +                          action="callback", callback=self.__x_callback, 
> +                          default=False,  help="Run X sandbox")

Ditto for "run"

> +
> +        parser.add_option("-H", "--homedir", 
> +                          action="callback", callback=self.__validdir,
> +                          type="string",
> +                          dest="homedir",  
> +                          help="Alternate homedir to use for mounting")

Ditto for "alternate"

> +
> +        parser.add_option("-T", "--tmpdir", dest="tmpdir",  
> +                          type="string",
> +                          action="callback", callback=self.__validdir,
> +                          help="Alternate tempdir to use for mounting")

Ditto for "alternate"

> +
> +        parser.add_option("-W", "--windowmanager", dest="wm",  
> +                          type="string",
> +                          default="/usr/bin/matchbox-window-manager -use_titlebar no",
> +                          help="Alternate window maanger")

Ditto for "alternate"

> +
> +        parser.add_option("-l", "--level", dest="level", 
> +                          help="MCS/MLS Level for the sandbox")
> +
> +        self.__parser=parser
> +
> +        self.__options, cmds = parser.parse_args()
> +
> +        if self.__options.X_ind:
> +               if DEFAULT_TYPE == self.__options.setype:
> +                     self.__options.setype = DEFAULT_X_TYPE

There's a corner case here where if the user explicitly sets setype to
DEFAULT_TYPE (e.g. sandbox -X -t sandbox_t) then the sandbox_t type will
be ignored and it will use DEFAULT_X_TYPE (sandbox_x_t) instead. It
seems that if the user specifies --type, that should be used no matter
what.

> +
> +        if self.__mount:
> +               self.__validate_mount()
> +
> +        if self.__options.session:
> +               if self.__options.setype in (DEFAULT_TYPE, DEFAULT_X_TYPE):
> +                      self.__options.setype = selinux.getcon()[1].split(":")[2]

There is a similar corner case here as above. If the user explicitly
specifies the type as sandbox_t or sandbox_x_t with and also specifies
the -S option, then the type would be ignored and the result of getcon()
will be used.

> +               if not self.__options.homedir or not self.__options.tmpdir:
> +                      self.usage(_("Homedir and tempdir required for session"))
> +               if len(cmds) > 0:
> +                      self.usage(_("Commands not allowed in a session"))
> +        else:
> +               if len(cmds) == 0:
> +                      self.usage(_("Command required"))
> +               cmds[0] = fullpath(cmds[0])
> +               self.__cmds = cmds
> +
> +        for f in cmds:
> +               rp = os.path.realpath(f)
> +               if os.path.exists(rp):
> +                      self.__paths.append(rp)
> +               else:
> +                      self.__paths.append(f)
> +                  
> +    def __gen_context(self):
> +           if self.__options.level:
> +                  level = self.__options.level
> +           else:
> +                  level = gen_mcs()
> +
> +           con = selinux.getcon()[1].split(":")
> +           self.__execcon = "%s:%s:%s:%s" % (con[0], con[1], self.__options.setype, level)
> +           self.__filecon = "%s:%s:%s:%s" % (con[0], "object_r", 
> +                                             "%s_file_t" % self.__options.setype[:-2], 
> +                                             level)

This assumes setype is of the form foo_t, is this a safe assumption?

> +    def __setup_dir(self):
> +           if self.__options.level or self.__options.session:
> +                  return
> +           sandboxdir = HOMEDIR + "/.sandbox"
> +           if not os.path.exists(sandboxdir):
> +                  os.mkdir(sandboxdir)
> +
> +           import warnings 
> +           warnings.simplefilter("ignore")

What warnings are being ignored? Can those be fixed?

> +           if self.__options.homedir:
> +                  chcon =  ("/usr/bin/chcon -R %s %s" % (self.__filecon, self.__options.homedir)).split()

This will fail if homedir has spaces. Why not just use spawnl? The
number of parameters is always fixed.

> +                  rc = os.spawnvp(os.P_WAIT, chcon[0], chcon)

This doesn't check return code if chcon fails.

> +                  self.__homedir = self.__options.homedir
> +           else:
> +                  selinux.setfscreatecon(self.__filecon)
> +                  self.__homedir = mkdtemp(dir=sandboxdir, prefix=".sandbox")
> +
> +           if self.__options.tmpdir:
> +                  chcon =  ("/usr/bin/chcon -R %s %s" % (self.__filecon, self.__options.tmpdir)).split()
> +                  rc = os.spawnvp(os.P_WAIT, chcon[0], chcon)

Same as previous two comments

> +                  self.__tmpdir = self.__options.homedir
> +           else:
> +                  selinux.setfscreatecon(self.__filecon)
> +                  self.__tmpdir = mkdtemp(dir="/tmp", prefix=".sandbox")
> +           warnings.resetwarnings()
> +           selinux.setfscreatecon(None)
> +           self.__copyfiles()
> +
> +    def __execute(self):
> +           try:
> +                  if self.__options.X_ind:
> +                         xmodmapfile = self.__homedir + "/.xmodmap"
> +                         xd = open(xmodmapfile,"w")
> +                         subprocess.Popen(["/usr/bin/xmodmap","-pke"],stdout=xd).wait()
> +                         xd.close()
> +
> +                         self.__setup_sandboxrc(self.__options.wm)
> +                         
> +                         cmds =  ("/usr/sbin/seunshare -t %s -h %s -- %s /usr/share/sandbox/sandboxX.sh" % (self.__tmpdir, self.__homedir, self.__execcon)).split()

Ditto

> +                         rc = os.spawnvp(os.P_WAIT, cmds[0], cmds)
> +                         return rc
> +
> +                  if self.__mount:
> +                         cmds =  ("/usr/sbin/seunshare -t %s -h %s -- %s " % (self.__tmpdir, self.__homedir, self.__execcon)).split()+self.__paths

Ditto

> +                         rc = os.spawnvp(os.P_WAIT, cmds[0], cmds)
> +                         return rc
> +
> +                  selinux.setexeccon(self.__execcon)
> +                  rc = os.spawnvp(os.P_WAIT, self.__cmds[0], self.__cmds)
> +                  selinux.setexeccon(None)
> +                  return rc
> +
> +           finally:
> +                  for i in self.__paths:
> +                         if i not in X_FILES:
> +                                continue
> +                         (dest, mtime) = X_FILES[i]
> +                         if os.path.getmtime(dest) > mtime:
> +                                savefile(dest, i, X_ind)

This should be savefile(dest, i, self.__options.X_ind)

> +
> +                  if self.__homedir and not self.__options.homedir: 
> +                         shutil.rmtree(self.__homedir)
> +                  if self.__tmpdir and not self.__options.tmpdir:
> +                         shutil.rmtree(self.__tmpdir)
> +    def main(self):
> +        try:
> +               self.__parse_options()
> +               self.__gen_context()
> +               self.__setup_dir()
> +               return self.__execute()
> +        except KeyboardInterrupt:
> +            sys.exit(0)
> +
> +
> +if __name__ == '__main__':
> +    setup_sighandlers()
> +    if selinux.is_selinux_enabled() != 1:
> +        error_exit("Requires an SELinux enabled system")
> +    
> +    try:
> +           sandbox = Sandbox()
> +           rc = sandbox.main()
> +    except OSError, error:
> +           error_exit(error.args[1])
> +    except ValueError, error:
> +           error_exit(error.args[0])
> +    except KeyError, error:
> +           error_exit(_("Invalid value %s") % error.args[0])
> +    except IOError, error:
> +           error_exit(error)
> +    except KeyboardInterrupt:
> +           rc = 0
> +           
> +    sys.exit(rc)
> diff --git a/policycoreutils/sandbox/sandbox.8 b/policycoreutils/sandbox/sandbox.8
> new file mode 100644
> index 0000000..ffaae49
> --- /dev/null
> +++ b/policycoreutils/sandbox/sandbox.8
> @@ -0,0 +1,56 @@
> This needs to be updated
> +.TH SANDBOX "8" "May 2009" "chcat" "User Commands"
> +.SH NAME
> +sandbox \- Run cmd under an SELinux sandbox
> +.SH SYNOPSIS
> +.B sandbox
> +sandbox [-h] [-[X|M] [-l level ] [-H homedir] [-T tempdir]] [-I includefile ] [-W windowmanager ] [[-i file ] ...] [ -t type ] -S

The usage is missing the 'cmd' option. Also, the -S option isn't
described anywhere. Adding the usage description from sandbox.py ("Run
complete desktop session within sandbox") should be fine.

> +.br
> +.SH DESCRIPTION
> +.PP
> +Run the 
> +.I cmd 
> +application within a tightly confined SELinux domain.  The default sandbox domain only allows applications the ability to read and write stdin, stdout and any other file descriptors handed to it. It is not allowed to open any other files.  The -M option will mount an alternate homedir and tmpdir to be used by the sandbox.
> +
> +If you have the 
> +.I policycoreutils-sandbox 
> +package installed, you can use the -X option and the -M option.
> +.B sandbox -X
> +allows you to run sandboxed X applications.  These applications will start up their own X Server and create a temporary homedir and /tmp.  The default policy does not allow any capabilities or network access.  It also prevents all access to the users other processes and files.  Any file specified on the command line will be copied into the sandbox.
> +
> +If directories are specified with -H or -T the directory will have its context modified with chcon(1) unless a level is specified with -l.  If the MLS/MCS security level is specified, the directories need to have a matching label.
> +.PP
> +.TP
> +\fB\-H\ homedir
> +Use alternate homedir to mount.  Defaults to temporary. Requires -X or -M.
> +.TP
> +\fB\-i file\fR
> +Copy this file into the temporary sandbox appriate. Command can be repeated.

appropriate is spelled wrong

> +.TP
> +\fB\-I inputfile\fR Copy all files listed in inputfile into the
> +appropriate temporary sandbox direcories.

directories is spelled wrong

> +.TP
> +\fB\-l\fR
> +Specify the MLS/MCS Security Level to run the sandbox in.  Defaults to random.
> +.TP
> +\fB\-M\fR
> +Create a Sandbox with temporary files for $HOME and /tmp, defaults to sandbox_t
> +.TP
> +\fB\-t type\fR
> +Use alternate sandbox type, defaults to sandbox_t or sandbox_x_t for -X.
> +.TP
> +\fB\-T\ tmpdir
> +Use alternate tempdir to mount.  Defaults to temporary. Requires -X or -M.

Should this be "Defaults to /tmp."?

> +.TP
> +\fB\-W windowmanager\fR
> +Select alternative window manager to run within 
> +.B sandbox -X.
> +Default to /usr/bin/matchbox-window-manager.
> +.TP
> +\fB\-X\fR 
> +Create an X based Sandbox for gui apps, temporary files for
> +$HOME and /tmp, seconday Xserver, defaults to sandbox_x_t
> +.PP
> +.SH "SEE ALSO"
> +.TP
> +runcon(1)
> +.PP
> diff --git a/policycoreutils/sandbox/sandbox.config b/policycoreutils/sandbox/sandbox.config
> new file mode 100644
> index 0000000..f9f059a
> --- /dev/null
> +++ b/policycoreutils/sandbox/sandbox.config
> @@ -0,0 +1,2 @@
> +# Space separate list of homedirs
> +HOMEDIRS="/home"
> diff --git a/policycoreutils/sandbox/sandbox.init b/policycoreutils/sandbox/sandbox.init
> new file mode 100644
> index 0000000..30d0861
> --- /dev/null
> +++ b/policycoreutils/sandbox/sandbox.init
> @@ -0,0 +1,67 @@
> +#!/bin/bash
> +## BEGIN INIT INFO
> +# Provides: sandbox
> +# Default-Start: 3 4 5
> +# Default-Stop: 0 1 2 3 4 6
> +# Required-Start:
> +#              
> +## END INIT INFO
> +# sandbox:        Set up / mountpoint to be shared, /var/tmp, /tmp, /home/sandbox unshared
> +#
> +# chkconfig: 345 1 99
> +#
> +# Description: sandbox is using pam_namespace to share the /var/tmp, /tmp and 
> +#              /home/sandbox accounts.  This script will setup the / mount 
> +#              point as shared and all of the subdirectories just these 
> +#              directories as unshared.

The last sentence doesn't make sense. Is this what you meant?

"This script will setup the / mount point as shared and each of these
directories as unshared."

> +#
> +
> +# Source function library.
> +. /etc/init.d/functions
> +
> +HOMEDIRS="/home"
> +
> +. /etc/sysconfig/sandbox
> +
> +LOCKFILE=/var/lock/subsys/sandbox
> +
> +base=${0##*/}
> +
> +case "$1" in
> +    start)
> +	[ -f "$LOCKFILE" ] && exit 0
> +
> +	touch $LOCKFILE
> +	mount --make-rshared /
> +	mount --rbind /tmp /tmp
> +	mount --rbind /var/tmp /var/tmp
> +	mount --make-private /tmp
> +	mount --make-private /var/tmp
> +	for h in $HOMEDIRS; do
> +	    mount --rbind $h $h 
> +	    mount --make-private $h
> +	done
> +
> +	RETVAL=$?
> +	exit $RETVAL

RETVAL is meaningless here. It only captures the result of the last
mount command. I would make this should check the results of each mount
and exit on failure.

> +	;;
> +
> +    status)
> +	if [ -f "$LOCKFILE" ]; then 
> +	    echo "$base is running"
> +	else
> +	    echo "$base is stopped"
> +	fi
> +	exit 0
> +	;;
> +
> +    stop)
> +	rm -f $LOCKFILE
> +	exit 0
> +	;;
> +
> +    *)
> +	echo $"Usage: $0 {start|stop}"

The usage string is missing 'status'

> +	exit 3
> +	;;
> +esac
> diff --git a/policycoreutils/sandbox/sandboxX.sh b/policycoreutils/sandbox/sandboxX.sh
> new file mode 100644
> index 0000000..ed318d0
> --- /dev/null
> +++ b/policycoreutils/sandbox/sandboxX.sh
> @@ -0,0 +1,15 @@
> +#!/bin/bash 
> +context=`id -Z | secon -t -l -P`
> +export TITLE="Sandbox $context -- `grep ^#TITLE: ~/.sandboxrc | /usr/bin/cut -b8-80`"
> +export SCREENSIZE="1000x700"
> +#export SCREENSIZE=`xdpyinfo | awk  '/dimensions/ {  print $2 }'`
> +trap "exit 0" HUP
> +
> +(/usr/bin/Xephyr -title "$TITLE" -terminate -screen $SCREENSIZE -displayfd 5 5>&1 2>/dev/null) | while read D; do 
> +    export DISPLAY=:$D
> +    python -c 'import gtk, os; os.system("%s/.sandboxrc" % os.environ["HOME"])'
> +    export EXITCODE=$?
> +    kill -HUP 0
> +    break
> +done
> +exit 0
> diff --git a/policycoreutils/sandbox/seunshare.c b/policycoreutils/sandbox/seunshare.c
> new file mode 100644
> index 0000000..ddf6bf1
> --- /dev/null
> +++ b/policycoreutils/sandbox/seunshare.c
> 
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
> +#include <getopt.h>		/* for getopt_long() form of getopt() */
> +#include <limits.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +
> +#include <selinux/selinux.h>
> +#include <selinux/context.h>	/* for context-mangling functions */
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
> +	capng_clear(CAPNG_SELECT_BOTH);
> +
> +	if (capng_lock() < 0) 
> +		return -1;
> +	/* Change uid */
> +	if (setresuid(uid, uid, uid)) {
> +		fprintf(stderr, "Error changing uid, aborting.\n");
> +		return -1;
> +	}
> +	return capng_apply(CAPNG_SELECT_BOTH);
> +}
> +
> +#define DEFAULT_PATH "/usr/bin:/bin"
> +#define TRUE 1
> +#define FALSE 0

TRUE/FALSE is never used anywhere. They can be removed.

> +
> +/**
> + * Take care of any signal setup
> + */
> +static int set_signal_handles(void)
> +{
> +	sigset_t empty;
> +
> +	/* Empty the signal mask in case someone is blocking a signal */
> +	if (sigemptyset(&empty)) {
> +		fprintf(stderr, "Unable to obtain empty signal set\n");
> +		return -1;
> +	}
> +
> +	(void)sigprocmask(SIG_SETMASK, &empty, NULL);
> +
> +	/* Terminate on SIGHUP. */
> +	if (signal(SIGHUP, SIG_DFL) == SIG_ERR) {
> +		perror("Unable to set SIGHUP handler");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +#define USAGE_STRING "USAGE: seunshare [ -t tmpdir ] [ -h homedir ] -- CONTEXT executable [args] "

This is kindof a weird place to define the usage string. Maybe move this
up near the other defines or down near main() where it is used.

> +
> +
> +
> +static int verify_mount(const char *mntdir, struct passwd *pwd) {
> +	struct stat sb;
> +	if (stat(mntdir, &sb) == -1) {
> +		perror("Invalid mount point");
> +		return -1;
> +	}
> +	if (sb.st_uid != pwd->pw_uid) {
> +		errno = EPERM;
> +		syslog(LOG_AUTHPRIV | LOG_ALERT, "%s attempted to mount an invalid directory, %s", pwd->pw_name, mntdir);
> +		perror("Invalid mount point, reporting to administrator");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * This function checks to see if the shell is known in /etc/shells.
> + * If so, it returns 1. On error or illegal shell, it returns 0.
> + */

Why does this return 1 on success and 0 on failure? This is the opposite
behavior from the other functions.

> +static int verify_shell(const char *shell_name)
> +{
> +	int found = 0;
> +	const char *buf;
> +
> +	if (!(shell_name && shell_name[0]))
> +		return found;
> +
> +	while ((buf = getusershell()) != NULL) {
> +		/* ignore comments */
> +		if (*buf == '#')
> +			continue;
> +
> +		/* check the shell skipping newline char */
> +		if (!strcmp(shell_name, buf)) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +	endusershell();
> +	return found;
> +}
> +
> +int main(int argc, char **argv) {
> +	int rc;
> +	int status = -1;
> +
> +	security_context_t scontext;
> +
> +	int flag_index;		/* flag index in argv[] */
> +	int clflag;		/* holds codes for command line flags */
> +	char *tmpdir_s = NULL;	/* tmpdir spec'd by user in argv[] */
> +	char *homedir_s = NULL;	/* homedir spec'd by user in argv[] */
> +
> +	const struct option long_options[] = {
> +		{"homedir", 1, 0, 'h'},
> +		{"tmpdir", 1, 0, 't'},
> +		{NULL, 0, 0, 0}
> +	};
> +
> +	uid_t uid = getuid();
> +
> +	if (!uid) {
> +		fprintf(stderr, "Must not be root");

Why restrict this to non-root users only?

> +		return -1;
> +	}
> +
> +	struct passwd *pwd=getpwuid(uid);
> +	if (!pwd) {
> +		perror("getpwduid failed");
> +		return -1;
> +	}
> +
> +	if (verify_shell(pwd->pw_shell) == 0) {
> +		fprintf(stderr, "Error!  Shell is not valid.\n");
> +		return -1;
> +	}
> +
> +	while (1) {
> +		clflag = getopt_long(argc, argv, "h:t:", long_options,
> +				     &flag_index);
> +		if (clflag == -1)
> +			break;
> +
> +		switch (clflag) {
> +		case 't':
> +			tmpdir_s = optarg;
> +			if (verify_mount(tmpdir_s, pwd) < 0) return -1;
> +			break;
> +		case 'h':
> +			homedir_s = optarg;
> +			if (verify_mount(homedir_s, pwd) < 0) return -1;
> +			if (verify_mount(pwd->pw_dir, pwd) < 0) return -1;
> +			break;
> +		default:
> +			fprintf(stderr, "%s\n", USAGE_STRING);
> +			return -1;
> +		}
> +	}
> +
> +	if (! homedir_s && ! tmpdir_s) {
> +		fprintf(stderr, "Error: tmpdir and/or homedir required \n"
> +			"%s\n", USAGE_STRING);
> +		return -1;
> +	}
> +
> +	if (argc - optind < 2) {
> +		fprintf(stderr, "Error: executable required \n"

Should be "Error: context and executable required"

> +			"%s\n", USAGE_STRING);
> +		return -1;
> +	}
> +
> +	scontext = argv[optind++];
> +	
> +	if (set_signal_handles())
> +		return -1;
> +
> +        if (unshare(CLONE_NEWNS) < 0) {
> +		perror("Failed to unshare");
> +		return -1;
> +	}
> +
> +	if (homedir_s && mount(homedir_s, pwd->pw_dir, NULL, MS_BIND, NULL) < 0) {
> +		perror("Failed to mount HOMEDIR");
> +		return -1;
> +	}
> +
> +	if (homedir_s && verify_mount(pwd->pw_dir, pwd) < 0) 
> +		return -1;
> +
> +	if (tmpdir_s && mount(tmpdir_s, "/tmp", NULL, MS_BIND, NULL) < 0) {
> +		perror("Failed to mount /tmp");
> +		return -1;
> +	}
> +
> +	if (tmpdir_s && verify_mount("/tmp", pwd) < 0) 
> +		return -1;
> +
> +	if (drop_capabilities(uid)) {
> +		perror("Failed to drop all capabilities");
> +		return -1;
> +	}
> +
> +	int child = fork();

The error case of fork isn't checked, maybe it's not necessary, but it
would be nice to display an error message instead of silently failing.

> +	if (!child) {
> +		char *display=NULL;
> +		/* Construct a new environment */
> +		char *d = getenv("DISPLAY");
> +		if (d) {
> +			display =  strdup(d);
> +			if (!display) {
> +				perror("Out of memory");
> +				exit(-1);
> +			}
> +		}
> +
> +		if ((rc = clearenv())) {
> +			perror("Unable to clear environment");
> +			free(display);
> +			exit(-1);
> +		}
> +		
> +		if (setexeccon(scontext)) {
> +			fprintf(stderr, "Could not set exec context to %s.\n",
> +				scontext);
> +			free(display);
> +			exit(-1);
> +		}
> +
> +		if (display) 
> +			rc |= setenv("DISPLAY", display, 1);
> +		rc |= setenv("HOME", pwd->pw_dir, 1);
> +		rc |= setenv("SHELL", pwd->pw_shell, 1);
> +		rc |= setenv("USER", pwd->pw_name, 1);
> +		rc |= setenv("LOGNAME", pwd->pw_name, 1);
> +		rc |= setenv("PATH", DEFAULT_PATH, 1);
> +	
> +		if (chdir(pwd->pw_dir)) {
> +			perror("Failed to change dir to homedir");
> +			exit(-1);
> +		}
> +		setsid();
> +		execv(argv[optind], argv + optind);
> +		free(display);
> +		perror("execv");
> +		exit(-1);
> +	} else {
> +		waitpid(child, &status, 0);
> +	}
> +
> +	return status;
> +}
> diff --git a/policycoreutils/sandbox/test_sandbox.py b/policycoreutils/sandbox/test_sandbox.py
> new file mode 100644
> index 0000000..b3b7f64
> --- /dev/null
> +++ b/policycoreutils/sandbox/test_sandbox.py
> @@ -0,0 +1,98 @@
> +import unittest, os, shutil 
> +from tempfile import mkdtemp
> +from subprocess import Popen, PIPE
> +
> +class SandboxTests(unittest.TestCase):
> +    def assertDenied(self, err):
> +        self.assert_('Permission denied' in err,
> +                     '"Permission denied" not found in %r' % err)
> +    def assertNotFound(self, err):
> +        self.assert_('not found' in err,
> +                     '"not found" not found in %r' % err)
> +
> +    def assertFailure(self, status):
> +        self.assert_(status != 0,
> +                     '"Succeeded when it should have failed')
> +
> +    def assertSuccess(self, status, err):
> +        self.assert_(status == 0,
> +                     '"Sandbox should have succeeded for this test %r' %  err)
> +
> +    def test_simple_success(self):
> +        "Verify that we can read file descriptors handed to sandbox"
> +        p1 = Popen(['cat', '/etc/passwd'], stdout = PIPE)
> +        p2 = Popen(['sandbox', 'grep', 'root'], stdin = p1.stdout, stdout=PIPE)
> +        out, err = p2.communicate()
> +        self.assert_('root' in out)
> +
> +    def test_cant_kill(self):
> +        "Verify that we cannot send kill signal in the sandbox"
> +        pid = os.getpid()
> +        p = Popen(['sandbox', 'kill', '-HUP', str(pid)], stdout=PIPE, stderr=PIPE)
> +        out, err = p.communicate()
> +        self.assertDenied(err)
> +
> +    def test_cant_ping(self):
> +        "Verify that we can't ping within the sandbox"
> +        p = Popen(['sandbox', 'ping', '-c 1 ', '127.0.0.1'], stdout=PIPE, stderr=PIPE)
> +        out, err = p.communicate()
> +        self.assertDenied(err)
> +    
> +    def test_cant_mkdir(self):
> +        "Verify that we can't mkdir within the sandbox"
> +        p = Popen(['sandbox', 'mkdir', '~/test'], stdout=PIPE, stderr=PIPE)
> +        out, err = p.communicate()
> +        self.assertFailure(p.returncode)
> +
> +    def test_cant_list_homedir(self):
> +        "Verify that we can't list homedir within the sandbox"
> +        p = Popen(['sandbox', 'ls', '~'], stdout=PIPE, stderr=PIPE)
> +        out, err = p.communicate()
> +        self.assertFailure(p.returncode)
> +
> +    def test_cant_send_mail(self):
> +        "Verify that we can't send mail within the sandbox"
> +        p = Popen(['sandbox', 'mail'], stdout=PIPE, stderr=PIPE)
> +        out, err = p.communicate()
> +        self.assertDenied(err)
> +    
> +    def test_cant_sudo(self):
> +        "Verify that we can't run sudo within the sandbox"
> +        p = Popen(['sandbox', 'sudo'], stdout=PIPE, stderr=PIPE)
> +        out, err = p.communicate()
> +        self.assertFailure(p.returncode)
> +    
> +    def test_mount(self):
> +        "Verify that we mount a file system"
> +        p = Popen(['sandbox', '-M', 'id'], stdout=PIPE, stderr=PIPE)
> +        out, err = p.communicate()
> +        self.assertSuccess(p.returncode, err)
> +    
> +    def test_set_level(self):
> +        "Verify that we set level a file system"
> +        p = Popen(['sandbox', '-l', 's0', 'id'], stdout=PIPE, stderr=PIPE)
> +        out, err = p.communicate()
> +        self.assertSuccess(p.returncode, err)
> +    
> +    def test_homedir(self):
> +        "Verify that we set homedir a file system"
> +        homedir = mkdtemp(dir=".", prefix=".sandbox_test")
> +        p = Popen(['sandbox', '-H', homedir, '-M', 'id'], stdout=PIPE, stderr=PIPE)
> +        out, err = p.communicate()
> +        shutil.rmtree(homedir)
> +        self.assertSuccess(p.returncode, err)
> +    
> +    def test_tmpdir(self):
> +        "Verify that we set tmpdir a file system"
> +        tmpdir = mkdtemp(dir="/tmp", prefix=".sandbox_test")
> +        p = Popen(['sandbox', '-T', tmpdir, '-M', 'id'], stdout=PIPE, stderr=PIPE)
> +        out, err = p.communicate()
> +        shutil.rmtree(tmpdir)
> +        self.assertSuccess(p.returncode, err)
> +    
> +if __name__ == "__main__":
> +    import selinux
> +    if selinux.security_getenforce() == 1:
> +        unittest.main()
> +    else:
> +        print "SELinux must be in enforcing mode for this test"


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
