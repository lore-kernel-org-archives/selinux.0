Subject: Re: Patch to allow semanage to set boolean values and translate
	booleans via policy.xml
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <472B817D.3030400@redhat.com>
References: <472B817D.3030400@redhat.com>
Content-Type: text/plain
Date: Fri, 09 Nov 2007 11:25:39 -0500
Message-Id: <1194625539.624.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-11-02 at 15:58 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Also added translations of booleans to command line.
> 
> > /usr/sbin/semanage boolean -l  | grep nfs_export
> > nfs_export_all_rw              -> off   Allow nfs to be exported read/write.
> > nfs_export_all_ro              -> on    Allow nfs to be exported read only
> > sh-3.2# /usr/sbin/semanage boolean -l  | grep nfs
> > xen_use_nfs                    -> off   Allow xen to manage nfs files
> > use_nfs_home_dirs              -> on    Support NFS home directories
> > allow_ftpd_use_nfs             -> off   Allow ftp servers to use nfs used for public file transfer services.
> > cdrecord_read_content          -> off   Allow cdrecord to read various content. nfs, samba, removable devices, user temp and untrusted content files
> > httpd_use_nfs                  -> off   Allow httpd to read nfs files
> > samba_share_nfs                -> off   Allow samba to export NFS volumes.
> > mail_read_content              -> off   Allow email client to various content. nfs, samba, removable devices, user temp and untrusted content files
> > allow_nfsd_anon_write          -> off   Allow nfs servers to modify public files used for public file transfer services.
> > nfs_export_all_rw              -> off   Allow nfs to be exported read/write.
> > nfs_export_all_ro              -> on    Allow nfs to be exported read only
> 
> 
> This time with the patch.  :^)

Offhand, the only problem I see it that semanage boolean -l then fails
if /usr/share/selinux/devel/policy.xml doesn't exist, rather than just
falling back to displaying the untranslated booleans.

Also, is /usr/share/selinux/devel/policy.xml created by upstream
refpolicy or is it Fedora-specific?


> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.7 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iD8DBQFHK4F9rlYvE4MpobMRAr9eAJwNWFoe0+i7P2exSWAZRKb6ZNzUEgCgsymy
> IRTVHeA8aa8boNYY9MTi/lA=
> =UWlf
> -----END PGP SIGNATURE-----
> plain text document attachment (diff)
> diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-2.0.31/semanage/semanage
> --- nsapolicycoreutils/semanage/semanage	2007-10-05 13:09:53.000000000 -0400
> +++ policycoreutils-2.0.31/semanage/semanage	2007-11-02 15:50:54.000000000 -0400
> @@ -1,5 +1,5 @@
>  #! /usr/bin/python -E
> -# Copyright (C) 2005 Red Hat 
> +# Copyright (C) 2005, 2006, 2007 Red Hat 
>  # see file 'COPYING' for use and warranty information
>  #
>  # semanage is a tool for managing SELinux configuration files
> @@ -115,7 +115,7 @@
>  		valid_option["translation"] = []
>  		valid_option["translation"] += valid_everyone + [ '-T', '--trans' ] 
>  		valid_option["boolean"] = []
> -		valid_option["boolean"] += valid_everyone 
> +		valid_option["boolean"] += valid_everyone + [ '--on', "--off", "-1", "-0" ] 
>  		return valid_option
>  
>  	#
> @@ -135,7 +135,7 @@
>  		seuser = ""
>  		prefix = ""
>  		heading=1
> -
> +                value=0
>  		add = 0
>  		modify = 0
>  		delete = 0
> @@ -154,7 +154,7 @@
>  		args = sys.argv[2:]
>  
>  		gopts, cmds = getopt.getopt(args,
> -					    'adf:lhmnp:s:CDR:L:r:t:T:P:S:',
> +					    '01adf:lhmnp:s:CDR:L:r:t:T:P:S:',
>  					    ['add',
>  					     'delete',
>  					     'deleteall',
> @@ -164,6 +164,8 @@
>  					     'modify',
>  					     'noheading',
>  					     'localist',
> +                                             'off', 
> +                                             'on', 
>  					     'proto=',
>  					     'seuser=',
>  					     'store=',
> @@ -242,6 +244,11 @@
>  			if o == "-T" or o == "--trans":
>  				setrans = a
>  
> +                        if o == "--on" or o == "-1":
> +                               value = 1
> +                        if o == "-off" or o == "-0":
> +                               value = 0
> +
>  		if object == "login":
>  			OBJECT = seobject.loginRecords(store)
>  
> diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-2.0.31/semanage/seobject.py
> --- nsapolicycoreutils/semanage/seobject.py	2007-10-07 21:46:43.000000000 -0400
> +++ policycoreutils-2.0.31/semanage/seobject.py	2007-11-02 15:51:27.000000000 -0400
> @@ -1,5 +1,5 @@
>  #! /usr/bin/python -E
> -# Copyright (C) 2005 Red Hat 
> +# Copyright (C) 2005, 2006, 2007 Red Hat 
>  # see file 'COPYING' for use and warranty information
>  #
>  # semanage is a tool for managing SELinux configuration files
> @@ -1095,7 +1092,13 @@
>  
>                  return con
>                 
> +        def validate(self, target):
> +               if target == "" or target.find("\n") >= 0:
> +                      raise ValueError(_("Invalid file specification"))
> +                      
>  	def add(self, target, type, ftype = "", serange = "", seuser = "system_u"):
> +                self.validate(target)
> +
>  		if is_mls_enabled == 1:
>                         serange = untranslate(serange)
>  			
> @@ -1154,6 +1157,7 @@
>  	def modify(self, target, setype, ftype, serange, seuser):
>  		if serange == "" and setype == "" and seuser == "":
>  			raise ValueError(_("Requires setype, serange or seuser"))
> +                self.validate(target)
>  
>  		(rc,k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
>  		if rc < 0:
> @@ -1303,9 +1307,35 @@
>  			else:
>  				print "%-50s %-18s <<None>>" % (fcon[0], fcon[1])
>  				
> +import sys, os
> +import re
> +import xml.etree.ElementTree
> +
>  class booleanRecords(semanageRecords):
> +
>  	def __init__(self, store = ""):
>  		semanageRecords.__init__(self, store)
> +                self.dict={}
> +
> +                tree=xml.etree.ElementTree.parse("/usr/share/selinux/devel/policy.xml")
> +                for l in  tree.findall("layer"):
> +                       for m in  l.findall("module"):
> +                              for b in  m.findall("tunable"):
> +                                     desc = b.find("desc").find("p").text.strip("\n")
> +                                     desc = re.sub("\n", " ", desc)
> +                                     self.dict[b.get('name')] = (m.get("name"), b.get('dftval'), desc)
> +                              for b in  m.findall("bool"):
> +                                     desc = b.find("desc").find("p").text.strip("\n")
> +                                     desc = re.sub("\n", " ", desc)
> +                                     self.dict[b.get('name')] = (m.get("name"), b.get('dftval'), desc)
> +                for i in  tree.findall("bool"):
> +                       desc = i.find("desc").find("p").text.strip("\n")
> +                       desc = re.sub("\n", " ", desc)
> +                       self.dict[i.get('name')] = ("Global", i.get('dftval'), desc)
> +                for i in  tree.findall("tunable"):
> +                       desc = i.find("desc").find("p").text.strip("\n")
> +                       desc = re.sub("\n", " ", desc)
> +                       self.dict[i.get('name')] = ("Global", i.get('dftval'), desc)
>  
>  	def modify(self, name, value = ""):
>  		if value == "":
> @@ -1328,11 +1358,14 @@
>  		if value != "":
>  			nvalue = int(value)
>  			semanage_bool_set_value(b, nvalue)
> +                else:
> +                       raise ValueError(_("You must specify a value"))
>  
>  		rc = semanage_begin_transaction(self.sh)
>  		if rc < 0:
>  			raise ValueError(_("Could not start semanage transaction"))
>  
> +                rc = semanage_bool_set_active(self.sh, k, b)
>  		rc = semanage_bool_modify_local(self.sh, k, b)
>  		if rc < 0:
>  			raise ValueError(_("Could not modify boolean %s") % name)
> @@ -1416,11 +1449,19 @@
>  
>  		return ddict
>  			
> +        def get_desc(self, boolean):
> +               if boolean in self.dict:
> +                      return _(self.dict[boolean][2])
> +               else:
> +                      return boolean
> +
>  	def list(self, heading = 1, locallist = 0):
> +                on_off = (_("off"),_("on")) 
>  		if heading:
> -			print "%-50s %7s %7s %7s\n" % (_("SELinux boolean"), _("value"), _("pending"),  _("active") )
> +			print "%-40s %s\n" % (_("SELinux boolean"), _("Description"))
>  		ddict = self.get_all(locallist)
>  		keys = ddict.keys()
>  		for k in keys:
>  			if ddict[k]:
> -				print "%-50s %7d %7d %7d " % (k, ddict[k][0],ddict[k][1], ddict[k][2])
> +				print "%-30s -> %-5s %s" %  (k, on_off[ddict[k][2]], self.get_desc(k))
> +
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
