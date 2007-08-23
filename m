Subject: Re: [PATCH] selinuxfs to globally disable dontaudit rules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <method@manicmethod.com>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <46CB4E14.3020809@redhat.com>
References: <1186696737.20393.10.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0708091525410.30691@us.intercode.com.au>
	 <46BBAE00.7050600@manicmethod.com>  <46BBBDDF.2000307@manicmethod.com>
	 <1187285317.909.36.camel@moss-spartans.epoch.ncsc.mil>
	 <46C48D2B.3010504@manicmethod.com>
	 <1187286476.909.51.camel@moss-spartans.epoch.ncsc.mil>
	 <46C48F01.40101@manicmethod.com>
	 <1187287475.909.69.camel@moss-spartans.epoch.ncsc.mil>
	 <46C4A4E7.8050902@manicmethod.com>  <46CB4E14.3020809@redhat.com>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 11:07:04 -0400
Message-Id: <1187881624.1451.502.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-21 at 16:41 -0400, Daniel J Walsh wrote:
> I would like to get these patches into policycoreutils.
> 
> 
> Submitted before, but here we go.

In the future, please post one patch per message.

> Change run_tty and open_init_pty to 755 instead of 555.  Some audit 
> tools are reporting this as a problem.  And I see no real value of 555. 
> for these to.
> 
> Simple bugfix for chcat
> 
> Fixes to make sure fixfiles reports errors and handles strange regexes.
> 
> Speed enhancement for genhomedircon to only compile regex's once.

I merged these to trunk, and the chcat bug fix to stable, but then the
libsemanage genhomedircon patch series removes genhomedircon altogether.
So you can extract the genhomedircon script with this enhancement from
the history, but you won't see any genhomedircon script at all on the
head.

> I reverted sepolgen-ifgen from sbin to bin, but I doubt many/anyone will 
> run it as non root, but I guess you never no.

I actually dislike having things in sbin because normal user paths don't
include it (even after su, unless you do a 'su -').  Regardless, the
real issue is providing stability - changing paths after it has already
been out there for a little while is harmful.

> plain text document attachment (diff)
> diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/run_init/Makefile policycoreutils-2.0.22/run_init/Makefile
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
> diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/scripts/chcat policycoreutils-2.0.22/scripts/chcat
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
> diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-2.0.22/scripts/fixfiles
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
> diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-2.0.22/scripts/genhomedircon
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
> diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-2.0.22/semanage/semanage
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
>  			
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
