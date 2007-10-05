Subject: Re: policycoreutils patch for semanage/seobject.py
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4703B5CA.7040309@redhat.com>
References: <4703B5CA.7040309@redhat.com>
Content-Type: text/plain
Date: Fri, 05 Oct 2007 10:23:19 -0400
Message-Id: <1191594199.891.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-10-03 at 11:31 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Patch implements handling of booleans via semanage
> 
> Adds display of local list.  So you can either show all booleans,
> fcontext, ports or just your local modifications.
> 
> Implements a store command, so you can use semanage to manage
> alternative stores.
> 
> Implements deleteall so you can remove all local customizations.
> 
> Add support for <<none>> as a context type for fcontext.

Thanks, merged, although I think we will want to eventually revisit the
division of labor between semanage and libsemanage for
interpreting/handling <<none>>.

Also, it seems like the deleteall method should be implemented for all
relevant objects - seems useful for fcontext as well as boolean.

When would use you use setsebool -P vs. semanage boolean -m?

> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.7 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iD8DBQFHA7XKrlYvE4MpobMRAuNZAKCTSMSk8mpCB8NZNQVgEqi9wMyDNgCfe5YT
> 35iafRHQHQ6lN6Kp2k1hlVA=
> =L9Yk
> -----END PGP SIGNATURE-----
> plain text document attachment (diff)
> diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-2.0.27/semanage/semanage
> --- nsapolicycoreutils/semanage/semanage	2007-08-23 16:52:26.000000000 -0400
> +++ policycoreutils-2.0.27/semanage/semanage	2007-10-03 11:25:41.000000000 -0400
> @@ -48,13 +48,14 @@
>  
>  	def usage(message = ""):
>  		print _('\
> -semanage {login|user|port|interface|fcontext|translation} -l [-n] \n\
> +semanage {boolean|login|user|port|interface|fcontext|translation} -{l|D} [-n] \n\
>  semanage login -{a|d|m} [-sr] login_name\n\
>  semanage user -{a|d|m} [-LrRP] selinux_name\n\
>  semanage port -{a|d|m} [-tr] [ -p protocol ] port | port_range\n\
>  semanage interface -{a|d|m} [-tr] interface_spec\n\
>  semanage fcontext -{a|d|m} [-frst] file_spec\n\
>  semanage translation -{a|d|m} [-T] level\n\n\
> +semanage boolean -{d|m} boolean\n\n\
>  \
>  Primary Options:\n\
>  \
> @@ -62,10 +63,12 @@
>  	-d, --delete     Delete a OBJECT record NAME\n\
>  	-m, --modify     Modify a OBJECT record NAME\n\
>  	-l, --list       List the OBJECTS\n\n\
> +	-C, --locallist  List OBJECTS local customizations\n\n\
> +	-D, --deleteall  Remove all OBJECTS local customizations\n\
>  \
>  	-h, --help       Display this message\n\
> -	-n, --noheading  Do not print heading when listing OBJECTS\n\n\
> -\
> +	-n, --noheading  Do not print heading when listing OBJECTS\n\
> +        -S, --store      Select and alternate SELinux store to manage\n\n\
>  Object-specific Options (see above):\n\
>  	-f, --ftype      File Type of OBJECT \n\
>  		"" (all files) \n\
> @@ -98,7 +101,7 @@
>  
>  	def get_options():
>  		valid_option={}
> -		valid_everyone=[ '-a', '--add', '-d', '--delete', '-m', '--modify', '-l', '--list', '-h', '--help', '-n', '--noheading' ]
> +		valid_everyone=[ '-a', '--add', '-d', '--delete', '-m', '--modify', '-l', '--list', '-h', '--help', '-n', '--noheading', '-C', '--locallist', '-D', '--deleteall', '-S', '--store' ]
>  		valid_option["login"] = []
>  		valid_option["login"] += valid_everyone + [ '-s', '--seuser', '-r', '--range']
>  		valid_option["user"] = []
> @@ -111,6 +114,8 @@
>  		valid_option["fcontext"] += valid_everyone + [ '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
>  		valid_option["translation"] = []
>  		valid_option["translation"] += valid_everyone + [ '-T', '--trans' ] 
> +		valid_option["boolean"] = []
> +		valid_option["boolean"] += valid_everyone 
>  		return valid_option
>  
>  	#
> @@ -134,7 +139,10 @@
>  		add = 0
>  		modify = 0
>  		delete = 0
> +		deleteall = 0
>  		list = 0
> +		locallist = 0
> +                store = ""
>  		if len(sys.argv) < 3:
>  			usage(_("Requires 2 or more arguments"))
>  			
> @@ -146,16 +154,19 @@
>  		args = sys.argv[2:]
>  
>  		gopts, cmds = getopt.getopt(args,
> -					    'adf:lhmnp:s:R:L:r:t:T:P:',
> +					    'adf:lhmnp:s:CDR:L:r:t:T:P:S:',
>  					    ['add',
>  					     'delete',
> +					     'deleteall',
>  					     'ftype=',
>  					     'help',
>  					     'list', 
>  					     'modify',
>  					     'noheading',
> +					     'localist',
>  					     'proto=',
>  					     'seuser=',
> +					     'store=',
>  					     'range=',
>  					     'level=',
>  					     'roles=',
> @@ -177,6 +188,10 @@
>  				if modify or add:
>  					usage()
>  				delete = 1
> +			if o == "-D"  or o == "--deleteall":
> +				if modify:
> +                                       usage()
> +				deleteall = 1
>  			if o == "-f"  or o == "--ftype":
>  				ftype=a
>  			if o == "-h" or o == "--help":
> @@ -185,11 +200,17 @@
>  			if o == "-n" or o == "--noheading":
>  				heading=0
>  
> +			if o == "-C" or o == "--locallist":
> +				locallist=1
> +
>  			if o == "-m"or o == "--modify":
>  				if delete or add:
>  					usage()
>  				modify = 1
>  				
> +			if o == "-S" or o == '--store':
> +				store = a
> +
>  			if o == "-r" or o == '--range':
>  				if is_mls_enabled == 0:
>  					errorExit(_("range not supported on Non MLS machines"))
> @@ -222,31 +243,38 @@
>  				setrans = a
>  
>  		if object == "login":
> -			OBJECT = seobject.loginRecords()
> +			OBJECT = seobject.loginRecords(store)
>  
>  		if object == "user":
> -			OBJECT = seobject.seluserRecords()
> +			OBJECT = seobject.seluserRecords(store)
>  
>  		if object == "port":
> -			OBJECT = seobject.portRecords()
> +			OBJECT = seobject.portRecords(store)
>  		
>  		if object == "interface":
> -			OBJECT = seobject.interfaceRecords()
> +			OBJECT = seobject.interfaceRecords(store)
>  		
>  		if object == "fcontext":
> -			OBJECT = seobject.fcontextRecords()
> +			OBJECT = seobject.fcontextRecords(store)
> +		
> +		if object == "boolean":
> +			OBJECT = seobject.booleanRecords(store)
>  		
>  		if object == "translation":
>  			OBJECT = seobject.setransRecords()
>  		
>  		if list:
> -			OBJECT.list(heading)
> +			OBJECT.list(heading, locallist)
> +			sys.exit(0);
> +			
> +		if deleteall:
> +			OBJECT.deleteall()
>  			sys.exit(0);
>  			
>  		if len(cmds) != 1:
>  			usage()
> -
> -		target = cmds[0]
> +                        
> +                target = cmds[0]
>  
>  		if add:
>  			if object == "login":
> @@ -274,6 +302,9 @@
>  			sys.exit(0);
>  			
>  		if modify:
> +			if object == "boolean":
> +				OBJECT.modify(target, value)
> +
>  			if object == "login":
>  				OBJECT.modify(target, seuser, serange)
>  
> diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-2.0.27/semanage/seobject.py
> --- nsapolicycoreutils/semanage/seobject.py	2007-07-16 14:20:41.000000000 -0400
> +++ policycoreutils-2.0.27/semanage/seobject.py	2007-10-03 11:24:40.000000000 -0400
> @@ -170,7 +170,7 @@
>  			rec += "%s=%s\n" %  (k, self.ddict[k])
>  		return rec
>  	
> -	def list(self,heading = 1):
> +	def list(self,heading = 1, locallist = 0):
>  		if heading:
>  			print "\n%-25s %s\n" % (_("Level"), _("Translation"))
>  		keys = self.ddict.keys()
> @@ -210,13 +210,17 @@
>  		os.write(fd, self.out())
>  		os.close(fd)
>  		os.rename(newfilename, self.filename)
> +                os.system("/sbin/service mcstrans reload > /dev/null")
>                  
>  class semanageRecords:
> -	def __init__(self):
> +	def __init__(self, store):
>  		self.sh = semanage_handle_create()
>  		if not self.sh:
>  		       raise ValueError(_("Could not create semanage handle"))
>  		
> +                if store != "":
> +                       semanage_select_store(self.sh, store, SEMANAGE_CON_DIRECT);
> +
>  		self.semanaged = semanage_is_managed(self.sh)
>  
>  		if not self.semanaged:
> @@ -234,8 +238,8 @@
>  			raise ValueError(_("Could not establish semanage connection"))
>  
>  class loginRecords(semanageRecords):
> -	def __init__(self):
> -		semanageRecords.__init__(self)
> +	def __init__(self, store = ""):
> +		semanageRecords.__init__(self, store)
>  
>  	def add(self, name, sename, serange):
>  		if is_mls_enabled == 1:
> @@ -389,10 +393,12 @@
>  		mylog.log(1,"delete SELinux user mapping", name);
>  		semanage_seuser_key_free(k)
>  
> -		
> -	def get_all(self):
> +	def get_all(self, locallist = 0):
>  		ddict = {}
> -		(rc, self.ulist) = semanage_seuser_list(self.sh)
> +                if locallist:
> +                       (rc, self.ulist) = semanage_seuser_list_local(self.sh)
> +                else:
> +                       (rc, self.ulist) = semanage_seuser_list(self.sh)
>  		if rc < 0:
>  			raise ValueError(_("Could not list login mappings"))
>  
> @@ -401,8 +407,8 @@
>  			ddict[name] = (semanage_seuser_get_sename(u), semanage_seuser_get_mlsrange(u))
>  		return ddict
>  
> -	def list(self,heading = 1):
> -		ddict = self.get_all()
> +	def list(self,heading = 1, locallist = 0):
> +		ddict = self.get_all(locallist)
>  		keys = ddict.keys()
>  		keys.sort()
>  		if is_mls_enabled == 1:
> @@ -417,8 +423,8 @@
>  				print "%-25s %-25s" % (k, ddict[k][0])
>  
>  class seluserRecords(semanageRecords):
> -	def __init__(self):
> -		semanageRecords.__init__(self)
> +	def __init__(self, store = ""):
> +		semanageRecords.__init__(self, store)
>  
>  	def add(self, name, roles, selevel, serange, prefix):
>  		if is_mls_enabled == 1:
> @@ -601,9 +607,12 @@
>  		mylog.log(1,"delete SELinux user record", name)
>  		semanage_user_key_free(k)		
>  
> -	def get_all(self):
> +	def get_all(self, locallist = 0):
>  		ddict = {}
> -		(rc, self.ulist) = semanage_user_list(self.sh)
> +                if locallist:
> +                       (rc, self.ulist) = semanage_user_list_local(self.sh)
> +                else:
> +                       (rc, self.ulist) = semanage_user_list(self.sh)
>  		if rc < 0:
>  			raise ValueError(_("Could not list SELinux users"))
>  
> @@ -618,8 +627,8 @@
>  
>  		return ddict
>  
> -	def list(self, heading = 1):
> -		ddict = self.get_all()
> +	def list(self, heading = 1, locallist = 0):
> +		ddict = self.get_all(locallist)
>  		keys = ddict.keys()
>  		keys.sort()
>  		if is_mls_enabled == 1:
> @@ -635,8 +644,8 @@
>  				print "%-15s %s" % (k, ddict[k][3])
>  
>  class portRecords(semanageRecords):
> -	def __init__(self):
> -		semanageRecords.__init__(self)
> +	def __init__(self, store = ""):
> +		semanageRecords.__init__(self, store)
>  
>  	def __genkey(self, port, proto):
>  		if proto == "tcp":
> @@ -795,9 +804,12 @@
>  		
>  		semanage_port_key_free(k)
>  
> -	def get_all(self):
> +	def get_all(self, locallist = 0):
>  		ddict = {}
> -		(rc, self.plist) = semanage_port_list(self.sh)
> +                if locallist:
> +                       (rc, self.plist) = semanage_port_list_local(self.sh)
> +                else:
> +                       (rc, self.plist) = semanage_port_list(self.sh)
>  		if rc < 0:
>  			raise ValueError(_("Could not list ports"))
>  
> @@ -814,9 +826,12 @@
>  			ddict[(low, high)] = (ctype, proto_str, level)
>  		return ddict
>  
> -	def get_all_by_type(self):
> +	def get_all_by_type(self, locallist = 0):
>  		ddict = {}
> -		(rc, self.plist) = semanage_port_list(self.sh)
> +                if locallist:
> +                       (rc, self.plist) = semanage_port_list_local(self.sh)
> +                else:
> +                       (rc, self.plist) = semanage_port_list(self.sh)
>  		if rc < 0:
>  			raise ValueError(_("Could not list ports"))
>  
> @@ -837,10 +852,10 @@
>  				ddict[(ctype,proto_str)].append("%d-%d" % (low, high))
>  		return ddict
>  
> -	def list(self, heading = 1):
> +	def list(self, heading = 1, locallist = 0):
>  		if heading:
>  			print "%-30s %-8s %s\n" % (_("SELinux Port Type"), _("Proto"), _("Port Number"))
> -		ddict = self.get_all_by_type()
> +		ddict = self.get_all_by_type(locallist)
>  		keys = ddict.keys()
>  		keys.sort()
>  		for i in keys:
> @@ -851,8 +866,8 @@
>  			print rec
>  
>  class interfaceRecords(semanageRecords):
> -	def __init__(self):
> -		semanageRecords.__init__(self)
> +	def __init__(self, store = ""):
> +		semanageRecords.__init__(self, store)
>  
>  	def add(self, interface, serange, ctype):
>  		if is_mls_enabled == 1:
> @@ -995,9 +1010,12 @@
>  		
>  		semanage_iface_key_free(k)
>  
> -	def get_all(self):
> +	def get_all(self, locallist = 0):
>  		ddict = {}
> -		(rc, self.ilist) = semanage_iface_list(self.sh)
> +                if locallist:
> +                       (rc, self.ilist) = semanage_iface_list_local(self.sh)
> +                else:
> +                       (rc, self.ilist) = semanage_iface_list(self.sh)
>  		if rc < 0:
>  			raise ValueError(_("Could not list interfaces"))
>  
> @@ -1007,10 +1025,10 @@
>  
>  		return ddict
>  			
> -	def list(self, heading = 1):
> +	def list(self, heading = 1, locallist = 0):
>  		if heading:
>  			print "%-30s %s\n" % (_("SELinux Interface"), _("Context"))
> -		ddict = self.get_all()
> +		ddict = self.get_all(locallist)
>  		keys = ddict.keys()
>  		keys.sort()
>  		if is_mls_enabled:
> @@ -1021,17 +1039,34 @@
>  				print "%-30s %s:%s:%s " % (k,ddict[k][0], ddict[k][1],ddict[k][2])
>  			
>  class fcontextRecords(semanageRecords):
> -	def __init__(self):
> -		semanageRecords.__init__(self)
> -		
> -	def add(self, target, type, ftype = "", serange = "", seuser = "system_u"):
> +	def __init__(self, store = ""):
> +		semanageRecords.__init__(self, store)
> +
> +        def createcon(self, target, seuser = "system_u"):
> +                (rc, con) = semanage_context_create(self.sh)
> +                if rc < 0:
> +                       raise ValueError(_("Could not create context for %s") % target)
>  		if seuser == "":
>  			seuser = "system_u"
> +
> +                rc = semanage_context_set_user(self.sh, con, seuser)
> +                if rc < 0:
> +                       raise ValueError(_("Could not set user in file context for %s") % target)
> +		
> +                rc = semanage_context_set_role(self.sh, con, "object_r")
> +                if rc < 0:
> +                       raise ValueError(_("Could not set role in file context for %s") % target)
> +
>  		if is_mls_enabled == 1:
> -			if serange == "":
> -				serange = "s0"
> -			else:
> -				serange = untranslate(serange)
> +                       rc = semanage_context_set_mls(self.sh, con, "s0")
> +                       if rc < 0:
> +                              raise ValueError(_("Could not set mls fields in file context for %s") % target)
> +
> +                return con
> +               
> +	def add(self, target, type, ftype = "", serange = "", seuser = "system_u"):
> +		if is_mls_enabled == 1:
> +                       serange = untranslate(serange)
>  			
>  		if type == "":
>  			raise ValueError(_("SELinux Type is required"))
> @@ -1051,33 +1086,23 @@
>  			raise ValueError(_("Could not create file context for %s") % target)
>  		
>  		rc = semanage_fcontext_set_expr(self.sh, fcontext, target)
> -		(rc, con) = semanage_context_create(self.sh)
> -		if rc < 0:
> -			raise ValueError(_("Could not create context for %s") % target)
> -
> -		rc = semanage_context_set_user(self.sh, con, seuser)
> -		if rc < 0:
> -			raise ValueError(_("Could not set user in file context for %s") % target)
> -		
> -		rc = semanage_context_set_role(self.sh, con, "object_r")
> -		if rc < 0:
> -			raise ValueError(_("Could not set role in file context for %s") % target)
> +                if type != "<<none>>":
> +                       con = self.createcon(target, seuser)
>  
> -		rc = semanage_context_set_type(self.sh, con, type)
> -		if rc < 0:
> -			raise ValueError(_("Could not set type in file context for %s") % target)
> -
> -		if serange != "":
> -			rc = semanage_context_set_mls(self.sh, con, serange)
> -			if rc < 0:
> -				raise ValueError(_("Could not set mls fields in file context for %s") % target)
> +                       rc = semanage_context_set_type(self.sh, con, type)
> +                       if rc < 0:
> +                              raise ValueError(_("Could not set type in file context for %s") % target)
> +
> +                       if serange != "":
> +                              rc = semanage_context_set_mls(self.sh, con, serange)
> +                              if rc < 0:
> +                                     raise ValueError(_("Could not set mls fields in file context for %s") % target)
> +                       rc = semanage_fcontext_set_con(self.sh, fcontext, con)
> +                       if rc < 0:
> +                              raise ValueError(_("Could not set file context for %s") % target)
>  
>  		semanage_fcontext_set_type(fcontext, file_types[ftype])
>  
> -		rc = semanage_fcontext_set_con(self.sh, fcontext, con)
> -		if rc < 0:
> -			raise ValueError(_("Could not set file context for %s") % target)
> -
>  		rc = semanage_begin_transaction(self.sh)
>  		if rc < 0:
>  			raise ValueError(_("Could not start semanage transaction"))
> @@ -1090,7 +1115,8 @@
>  		if rc < 0:
>  			raise ValueError(_("Could not add file context for %s") % target)
>  
> -		semanage_context_free(con)
> +                if type != "<<none>>":
> +                       semanage_context_free(con)
>  		semanage_fcontext_key_free(k)
>  		semanage_fcontext_free(fcontext)
>  
> @@ -1112,16 +1138,29 @@
>  		if rc < 0:
>  			raise ValueError(_("Could not query file context for %s") % target)
>  
> -		con = semanage_fcontext_get_con(fcontext)
> +                if setype != "<<none>>":
> +                       con = semanage_fcontext_get_con(fcontext)
>  			
> -		if serange != "":
> -			semanage_context_set_mls(self.sh, con, untranslate(serange))
> -		if seuser != "":
> -			semanage_context_set_user(self.sh, con, seuser)	
> -		if setype != "":
> -			semanage_context_set_type(self.sh, con, setype)
> -
> -		rc = semanage_begin_transaction(self.sh)
> +                       if con == None:
> +                              con = self.createcon(target)
> +                              
> +                       if serange != "":
> +                              semanage_context_set_mls(self.sh, con, untranslate(serange))
> +                       if seuser != "":
> +                              semanage_context_set_user(self.sh, con, seuser)
> +                              
> +                       if setype != "":
> +                              semanage_context_set_type(self.sh, con, setype)
> +
> +                       rc = semanage_fcontext_set_con(self.sh, fcontext, con)
> +                       if rc < 0:
> +                              raise ValueError(_("Could not set file context for %s") % target)
> +                else:
> +                       rc = semanage_fcontext_set_con(self.sh, fcontext, None)
> +                       if rc < 0:
> +                              raise ValueError(_("Could not set file context for %s") % target)
> +                       
> +                rc = semanage_begin_transaction(self.sh)
>  		if rc < 0:
>  			raise ValueError(_("Could not start semanage transaction"))
>  
> @@ -1167,17 +1206,20 @@
>  
>  		semanage_fcontext_key_free(k)		
>  
> -	def get_all(self):
> +	def get_all(self, locallist = 0):
>  		l = []
> -		(rc, self.flist) = semanage_fcontext_list(self.sh)
> -		if rc < 0:
> -			raise ValueError(_("Could not list file contexts"))
> -
> -		(rc, fclocal) = semanage_fcontext_list_local(self.sh)
> -		if rc < 0:
> -			raise ValueError(_("Could not list local file contexts"))
> +                if locallist:
> +                       (rc, self.flist) = semanage_fcontext_list_local(self.sh)
> +                else:
> +                       (rc, self.flist) = semanage_fcontext_list(self.sh)
> +                       if rc < 0:
> +                              raise ValueError(_("Could not list file contexts"))
> +
> +                       (rc, fclocal) = semanage_fcontext_list_local(self.sh)
> +                       if rc < 0:
> +                              raise ValueError(_("Could not list local file contexts"))
>  
> -		self.flist += fclocal
> +                       self.flist += fclocal
>  
>  		for fcontext in self.flist:
>  			expr = semanage_fcontext_get_expr(fcontext)
> @@ -1191,10 +1233,10 @@
>  
>  		return l
>  			
> -	def list(self, heading = 1):
> +	def list(self, heading = 1, locallist = 0 ):
>  		if heading:
>  			print "%-50s %-18s %s\n" % (_("SELinux fcontext"), _("type"), _("Context"))
> -		fcon_list = self.get_all()
> +		fcon_list = self.get_all(locallist)
>  		for fcon in fcon_list:
>  			if len(fcon) > 3:
>  				if is_mls_enabled:
> @@ -1205,9 +1247,9 @@
>  				print "%-50s %-18s <<None>>" % (fcon[0], fcon[1])
>  				
>  class booleanRecords(semanageRecords):
> -	def __init__(self):
> -		semanageRecords.__init__(self)
> -		
> +	def __init__(self, store = ""):
> +		semanageRecords.__init__(self, store)
> +
>  	def modify(self, name, value = ""):
>  		if value == "":
>  			raise ValueError(_("Requires value"))
> @@ -1266,34 +1308,62 @@
>  		if rc < 0:
>  			raise ValueError(_("Could not start semanage transaction"))
>  
> -		rc = semanage_fcontext_del_local(self.sh, k)
> +		rc = semanage_bool_del_local(self.sh, k)
>  		if rc < 0:
>  			raise ValueError(_("Could not delete boolean %s") % name)
>  	
>  		rc = semanage_commit(self.sh)
>  		if rc < 0:
>  			raise ValueError(_("Could not delete boolean %s") % name)
> -		
>  		semanage_bool_key_free(k)
>  
> -	def get_all(self):
> +	def deleteall(self):
> +		(rc, self.blist) = semanage_bool_list_local(self.sh)
> +		if rc < 0:
> +			raise ValueError(_("Could not list booleans"))
> +
> +		rc = semanage_begin_transaction(self.sh)
> +		if rc < 0:
> +			raise ValueError(_("Could not start semanage transaction"))
> +
> +		for boolean in self.blist:
> +                       name = semanage_bool_get_name(boolean)
> +                       (rc,k) = semanage_bool_key_create(self.sh, name)
> +                       if rc < 0:
> +                              raise ValueError(_("Could not create a key for %s") % name)
> +
> +                       rc = semanage_bool_del_local(self.sh, k)
> +                       if rc < 0:
> +                              raise ValueError(_("Could not delete boolean %s") % name)
> +                       semanage_bool_key_free(k)
> +	
> +		rc = semanage_commit(self.sh)
> +		if rc < 0:
> +			raise ValueError(_("Could not delete boolean %s") % name)
> +	def get_all(self, locallist = 0):
>  		ddict = {}
> -		(rc, self.blist) = semanage_bool_list(self.sh)
> +                if locallist:
> +                       (rc, self.blist) = semanage_bool_list_local(self.sh)
> +                else:
> +                       (rc, self.blist) = semanage_bool_list(self.sh)
>  		if rc < 0:
>  			raise ValueError(_("Could not list booleans"))
>  
>  		for boolean in self.blist:
> -			name = semanage_bool_get_name(boolean)
> -			value = semanage_bool_get_value(boolean)
> -			ddict[name] = value
> +                       value = []
> +                       name = semanage_bool_get_name(boolean)
> +                       value.append(semanage_bool_get_value(boolean))
> +                       value.append(selinux.security_get_boolean_pending(name))
> +                       value.append(selinux.security_get_boolean_active(name))
> +                       ddict[name] = value
>  
>  		return ddict
>  			
> -	def list(self, heading = 1):
> +	def list(self, heading = 1, locallist = 0):
>  		if heading:
> -			print "%-50s %-18s\n" % (_("SELinux boolean"), _("value"))
> -		ddict = self.get_all()
> +			print "%-50s %7s %7s %7s\n" % (_("SELinux boolean"), _("value"), _("pending"),  _("active") )
> +		ddict = self.get_all(locallist)
>  		keys = ddict.keys()
>  		for k in keys:
>  			if ddict[k]:
> -				print "%-50s %-18s " % (k[0], ddict[k][0])
> +				print "%-50s %7d %7d %7d " % (k, ddict[k][0],ddict[k][1], ddict[k][2])
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
