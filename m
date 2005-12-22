Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBM1PsXf023627
	for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2005 20:25:54 -0500 (EST)
Received: from e1.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBM1OvYr026650
	for <selinux@tycho.nsa.gov>; Thu, 22 Dec 2005 01:24:57 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id jBM1PqLv002026
	for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2005 20:25:52 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jBM1Pqgh095392
	for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2005 20:25:52 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id jBM1PqfO007037
	for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2005 20:25:52 -0500
Date: Wed, 21 Dec 2005 19:25:51 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: [PATCH] Re: ANN: Reference Policy Release
Message-ID: <20051222012551.GA7585@sergelap.austin.ibm.com>
References: <1133973607.8185.10.camel@sgc.columbia.tresys.com> <20051215222809.GA17384@sergelap.austin.ibm.com> <43A30097.2020701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43A30097.2020701@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Daniel J Walsh (dwalsh@redhat.com):
> Serge E. Hallyn wrote:
> >Hmm, I'm trying to compile this as a modular policy.  I've selected
> >"nis = off" in my modules.conf.  But I get
> >
> >	policy/modules/admin/netutils.te:88:ERROR 'syntax error' at token
> >	'nis_use_ypbind' on line 33005:
> >	#line 88
> >		nis_use_ypbind(netutils_t)
> >
> >when I try 'make load'.
> >
> >Is this me misunderstanding how I can use modules.conf, or is
> >the module policy mostly unsupported?  (I'm happy to help get it
> >working, just am not sure how it's supposed to work now :)  My first
> >instinct of course is that the "optional_policy" macro in
> >policy/support/loadable_module.spt would need to be more complicated
> >to handle using modules.conf...  But man that's one ugly macro.
> >  
> Looks like this should be optional.

Right :)  I just had no idea how it was meant to be implemented.

The following patch is one way of implementing the optional_policy
macro for policy modules.  Likely not the best, but I can now
do a full 'make modules'.

thanks,
-serge

Index: refpolicy/Rules.modular
===================================================================
--- refpolicy.orig/Rules.modular	2005-12-21 17:15:50.000000000 -0600
+++ refpolicy/Rules.modular	2005-12-21 18:48:49.000000000 -0600
@@ -37,7 +37,12 @@ all: base modules
 
 base: $(BASE_PKG)
 
-modules: $(MOD_PKGS)
+active_modules: $(MOD_CONF)
+	echo $(MOD_MODS) | sed -e 's/ /\n/g' \
+		| sed -e 's/^\(.*\)$$/define(`\1\x27,1)/' \
+		> active_modules
+
+modules: active_modules $(MOD_PKGS)
 
 install: $(INSTPKG) $(APPFILES)
 
@@ -62,7 +67,7 @@ $(MODPKGDIR)/%.pp: %.pp
 #
 # Build module packages
 #
-tmp/%.mod: $(M4SUPPORT) tmp/generated_definitions.conf tmp/all_interfaces.conf %.te
+tmp/%.mod: active_modules $(M4SUPPORT) tmp/generated_definitions.conf tmp/all_interfaces.conf %.te
 	@echo "Compliling $(NAME) $(@F) module"
 	$(QUIET) m4 $(M4PARAM) -s $^ > $(@:.mod=.tmp)
 	$(QUIET) $(CHECKMODULE) -m $(@:.mod=.tmp) -o $@
@@ -186,5 +191,6 @@ clean:
 	rm -f *.pp
 	rm -f $(BASE_FC)
 	rm -fR tmp
+	rm -f active_modules
 
 .PHONY: default all base modules install load clean
Index: refpolicy/policy/support/loadable_module.spt
===================================================================
--- refpolicy.orig/policy/support/loadable_module.spt	2005-12-21 17:15:59.000000000 -0600
+++ refpolicy/policy/support/loadable_module.spt	2005-12-21 18:45:56.000000000 -0600
@@ -86,17 +86,7 @@ define(`policy_call_depth',0)
 # Optional policy handling
 #
 define(`optional_policy',`
-	ifdef(`self_contained_policy',`
-		ifdef(`$1.te',`$2',`$3')
-	',`
-		optional {
-			$2
-		ifelse(`$3',`',`',`
-		} else {
-			$3
-		')
-		}
-	')
+	ifdef(`$1.te',`$2',`$3')
 ')
 
 ##############################

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
