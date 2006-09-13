Subject: Re: Latest policycoreutils.patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4508572C.408@tresys.com>
References: <450845E8.2090709@redhat.com>  <4508572C.408@tresys.com>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 15:20:40 -0400
Message-Id: <1158175240.15278.161.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-13 at 15:08 -0400, Joshua Brindle wrote:
> Daniel J Walsh wrote:
> > This patch include simple man page fixes and changes the way python 
> > scripts run to make the somewhat more secure.
> >
> > Also fixes some missing getopt flags.
> >
> > ------------------------------------------------------------------------
> >
> > diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/audit2allow/audit2allow policycoreutils-1.30.28/audit2allow/audit2allow
> > --- nsapolicycoreutils/audit2allow/audit2allow	2006-08-28 16:58:19.000000000 -0400
> > +++ policycoreutils-1.30.28/audit2allow/audit2allow	2006-09-08 09:12:12.000000000 -0400
> > @@ -1,4 +1,4 @@
> > -#! /usr/bin/env python
> > +#! /usr/bin/python -E
> >  # Copyright (C) 2005 Red Hat 
> >  # see file 'COPYING' for use and warranty information
> >  #
> > diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/audit2allow/avc.py policycoreutils-1.30.28/audit2allow/avc.py
> > --- nsapolicycoreutils/audit2allow/avc.py	2006-08-28 16:58:19.000000000 -0400
> > +++ policycoreutils-1.30.28/audit2allow/avc.py	2006-09-08 09:12:12.000000000 -0400
> > @@ -1,4 +1,4 @@
> > -#! /usr/bin/env python
> > +#! /usr/bin/python -E
> >  # Copyright (C) 2006 Red Hat 
> >  # see file 'COPYING' for use and warranty information
> >  #
> > diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/restorecond/restorecond.init policycoreutils-1.30.28/restorecond/restorecond.init
> > --- nsapolicycoreutils/restorecond/restorecond.init	2006-08-28 16:58:19.000000000 -0400
> > +++ policycoreutils-1.30.28/restorecond/restorecond.init	2006-09-08 09:12:12.000000000 -0400
> > @@ -3,9 +3,9 @@
> >  # restorecond:		Daemo used to maintain path file context
> >  #
> >  # chkconfig:	2345 10 90
> > -# description:	restorecond uses inotify to look for creation of new files listed in the 
> > -#               /etc/selinux/POLICYTYPE/restorefiles.conf file, and sets the correct security 
> > -#               context.
> > +# description:	restorecond uses inotify to look for creation of new files \
> > +# listed in the /etc/selinux/restorecond.conf file, and restores the \
> > +# correct security context.
> >  #
> >  
> >  # Source function library.
> > diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/scripts/chcat policycoreutils-1.30.28/scripts/chcat
> > --- nsapolicycoreutils/scripts/chcat	2006-08-28 16:58:19.000000000 -0400
> > +++ policycoreutils-1.30.28/scripts/chcat	2006-09-08 09:12:12.000000000 -0400
> > @@ -1,4 +1,4 @@
> > -#! /usr/bin/env python
> > +#! /usr/bin/python -E
> >  # Copyright (C) 2005 Red Hat 
> >  # see file 'COPYING' for use and warranty information
> >  #
> > diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-1.30.28/scripts/genhomedircon
> > --- nsapolicycoreutils/scripts/genhomedircon	2006-08-28 16:58:19.000000000 -0400
> > +++ policycoreutils-1.30.28/scripts/genhomedircon	2006-09-13 07:32:44.000000000 -0400
> > @@ -1,4 +1,4 @@
> > -#! /usr/bin/python
> > +#! /usr/bin/python -E
> >  # Copyright (C) 2004 Tresys Technology, LLC
> >  # see file 'COPYING' for use and warranty information
> >  #
> > @@ -356,7 +356,7 @@
> >  	usepwd = 1
> >  	directory = "/etc/selinux"
> >  	type = None
> > -	gopts, cmds = getopt.getopt(sys.argv[1:], 'nd:t:', ['help',
> > +	gopts, cmds = getopt.getopt(sys.argv[1:], 'hnd:t:', ['help',
> >  						'type=',
> >  						'nopasswd',
> >  						'dir='])
> > @@ -367,7 +367,7 @@
> >  			usepwd = 0
> >  		if o == '--dir'  or o == "-d":
> >  			directory = a
> > -		if o == '--help':
> > +		if o == '--help'  or o == "-h":
> >  			usage()
> >  
> >  
> > diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/secon/Makefile policycoreutils-1.30.28/secon/Makefile
> > --- nsapolicycoreutils/secon/Makefile	2006-08-28 16:58:20.000000000 -0400
> > +++ policycoreutils-1.30.28/secon/Makefile	2006-09-08 09:16:28.000000000 -0400
> > @@ -20,8 +20,8 @@
> >  install: all
> >  	install -m 755 secon $(BINDIR);
> >  
> > -#	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
> > -#	install -m 644 ../man/secon.1 $(MANDIR)/man1
> > +	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
> > +	install -m 644 secon.1 $(MANDIR)/man1
> >  
> >  relabel:
> >  	/sbin/restorecon $(BINDIR)/secon
> > diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-1.30.28/semanage/semanage
> > --- nsapolicycoreutils/semanage/semanage	2006-08-28 16:58:18.000000000 -0400
> > +++ policycoreutils-1.30.28/semanage/semanage	2006-09-08 09:12:12.000000000 -0400
> > @@ -1,4 +1,4 @@
> > -#! /usr/bin/env python
> > +#! /usr/bin/python -E
> >  # Copyright (C) 2005 Red Hat 
> >  # see file 'COPYING' for use and warranty information
> >  #
> > diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/semanage/semanage.8 policycoreutils-1.30.28/semanage/semanage.8
> > --- nsapolicycoreutils/semanage/semanage.8	2006-08-28 16:58:18.000000000 -0400
> > +++ policycoreutils-1.30.28/semanage/semanage.8	2006-09-11 16:02:25.000000000 -0400
> > @@ -88,9 +88,9 @@
> >  # View SELinux user mappings
> >  $ semanage user -l
> >  # Allow joe to login as staff_u
> > -$ semanage login -a -s staff_u
> > +$ semanage login -a -s staff_u joe
> >  # Add file-context for everything under /web (used by restorecon)
> > -$ semanage fcontext -a -t httpd_sys_content_t '/web(/.*)?'
> > +$ semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
> >  # Allow Apache to listen on port 81
> >  $ semanage port -a -t http_port_t -p tcp 81
> >  .fi
> > diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-1.30.28/semanage/seobject.py
> > --- nsapolicycoreutils/semanage/seobject.py	2006-08-28 16:58:18.000000000 -0400
> > +++ policycoreutils-1.30.28/semanage/seobject.py	2006-09-08 09:12:12.000000000 -0400
> > @@ -1,4 +1,4 @@
> > -#! /usr/bin/env python
> > +#! /usr/bin/python -E
> >  # Copyright (C) 2005 Red Hat 
> >  # see file 'COPYING' for use and warranty information
> >  #
> > diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/semodule_link/semodule_link.8 policycoreutils-1.30.28/semodule_link/semodule_link.8
> > --- nsapolicycoreutils/semodule_link/semodule_link.8	2006-08-28 16:58:19.000000000 -0400
> > +++ policycoreutils-1.30.28/semodule_link/semodule_link.8	2006-09-13 07:41:52.000000000 -0400
> > @@ -3,7 +3,7 @@
> >  semodule_link \- Link SELinux policy module packages together
> >  
> >  .SH SYNOPSIS
> > -.B semodule_link [-V] [-o outfile] basemodpkg modpkg1 [modpkg2]...
> > +.B semodule_link [-Vv] [-o outfile] basemodpkg modpkg1 [modpkg2]...
> >  .br
> >  .SH DESCRIPTION
> >  .PP
> > @@ -17,9 +17,12 @@
> >  .SH "OPTIONS"
> >  .TP
> >  .B \-V
> > +show version
> > +.TP
> > +.B \-v
> >  verbose mode
> >  .TP
> > -.B \-o \-\-outfile <output file> 
> > +.B \-o <output file> 
> >  Linked policy module package generated by this tool.
> >  
> >  
> > diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/semodule_package/semodule_package.8 policycoreutils-1.30.28/semodule_package/semodule_package.8
> > --- nsapolicycoreutils/semodule_package/semodule_package.8	2006-08-28 16:58:19.000000000 -0400
> > +++ policycoreutils-1.30.28/semodule_package/semodule_package.8	2006-09-13 07:46:26.000000000 -0400
> > @@ -28,11 +28,20 @@
> >  .B \-o \-\-outfile <output file> 
> >  Policy module package file generated by this tool.
> >  .TP
> > +.B  \-s \-\-seuser <seuser file>
> > +seuser file to be included in the package.
> > +.TP
> > +.B  \-u \-\-user_extra <user extra file>
> > +user_extra file to be included in the package.
> > +.TP
> >  .B  \-m \-\-module <Module file>
> >  Policy module file to be included in the package.
> >  .TP
> >  .B  \-f \-\-fc	<File context file>
> >  File contexts file for the module (optional).
> > +.TP
> > +.B  \-n \-\-nc <netfilter context file>
> > +netfilter context file to be included in the package.
> >  
> >  .SH SEE ALSO
> >  .B checkmodule(8), semodule(8)
> > diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/setfiles/setfiles.8 policycoreutils-1.30.28/setfiles/setfiles.8
> > --- nsapolicycoreutils/setfiles/setfiles.8	2006-08-28 16:58:22.000000000 -0400
> > +++ policycoreutils-1.30.28/setfiles/setfiles.8	2006-09-08 09:12:12.000000000 -0400
> > @@ -4,7 +4,7 @@
> >  
> >  .SH "SYNOPSIS"
> >  .B setfiles
> > -.I [\-c policy ] [\-d] [\-l] [\-n] [\-e directory ] [\-o filename ] [\-q] [\-s] [\-v] [\-vv] [\-W] [\-F] spec_file pathname...
> > +.I [\-c policy ] [\-d] [\-l] [\-n] [\-e directory ] [\-o ] [\-q] [\-s] [\-v] [\-vv] [\-W] [\-F] spec_file pathname...
> >  .SH "DESCRIPTION"
> >  This manual page describes the
> >  .BR setfiles
> > @@ -44,8 +44,8 @@
> >  .B \-F
> >  Force reset of context to match file_context for customizable files
> >  .TP 
> > -.B \-o filename
> > -save list of files with incorrect context in filename.
> > +.B \-o 
> > +Print list of files with incorrect context.
> >  .TP 
> >  .B \-s
> >  take a list of files from standard input instead of using a pathname on the
> >   
> Acked-By: Joshua Brindle <jbrindle@tresys.com>

Except for the last hunk (which changes interface and needs to be
separately discussed with the actual code change):
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Note that ideally we'd really like to split the patches further in the
future, one per logical change (e.g. python header changes are one
logical change, updating all man pages to reflect current usage is
another, modifying the usage in the code and updating the man page to
reflect that change is another, etc).

But this can be merged aside from the last hunk, IMHO.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
