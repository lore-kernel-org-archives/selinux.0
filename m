Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r46IqunI007383
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2013 14:52:58 -0400
Message-ID: <5187FBF7.3090703@redhat.com>
Date: Mon, 06 May 2013 14:52:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov
Subject: Re: What provides _policy?
References: <20130501135544.GA21525@siphos.be> <20130503173926.GA22935@siphos.be> <5187DFB7.9050700@redhat.com> <20130506183828.GA26604@siphos.be>
In-Reply-To: <20130506183828.GA26604@siphos.be>
Content-Type: multipart/mixed;
 boundary="------------000400090808060503030607"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000400090808060503030607
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/06/2013 02:38 PM, Sven Vermeulen wrote:
> On Mon, May 06, 2013 at 12:52:07PM -0400, Daniel J Walsh wrote:
>>> However, I'm having a hard time debugging why I get the following:
>>> 
>>> File "/usr/bin/sepolicy-2.7", line 63, in __call__ from
>>> sepolicy.network import domains File 
>>> "/usr/lib64/python2.7/site-packages/sepolicy/network.py", line 44, in 
>>> <module> portrecs, portrecsbynum = _gen_port_dict() File 
>>> "/usr/lib64/python2.7/site-packages/sepolicy/network.py", line 31, in 
>>> _gen_port_dict for i in info(sepolicy.PORT): File 
>>> "/usr/lib64/python2.7/site-packages/sepolicy/__init__.py", line 182,
>>> in info dict_list = _policy.info(setype, name) RuntimeError: No such
>>> file or directory
>>> 
>>> What could this error be about? I get this when I try "sepolicy
>>> communicate -s portage_t".
>>> 
>> Where are you executing this?
> 
> If you mean distribution: Gentoo Hardened. If you mean location: anywhere
> (like in /root). If you mean context: I'm staff_u:sysadm_r:sysadm_t at the
> time of executing.
> 
> I get the same stacktrace with "sepolicy transition".
> 
> I notice that there is some port specific stuff in the stack trace; 
> "semanage port -l" works ok here.
> 
> Wkr, Sven Vermeulen
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
> 
You might have found a bug in the current upstream,  we don't have this
problem in Fedora.

I have attached the current fedora-sepolicy patch.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGH+/cACgkQrlYvE4MpobMwSgCfebsEWOfLhXoRi12gIwmAToij
XQgAmQFg/0J2lXvWaBNmSWnYDdv+2Bie
=vUg0
-----END PGP SIGNATURE-----

--------------000400090808060503030607
Content-Type: text/x-patch;
 name="fedora-sepolicy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fedora-sepolicy.patch"

diff --git a/policycoreutils/sepolicy/Makefile b/policycoreutils/sepolicy/Makefile
index 11b534f..ae064c4 100644
--- a/policycoreutils/sepolicy/Makefile
+++ b/policycoreutils/sepolicy/Makefile
@@ -7,7 +7,7 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 PYTHON ?= /usr/bin/python
-BASHCOMPLETIONDIR ?= $(DESTDIR)/etc/bash_completion.d/
+BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
 SHAREDIR ?= $(PREFIX)/share/sandbox
 override CFLAGS = $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="policycoreutils" -Wall -Werror -Wextra -W  -DSHARED -shared
 
@@ -22,11 +22,15 @@ clean:
 	$(PYTHON) setup.py clean
 	-rm -rf build *~ \#* *pyc .#*
 
