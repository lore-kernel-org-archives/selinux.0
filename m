Subject: Re: policycoreutils patches
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <46B22681.2030107@redhat.com>
References: <46B22681.2030107@redhat.com>
Content-Type: text/plain
Date: Thu, 16 Aug 2007 13:21:57 -0400
Message-Id: <1187284917.909.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 14:46 -0400, Daniel J Walsh wrote:
> nsapolicycoreutils_audit2allow_Makefile - Move sepolgen-iggen to sbindir.

Karl, is moving sepolgen-ifgen fine with you?
Dan - every time we move something like this, we risk breaking existing
packages (like .spec file invocation of it), scripts, etc, so let's
minimize please.

> nsapolicycoreutils_run_init_Makefile Change permissions to 755 instead 
> of 555, Some audit scripts are reporting problems with 755 permissions.

Ok by me, but I don't quite understand why it matters.

> nsapolicycoreutils_scripts_chcat - Missing : after else commands

Hmm...so chcat has been broken for a while.  Is it actually being used?
Worth retaining (upstream)?

> nsapolicycoreutils_scripts_fixfiles - Certain patterns were not 
> expanding.  So relabel was not complete also fix error handling

This seems pretty fragile.

> nsapolicycoreutils_scripts_genhomedircon - Speed up processing by a 
> factor of 10 by precompiling regex

Obsoleted by the libsemanage genhomedircon support, I think, once it is
merged.

> nsapolicycoreutils_semanage_semanage - Fix handling of internationalization
> nsapolicycoreutils_semanage_seobject.py - Allow users to specify <<none>>

Is this the way we want to handle this?  Layering seems broken.