+sepolgen:
+	ln -sf sepolicy sepolgen
+
 install:
 	$(PYTHON) setup.py install `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
 	[ -d $(BINDIR) ] || mkdir -p $(BINDIR)
 	install -m 755 sepolicy.py $(BINDIR)/sepolicy
+	(cd $(BINDIR); ln -sf sepolicy sepolgen)
 	-mkdir -p $(MANDIR)/man8
 	install -m 644 *.8 $(MANDIR)/man8
 	-mkdir -p $(BASHCOMPLETIONDIR)
-	install -m 644 $(BASHCOMPLETIONS) $(BASHCOMPLETIONDIR)
+	install -m 644 $(BASHCOMPLETIONS) $(BASHCOMPLETIONDIR)/sepolicy
diff --git a/policycoreutils/sepolicy/info.c b/policycoreutils/sepolicy/info.c
index 65458e6..b6244be 100644
--- a/policycoreutils/sepolicy/info.c
+++ b/policycoreutils/sepolicy/info.c
@@ -78,6 +78,58 @@ static int py_insert_bool(PyObject *dict, const char *name, int value)
 }
 
 /**
+ * Get the alias of a type.
+ *
+ * @param fp Reference to a file to which to get type information
+ * @param type_datum Reference to sepol type_datum
+ * @param policydb Reference to a policy
+ * attributes
+ */
+static PyObject* get_type_aliases(const qpol_type_t * type_datum, const apol_policy_t * policydb)
+{
+	qpol_iterator_t *iter = NULL;
+	size_t alias_size;
+	unsigned char isattr, isalias;
+	const char *type_name = NULL;
+	const char *alias_name;
+	int error = 0;
+	qpol_policy_t *q = apol_policy_get_qpol(policydb);
+	PyObject *list = PyList_New(0);
+	if (!list) goto err;
+
+	if (qpol_type_get_name(q, type_datum, &type_name))
+		goto cleanup;
+	if (qpol_type_get_isattr(q, type_datum, &isattr))
+		goto cleanup;
+	if (qpol_type_get_isalias(q, type_datum, &isalias))
+		goto cleanup;
+
+	if (qpol_type_get_alias_iter(q, type_datum, &iter))
+		goto cleanup;
+	if (qpol_iterator_get_size(iter, &alias_size))
+		goto cleanup;
+	if (alias_size >  0) {
+		for (; !qpol_iterator_end(iter); qpol_iterator_next(iter)) {
+			if (qpol_iterator_get_item(iter, (void **)&alias_name))
+				goto err;
+			if (py_append_string(list, alias_name))
+				goto err;
+		}
+	}
+	goto cleanup;
+
+err:
+	error = errno;
+	PyErr_SetString(PyExc_RuntimeError,strerror(errno));
+	py_decref(list); list = NULL;
+
+cleanup:
+	qpol_iterator_destroy(&iter);
+	errno = error;
+	return list;
+}
+
+/**
  * Gets a textual representation of an attribute, and 
  * all of that attribute's types.
  *
@@ -295,6 +347,11 @@ static PyObject* get_type( const qpol_type_t * type_datum, const apol_policy_t *
 		Py_DECREF(obj);
 		if (rt) goto err;
 	}
+
+	obj = get_type_aliases(type_datum, policydb);
+	rt = py_insert_obj(dict, "aliases", obj);
+	Py_DECREF(obj);
+	if (rt) goto err;
 	goto cleanup;
 
 err:
diff --git a/policycoreutils/sepolicy/policy.c b/policycoreutils/sepolicy/policy.c
index 4eca22d..eeee0ab 100644
--- a/policycoreutils/sepolicy/policy.c
+++ b/policycoreutils/sepolicy/policy.c
@@ -66,7 +66,6 @@ PyObject *wrap_policy(PyObject *UNUSED(self), PyObject *args){
     }
     apol_vector_destroy(&mod_paths);
     
-    policy_load_options |= QPOL_POLICY_OPTION_MATCH_SYSTEM;
     policy = apol_policy_create_from_policy_path(pol_path, policy_load_options, NULL, NULL);
     apol_policy_path_destroy(&pol_path);
     if (!policy) {
diff --git a/policycoreutils/sepolicy/sepolgen.8 b/policycoreutils/sepolicy/sepolgen.8
new file mode 100644
index 0000000..3ecf3eb
--- /dev/null
+++ b/policycoreutils/sepolicy/sepolgen.8
@@ -0,0 +1 @@
+.so man8/sepolicy-generate.8
diff --git a/policycoreutils/sepolicy/sepolicy-bash-completion.sh b/policycoreutils/sepolicy/sepolicy-bash-completion.sh
index 82fea52..6efd463 100644
--- a/policycoreutils/sepolicy/sepolicy-bash-completion.sh
+++ b/policycoreutils/sepolicy/sepolicy-bash-completion.sh
@@ -1,6 +1,6 @@
 # This file is part of systemd.
 #
-# Copyright 2012 Dan Walsh
+# Copyright 2012-2013 Dan Walsh
 #
 # systemd is free software; you can redistribute it and/or modify it
 # under the terms of the GNU General Public License as published by
@@ -80,8 +80,8 @@ _sepolicy () {
                [booleans]='-h --help -p --path -a -all -b --boolean'
                [communicate]='-h --help -s --source -t --target -c --class -S --sourceaccess -T --targetaccess'
                [generate]='-a --admin --admin_user --application --cgi --confined_admin --customize  -d --domain --dbus --desktop_user -h --help --inetd --init -n --name --newtype -p --path --sandbox -T --test --term_user -u --user -w --writepath --x_user'
-               [interface]='-h --help -a --list_admin" -u --list_user -l --list'
-               [manpage]='-h --help -p --path -a -all -o --os -d --domain -w --web'
+               [interface]='-h --help -a --list_admin -c --compile -i --interface -l --list -u --list_user -u --list_user -v --verbose'
+               [manpage]='-h --help -p --path -a -all -o --os -d --domain -w --web -r --root'
                [network]='-h --help -d --domain -l --list -p --port -t --type '
                [transition]='-h --help -s --source -t --target'
         )
@@ -130,9 +130,6 @@ _sepolicy () {
                 COMPREPLY=( $( compgen -d -- "$cur") )
                 compopt -o filenames
                 return 0
-            elif [ "$prev" = "--type" -o "$prev" = "-t" ]; then
-                COMPREPLY=( $(compgen -W '0 1 2 3 4 5 6 7 8 9 10 11' -- "$cur") )
-                return 0
             elif [ "$prev" = "--domain" -o "$prev" = "-d" ]; then
                 COMPREPLY=( $(compgen -W "$( __get_all_domain_types ) " -- "$cur") )
                 return 0
@@ -140,7 +137,7 @@ _sepolicy () {
                 COMPREPLY=( $(compgen -W "$( __get_all_admin_interaces ) " -- "$cur") )
                 return 0
             elif [ "$prev" = "--user" -o "$prev" = "-u" ]; then
-                COMPREPLY=( $(compgen -W "$( __get_all_users ) " -- "$cur") )
+                COMPREPLY=( $(compgen -W "$( __get_all_users )" -- "$cur") )
                 return 0
             elif [[ "$cur" == "$verb" || "$cur" == "" || "$cur" == -* ]]; then
                 COMPREPLY=( $(compgen -W '${OPTS[$verb]}' -- "$cur") )
@@ -156,6 +153,10 @@ _sepolicy () {
             if [ "$prev" = "-d" -o "$prev" = "--domain" ]; then
                 COMPREPLY=( $(compgen -W "$( __get_all_domains ) " -- "$cur") )
                 return 0
+            elif test "$prev" = "-r" || test "$prev" = "--root" ; then
+                COMPREPLY=( $( compgen -d -- "$cur") )
+                compopt -o filenames
+                return 0
             elif [ "$prev" = "-o" -o "$prev" = "--os" ]; then
                 return 0
             elif test "$prev" = "-p" || test "$prev" = "--path" ; then
@@ -167,11 +168,11 @@ _sepolicy () {
             return 0
         elif [ "$verb" = "network" ]; then
             if [ "$prev" = "-t" -o "$prev" = "--type" ]; then
-                COMPREPLY=( $(compgen -W "$( __get_all_port_types ) " -- "$cur") )
+                COMPREPLY=( $(compgen -W "$( __get_all_port_types )" -- "$cur") )
                 return 0
             fi
             if [ "$prev" = "-d" -o "$prev" = "--domain" ]; then
-                COMPREPLY=( $(compgen -W "$( __get_all_domain_types ) " -- "$cur") )
+                COMPREPLY=( $(compgen -W "$( __get_all_domain_types )" -- "$cur") )
                 return 0
             fi
             COMPREPLY=( $(compgen -W '${OPTS[$verb]}' -- "$cur") )
diff --git a/policycoreutils/sepolicy/sepolicy-generate.8 b/policycoreutils/sepolicy/sepolicy-generate.8
index fb84af6..c2fa601 100644
--- a/policycoreutils/sepolicy/sepolicy-generate.8
+++ b/policycoreutils/sepolicy/sepolicy-generate.8
@@ -8,12 +8,18 @@ sepolicy-generate \- Generate an initial SELinux policy module template.
 .B sepolicy generate [\-h] [\-d DOMAIN] [\-u USER] [\-w WRITE_PATH ] [\-a ADMIN_DOMAIN] [\-n NAME] [\-p PATH] [\-\-admin_user | \-\-application | \-\-cgi | \-\-confined_admin | \-\-customize | \-\-dbus | \-\-desktop_user | \-\-inetd | \-\-newtype | \-\-init | \-\-sandbox | \-\-term_user | \-\-x_user]
 
 .SH "DESCRIPTION"
-Use sepolicy generate to generate an SELinux policy Module.  sepolicy generate will generate 4 files.
+Use \fBsepolicy generate\fP to generate an SELinux policy Module.  \fBsepolicy generate\fP will create 5 files.
+
+If you specify a binary path, \fBsepolicy generate\fP will use the rpm payload of the binary along with \fBnm -D BINARY\fP to discover types and policy rules to generate these template files.
+
 
 .B Type Enforcing File NAME.te
 .br
 This file can be used to define all the types rules for a particular domain.
 
+.I Note:
+Policy generated by \fBsepolicy generate\fP will automatically add a permissive DOMAIN to your te file.  When you are satisfied that your policy works, you need to remove the permissive line from the te file to run your domain in enforcing mode.
+
 .B Interface File NAME.if
 .br
 This file defines the interfaces for the types generated in the te file, which can be used by other policy domains.
@@ -25,7 +31,7 @@ file paths to the types.  Tools like restorecon and RPM will use these paths to
 
 .B RPM Spec File NAME_selinux.spec
 .br
-This file is an RPM SPEC file that can be used to install the SELinux policy on to machines and setup the labeling. The spec file also installs the interface file and a man page describing the policy.  You can use sepolicy manpage -d NAME to generate the man page.
+This file is an RPM SPEC file that can be used to install the SELinux policy on to machines and setup the labeling. The spec file also installs the interface file and a man page describing the policy.  You can use \fBsepolicy manpage -d NAME\fP to generate the man page.
 
 .B Shell File NAME.sh
 .br
diff --git a/policycoreutils/sepolicy/sepolicy-interface.8 b/policycoreutils/sepolicy/sepolicy-interface.8
index 4fc9792..02c4c1a 100644
--- a/policycoreutils/sepolicy/sepolicy-interface.8
+++ b/policycoreutils/sepolicy/sepolicy-interface.8
@@ -5,7 +5,7 @@ sepolicy-interface \- Print interface information based on the installed SELinux
 .SH "SYNOPSIS"
 
 .br
-.B sepolicy interface [\-h] [\-a | \-u | \-l ]
+.B sepolicy interface  [\-h] [\-c] [\-v] [\-a | \-u | \-l | \-i INTERFACE [INTERFACE ... ]]
 
 .SH "DESCRIPTION"
 Use sepolicy interface to print interfaces information based on SELinux Policy.
@@ -15,14 +15,23 @@ Use sepolicy interface to print interfaces information based on SELinux Policy.
 .I                \-a, \-\-list_admin
 List all domains with admin interface
 .TP
+.I                \-c, \-\-compile
+Test compile of interfaces
+.TP
 .I                \-h, \-\-help       
 Display help message
 .TP
+.I                \-i, \-\-interface
+Interface(s) to be displayed
+.TP
 .I                \-l, \-\-list
 List all interfaces
 .TP
 .I                \-u, \-\-list_user
 List all domains with SELinux user role interface
+.TP
+.I                \-v, \-\-verbose
+Display extended information about the interface including parameters and desctiprion if available.
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/policycoreutils/sepolicy/sepolicy-manpage.8 b/policycoreutils/sepolicy/sepolicy-manpage.8
index b6abdf5..c05c943 100644
--- a/policycoreutils/sepolicy/sepolicy-manpage.8
+++ b/policycoreutils/sepolicy/sepolicy-manpage.8
@@ -5,7 +5,7 @@ sepolicy-manpage \- Generate a man page based on the installed SELinux Policy
 .SH "SYNOPSIS"
 
 .br
-.B sepolicy manpage [\-w] [\-h] [\-p PATH ]  [\-a | \-d ]
+.B sepolicy manpage [\-w] [\-h] [\-p PATH ] [\-r ROOTDIR ] [\-a | \-d ]
 
 .SH "DESCRIPTION"
 Use sepolicy manpage to generate manpages based on SELinux Policy.
@@ -24,6 +24,9 @@ Display help message
 .I                \-p, \-\-path
 Specify the directory to store the created man pages. (Default to /tmp)
 .TP
+.I                \-r, \-\-root
+Specify alternate root directory to generate man pages from. (Default to /)
+.TP
 .I                \-w, \-\-web
 Generate an additional HTML man pages for the specified domain(s).
 
diff --git a/policycoreutils/sepolicy/sepolicy.py b/policycoreutils/sepolicy/sepolicy.py
index b25d3b2..7ca5554 100755
--- a/policycoreutils/sepolicy/sepolicy.py
+++ b/policycoreutils/sepolicy/sepolicy.py
@@ -22,6 +22,8 @@
 #
 #
 import os, sys
+import selinux
+import sepolicy
 from sepolicy import get_os_version
 import argparse
 import gettext
@@ -37,6 +39,9 @@ except IOError:
     import __builtin__
     __builtin__.__dict__['_'] = unicode
 
+usage = "sepolicy generate [-h] [-n NAME] [-p PATH] [-w [WRITEPATHS [WRITEPATHS ...]]] ["
+usage_dict = {' --newtype':('-t [TYPES [TYPES ...]]',),' --customize':('-d DOMAIN','-a  ADMIN_DOMAIN',), ' --admin_user':('-a  ADMIN_DOMAIN',), ' --application':('COMMAND',), ' --cgi':('COMMAND',), ' --confined_admin':('-a  ADMIN_DOMAIN',), ' --dbus':('COMMAND',), ' --desktop_user':('',),' --inetd':('COMMAND',),' --init':('COMMAND',), ' --sandbox':('',), ' --term_user':('',), ' --x_user':('',)}
+
 class CheckPath(argparse.Action):
     def __call__(self, parser, namespace, values, option_string=None):
         if not os.path.exists(values):
@@ -45,7 +50,7 @@ class CheckPath(argparse.Action):
 
 class CheckType(argparse.Action):
     def __call__(self, parser, namespace, values, option_string=None):
-        from sepolicy.network import domains
+        domains = sepolicy.get_all_domains()
 
         if isinstance(values,str):
             setattr(namespace, self.dest, values)
@@ -58,9 +63,30 @@ class CheckType(argparse.Action):
                 newval.append(v)
             setattr(namespace, self.dest, newval)
 
+class CheckBoolean(argparse.Action):
+    def __call__(self, parser, namespace, values, option_string=None):
+        booleans = sepolicy.get_all_booleans()
+        newval = getattr(namespace, self.dest)
+        if not newval:
+            newval = []
+
+        if isinstance(values,str):
+            v = selinux.selinux_boolean_sub(values)
+            if v not in booleans:
+                raise ValueError("%s must be an SELinux process domain:\nValid domains: %s" % (v, ", ".join(booleans)))
+            newval.append(v)
+            setattr(namespace, self.dest, newval)
+        else:
+            for value in values:
+                v = selinux.selinux_boolean_sub(value)
+                if v not in booleans:
+                    raise ValueError("%s must be an SELinux boolean:\nValid boolean: %s" % (v, ", ".join(booleans)))
+                newval.append(v)
+            setattr(namespace, self.dest, newval)
+
 class CheckDomain(argparse.Action):
     def __call__(self, parser, namespace, values, option_string=None):
-        from sepolicy.network import domains
+        domains = sepolicy.get_all_domains()
 
         if isinstance(values,str):
             if values not in domains:
@@ -80,7 +106,6 @@ class CheckDomain(argparse.Action):
 all_classes = None
 class CheckClass(argparse.Action):
     def __call__(self, parser, namespace, values, option_string=None):
-        import sepolicy
         global all_classes
         if not all_classes:
                 all_classes = map(lambda x: x['name'], sepolicy.info(sepolicy.TCLASS))
@@ -114,7 +139,7 @@ class CheckPort(argparse.Action):
 
 class CheckPortType(argparse.Action):
     def __call__(self, parser, namespace, values, option_string=None):
-        from sepolicy.network import port_types
+        port_types = sepolicy.get_all_port_types()
         newval = getattr(namespace, self.dest)
         if not newval:
             newval = []
@@ -140,19 +165,40 @@ class CheckPolicyType(argparse.Action):
 
 class CheckUser(argparse.Action):
     def __call__(self, parser, namespace, value, option_string=None):
-        from sepolicy import get_all_users
         newval = getattr(namespace, self.dest)
         if not newval:
             newval = []
-        users = get_all_users()
+        users = sepolicy.get_all_users()
         if value not in users:
                 raise ValueError("%s must be an SELinux user:\nValid users: %s" % (value, ", ".join(users)))
         newval.append(value)
         setattr(namespace, self.dest, newval)
 
+class InterfaceInfo(argparse.Action):
+    def __call__(self, parser, namespace, values, option_string=None):
+	from sepolicy.interface import get_interface_dict
+        interface_dict = get_interface_dict()
+        for v in values:
+            if v not in interface_dict.keys():
+                raise ValueError(_("Interface %s does not exist.") % v)
+
+        setattr(namespace, self.dest, values)
+
+def generate_custom_usage(usage_text,usage_dict):
+    sorted_keys = []
+    for i in usage_dict.keys():
+        sorted_keys.append(i)
+    sorted_keys.sort()  
+    for k in sorted_keys:
+        usage_text += "%s %s |" % (k,(" ".join(usage_dict[k])))
+    usage_text = usage_text[:-1] + "]"
+    usage_text = _(usage_text)
+
+    return usage_text
+
 def _print_net(src, protocol, perm):
-    from sepolicy.network import get_network_connect
-    portdict = get_network_connect(src, protocol, perm)
+    import sepolicy.network
+    portdict = sepolicy.network.get_network_connect(src, protocol, perm)
     if len(portdict) > 0:
         print "%s: %s %s" % (src, protocol, perm)
         for p in portdict:
@@ -160,7 +206,7 @@ def _print_net(src, protocol, perm):
                 print "\t" + recs
 
 def network(args):
-    from sepolicy.network import portrecsbynum, portrecs, get_network_connect
+    portrecs, portrecsbynum = sepolicy.gen_port_dict()
     if args.list_ports:
         all_ports = []
         for i in portrecs:
@@ -201,41 +247,41 @@ def manpage(args):
     from sepolicy.manpage import ManPage, HTMLManPages, manpage_domains, manpage_roles, gen_domains
 
     path = args.path
-    if args.policy:
-        for f in ( "policy.xml", "file_context", "file_context.homedirs"):
-            if not os.path.exists(path + f):
-                raise ValueError("manpage creation with alternate policy requires the %s file exist" % (path + f))
-
+    if not args.policy and args.root != "/":
+        sepolicy.policy(sepolicy.get_installed_policy(args.root))
+        
     if args.all:
         test_domains = gen_domains()
     else:
         test_domains = args.domain
 
     for domain in test_domains:
-        m = ManPage(domain, path, args.web)
+        m = ManPage(domain, path, args.root, args.web)
         print m.get_man_page_path()
 
     if args.web:
         HTMLManPages(manpage_roles, manpage_domains, path, args.os)
 
 def gen_manpage_args(parser):
-        man = parser.add_parser("manpage",
-                                   help=_('Generate SELinux man pages'))
-
-        man.add_argument("-p", "--path", dest="path", default="/tmp",
-                         help=_("path in which the generated SELinux man pages will be stored"))
-        man.add_argument("-o", "--os", dest="os", default=get_os_version(),
-                         help=_("name of the OS for man pages"))
-        man.add_argument("-w", "--web", dest="web", default=False, action="store_true",
-                                help=_("Generate HTML man pages structure for selected SELinux man page"))
-        group = man.add_mutually_exclusive_group(required=True)
-        group.add_argument("-a", "--all", dest="all", default=False,
-                           action="store_true",
-                           help=_("All domains"))
-        group.add_argument("-d", "--domain", nargs="+",
-                           action=CheckDomain,
-                           help=_("Domain name(s) of man pages to be created"))
-        man.set_defaults(func=manpage)
+    man = parser.add_parser("manpage",
+                            help=_('Generate SELinux man pages'))
+
+    man.add_argument("-p", "--path", dest="path", default="/tmp",
+                     help=_("path in which the generated SELinux man pages will be stored"))
+    man.add_argument("-o", "--os", dest="os", default=get_os_version(),
+                     help=_("name of the OS for man pages"))
+    man.add_argument("-w", "--web", dest="web", default=False, action="store_true",
+                     help=_("Generate HTML man pages structure for selected SELinux man page"))
+    man.add_argument("-r", "--root", dest="root", default="/",
+                     help=_("Alternate root directory, defaults to /"))
+    group = man.add_mutually_exclusive_group(required=True)
+    group.add_argument("-a", "--all", dest="all", default=False,
+                       action="store_true",
+                       help=_("All domains"))
+    group.add_argument("-d", "--domain", nargs="+",
+                       action=CheckDomain,
+                       help=_("Domain name(s) of man pages to be created"))
+    man.set_defaults(func=manpage)
 
 def gen_network_args(parser):
         net = parser.add_parser("network",
@@ -283,7 +329,6 @@ def gen_communicate_args(parser):
     comm.set_defaults(func=communicate)
 
 def booleans(args):
-    import selinux
     from sepolicy import boolean_desc
     if args.all:
         rc, args.booleans = selinux.security_get_boolean_names()
@@ -300,6 +345,7 @@ def gen_booleans_args(parser):
                        action="store_true",
                        help=_("get all booleans descriptions"))
     group.add_argument("-b", "--boolean", dest="booleans", nargs="+",
+                       action=CheckBoolean, required=False,
                        help=_("boolean to get description"))
     bools.set_defaults(func=booleans)
 
@@ -319,22 +365,50 @@ def gen_transition_args(parser):
                        help=_("target process domain"))
     trans.set_defaults(func=transition)
 
+def print_interfaces(interfaces, args, append=""):
+    from sepolicy.interface import get_interface_format_text, interface_compile_test
+    for i in interfaces:
+        if args.verbose:
+            try:
+                print get_interface_format_text(i + append)
+            except KeyError:
+                print i
+        if args.compile:
+            try:
+                interface_compile_test(i)
+            except KeyError:
+                print i
+        else:
+            print i
+    
 def interface(args):
-    from sepolicy.interface import get_admin, get, get_user
+    from sepolicy.interface import get_admin, get_user
+    from sepolicy import get_methods
     if args.list_admin:
-        for a in get_admin():
-            print a
+        print_interfaces(get_admin(), args, "_admin")
     if args.list_user:
-        for a in get_user():
-            print a
+        print_interfaces(get_user(), args, "_role")
     if args.list:
-        for m in get():
-            print m
+        print_interfaces(get_methods(), args)
+    if args.interfaces:
+        print_interfaces(args.interfaces, args)
 
 def generate(args):
-    from sepolicy.generate import policy, USERS, SANDBOX, APPLICATIONS, NEWTYPE
+    from sepolicy.generate import policy, AUSER, RUSER, EUSER, USERS, SANDBOX, APPLICATIONS, NEWTYPE
     cmd = None
-    if args.policytype not in USERS +  [ SANDBOX, NEWTYPE]:
+# numbers present POLTYPE defined in sepolicy.generate
+    conflict_args = {'TYPES':(NEWTYPE,), 'DOMAIN':(EUSER,), 'ADMIN_DOMAIN':(AUSER, RUSER, EUSER,)}
+    error_text = ""
+
+    if args.policytype is None:
+        generate_usage = generate_custom_usage(usage, usage_dict)
+        for k in usage_dict:
+            error_text += "%s" % (k)
+        print(generate_usage)   
+        print(_("sepolicy generate: error: one of the arguments %s is required") % error_text)
+        sys.exit(1)
+
+    if args.policytype in APPLICATIONS:
         if not args.command:
             raise ValueError(_("Command required for this type of policy"))
         cmd = os.path.realpath(args.command)
@@ -346,8 +420,18 @@ def generate(args):
         mypolicy.set_program(cmd)
 
     if args.types:
+        if args.policytype not in conflict_args['TYPES']:
+            raise ValueError(_("-t option can not be used with this option. Read usage for more details."))
         mypolicy.set_types(args.types)
 
+    if args.domain:
+        if args.policytype not in conflict_args['DOMAIN']:
+            raise ValueError(_("-d option can not be used with this option. Read usage for more details."))
+
+    if args.admin_domain:
+        if args.policytype not in conflict_args['ADMIN_DOMAIN']:
+            raise ValueError(_("-a option can not be used with this option. Read usage for more details."))
+
     for p in args.writepaths:
         if os.path.isdir(p):
             mypolicy.add_dir(p)
@@ -366,20 +450,32 @@ def generate(args):
 def gen_interface_args(parser):
     itf = parser.add_parser("interface",
                             help=_('List SELinux Policy interfaces'))
+    itf.add_argument("-c", "--compile", dest="compile",
+                     action="store_true", default=False,
+                     help="Run compile test for selected interface")
+    itf.add_argument("-v", "--verbose", dest="verbose", 
+                     action="store_true", default=False,
+                     help="Show verbose information")
     group = itf.add_mutually_exclusive_group(required=True)
     group.add_argument("-a", "--list_admin", dest="list_admin",action="store_true",                       default=False,
-                       help="List all domains with admin interface")
+                       help="List all domains with admin interface - DOMAIN_admin()")
     group.add_argument("-u", "--list_user", dest="list_user",action="store_true",
                        default=False,
-                       help="List all domains with SELinux user role interface")
+                       help="List all domains with SELinux user role interface - DOMAIN_role()")
     group.add_argument("-l", "--list", dest="list",action="store_true",
                        default=False,
                        help="List all interfaces")
+    group.add_argument("-i", "--interfaces", nargs="+", dest="interfaces", 
+                       action=InterfaceInfo,
+                       help=_("Enter interface names, you wish to query"))
     itf.set_defaults(func=interface)
 
 def gen_generate_args(parser):
     from sepolicy.generate import DAEMON, get_poltype_desc, poltype, DAEMON, DBUS, INETD, CGI, SANDBOX, USER, EUSER, TUSER, XUSER, LUSER, AUSER, RUSER, NEWTYPE
-    pol = parser.add_parser("generate",
+ 
+    generate_usage = generate_custom_usage(usage, usage_dict)
+
+    pol = parser.add_parser("generate", usage = generate_usage,
                             help=_('Generate SELinux Policy module template'))
     pol.add_argument("-d", "--domain", dest="domain", default=[],
                      action=CheckDomain, nargs="*",
@@ -397,53 +493,57 @@ def gen_generate_args(parser):
                      help=argparse.SUPPRESS)
     pol.add_argument("-t", "--type", dest="types", default=[], nargs="*",
                      action=CheckType, 
-                     help=argparse.SUPPRESS)
+                     help="Enter type(s) for which you will generate new definition and rule(s)")
     pol.add_argument("-p", "--path", dest="path", default=os.getcwd(),
                      help=_("path in which the generated policy files will be stored"))
     pol.add_argument("-w", "--writepath", dest="writepaths", nargs="*", default = [],
                      help=_("path to which the confined processes will need to write"))
-    pol.add_argument("command",nargs="?", default=None,
-                     help=_("executable to confine"))
-    group = pol.add_mutually_exclusive_group(required=False)
-    group.add_argument("--newtype", dest="policytype", const=NEWTYPE,
+    cmdtype = pol.add_argument_group(_("Policy types which require a command"))
+    cmdgroup = cmdtype.add_mutually_exclusive_group(required=False)
+    cmdgroup.add_argument("--application", dest="policytype", const=USER,
                        action="store_const",
-                       help=_("Generate Policy for %s") % poltype[NEWTYPE])
-    group.add_argument("--admin_user", dest="policytype", const=AUSER,
+                       help=_("Generate '%s' policy") % poltype[USER])
+    cmdgroup.add_argument("--cgi", dest="policytype", const=CGI,
                        action="store_const",
-                       help=_("Generate Policy for %s") % poltype[AUSER])
-    group.add_argument("--application", dest="policytype", const=USER,
+                       help=_("Generate '%s' policy") % poltype[CGI])
+    cmdgroup.add_argument("--dbus", dest="policytype", const=DBUS, 
                        action="store_const",
-                       help=_("Generate Policy for %s") % poltype[USER])
-    group.add_argument("--cgi", dest="policytype", const=CGI,
+                       help=_("Generate '%s' policy") % poltype[DBUS])
+    cmdgroup.add_argument("--inetd", dest="policytype", const=INETD,
                        action="store_const",
-                       help=_("Generate Policy for %s") % poltype[CGI])
+                       help=_("Generate '%s' policy") % poltype[INETD])
+    cmdgroup.add_argument("--init", dest="policytype", const=DAEMON, 
+                       action="store_const", default=DAEMON, 
+                       help=_("Generate '%s' policy") % poltype[DAEMON])
+
+    type = pol.add_argument_group("Policy types which do not require a command")
+    group = type.add_mutually_exclusive_group(required=False)
+    group.add_argument("--admin_user", dest="policytype", const=AUSER,
+                       action="store_const",
+                       help=_("Generate '%s' policy") % poltype[AUSER])
     group.add_argument("--confined_admin", dest="policytype", const=RUSER,
                        action="store_const",
-                       help=_("Generate Policy for %s") % poltype[RUSER])
+                       help=_("Generate '%s' policy") % poltype[RUSER])
     group.add_argument("--customize", dest="policytype", const=EUSER,
                        action="store_const",
-                       help=_("Generate Policy for %s") % poltype[EUSER])
-    group.add_argument("--dbus", dest="policytype", const=DBUS, 
-                       action="store_const",
-                       help=_("Generate Policy for %s") % poltype[DBUS])
+                       help=_("Generate '%s' policy") % poltype[EUSER])
     group.add_argument("--desktop_user", dest="policytype", const=LUSER,
                        action="store_const",
-                       help=_("Generate Policy for %s") % poltype[LUSER])
-    group.add_argument("--inetd", dest="policytype", const=INETD,
+                       help=_("Generate '%s' policy ") % poltype[LUSER])
+    group.add_argument("--newtype", dest="policytype", const=NEWTYPE,
                        action="store_const",
-                       help=_("Generate Policy for %s") % poltype[INETD])
-    group.add_argument("--init", dest="policytype", const=DAEMON, 
-                       action="store_const", default=DAEMON, 
-                       help=_("Generate Policy for %s") % poltype[DAEMON])
+                       help=_("Generate '%s' policy") % poltype[NEWTYPE])
     group.add_argument("--sandbox", dest="policytype", const=SANDBOX,
                        action="store_const",
-                       help=_("Generate Policy for %s") % poltype[SANDBOX])
+                       help=_("Generate '%s' policy") % poltype[SANDBOX])
     group.add_argument("--term_user", dest="policytype", const=TUSER,
                        action="store_const",
-                       help=_("Generate Policy for %s") % poltype[TUSER])
+                       help=_("Generate '%s' policy") % poltype[TUSER])
     group.add_argument("--x_user", dest="policytype", const=XUSER,
                        action="store_const",
-                       help=_("Generate Policy for %s") % poltype[XUSER])
+                       help=_("Generate '%s' policy") % poltype[XUSER])
+    pol.add_argument("command",nargs="?", default=None,
+                     help=_("executable to confine"))
     pol.set_defaults(func=generate)
 
 if __name__ == '__main__':
@@ -461,11 +561,17 @@ if __name__ == '__main__':
     gen_transition_args(subparsers)
 
     try:
-        args = parser.parse_args()
+        if os.path.basename(sys.argv[0]) == "sepolgen":
+            args = parser.parse_args([ "generate" ] + sys.argv[1:])
+        else:
+            args = parser.parse_args()
         args.func(args)
         sys.exit(0)
     except ValueError,e:
         sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
         sys.exit(1)
+    except IOError,e:
+        sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
+        sys.exit(1)
     except KeyboardInterrupt:
         sys.exit(0)
diff --git a/policycoreutils/sepolicy/sepolicy/__init__.py b/policycoreutils/sepolicy/sepolicy/__init__.py
index 5e7415c..5267ed9 100644
--- a/policycoreutils/sepolicy/sepolicy/__init__.py
+++ b/policycoreutils/sepolicy/sepolicy/__init__.py
@@ -7,6 +7,9 @@ import _policy
 import selinux, glob
 PROGNAME="policycoreutils"
 import gettext
+import sepolgen.defaults as defaults
+import sepolgen.interfaces as interfaces
+import sys
 gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
 gettext.textdomain(PROGNAME)
 try:
@@ -37,9 +40,30 @@ CLASS = 'class'
 TRANSITION = 'transition'
 ROLE_ALLOW = 'role_allow'
 
-def __get_installed_policy():
+def info(setype, name=None):
+    dict_list = _policy.info(setype, name)
+    return dict_list
+
+def search(types, info = {} ):
+    valid_types = [ALLOW, AUDITALLOW, NEVERALLOW, DONTAUDIT, TRANSITION, ROLE_ALLOW]
+    for type in types:
+        if type not in valid_types:
+            raise ValueError("Type has to be in %s" % valid_types)
+        info[type] = True
+
+    perms = []
+    if PERMS in info:
+        perms = info[PERMS]
+        info[PERMS] = ",".join(info[PERMS])
+
+    dict_list = _policy.search(info)
+    if dict_list and len(perms) != 0:
+        dict_list = filter(lambda x: _dict_has_perms(x, perms), dict_list)
+    return dict_list
+
+def get_installed_policy(root = "/"):
     try:
-        path = selinux.selinux_binary_policy_path()
+        path = root + selinux.selinux_binary_policy_path()
         policies = glob.glob ("%s.*" % path )
         policies.sort()
         return policies[-1]
@@ -47,6 +71,26 @@ def __get_installed_policy():
         pass
     raise ValueError(_("No SELinux Policy installed"))
         
+methods = []
+def get_methods():
+    global methods
+    if len(methods) > 0:
+        return methods
+    fn = defaults.interface_info()
+    try:
+        fd = open(fn)
+    # List of per_role_template interfaces
+        ifs = interfaces.InterfaceSet()
+        ifs.from_file(fd)
+        methods = ifs.interfaces.keys()
+        fd.close()
+    except:
+        sys.stderr.write("could not open interface info [%s]\n" % fn)
+        sys.exit(1)
+    
+    methods.sort()
+    return methods
+
 all_types = None
 def get_all_types():
     global all_types
@@ -54,6 +98,13 @@ def get_all_types():
         all_types = map(lambda x: x['name'], info(TYPE))
     return all_types
 
+user_types =  None
+def get_user_types():
+    global user_types
+    if user_types == None:
+        user_types = info(ATTRIBUTE,"userdomain")[0]["types"]
+    return user_types
+
 role_allows = None
 def get_all_role_allows():
 	global role_allows
@@ -71,6 +122,7 @@ def get_all_role_allows():
 	return role_allows
 
 def get_all_entrypoint_domains():
+    import re
     all_domains = []
     types=get_all_types()
     types.sort()
@@ -81,11 +133,35 @@ def get_all_entrypoint_domains():
                 all_domains.append(m[0])
     return all_domains
 
+portrecs = None
+portrecsbynum = None
+
+def gen_port_dict():
+    global portrecs
+    global portrecsbynum
+    if portrecs:
+        return ( portrecs, portrecsbynum )
+    portrecsbynum = {}
+    portrecs = {}
+    for i in info(PORT):
+        if i['low'] == i['high']:
+            port = str(i['low'])
+        else:
+            port = "%s-%s" % (str(i['low']), str(i['high']))
+
+        if (i['type'], i['protocol']) in portrecs:
+            portrecs [(i['type'], i['protocol'])].append(port)
+        else:
+            portrecs [(i['type'], i['protocol'])] = [port]
+
+        portrecsbynum[(i['low'], i['high'],i['protocol'])] = (i['type'], i['range'])
+    return ( portrecs, portrecsbynum )
+
 all_domains = None
 def get_all_domains():
 	global all_domains
 	if not all_domains:
-		all_domains = info(ATTRIBUTE,"domain")[0]["types"]
+            all_domains = info(ATTRIBUTE,"domain")[0]["types"]
 	return all_domains
 
 roles = None
@@ -139,48 +215,48 @@ def get_all_attributes():
 	return all_attributes
 
 def policy(policy_file):
+    global all_domains
+    global all_attributes
+    global bools
+    global all_types
+    global role_allows
+    global users
+    global roles
+    global file_types
+    global port_types
+    all_domains = None
+    all_attributes = None
+    bools = None 
+    all_types = None 
+    role_allows = None 
+    users = None 
+    roles = None 
+    file_types = None 
+    port_types = None 
     try:
         _policy.policy(policy_file)
     except:
         raise ValueError(_("Failed to read %s policy file") % policy_file)
 
-
-policy_file = selinux.selinux_current_policy_path()
-if not policy_file:
-    policy_file = __get_installed_policy()
-
 try:
+    policy_file = get_installed_policy()
     policy(policy_file)
 except ValueError, e:
     if selinux.is_selinux_enabled() == 1:
         raise e
 
-def search(types, info = {} ):
-    valid_types = [ALLOW, AUDITALLOW, NEVERALLOW, DONTAUDIT, TRANSITION, ROLE_ALLOW]
-    for type in types:
-        if type not in valid_types:
-            raise ValueError("Type has to be in %s" % valid_types)
-        info[type] = True
-
-    perms = []
-    if PERMS in info:
-        perms = info[PERMS]
-        info[PERMS] = ",".join(info[PERMS])
-
-    dict_list = _policy.search(info)
-    if dict_list and len(perms) != 0:
-        dict_list = filter(lambda x: _dict_has_perms(x, perms), dict_list)
-    return dict_list
-
 def _dict_has_perms(dict, perms):
     for perm in perms:
         if perm not in dict[PERMS]:
             return False
     return True
 
-def info(setype, name=None):
-    dict_list = _policy.info(setype, name)
-    return dict_list
+booleans = None
+def get_all_booleans():
+    global booleans
+    if not booleans:
+        booleans = selinux.security_get_boolean_names()[1]
+    return booleans
 
 booleans_dict = None
 def gen_bool_dict(path="/usr/share/selinux/devel/policy.xml"):
diff --git a/policycoreutils/sepolicy/sepolicy/communicate.py b/policycoreutils/sepolicy/sepolicy/communicate.py
index a179d95..9b9a09a 100755
--- a/policycoreutils/sepolicy/sepolicy/communicate.py
+++ b/policycoreutils/sepolicy/sepolicy/communicate.py
@@ -40,7 +40,7 @@ def expand_attribute(attribute):
 def get_types(src, tclass, perm):
     allows=search([sepolicy.ALLOW],{sepolicy.SOURCE:src,sepolicy.CLASS:tclass, sepolicy.PERMS:perm})
     if not allows:
-        raise TypeError("The %s type is not allowed to %s any types" % (src, ",".join(perm)))
+        raise ValueError("The %s type is not allowed to %s any types" % (src, ",".join(perm)))
 
     tlist = []
     for l in map(lambda y: y[sepolicy.TARGET], filter(lambda x: set(perm).issubset(x[sepolicy.PERMS]), allows)):
diff --git a/policycoreutils/sepolicy/sepolicy/generate.py b/policycoreutils/sepolicy/sepolicy/generate.py
index 26f8390..4739025 100644
--- a/policycoreutils/sepolicy/sepolicy/generate.py
+++ b/policycoreutils/sepolicy/sepolicy/generate.py
@@ -63,20 +63,6 @@ except IOError:
     import __builtin__
     __builtin__.__dict__['_'] = unicode
 
-user_types =  sepolicy.info(sepolicy.ATTRIBUTE,"userdomain")[0]["types"]
-methods = []
-fn = defaults.interface_info()
-try:
-    fd = open(fn)
-    # List of per_role_template interfaces
-    ifs = interfaces.InterfaceSet()
-    ifs.from_file(fd)
-    methods = ifs.interfaces.keys()
-    fd.close()
-except:
-    sys.stderr.write("could not open interface info [%s]\n" % fn)
-    sys.exit(1)
-
 def get_rpm_nvr_from_header(hdr):
     'Given an RPM header return the package NVR as a string'
     name    = hdr['name']
@@ -164,7 +150,7 @@ def get_poltype_desc():
     return msg
         
 APPLICATIONS = [ DAEMON, DBUS, INETD, USER, CGI ]
-USERS = [ XUSER, TUSER, LUSER, AUSER, EUSER, RUSER]
+USERS = [ XUSER, TUSER, LUSER, AUSER, RUSER]
 
 def verify_ports(ports):
     if ports == "":
@@ -587,7 +573,7 @@ class policy:
         def generate_network_action(self, protocol, action, port_name):
             line = ""
             method = "corenet_%s_%s_%s" % (protocol, action, port_name)
-            if method in methods:
+            if method in sepolicy.get_methods():
                 line = "%s(%s_t)\n" % (method, self.name)
             else:
                 line = """
@@ -765,7 +751,7 @@ allow %s_t %s_t:%s_socket name_%s;
 
                 return newte 
 
-            if self.type == RUSER:
+            if self.type == RUSER or self.type == AUSER:
                 newte += re.sub("TEMPLATETYPE", self.name, user.te_admin_rules)
 
                 for app in self.admin_domains:
@@ -875,6 +861,13 @@ allow %s_t %s_t:%s_socket name_%s;
                         if t.endswith(i):
                             newte += re.sub("TEMPLATETYPE", t[:-len(i)], self.DEFAULT_EXT[i].te_types)
                             break
+
+                if NEWTYPE and newte == "":
+                    default_ext = []
+                    for i in self.DEFAULT_EXT:
+                        default_ext.append(i)
+                    raise ValueError(_("You need to define a new type which ends with: \n %s") % "\n ".join(default_ext)) 
+
                 return newte
 
 	def generate_new_rules(self):
@@ -1014,7 +1007,7 @@ allow %s_t %s_t:%s_socket name_%s;
 
 	def generate_roles_rules(self):
             newte = ""
-            if self.type in ( TUSER, XUSER, AUSER, LUSER, EUSER):
+            if self.type in ( TUSER, XUSER, AUSER, LUSER ):
                 roles = ""
                 if len(self.roles) > 0:
                     newte += re.sub("TEMPLATETYPE", self.name, user.te_sudo_rules)
@@ -1030,14 +1023,15 @@ allow %s_t %s_t:%s_socket name_%s;
 			if len(self.DEFAULT_DIRS[d][1]) > 0:
 				# CGI scripts already have a rw_t
 				if self.type != CGI or d != "rw":
-					newte += re.sub("TEMPLATETYPE", self.name, self.DEFAULT_DIRS[d][2].te_types)
+                                    newte += re.sub("TEMPLATETYPE", self.name, self.DEFAULT_DIRS[d][2].te_types)
 
                 if self.type != EUSER:
                     newte +="""
 ########################################
 #
 # %s local policy
-#""" % self.name
+#
+""" % self.name
                 newte += self.generate_capabilities()
                 newte += self.generate_process()
 		newte += self.generate_network_types()
@@ -1048,11 +1042,22 @@ allow %s_t %s_t:%s_socket name_%s;
 
                 for d in self.DEFAULT_KEYS:
 			if len(self.DEFAULT_DIRS[d][1]) > 0:
-				newte += re.sub("TEMPLATETYPE", self.name, self.DEFAULT_DIRS[d][2].te_rules)
-                                for i in self.DEFAULT_DIRS[d][1]:
-                                        if os.path.exists(i) and stat.S_ISSOCK(os.stat(i)[stat.ST_MODE]):
-                                            newte += re.sub("TEMPLATETYPE", self.name, self.DEFAULT_DIRS[d][2].te_stream_rules)
-                                            break
+                            if self.type == EUSER:
+                                newte_tmp = ""
+                                for domain in self.existing_domains:
+                                    newte_tmp += re.sub("TEMPLATETYPE_t", domain[:-2]+"_t", self.DEFAULT_DIRS[d][2].te_rules)
+                                    newte += re.sub("TEMPLATETYPE_rw_t", self.name+"_rw_t", newte_tmp)
+                            else:
+                                newte += re.sub("TEMPLATETYPE", self.name, self.DEFAULT_DIRS[d][2].te_rules)
+                            for i in self.DEFAULT_DIRS[d][1]:
+                                if os.path.exists(i) and stat.S_ISSOCK(os.stat(i)[stat.ST_MODE]):
+                                    if self.type == EUSER:
+                                        for domain in self.existing_domains:
+                                            newte += re.sub("TEMPLATETYPE", domain[:-2], self.DEFAULT_DIRS[d][2].te_stream_rules)
+                                        
+                                    else:
+                                        newte += re.sub("TEMPLATETYPE", self.name, self.DEFAULT_DIRS[d][2].te_stream_rules)
+                                    break
 
 		newte += self.generate_tmp_rules()
 		newte += self.generate_network_rules()
@@ -1079,7 +1084,7 @@ allow %s_t %s_t:%s_socket name_%s;
                 fclist = []
                 if self.type in USERS +  [ SANDBOX ]:
                     return executable.fc_user
-                if self.type != NEWTYPE and not self.program:
+                if self.type not in [ EUSER,  NEWTYPE ] and not self.program:
                     raise ValueError(_("You must enter the executable path for your confined process"))
 
                 if self.program:
@@ -1109,7 +1114,7 @@ allow %s_t %s_t:%s_socket name_%s;
 
 	def generate_user_sh(self):
             newsh = ""
-            if self.type not in ( TUSER, XUSER, AUSER, LUSER, EUSER):
+            if self.type not in ( TUSER, XUSER, AUSER, LUSER, RUSER):
                 return newsh
 
             roles = ""
@@ -1117,13 +1122,10 @@ allow %s_t %s_t:%s_socket name_%s;
                 roles += " %s_r" % role
             if roles != "":
                 roles += " system_r"
-            if self.type == EUSER:
-                tmp = re.sub("TEMPLATETYPE", self.name, script.eusers)
-            else:
-                tmp = re.sub("TEMPLATETYPE", self.name, script.users)
+            tmp = re.sub("TEMPLATETYPE", self.name, script.users)
             newsh += re.sub("ROLES", roles, tmp)
 
-            if self.type == RUSER:
+            if self.type == RUSER or self.type == AUSER:
                 for u in self.transition_users:
                     tmp =  re.sub("TEMPLATETYPE", self.name, script.admin_trans)
                     newsh += re.sub("USER", u, tmp)
diff --git a/policycoreutils/sepolicy/sepolicy/interface.py b/policycoreutils/sepolicy/sepolicy/interface.py
index 8b063ca..407ce20 100644
--- a/policycoreutils/sepolicy/sepolicy/interface.py
+++ b/policycoreutils/sepolicy/sepolicy/interface.py
@@ -21,15 +21,13 @@
 #                                        02111-1307  USA
 #
 #
-import re
-
-import sepolgen.interfaces as interfaces
-import sepolgen.defaults as defaults
+import re, sys
+import sepolicy
 ADMIN_TRANSITION_INTERFACE = "_admin$"
 USER_TRANSITION_INTERFACE = "_role$"
-from sepolicy.generate import get_all_types
+import selinux
 
-__all__ = [ 'get', 'get_admin', 'get_user' ]
+__all__ = [ 'get_admin', 'get_user' ,'get_interface_dict', 'get_interface_format_text', 'get_interface_compile_format_text', 'interface_compile_test' ]
 
 ##
 ## I18N
@@ -48,24 +46,10 @@ except IOError:
     import __builtin__
     __builtin__.__dict__['_'] = unicode
 
-def get():
-    """ Get all Methods """
-    fn = defaults.interface_info()
-    try:
-        fd = open(fn)
-        ifs = interfaces.InterfaceSet()
-        ifs.from_file(fd)
-        methods = ifs.interfaces.keys()
-        fd.close()
-    except:
-        raise ValueError(_("could not open interface info [%s]\n") % fn)
-
-    return methods
-
 def get_admin():
     """ Get all domains with an admin interface"""
     admin_list = []
-    for i in get():
+    for i in sepolicy.get_methods():
         if i.endswith("_admin"):
             admin_list.append(i.split("_admin")[0])
     return admin_list
@@ -73,9 +57,87 @@ def get_admin():
 def get_user():
     """ Get all domains with SELinux user role interface"""
     trans_list = []
-    for i in get():
+    for i in sepolicy.get_methods():
         m = re.findall("(.*)%s" % USER_TRANSITION_INTERFACE, i)
         if len(m) > 0:
-            if "%s_exec_t" % m[0] in get_all_types():
+            if "%s_exec_t" % m[0] in sepolicy.get_all_types():
                 trans_list.append(m[0])
     return trans_list
+
+interface_dict = None
+def get_interface_dict(path = "/usr/share/selinux/devel/policy.xml"):
+    global interface_dict
+    import xml.etree.ElementTree
+    if interface_dict:
+        return interface_dict
+
+    interface_dict = {}
+    param_list = []
+    try:
+        tree = xml.etree.ElementTree.parse(path)
+        for l in tree.findall("layer"):
+            for m in l.findall("module"):
+                for i in m.getiterator('interface'):
+                    for e in i.findall("param"):
+                        param_list.append(e.get('name'))
+                    interface_dict[(i.get("name"))] = [param_list,(i.find('summary').text),"interface"]
+                    param_list = []
+                for i in m.getiterator('template'):
+                    for e in i.findall("param"):
+                        param_list.append(e.get('name'))
+                    interface_dict[(i.get("name"))] = [param_list,(i.find('summary').text),"template"]
+                    param_list = []
+    except IOError, e:
+        pass
+    return interface_dict
+
+def get_interface_format_text(interface,path = "/usr/share/selinux/devel/policy.xml"):
+    interface_dict = get_interface_dict(path)
+    interface_text = "%s(%s) %s" % (interface, ", ".join(interface_dict[interface][0]), " ".join(interface_dict[interface][1].split("\n")))
+
+    return interface_text
+
+def get_interface_compile_format_text(interfaces_dict, interface):
+    from templates import test_module
+    param_tmp = []
+    for i in interfaces_dict[interface][0]:
+        param_tmp.append(test_module.dict_values[i])
+        interface_text = "%s(%s)\n" % (interface, ", ".join(param_tmp))
+
+    return interface_text
+
+def generate_compile_te(interface, interface_dict, name="compiletest"):
+    from templates import test_module
+    te = ""
+    te += re.sub("TEMPLATETYPE", name, test_module.te_test_module )
+    te += get_interface_compile_format_text(interface_dict,interface)
+
+    return te
+
+def interface_compile_test(interface, path = "/usr/share/selinux/devel/policy.xml"):
+    exclude_interfaces = ["userdom","kernel","corenet","files", "dev"]
+    exclude_interface_type = ["template"]
+
+    import commands, os
+    te = "compiletest.te"
+    pp = "compiletest.pp"
+    interface_dict = get_interface_dict(path)
+
+    if not (interface.split("_")[0] in exclude_interfaces or interface_dict[interface][2] in exclude_interface_type):
+        print(_("Compiling %s interface" % interface))
+        try:
+            fd = open(te, "w")
+            fd.write(generate_compile_te(interface, interface_dict))
+            fd.close()
+            rc, output=commands.getstatusoutput("make -f /usr/share/selinux/devel/Makefile %s" % pp )
+            if rc != 0:
+                sys.stderr.write(output)
+                sys.stderr.write(_("\nCompile test for %s failed.\n") % interface)
+
+        except EnvironmentError, e:
+            sys.stderr.write(_("\nCompile test for %s has not run.\n") % interface)
+        if os.path.exists(te):
+            os.remove(te)
+
+    else:
+        sys.stderr.write(_("\nCompiling of %s interface is not supported." % interface))
diff --git a/policycoreutils/sepolicy/sepolicy/manpage.py b/policycoreutils/sepolicy/sepolicy/manpage.py
index 25062da..63efc6d 100755
--- a/policycoreutils/sepolicy/sepolicy/manpage.py
+++ b/policycoreutils/sepolicy/sepolicy/manpage.py
@@ -28,12 +28,12 @@ import string
 import argparse
 import selinux
 import sepolicy
-from sepolicy import network, gen_bool_dict, get_all_file_types, get_all_domains, get_all_roles, get_all_users, get_all_port_types, get_all_bools, get_all_attributes, get_all_role_allows
+from sepolicy import *
 
 import commands
 import sys, os, re, time
 
-equiv_dict={ "smbd" : [ "samba" ], "httpd" : [ "apache" ], "virtd" : [ "virt", "libvirt" ], "named" : [ "bind" ], "fsdaemon" : [ "smartmon" ], "mdadm" : [ "raid" ] }
+equiv_dict={ "smbd" : [ "samba" ], "httpd" : [ "apache" ], "virtd" : [ "virt", "libvirt", "svirt", "svirt_tcg", "svirt_lxc_t", "svirt_lxc_net_t" ], "named" : [ "bind" ], "fsdaemon" : [ "smartmon" ], "mdadm" : [ "raid" ] }
 
 equiv_dirs=[ "/var" ]
 modules_dict = None
@@ -100,8 +100,8 @@ def gen_domains():
 	for d in get_all_domains():
 		found = False
 		domain = d[:-2]
-		if domain + "_exec_t" not in get_entrypoints():
-			continue
+#		if domain + "_exec_t" not in get_entrypoints():
+#			continue
 		if domain in domains:
 			continue
 		domains.append(domain)
@@ -184,14 +184,12 @@ def get_alphabet_manpages(manpage_list):
 	return alphabet_manpages
 
 def convert_manpage_to_html(html_manpage,manpage):
-	fd = open(html_manpage,'w')
-	rc, output = commands.getstatusoutput("man2html -r %s" % manpage)
+	rc, output = commands.getstatusoutput("/usr/bin/groff -man -Thtml %s 2>/dev/null" % manpage)
 	if rc == 0:
+		print html_manpage, " has been created"
+		fd = open(html_manpage,'w')
 		fd.write(output)
-	else:
-		fd.write("Man page does not exist")
-
-	fd.close()
+		fd.close()
 
 class HTMLManPages:
 	"""
@@ -416,40 +414,33 @@ class ManPage:
     """
 	Generate a Manpage on an SELinux domain in the specified path
     """
-    all_attributes = get_all_attributes()
-    all_domains = get_all_domains()
-    all_bools = get_all_bools()
-    all_port_types = get_all_port_types()
-    all_roles = get_all_roles()
-    all_users = get_all_users_info()[0]
-    all_users_range = get_all_users_info()[1]
-    all_file_types = get_all_file_types()
-    types = _gen_types()
     modules_dict = None
-    domains = gen_domains()
-    role_allows = get_all_role_allows()
     enabled_str = ["Disabled", "Enabled"]
 
-    def __init__(self, domainname, path = "/tmp", html = False):
+    def __init__(self, domainname, path = "/tmp", root="/", html = False):
 	self.html = html
-	self.portrecs = network.portrecs
-
-	fcpath = path + "/file_contexts"
-	if os.path.exists(fcpath):
-		self.fcpath = fcpath
-	else:
-		self.fcpath = selinux.selinux_file_context_path()
+	self.root = root
+	self.portrecs = gen_port_dict()[0]
+	self.domains = gen_domains()
+	self.all_domains = get_all_domains()
+	self.all_attributes = get_all_attributes()
+	self.all_bools = get_all_bools()
+	self.all_port_types = get_all_port_types()
+	self.all_roles = get_all_roles()
+	self.all_users = get_all_users_info()[0]
+	self.all_users_range = get_all_users_info()[1]
+	self.all_file_types = get_all_file_types()
+	self.role_allows = get_all_role_allows()
+	self.types = _gen_types()
+
+	self.fcpath = self.root + selinux.selinux_file_context_path()
 	self.fcdict = _gen_fcdict(self.fcpath)
 
 	if not os.path.exists(path):
 		os.makedirs(path)
-	self.path = path
 
-	xmlpath = path + "/policy.xml"
-	if os.path.exists(xmlpath):
-		self.xmlpath = xmlpath
-	else:
-		self.xmlpath = "/usr/share/selinux/devel/policy.xml"
+	self.path = path
+	self.xmlpath = self.root + "/usr/share/selinux/devel/policy.xml"
 	self.booleans_dict = gen_bool_dict(self.xmlpath)
 
 	if domainname.endswith("_t"):
@@ -459,13 +450,16 @@ class ManPage:
 
 	if self.domainname + "_t" not in self.all_domains:
 		raise  ValueError("domain %s_t does not exist" % self.domainname)
-	self.short_name = self.domainname
+	if self.domainname[-1]=='d':
+		self.short_name = self.domainname[:-1] + "_"
+	else:
+		self.short_name = self.domainname + "_"
 
 	self.type = self.domainname + "_t"
 	self._gen_bools()
 	self.man_page_path = "%s/%s_selinux.8" % (path, self.domainname)
 	self.fd = open(self.man_page_path, 'w')
-	if domainname + "_r" in self.all_roles:
+	if self.domainname + "_r" in self.all_roles:
 	    self.__gen_user_man_page()
 	    if self.html:
 		manpage_roles.append(self.man_page_path)
@@ -483,16 +477,23 @@ class ManPage:
     def _gen_bools(self):
 	    self.bools=[]
 	    self.domainbools=[]
-	    for i in map(lambda x: x['boolean'], filter(lambda x: 'boolean' in x, sepolicy.search([sepolicy.ALLOW],{'source' : self.type }))):
-		    for b in i:
-			    if not isinstance(b,tuple):
-				    continue
-			    if b[0].startswith(self.short_name):
-				    if b not in self.domainbools and (b[0], not b[1]) not in self.domainbools:
-					    self.domainbools.append(b)
-			    else:
-				    if b not in self.bools and (b[0], not b[1]) not in self.bools:
-					    self.bools.append(b)
+	    types = [self.type]
+	    if self.domainname in equiv_dict:
+		    for t in equiv_dict[self.domainname]:
+			    if t + "_t" in self.all_domains:
+				    types.append(t+"_t")
+
+	    for t in types:
+		    for i in map(lambda x: x['boolean'], filter(lambda x: 'boolean' in x, sepolicy.search([sepolicy.ALLOW],{'source' : t }))):
+			    for b in i:
+				    if not isinstance(b,tuple):
+					    continue
+				    if b[0].startswith(self.short_name) or b[0].startswith(self.domainname):
+					    if b not in self.domainbools and (b[0], not b[1]) not in self.domainbools:
+						    self.domainbools.append(b)
+				    else:
+					    if b not in self.bools and (b[0], not b[1]) not in self.bools:
+						    self.bools.append(b)
 
 	    self.bools.sort()
 	    self.domainbools.sort()
@@ -538,9 +539,6 @@ class ManPage:
 	    print path
 
     def __gen_man_page(self):
-	if self.domainname[-1]=='d':
-	    self.short_name = self.domainname[:-1]
-
 	self.anon_list = []
 
 	self.attributes = {}
@@ -563,22 +561,11 @@ class ManPage:
 
     def _get_ptypes(self):
 	for f in self.all_domains:
-	    if f.startswith(self.short_name):
-		self.ptypes.append(f)
-
-    def __whoami(self):
-	    import pwd
-	    fd = open("/proc/self/loginuid", "r")
-	    uid = int(fd.read())
-	    fd.close()
-	    pw = pwd.getpwuid(uid)
-	    if len(pw.pw_gecos) > 0:
-		    return pw.pw_gecos
-	    else:
-		    return pw.pw_name
+		if f.startswith(self.short_name) or f.startswith(self.domainname):
+			self.ptypes.append(f)
 
     def _header(self):
-	self.fd.write('.TH  "%(domainname)s_selinux"  "8"  "%(date)s" "%(domainname)s" "SELinux Policy documentation for %(domainname)s"'
+	self.fd.write('.TH  "%(domainname)s_selinux"  "8"  "%(date)s" "%(domainname)s" "SELinux Policy %(domainname)s"'
 		 % {'domainname':self.domainname, 'date': time.strftime("%y-%m-%d")})
 	self.fd.write(r"""
 .SH "NAME"
@@ -774,7 +761,7 @@ can be used to make the process type %(domainname)s_t permissive. SELinux does n
     def _port_types(self):
 	self.ports = []
 	for f in self.all_port_types:
-	    if f.startswith(self.short_name):
+            if f.startswith(self.short_name) or f.startswith(self.domainname):
 		self.ports.append(f)
 
 	if len(self.ports) == 0:
@@ -923,13 +910,12 @@ to apply the labels.
 
     def _see_also(self):
 	    ret = ""
-	    prefix = self.short_name.split("_")[0]
 	    for d in self.domains:
 		    if d == self.domainname:
 			    continue
-		    if d.startswith(prefix):
+		    if d.startswith(self.short_name):
 			    ret += ", %s_selinux(8)" % d
-		    if self.domainname.startswith(d):
+		    if d.startswith(self.domainname + "_"):
 			    ret += ", %s_selinux(8)" % d
 	    self.fd.write(ret)
 
@@ -947,13 +933,14 @@ semanage fcontext -a -t public_content_t "/var/%(domainname)s(/.*)?"
 .B restorecon -F -R -v /var/%(domainname)s
 .pp
 .TP
-Allow %(domainname)s servers to read and write /var/tmp/incoming by adding the public_content_rw_t type to the directory and by restoring the file type.  This also requires the allow_%(domainname)sd_anon_write boolean to be set.
+Allow %(domainname)s servers to read and write /var/%(domainname)s/incoming by adding the public_content_rw_t type to the directory and by restoring the file type.  You also need to turn on the %(domainname)s_anon_write boolean.
 .PP
 .B
 semanage fcontext -a -t public_content_rw_t "/var/%(domainname)s/incoming(/.*)?"
 .br
 .B restorecon -F -R -v /var/%(domainname)s/incoming
-
+.br
+.B setsebool -P %(domainname)s_anon_write 1
 """  % {'domainname':self.domainname})
 	    for b in self.anon_list:
 		desc = self.booleans_dict[b][2][0].lower() + self.booleans_dict[b][2][1:]
@@ -998,12 +985,11 @@ is a GUI tool available to customize SELinux policy settings.
 
 .SH AUTHOR
 This manual page was auto-generated using
-.B "sepolicy manpage"
-by %s.
+.B "sepolicy manpage".
 
 .SH "SEE ALSO"
 selinux(8), %s(8), semanage(8), restorecon(8), chcon(1), sepolicy(8)
-""" % (self.__whoami(), self.domainname))
+""" % (self.domainname))
 
 	if self.booltext != "":
 	    self.fd.write(", setsebool(8)")
@@ -1230,6 +1216,7 @@ The SELinux user %s_u is not able to terminal login.
 """ % self.domainname)
 
     def _network(self):
+        from sepolicy import network
 	self.fd.write("""
 .SH NETWORK
 """)
diff --git a/policycoreutils/sepolicy/sepolicy/network.py b/policycoreutils/sepolicy/sepolicy/network.py
index 66efe26..a446d68 100755
--- a/policycoreutils/sepolicy/sepolicy/network.py
+++ b/policycoreutils/sepolicy/sepolicy/network.py
@@ -25,27 +25,6 @@ import sepolicy
 search=sepolicy.search
 info=sepolicy.info
 
-def _gen_port_dict():
-    portrecsbynum = {}
-    portrecs = {}
-    for i in info(sepolicy.PORT):
-        if i['low'] == i['high']:
-            port = str(i['low'])
-        else:
-            port = "%s-%s" % (str(i['low']), str(i['high']))
-
-        if (i['type'], i['protocol']) in portrecs:
-            portrecs [(i['type'], i['protocol'])].append(port)
-        else:
-            portrecs [(i['type'], i['protocol'])] = [port]
-
-        portrecsbynum[(i['low'], i['high'],i['protocol'])] = (i['type'], i['range'])
-    return ( portrecs, portrecsbynum )
-portrecs, portrecsbynum = _gen_port_dict()
-
-port_types =  sepolicy.info(sepolicy.ATTRIBUTE,"port_type")[0]["types"]
-domains =  sepolicy.info(sepolicy.ATTRIBUTE,"domain")[0]["types"]
-
 def get_types(src, tclass, perm):
     allows=search([sepolicy.ALLOW],{sepolicy.SOURCE:src,sepolicy.CLASS:tclass, sepolicy.PERMS:perm})
     nlist=[]
@@ -57,6 +36,7 @@ def get_types(src, tclass, perm):
    
 
 def get_network_connect(src, protocol, perm):
+    portrecs, portrecsbynum = sepolicy.gen_port_dict()
     d={}
     tlist = get_types(src, "%s_socket" % protocol, [perm])
     if len(tlist) > 0:
diff --git a/policycoreutils/sepolicy/sepolicy/templates/test_module.py b/policycoreutils/sepolicy/sepolicy/templates/test_module.py
new file mode 100644
index 0000000..3a3faa6
--- /dev/null
+++ b/policycoreutils/sepolicy/sepolicy/templates/test_module.py
@@ -0,0 +1,119 @@
+# Copyright (C) 2007-2012 Red Hat
+# see file 'COPYING' for use and warranty information
+#
+# policygentool is a tool for the initial generation of SELinux policy
+#
+#    This program is free software; you can redistribute it and/or
+#    modify it under the terms of the GNU General Public License as
+#    published by the Free Software Foundation; either version 2 of
+#    the License, or (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License
+#    along with this program; if not, write to the Free Software
+#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+#                                        02111-1307  USA
+#
+#
+
+
+#['domain', 'role', 'role_prefix', 'object_class', 'name', 'private_type', 'prefix', 'entrypoint', 'target_domain', 'terminal', 'range', 'domains', 'entry_point', 'entry_file', 'domain_prefix', 'private type', 'user_prefix', 'user_role', 'user_domain', 'object', 'type', 'source_domain', 'file_type', 'file', 'class', 'peer_domain', 'objectclass(es)', 'exception_types', 'home_type', 'object_type', 'directory_type', 'boolean', 'pty_type', 'userdomain', 'tty_type', 'tmpfs_type', 'script_file', 'filetype', 'filename', 'init_script_file', 'source_role', 'userdomain_prefix']
+
+dict_values={}
+dict_values['domain'] = 'sepolicy_domain_t'
+dict_values['domains'] = 'sepolicy_domain_t'
+dict_values['target_domain'] = 'sepolicy_target_t'
+dict_values['source_domain'] = 'sepolicy_source_t'
+dict_values['peer_domain'] = 'sepolicy_peer_t'
+dict_values['exception_types'] = 'sepolicy_exception_types_t'
+dict_values['user_domain'] = 'sepolicy_userdomain_t'
+dict_values['userdomain'] = 'sepolicy_userdomain_t'
+dict_values['bool_domain'] = 'sepolicy_bool_domain_t'
+
+dict_values['type'] = 'sepolicy_file_t'
+dict_values['file_type'] = 'sepolicy_file_t'
+dict_values['private type'] = 'sepolicy_private_file_t'
+dict_values['private_type'] = 'sepolicy_private_file_t'
+dict_values['pty_type'] = 'sepolicy_devpts_t'
+dict_values['tmpfs_type'] = 'sepolicy_tmpfs_t'
+dict_values['home_type'] = 'sepolicy_home_file_t'
+dict_values['tty_type'] = 'sepolicy_t'
+dict_values['directory_type'] = 'sepolicy_file_t'
+dict_values['object_type'] = 'sepolicy_object_t'
+
+dict_values['script_file'] = 'sepolicy_exec_t'
+dict_values['entry_point'] = 'sepolicy_exec_t'
+dict_values['file'] = 'sepolicy_file_t'
+dict_values['entry_file'] = 'sepolicy_exec_t'
+dict_values['init_script_file'] = 'sepolicy_exec_t'
+dict_values['entrypoint'] = 'sepolicy_exec_t'
+
+dict_values['role'] = 'sepolicy_r'
+dict_values['role_prefix'] = 'sepolicy'
+dict_values['user_role'] = 'sepolicy_r'
+dict_values['source_role'] = 'sepolicy_source_r'
+
+dict_values['prefix'] = 'sepolicy_domain'
+dict_values['domain_prefix'] = 'sepolicy_domain'
+dict_values['userdomain_prefix'] = 'sepolicy_userdomain'
+dict_values['user_prefix'] = 'sepolicy_userdomain'
+
+dict_values['object_class'] = 'file'
+dict_values['object'] = 'file'
+dict_values['class'] = 'file'
+dict_values['objectclass(es)'] = 'file'
+dict_values['object_name'] = 'sepolicy_object'
+dict_values['name'] = '"sepolicy_name"'
+
+dict_values['terminal'] = 'sepolicy_tty_t'
+dict_values['boolean'] = 'sepolicy_bool_t'
+dict_values['range'] = 's0 - mcs_systemhigh'
+
+te_test_module="""\
+policy_module(TEMPLATETYPE, 1.0.0)
+
+type sepolicy_t;
+domain_type(sepolicy_t)
+type sepolicy_domain_t;
+domain_type(sepolicy_domain_t)
+type sepolicy_target_t;
+domain_type(sepolicy_target_t)
+type sepolicy_source_t;
+domain_type(sepolicy_source_t)
+type sepolicy_peer_t;
+domain_type(sepolicy_peer_t)
+type sepolicy_exception_types_t;
+domain_type(sepolicy_exception_types_t)
+type sepolicy_userdomain_t;
+domain_type(sepolicy_userdomain_t)
+
+type sepolicy_file_t;
+files_type(sepolicy_file_t)
+type sepolicy_private_file_t;
+files_type(sepolicy_private_file_t)
+type sepolicy_home_file_t;
+files_type(sepolicy_home_file_t)
+type sepolicy_tty_t;
+term_tty(sepolicy_tty_t)
+type sepolicy_object_t;
+type sepolicy_devpts_t;
+term_pty(sepolicy_devpts_t)
+type sepolicy_tmpfs_t;
+files_type(sepolicy_tmpfs_t)
+type sepolicy_exec_t;
+files_type(sepolicy_exec_t)
+
+role sepolicy_r;
+role sepolicy_source_r;
+role sepolicy_target_r;
+
+################################# 
+#
+# Local policy
+#
+
+"""

--------------000400090808060503030607--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