> 
> plain text document attachment
> (nsapolicycoreutils_audit2allow_Makefile)
> --- nsapolicycoreutils/audit2allow/Makefile	2007-07-16 14:20:41.000000000 -0400
> +++ policycoreutils-2.0.22/audit2allow/Makefile	2007-07-31 15:45:57.000000000 -0400
> @@ -1,6 +1,7 @@
>  # Installation directories.
>  PREFIX ?= ${DESTDIR}/usr
>  BINDIR ?= $(PREFIX)/bin
> +SBINDIR ?= $(PREFIX)/sbin
>  LIBDIR ?= $(PREFIX)/lib
>  MANDIR ?= $(PREFIX)/share/man
>  LOCALEDIR ?= /usr/share/locale
> @@ -10,7 +11,7 @@
>  install: all
>  	-mkdir -p $(BINDIR)
>  	install -m 755 audit2allow $(BINDIR)
> -	install -m 755 sepolgen-ifgen $(BINDIR)
> +	install -m 755 sepolgen-ifgen $(SBINDIR)
>  	-mkdir -p $(MANDIR)/man1
>  	install -m 644 audit2allow.1 $(MANDIR)/man1/
>  
> plain text document attachment (nsapolicycoreutils_run_init_Makefile)
> --- nsapolicycoreutils/run_init/Makefile	2007-07-16 14:20:41.000000000 -0400
> +++ policycoreutils-2.0.22/run_init/Makefile	2007-07-31 15:45:57.000000000 -0400
> @@ -34,8 +34,8 @@
>  install: all
>  	test -d $(SBINDIR)      || install -m 755 -d $(SBINDIR)
>  	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
> -	install -m 555 run_init $(SBINDIR)
> -	install -m 555 open_init_pty $(SBINDIR)
> +	install -m 755 run_init $(SBINDIR)
> +	install -m 755 open_init_pty $(SBINDIR)
>  	install -m 644 run_init.8 $(MANDIR)/man8/
>  	install -m 644 open_init_pty.8 $(MANDIR)/man8/
>  ifeq (${PAMH}, /usr/include/security/pam_appl.h)
> plain text document attachment (nsapolicycoreutils_scripts_chcat)
> --- nsapolicycoreutils/scripts/chcat	2007-07-16 14:20:41.000000000 -0400
> +++ policycoreutils-2.0.22/scripts/chcat	2007-07-31 15:45:57.000000000 -0400
> @@ -77,7 +77,7 @@
>              
>          if len(cats) > 0:
>              new_serange = "%s-%s:%s" % (serange[0], top[0], ",".join(cats))
> -        else
> +        else:
>              new_serange = "%s-%s" % (serange[0], top[0])
>              
>          if add_ind:
> @@ -155,7 +155,7 @@
>  
>          if len(cats) > 0:
>              new_serange = "%s-%s:%s" % (serange[0], top[0], ",".join(cats))
> -        else
> +        else:
>              new_serange = "%s-%s" % (serange[0], top[0])
>              
>          if add_ind:
> plain text document attachment (nsapolicycoreutils_scripts_fixfiles)
> --- nsapolicycoreutils/scripts/fixfiles	2007-07-16 14:20:41.000000000 -0400
> +++ policycoreutils-2.0.22/scripts/fixfiles	2007-07-31 15:45:57.000000000 -0400
> @@ -88,7 +88,7 @@
>                    esac; \
>                 fi; \
>              done | \
> -	while read pattern ; do find $pattern \
> +	while read pattern ; do sh -c "find $pattern" \
>  		      ! \( -fstype ext2 -o -fstype ext3 -o -fstype jfs -o -fstype xfs \) -prune  -o \
>  		      \( -wholename /home -o -wholename /root -o -wholename /tmp -wholename /dev \) -prune -o -print; \
>  		      done 2> /dev/null | \
> @@ -108,6 +108,7 @@
>  
>  rpmlist() {
>  rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
> +[ ${PIPESTATUS[0]} != 0 ] && echo "$1 not found" >/dev/stderr
>  }
>  
>  # 
> plain text document attachment
> (nsapolicycoreutils_scripts_genhomedircon)
> --- nsapolicycoreutils/scripts/genhomedircon	2007-07-16 14:20:41.000000000 -0400
> +++ policycoreutils-2.0.22/scripts/genhomedircon	2007-08-01 16:03:41.000000000 -0400
> @@ -139,7 +139,22 @@
>  		self.default_user = "user_u"
>  		self.default_prefix = "user"
>  		self.users = self.getUsers()
> +		fd = open(self.getFileContextFile())
> +		self.fclines=[]
> +		for i in fd.readlines():
> +		    try:
> +			    regex = i.split()[0]
> +			    #match a trailing .+
> +			    regex = re.sub("\.+$", "", regex)
> +			    regex = re.sub("\.\*$", "", regex)
> +			    regex = re.sub("\(\/\.\*\)\?", "", regex)
> +			    regex = regex + "/*$"
> +			    self.fclines.append(re.compile(regex))
> +		    except:
> +			    continue
>  
> +		fd.close()
> +		
>  	def getFileContextDir(self):
>  		return self.selinuxdir+self.type+self.filecontextdir
>  
> @@ -289,20 +304,9 @@
>  		return ret+"\n"
>  
>  	def checkExists(self, home):
> -		fd = open(self.getFileContextFile())
> -		for i in  fd.readlines():
> -                    if len(i) == 0:
> -			    continue
> +		for i in self.fclines:
>  		    try:
> -			    regex = i.split()[0]
> -			    #match a trailing .+
> -			    regex = re.sub("\.+$", "", regex)
> -			    regex = re.sub("\.\*$", "", regex)
> -			    #strip a (/.*)? which matches anything trailing to a /*$ which matches trailing /'s
> -			    
> -			    regex = re.sub("\(\/\.\*\)\?", "", regex)
> -			    regex = regex + "/*$"
> -			    if re.search(regex,home, 0):
> +			    if i.match(home):
>  				    return 1
>  		    except:
>  			    continue
> plain text document attachment (nsapolicycoreutils_semanage_semanage)
> --- nsapolicycoreutils/semanage/semanage	2007-07-16 14:20:41.000000000 -0400
> +++ policycoreutils-2.0.22/semanage/semanage	2007-07-31 15:45:57.000000000 -0400
> @@ -34,7 +34,10 @@
>  sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.__stdout__, 'replace')
>  
>  try:
> -       gettext.install(PROGNAME, localedir="/usr/share/locale", unicode=1)
> +       gettext.install(PROGNAME,
> +                       localedir="/usr/share/locale",
> +                       unicode=False,
> +                       codeset = 'utf-8')
>  except IOError:
>         import __builtin__
>         __builtin__.__dict__['_'] = unicode
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
