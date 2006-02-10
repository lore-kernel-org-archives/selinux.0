Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1AJRpXf014400
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 14:27:51 -0500 (EST)
Received: from vms055pub.verizon.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1AJRlTR007791
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 19:27:47 GMT
Received: from vms134.mailsrvcs.net ([172.19.0.60])
 by vms055.mailsrvcs.net (Sun Java System Messaging Server 6.2-2.05 (built Apr
 28 2005)) with ESMTP id <0IUH000DMKQE9AR4@vms055.mailsrvcs.net> for
 selinux@tycho.nsa.gov; Fri, 10 Feb 2006 13:27:50 -0600 (CST)
Received: from bluelantern.columbia.tresys.com ([209.60.7.66])
 by vms134.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTPSA id <0IUH00HH0KQDQ2U2@vms134.mailsrvcs.net> for
 selinux@tycho.nsa.gov; Fri, 10 Feb 2006 13:27:50 -0600 (CST)
Date: Fri, 10 Feb 2006 14:27:48 -0500
From: David Sugar <dsugar@tresys.com>
Subject: [PATCH] XML Documentaion Modification and Third Party Module support
To: selinux@tycho.nsa.gov
Message-id: <200602101427.48881.dsugar@tresys.com>
MIME-version: 1.0
Content-type: Multipart/Mixed; boundary="Boundary-00=_0kO7DiLW39ZGI0r"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_0kO7DiLW39ZGI0r
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is a patch for reference policy that achieved the following

1) install a set of headers for each $NAME, instead of a single generic set, 
and put the .if files into layer directories under 
the /usr/share/selinux/$NAME/include directory.
2) install the layer, booleans and tunables xml files into the include 
directory
3) install the xml generation tool (segenxml.py)
4) include the <desc> xml tag around parameter descriptions for 
global_tunables and global_booleans
5) install build.conf into the include directory
6) install Makefile.example into the include directory

7) modify segenxml.py to work for out of layer (third party) modules
8) modify segenxml.py to generate xml files for global_tunables and 
global_booleans

Also a sed script is included to change the xml in the .if files to wrap the 
parameter information in a <summary> tag.

#1-3 & 7-8 will allow policy.xml to be regenerated when someone is generating 
a 3rd part module.  

#4 will make translations easily doable in the future

#5-6 will make the user module building work similar to building kernel 
modules outside of /usr/src/linux

Dave Sugar
Tresys Technology 
dsugar@tresys.com

--Boundary-00=_0kO7DiLW39ZGI0r
Content-Type: text/plain;
  charset="us-ascii";
  name="diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff.txt"

Index: doc/Makefile.example
===================================================================
--- doc/Makefile.example	(.../trunk/refpolicy/doc)	(revision 1476)
+++ doc/Makefile.example	(.../branches/xml-changes-20060208-1476/doc)	(working copy)
@@ -1,140 +1,6 @@
 
--include build.conf
+NAME ?= refpolicy
+SHAREDIR := /usr/share/selinux
+HEADERDIR := $(SHAREDIR)/$(NAME)/include
 
-# executables
-PREFIX := /usr
-BINDIR := $(PREFIX)/bin
-SBINDIR := $(PREFIX)/sbin
-CHECKMODULE := $(BINDIR)/checkmodule
-SEMODULE := $(SBINDIR)/semodule
-SEMOD_PKG := $(BINDIR)/semodule_package
-
-# helper tools
-AWK ?= gawk
-INSTALL ?= install
-M4 ?= m4
-SED ?= sed
-EINFO ?= echo
-
-# installation paths
-SHAREDIR := $(PREFIX)/share/selinux
-MODPKGDIR := $(SHAREDIR)/$(NAME)
-HEADERDIR := $(SHAREDIR)/refpolicy/include
-
-# set default build options
-TYPE ?= strict
-NAME ?= $(TYPE)
-DIRECT_INITRC ?= n
-POLY ?= n
-
-# compile strict policy if requested.
-ifneq ($(findstring strict,$(TYPE)),)
-	M4PARAM += -D strict_policy
-endif
-
-# compile targeted policy if requested.
-ifneq ($(findstring targeted,$(TYPE)),)
-	M4PARAM += -D targeted_policy
-endif
-
-# enable MLS if requested.
-ifneq ($(findstring -mls,$(TYPE)),)
-	M4PARAM += -D enable_mls
-	CHECKPOLICY += -M
-	CHECKMODULE += -M
-endif
-
-# enable MLS if MCS requested.
-ifneq ($(findstring -mcs,$(TYPE)),)
-	M4PARAM += -D enable_mcs
-	CHECKPOLICY += -M
-	CHECKMODULE += -M
-endif
-
-# enable distribution-specific policy
-ifneq ($(DISTRO),)
-	M4PARAM += -D distro_$(DISTRO)
-endif
-
-# enable polyinstantiation
-ifeq ($(POLY),y)
-	M4PARAM += -D enable_polyinstantiation
-endif
-
-ifeq ($(DIRECT_INITRC),y)
-	M4PARAM += -D direct_sysadm_daemon
-endif
-
-ifneq ($(VERBOSE),y)
-	quiet := @
-endif
-
-M4PARAM += -D hide_broken_symptoms
-
-# policy headers
-m4support := $(wildcard $(HEADERDIR)/*.spt)
-all_interfaces := $(wildcard $(HEADERDIR)/*.if)
-rolemap := $(HEADERDIR)/rolemap
-
-detected_mods := $(wildcard *.te)
-detected_ifs := $(detected_mods:.te=.if)
-all_packages := $(detected_mods:.te=.pp)
-install_mods := $(MODPKGDIR)/$(all_packages)
-
-########################################
-#
-# Functions
-#
-
-# parse-rolemap modulename,outputfile
-define parse-rolemap
-	$(verbose) $(M4) $(M4PARAM) $(rolemap) | \
-		$(AWK) '/^[[:blank:]]*[A-Za-z]/{ print "gen_require(type " $$3 "; role " $$1 ";)\n$1_per_userdomain_template(" $$2 "," $$3 "," $$1 ")" }' >> $2
-endef
-
-# peruser-expansion modulename,outputfile
-define peruser-expansion
-	$(verbose) echo "ifdef(\`""$1""_per_userdomain_template',\`" > $2
-	$(call parse-rolemap,$1,$2)
-	$(verbose) echo "')" >> $2
-endef
-
-########################################
-#
-# Main targets
-#
-
-all: $(all_packages)
-
-########################################
-#
-# Build module packages
-#
-tmp/%.mod: $(m4support) tmp/all_interfaces.conf %.te
-	@$(EINFO) "Compliling $(NAME) $(basename $(@F)) module"
-	@test -d tmp || mkdir -p tmp
-	$(call peruser-expansion,$(basename $(@F)),$@.role)
-	$(verbose) $(M4) $(M4PARAM) -s $^ $@.role > $(@:.mod=.tmp)
-	$(verbose) $(CHECKMODULE) -m $(@:.mod=.tmp) -o $@
-
-tmp/%.mod.fc: $(m4support) %.fc
-	$(verbose) $(M4) $(M4PARAM) $^ > $@
-
-%.pp: tmp/%.mod tmp/%.mod.fc
-	@echo "Creating $(NAME) $(@F) policy package"
-	$(verbose) $(SEMOD_PKG) -o $@ -m $< -f $<.fc
-
-tmp/all_interfaces.conf: $(m4support) $(all_interfaces) $(detected_ifs)
-	@test -d tmp || mkdir -p tmp
-	$(verbose) m4 $^ | sed -e s/dollarsstar/\$$\*/g > $@
-
-########################################
-#
-# Clean the environment
-#
-
-clean:
-	rm -fR tmp
-	rm -f *.pp
-
-.PHONY: clean install all default
+include $(HEADERDIR)/Makefile
Index: doc/policy.dtd
===================================================================
--- doc/policy.dtd	(.../trunk/refpolicy/doc)	(revision 1476)
+++ doc/policy.dtd	(.../branches/xml-changes-20060208-1476/doc)	(working copy)
@@ -11,11 +11,11 @@
 <!ELEMENT required (#PCDATA)>
 <!ATTLIST required
       val (true|false) "false">
-<!ELEMENT tunable (#PCDATA)>
+<!ELEMENT tunable (desc)>
 <!ATTLIST tunable
       name CDATA #REQUIRED
       dftval CDATA #REQUIRED>
-<!ELEMENT bool (#PCDATA)>
+<!ELEMENT bool (desc)>
 <!ATTLIST bool
       name CDATA #REQUIRED
       dftval CDATA #REQUIRED>
@@ -25,7 +25,7 @@
 <!ELEMENT template (summary,desc?,param+)>
 <!ATTLIST template name CDATA #REQUIRED lineno CDATA #REQUIRED>
 <!ELEMENT desc (#PCDATA|%inline.class;)*>
-<!ELEMENT param (#PCDATA)>
+<!ELEMENT param (summary)>
 <!ATTLIST param 
       name CDATA #REQUIRED
       optional (true|false) "false">
Index: doc/templates/global_tun_list.html
===================================================================
--- doc/templates/global_tun_list.html	(.../trunk/refpolicy/doc)	(revision 1476)
+++ doc/templates/global_tun_list.html	(.../branches/xml-changes-20060208-1476/doc)	(working copy)
@@ -8,7 +8,7 @@
 <p>[[tun['def_val']]]</p>
 [[if tun['desc']]]
 <h5>Description</h5>
-<p>[[tun['desc']]]</p>
+[[tun['desc']]]
 [[end]]
 </div></div>
 [[end]]
Index: doc/templates/global_bool_list.html
===================================================================
--- doc/templates/global_bool_list.html	(.../trunk/refpolicy/doc)	(revision 1476)
+++ doc/templates/global_bool_list.html	(.../branches/xml-changes-20060208-1476/doc)	(working copy)
@@ -8,7 +8,7 @@
 <p>[[bool['def_val']]]</p>
 [[if bool['desc']]]
 <h5>Description</h5>
-<p>[[bool['desc']]]</p>
+[[bool['desc']]]
 [[end]]
 </div></div>
 [[end]]
Index: support/Makefile.devel
===================================================================
--- support/Makefile.devel	(.../trunk/refpolicy/support)	(revision 0)
+++ support/Makefile.devel	(.../branches/xml-changes-20060208-1476/support)	(revision 1500)
@@ -0,0 +1,180 @@
+
+include $(HEADERDIR)/build.conf
+
+# executables
+PREFIX := /usr
+BINDIR := $(PREFIX)/bin
+SBINDIR := $(PREFIX)/sbin
+CHECKMODULE := $(BINDIR)/checkmodule
+SEMODULE := $(SBINDIR)/semodule
+SEMOD_PKG := $(BINDIR)/semodule_package
+XMLLINT := $(BINDIR)/xmllint
+
+# helper tools
+AWK ?= gawk
+INSTALL ?= install
+M4 ?= m4
+SED ?= sed
+EINFO ?= echo
+PYTHON ?= python
+
+# set default build options if missing
+TYPE ?= strict
+NAME ?= $(TYPE)
+DIRECT_INITRC ?= n
+POLY ?= n
+QUIET ?= y
+
+genxml := $(PYTHON) $(HEADERDIR)/support/segenxml.py
+
+docs = doc
+polxml = $(docs)/policy.xml
+xmldtd = $(HEADERDIR)/support/policy.dtd
+layerxml = metadata.xml
+
+globaltun = $(HEADERDIR)/global_tunables.xml
+globalbool = $(HEADERDIR)/global_booleans.xml
+
+# compile strict policy if requested.
+ifneq ($(findstring strict,$(TYPE)),)
+	M4PARAM += -D strict_policy
+endif
+
+# compile targeted policy if requested.
+ifneq ($(findstring targeted,$(TYPE)),)
+	M4PARAM += -D targeted_policy
+endif
+
+# enable MLS if requested.
+ifneq ($(findstring -mls,$(TYPE)),)
+	M4PARAM += -D enable_mls
+	CHECKPOLICY += -M
+	CHECKMODULE += -M
+endif
+
+# enable MLS if MCS requested.
+ifneq ($(findstring -mcs,$(TYPE)),)
+	M4PARAM += -D enable_mcs
+	CHECKPOLICY += -M
+	CHECKMODULE += -M
+endif
+
+# enable distribution-specific policy
+ifneq ($(DISTRO),)
+	M4PARAM += -D distro_$(DISTRO)
+endif
+
+# enable polyinstantiation
+ifeq ($(POLY),y)
+	M4PARAM += -D enable_polyinstantiation
+endif
+
+ifeq ($(DIRECT_INITRC),y)
+	M4PARAM += -D direct_sysadm_daemon
+endif
+
+ifeq ($(QUIET),y)
+	verbose := @
+endif
+
+M4PARAM += -D hide_broken_symptoms
+
+# policy headers
+m4support = $(wildcard $(HEADERDIR)/support/*.spt)
+all_layers = $(filter-out $(HEADERDIR)/support,$(shell find $(wildcard $(HEADERDIR)/*) -maxdepth 0 -type d))
+all_interfaces = $(foreach layer,$(all_layers),$(wildcard $(layer)/*.if))
+rolemap = $(HEADERDIR)/rolemap
+
+detected_layers =  $(filter-out CVS tmp $(docs),$(shell find $(wildcard *) -maxdepth 0 -type d))
+3rd_party_mods = $(wildcard *.te)
+3rd_party_ifs = $(3rd_party_mods:.te=.if)
+detected_mods = $(3rd_party_mods) $(foreach layer,$(detected_layers),$(wildcard $(layer)/*.te))
+detected_ifs = $(3rd_party_ifs) $(foreach layer,$(detected_layers),$(wildcard $(layer)/*.if))
+all_packages = $(detected_mods:.te=.pp)
+
+# if there are modules in the current directory, add them into the third party layer
+ifneq "$(3rd_party_ifs)" ""
+        genxml += -3 .
+endif
+
+########################################
+#
+# Functions
+#
+
+# parse-rolemap modulename,outputfile
+define parse-rolemap
+	$(verbose) $(M4) $(M4PARAM) $(rolemap) | \
+		$(AWK) '/^[[:blank:]]*[A-Za-z]/{ print "gen_require(type " $$3 "; role " $$1 ";)\n$1_per_userdomain_template(" $$2 "," $$3 "," $$1 ")" }' >> $2
+endef
+
+# peruser-expansion modulename,outputfile
+define peruser-expansion
+	$(verbose) echo "ifdef(\`""$1""_per_userdomain_template',\`" > $2
+	$(call parse-rolemap,$1,$2)
+	$(verbose) echo "')" >> $2
+endef
+
+.PHONY: clean all xml
+.SUFFIXES:
+.SUFFIXES: .pp
+
+########################################
+#
+# Main targets
+#
+
+all: $(all_packages)
+
+xml: $(polxml)
+
+########################################
+#
+# Build module packages
+#
+tmp/%.mod: $(m4support) tmp/all_interfaces.conf %.te
+	@$(EINFO) "Compliling $(NAME) $(basename $(@F)) module"
+	@test -d tmp || mkdir -p tmp
+	$(call peruser-expansion,$(basename $(@F)),$@.role)
+	$(verbose) $(M4) $(M4PARAM) -s $^ $@.role > $(@:.mod=.tmp)
+	$(verbose) $(CHECKMODULE) -m $(@:.mod=.tmp) -o $@
+
+tmp/%.mod.fc: $(m4support) %.fc
+	$(verbose) $(M4) $(M4PARAM) $^ > $@
+
+%.pp: tmp/%.mod tmp/%.mod.fc
+	@echo "Creating $(NAME) $(@F) policy package"
+	$(verbose) $(SEMOD_PKG) -o $@ -m $< -f $<.fc
+
+tmp/all_interfaces.conf: $(m4support) $(all_interfaces) $(detected_ifs)
+	@test -d tmp || mkdir -p tmp
+	$(verbose) m4 $^ | sed -e s/dollarsstar/\$$\*/g > $@
+
+
+########################################
+#
+# Documentation generation
+#
+
+# minimal dependencies here, because we don't want to rebuild
+# this and its dependents every time the dependencies
+# change.  Also use all .if files here, rather then just the
+# enabled modules.
+$(polxml): $(detected_ifs) $(foreach dir,$(all_layers),$(dir)/$(layerxml))
+	@echo "Creating $@"
+	@mkdir -p doc
+	$(verbose) echo '<?xml version="1.0" encoding="ISO-8859-1" standalone="no"?>' > $@
+	$(verbose) echo '<!DOCTYPE policy SYSTEM "$(xmldtd)">' >> $@
+	$(verbose) $(genxml) -m $(layerxml) --tunables-xml $(globaltun) --booleans-xml $(globalbool) $(all_layers) $(detected_layers) >> $@
+	$(verbose) if test -x $(XMLLINT) && test -f $(xmldtd); then \
+		$(XMLLINT) --noout --dtdvalid $(xmldtd) $@ ;\
+	fi
+
+########################################
+#
+# Clean the environment
+#
+
+clean:
+	rm -fR tmp
+	rm -f *.pp
Index: support/sedoctool.py
===================================================================
--- support/sedoctool.py	(.../trunk/refpolicy/support)	(revision 1476)
+++ support/sedoctool.py	(.../branches/xml-changes-20060208-1476/support)	(working copy)
@@ -55,7 +55,10 @@
 	"""
 
 	for node in doc.getElementsByTagName("tunable"):
-		s = string.split(format_txt_desc(node), "\n")
+		for desc in node.getElementsByTagName("desc"):
+			tun_desc = format_txt_desc(desc)
+		s = string.split(tun_desc, "\n")
+		file_name.write("#\n")
 		for line in s:
 			file_name.write("# %s\n" % line)
 		tun_name = tun_val = None
@@ -403,13 +406,15 @@
 			interface_desc = interface_summary = None
 			interface_name = interface.getAttribute("name")
 			interface_line = interface.getAttribute("lineno")
-			for desc in interface.getElementsByTagName("desc"):
-				interface_desc = format_html_desc(desc)
-			for desc in interface.getElementsByTagName("summary"):
-				interface_summary = format_html_desc(desc)
-			
+			for desc in interface.childNodes:
+				if desc.nodeName == "desc":
+					interface_desc = format_html_desc(desc)
+				elif desc.nodeName == "summary":
+					interface_summary = format_html_desc(desc)
+
 			for args in interface.getElementsByTagName("param"):
-				paramdesc = args.firstChild.data
+				for desc in args.getElementsByTagName("summary"):
+					paramdesc = format_html_desc(desc)
 				paramname = args.getAttribute("name")
 				if args.getAttribute("optional") == "true":
 					paramopt = "Yes"
@@ -442,13 +447,15 @@
 			template_desc = template_summary = None
 			template_name = template.getAttribute("name")
 			template_line = template.getAttribute("lineno")
-			for desc in template.getElementsByTagName("desc"):
-				template_desc = format_html_desc(desc)
-			for desc in template.getElementsByTagName("summary"):
-				template_summary = format_html_desc(desc)
-			
+			for desc in template.childNodes:
+				if desc.nodeName == "desc":
+					template_desc = format_html_desc(desc)
+				elif desc.nodeName == "summary":
+					template_summary = format_html_desc(desc)
+
 			for args in template.getElementsByTagName("param"):
-				paramdesc = args.firstChild.data
+				for desc in args.getElementsByTagName("summary"):
+					paramdesc = format_html_desc(desc)
 				paramname = args.getAttribute("name")
 				if args.getAttribute("optional") == "true":
 					paramopt = "Yes"
@@ -558,7 +565,8 @@
 		if tunable.parentNode.nodeName == "policy":
 			tunable_name = tunable.getAttribute("name")
 			default_value = tunable.getAttribute("dftval")
-			description = format_html_desc(tunable)
+			for desc in tunable.getElementsByTagName("desc"):
+				description = format_html_desc(desc)
 			global_tun_buf.append( { "tun_name" : tunable_name,
 						"def_val" : default_value,
 						"desc" : description } )
@@ -582,7 +590,8 @@
 		if boolean.parentNode.nodeName == "policy":
 			bool_name = boolean.getAttribute("name")
 			default_value = boolean.getAttribute("dftval")
-			description = format_html_desc(boolean)
+			for desc in boolean.getElementsByTagName("desc"):
+				description = format_html_desc(desc)
 			global_bool_buf.append( { "bool_name" : bool_name,
 						"def_val" : default_value,
 						"desc" : description } )
Index: support/segenxml.py
===================================================================
--- support/segenxml.py	(.../trunk/refpolicy/support)	(revision 1476)
+++ support/segenxml.py	(.../branches/xml-changes-20060208-1476/support)	(working copy)
@@ -1,8 +1,10 @@
 #!/usr/bin/python
 
-#  Author: Donald Miner <dminer@tresys.com>
+#  Author(s): Donald Miner <dminer@tresys.com>
+#             Dave Sugar <dsugar@tresys.com>
+#             Brian Williams <bwilliams@tresys.com>
 #
-# Copyright (C) 2003 - 2005 Tresys Technology, LLC
+# Copyright (C) 2003 - 2006 Tresys Technology, LLC
 #      This program is free software; you can redistribute it and/or modify
 #      it under the terms of the GNU General Public License as published by
 #      the Free Software Foundation, version 2.
@@ -20,12 +22,15 @@
 # GLOBALS
 
 # Default values of command line arguments:
-directory = "./"
 warn = False
 meta = "metadata"
-layers = []
+third_party = "third-party"
+layers = {}
 tunable_files = []
 bool_files = []
+xml_tunable_files = []
+xml_bool_files = []
+output_dir = ""
 
 # Pre compiled regular expressions:
 
@@ -144,11 +149,14 @@
 			# Add default summaries and parameters so that the
 			#  DTD is happy.
 			else:
+				warning ("unable to find XML for %s %s()" % (groups[0], groups[1]))	
 				module_buf.append("<summary>\n")
 				module_buf.append("Summary is missing!\n")
 				module_buf.append("</summary>\n")
 				module_buf.append("<param name=\"?\">\n")
+				module_buf.append("<summary>")
 				module_buf.append("Parameter descriptions are missing!\n")
+				module_buf.append("</summary>")
 				module_buf.append("</param>\n")
 
 			# Close the interface/template tag.
@@ -171,7 +179,7 @@
 
 	return module_buf
 
-def getLayerXML(directory):
+def getLayerXML (layerName, directories):
 	'''
 	Returns the XML documentation for a layer.
 	'''
@@ -179,21 +187,35 @@
 	layer_buf = []
 
 	# Infer the layer name from the directory name.
-	layer_buf.append("<layer name=\"%s\">\n" % os.path.basename(directory))
+	layer_buf.append("<layer name=\"%s\">\n" % layerName)
 
-	# Try to open the metadata file for this directory and if it exists,
+	# Try to file the metadata file for this layer and if it exists,
 	# append the contents to the buffer.
-	try:
-		layer_meta = open(directory+"/"+meta, "r")
-		layer_buf += layer_meta.readlines()
-		layer_meta.close()
-	except:
-		warning("cannot open file %s for read, assuming no data"\
-			% meta)
+	bFoundMeta = False
+	for directory in directories:
+		metafile = directory + "/" + meta
 
+		if not bFoundMeta and os.path.isfile (metafile):
+			layer_meta = open (metafile, "r")
+			layer_buf += layer_meta.readlines ()
+			layer_meta.close()
+			bFoundMeta = True
+
+	# force the metadata for the third party layer
+	if not bFoundMeta:
+		if layerName == third_party:
+			layer_buf.append ("<summary>This is all third-party generated modules.</summary>\n")
+			bFoundMeta = True
+
+	# didn't find meta data for this layer - oh well	
+	if not bFoundMeta:
+		layer_buf.append ("<summary>Summary is missing!.</summary>\n")
+		warning ("unable to find %s for layer %s" % (meta, layerName))	
+	
 	# For each module file in the layer, add its XML.
-	for module in glob.glob("%s/*.if" % directory):
-		layer_buf += getModuleXML(module)
+	for directory in directories:
+		for module in glob.glob("%s/*.if" % directory):
+			layer_buf += getModuleXML(module)
 
 	layer_buf.append("</layer>\n")
 
@@ -222,7 +244,7 @@
 		# If it is an XML comment, add it to the buffer and go on.
 		comment = XML_COMMENT.match(line)
 		if comment:
-			temp_buf.append(comment.group(1))
+			temp_buf.append(comment.group(1) + "\n")
 			continue
 
 		# Get the boolean/tunable data.
@@ -246,50 +268,70 @@
 	if len(temp_buf):
 		warning("orphan XML comments at bottom of file %s" % file_name)
 
+
+	# If the caller requested a the global_tunables and global_booleans to be
+	# output to a file output them now
+	if len(output_dir) > 0:
+		xmlfile = os.path.split(file_name)[1] + ".xml"
+
+		try:
+			xml_outfile = open(output_dir + "/" + xmlfile, "w")
+			for tunable_line in tunable_buf:
+				xml_outfile.write (tunable_line)
+			xml_outfile.close()
+		except:
+			warning ("cannot write to file %s, skipping creation" % xmlfile)
+
 	return tunable_buf
 
-def getPolicyXML(directory):
+def getXMLFileContents (file_name):
 	'''
-	Return the compelete reference policy XML documentation through a list,
-	one line per item.
+	Return all the XML in the file specified.
 	'''
 
-	# Keep track of original path so that it will change back at the end.
-	old_dir = os.path.abspath(os.path.curdir)
-
-	# Attempt to change directory into the policy directory. If it doesn't
-	# exist just return an empty documentation.
+	tunable_buf = []
+	# Try to open the xml file for this type of file
+	# append the contents to the buffer.
 	try:
-		os.chdir(directory)
+		tunable_xml = open(file_name, "r")
+		tunable_buf += tunable_xml.readlines()
+		tunable_xml.close()
 	except:
-		warning("cannot change directory to %s, ignoring"\
-			% directory)
-		return []
+		warning("cannot open file %s for read, assuming no data" % file_name)
 
+	return tunable_buf
+
+def getPolicyXML():
+	'''
+	Return the compelete reference policy XML documentation through a list,
+	one line per item.
+	'''
+
 	policy_buf = []
 	policy_buf.append("<policy>\n")
 
 	# Add to the XML each layer specified by the user.
-	for layer in layers:
-		policy_buf += getLayerXML(layer)
+	for layer in layers.keys ():
+		policy_buf += getLayerXML(layer, layers[layer])
 
 	# Add to the XML each tunable file specified by the user.
 	for tunable_file in tunable_files:
 		policy_buf += getTunableXML(tunable_file, "tunable")
 
+	# Add to the XML each XML tunable file specified by the user.
+	for tunable_file in xml_tunable_files:
+		policy_buf += getXMLFileContents (tunable_file)
+
 	# Add to the XML each bool file specified by the user.
 	for bool_file in bool_files:
 		policy_buf += getTunableXML(bool_file, "bool")
 
+	# Add to the XML each XML bool file specified by the user.
+	for bool_file in xml_bool_files:
+		policy_buf += getXMLFileContents (bool_file)
 
 	policy_buf.append("</policy>\n")
 
-	# Return to old directory.
-	try:
-		os.chdir(old_dir)
-	except:
-		error("cannot change directory to %s" % old_dir)
-
 	return policy_buf
 
 def usage():
@@ -297,28 +339,40 @@
 	Displays a message describing the proper usage of this script.
 	"""
 
-	sys.stdout.write("usage: %s [-w] [-d directory] [-m file] "\
+	sys.stdout.write("usage: %s [-w] [-m file] "\
 		% sys.argv[0])
 
 	sys.stdout.write("layerdirectory [layerdirectory...]\n\n")
 
 	sys.stdout.write("Options:\n")
 
-	sys.stdout.write("-w --warn		--	"+\
+	sys.stdout.write ("-h --help                      -- "+\
+				"show command line options\n")
+
+	sys.stdout.write("-w --warn                      -- "+\
 				"show warnings\n")
 
-	sys.stdout.write("-m --meta <file>	--	"+\
+	sys.stdout.write("-m --meta <file>               -- "+\
 				"the filename of the metadata in each layer\n")
 
-	sys.stdout.write("-d --directory <dir>	--	"+\
-				"directory where the layers are\n")
-
-	sys.stdout.write("-t --tunable <file>	--	"+\
+	sys.stdout.write("-t --tunable <file>            -- "+\
 				"A file containing tunable declarations\n")
 
-	sys.stdout.write("-b --bool <file>      --      "+\
+	sys.stdout.write("-b --bool <file>               -- "+\
 				"A file containing bool declarations\n")
+												   
+	sys.stdout.write("-o --output-dir <directory>    -- "+\
+				"A directory to output global_tunables.xml and global_booleans.xml\n")
 
+	sys.stdout.write("--tunables-xml <file>          -- "+\
+				"A file containing tunable declarations already in XML format\n")
+
+	sys.stdout.write("--booleans-xml <file>          -- "+\
+				"A file containing bool declarations already in XML format\n")
+				
+	sys.stdout.write ("-3 --third-party <directory>   -- "+\
+				"Look for 3rd Party modules in directory.\n")
+
 def warning(description):
 	'''
 	Warns the user of a non-critical error.
@@ -349,16 +403,13 @@
 
 # Parse the command line arguments
 for i in range(1, len(sys.argv)):
-	if sys.argv[i-1] in ("-d", "--directory", "-m", "--meta",\
-					"-t", "--tunable", "-b", "--bool"):
+	if sys.argv[i-1] in ("-m", "--meta",\
+					"-t", "--tunable", "-b", "--bool",\
+					"-o", "--output-dir", "-3", "--third-party", \
+					"--tunables-xml", "--booleans-xml"):
 		continue
 	elif sys.argv[i] in ("-w", "--warn"):
 		warn = True
-	elif sys.argv[i] in ("-d", "--directory"):
-		if i < len(sys.argv)-1:
-			directory = sys.argv[i+1]
-		else:
-			usage()
 	elif sys.argv[i] in ("-m", "--meta"):
 		if i < len(sys.argv)-1:
 			meta = sys.argv[i+1]
@@ -374,12 +425,49 @@
 			bool_files.append(sys.argv[i+1])
 		else:
 			usage()
+	
+	elif sys.argv[i] == "--tunables-xml":
+		if i < len(sys.argv)-1:
+			xml_bool_files.append (sys.argv[i+1])
+		else:
+			usage ()
+			
+	elif sys.argv[i] == "--booleans-xml":
+		if i < len(sys.argv)-1:
+			xml_tunable_files.append (sys.argv[i+1])
+		else:
+			usage ()
+			
+	elif sys.argv[i] in ("-o", "--output-dir"):
+		if i < len(sys.argv)-1:
+			output_dir = sys.argv[i+1]
+		else:
+			usage ()
+			
+	elif sys.argv[i] in ("-3", "--third-party"):
+		if i < len(sys.argv) -1:
+			if layers.has_key (third_party):
+				layers[third_party].append (sys.argv[i+1])
+			else:
+				layers[third_party] = [sys.argv[i+1]]
+		else:
+			usage ()
 
+	elif sys.argv[i] in ("-h", "--help"):
+		usage ()
+		sys.exit (1)
+
 	else:
-		layers.append(sys.argv[i])
+		# store directories in hash stored by layer name
+		splitlayer = os.path.split(sys.argv[i])
+		if layers.has_key (splitlayer[1]):
+			layers[splitlayer[1]].append (sys.argv[i])
+		else:
+			layers[splitlayer[1]] = [sys.argv[i]]
 
 
 # Generate the XML and output it to a file
-lines = getPolicyXML(directory)
+lines = getPolicyXML()
 for s in lines:
 	sys.stdout.write(s)
+
Index: Makefile
===================================================================
--- Makefile	(.../trunk/refpolicy/Makefile)	(revision 1476)
+++ Makefile	(.../branches/xml-changes-20060208-1476/Makefile)	(working copy)
@@ -273,7 +273,7 @@
 	@mkdir -p tmp
 	$(verbose) echo '<?xml version="1.0" encoding="ISO-8859-1" standalone="no"?>' > $@
 	$(verbose) echo '<!DOCTYPE policy SYSTEM "$(notdir $(XMLDTD))">' >> $@
-	$(verbose) $(GENXML) -w -m $(LAYERXML) -t $(GLOBALTUN) -b $(GLOBALBOOL) $(ALL_LAYERS) >> $@
+	$(verbose) $(GENXML) -m $(LAYERXML) -t $(GLOBALTUN) -b $(GLOBALBOOL) -o tmp $(ALL_LAYERS) >> $@
 	$(verbose) if test -x $(XMLLINT) && test -f $(XMLDTD); then \
 		$(XMLLINT) --noout --dtdvalid $(XMLDTD) $@ ;\
 	fi
@@ -358,21 +358,38 @@
 #
 # Install policy headers
 #
-install-headers: $(DETECTED_MODS:.te=.if) $(ROLEMAP) $(M4SUPPORT)
+install-headers: doc/policy.xml
 	@mkdir -p $(HEADERDIR)
 	@echo "Installing policy headers"
-	$(verbose) install -m 644 $^ $(HEADERDIR)
-	$(verbose) $(GENPERM) $(AVS) $(SECCLASS) > $(HEADERDIR)/all_perms.spt
+	$(verbose) install -m 644 tmp/global_{tunables,booleans}.xml $(HEADERDIR)
+	$(verbose) m4 $(M4PARAM) $(ROLEMAP) > $(HEADERDIR)/$(notdir $(ROLEMAP))
+	$(verbose) mkdir -p $(HEADERDIR)/support
+	$(verbose) install -m 644 $(M4SUPPORT) $(GENXML) $(XMLDTD) $(HEADERDIR)/support
+	$(verbose) $(GENPERM) $(AVS) $(SECCLASS) > $(HEADERDIR)/support/all_perms.spt
+	$(verbose) for i in $(notdir $(ALL_LAYERS)); do \
+		mkdir -p $(HEADERDIR)/$$i ;\
+		install -m 644 $(MODDIR)/$$i/*.if \
+			$(MODDIR)/$$i/metadata.xml \
+			$(HEADERDIR)/$$i ;\
+	done
+	$(verbose) echo "TYPE=$(TYPE)" > $(HEADERDIR)/build.conf
+	$(verbose) echo "NAME=$(NAME)" >> $(HEADERDIR)/build.conf
+ifneq "$(DISTRO)" ""
+	$(verbose) echo "DISTRO=$(DISTRO)" >> $(HEADERDIR)/build.conf
+endif
+	$(verbose) echo "MONOLITHIC=n" >> $(HEADERDIR)/build.conf
+	$(verbose) echo "DIRECT_INITRC=$(DIRECT_INITRC)" >> $(HEADERDIR)/build.conf
+	$(verbose) echo "POLY=$(POLY)" >> $(HEADERDIR)/build.conf
+	$(verbose) install -m 644 $(SUPPORT)/Makefile.devel $(HEADERDIR)/Makefile
 
 ########################################
 #
 # Install policy documentation
 #
-install-docs: $(DOCFILES) build.conf tmp/html
+install-docs: tmp/html
 	@mkdir -p $(DOCSDIR)/html
 	@echo "Installing policy documentation"
 	$(verbose) install -m 644 $(DOCFILES) $(DOCSDIR)
-	$(verbose) install -m 644 build.conf $(DOCSDIR)/build.conf.example
 	$(verbose) install -m 644 $(wildcard $(HTMLDIR)/*) $(DOCSDIR)/html
 
 ########################################
Index: policy/global_booleans
===================================================================
--- policy/global_booleans	(.../trunk/refpolicy/policy/global_booleans)	(revision 1476)
+++ policy/global_booleans	(.../branches/xml-changes-20060208-1476/policy/global_booleans)	(working copy)
@@ -4,15 +4,27 @@
 # file should be used.
 #
 
+## <desc>
+## <p>
 ## Enabling secure mode disallows programs, such as
 ## newrole, from transitioning to administrative
 ## user domains.
+## </p>
+## </desc>
 gen_bool(secure_mode,false)
 
+## <desc>
+## <p>
 ## Disable transitions to insmod.
+## </p>
+## </desc>
 gen_bool(secure_mode_insmod,false)
 
+## <desc>
+## <p>
 ## boolean to determine whether the system permits loading policy, setting
 ## enforcing mode, and changing boolean values.  Set this to true and you
 ## have to reboot to set it back
+## </p>
+## </desc>
 gen_bool(secure_mode_policyload,false)
Index: policy/global_tunables
===================================================================
--- policy/global_tunables	(.../trunk/refpolicy/policy/global_tunables)	(revision 1476)
+++ policy/global_tunables	(.../branches/xml-changes-20060208-1476/policy/global_tunables)	(working copy)
@@ -9,142 +9,312 @@
 # Common tunables
 #
 
+## <desc>
+## <p>
 ## Allow cvs daemon to read shadow
+## </p>
+## </desc>
+#
 gen_tunable(allow_cvs_read_shadow,false)
 
+## <desc>
+## <p>
 ## Allow making the heap executable.
+## </p>
+## </desc>
 gen_tunable(allow_execheap,false)
 
+
+## <desc>
+## <p>
 ## Allow making anonymous memory executable, e.g. 
 ## for runtime-code generation or executable stack.
+## </p>
+## </desc>
 gen_tunable(allow_execmem,false)
 
+## <desc>
+## <p>
 ## Allow making a modified private file
 ## mapping executable (text relocation).
+## </p>
+## </desc>
 gen_tunable(allow_execmod,false)
 
+## <desc>
+## <p>
 ## Allow making the stack executable via mprotect.
 ## Also requires allow_execmem.
+## </p>
+## </desc>
 gen_tunable(allow_execstack,false)
 
+## <desc>
+## <p>
 ## Allow ftp servers to modify public files
 ## used for public file transfer services.
+## </p>
+## </desc>
 gen_tunable(allow_ftpd_anon_write,false)
 
+## <desc>
+## <p>
 ## Allow gssd to read temp directory.
+## </p>
+## </desc>
 gen_tunable(allow_gssd_read_tmp,true)
 
+## <desc>
+## <p>
 ## Allow Apache to modify public files
 ## used for public file transfer services.
+## </p>
+## </desc>
 gen_tunable(allow_httpd_anon_write,false)
 
+## <desc>
+## <p>
 ## Allow java executable stack
+## </p>
+## </desc>
 gen_tunable(allow_java_execstack,false)
 
+## <desc>
+## <p>
 ## Allow system to run with kerberos
+## </p>
+## </desc>
 gen_tunable(allow_kerberos,false)
 
+## <desc>
+## <p>
 ## Allow rsync to modify public files
 ## used for public file transfer services.
+## </p>
+## </desc>
 gen_tunable(allow_rsync_anon_write,false)
 
+## <desc>
+## <p>
 ## Allow sasl to read shadow
+## </p>
+## </desc>
 gen_tunable(allow_saslauthd_read_shadow,false)
 
+## <desc>
+## <p>
 ## Allow samba to modify public files
 ## used for public file transfer services.
+## </p>
+## </desc>
 gen_tunable(allow_smbd_anon_write,false)
 
+## <desc>
+## <p>
 ## Allow sysadm to ptrace all processes
+## </p>
+## </desc>
 gen_tunable(allow_ptrace,false)
 
+## <desc>
+## <p>
 ## Allow system to run with NIS
+## </p>
+## </desc>
 gen_tunable(allow_ypbind,false)
 
+## <desc>
+## <p>
 ## Enable extra rules in the cron domain
 ## to support fcron.
+## </p>
+## </desc>
 gen_tunable(fcron_crond,false)
 
+## <desc>
+## <p>
 ## Allow ftp to read and write files in the user home directories
+## </p>
+## </desc>
 gen_tunable(ftp_home_dir,false)
 
+## <desc>
+## <p>
 ## Allow ftpd to run directly without inetd
+## </p>
+## </desc>
 gen_tunable(ftpd_is_daemon,false)
 
+## <desc>
+## <p>
 ## Allow httpd to use built in scripting (usually php)
+## </p>
+## </desc>
 gen_tunable(httpd_builtin_scripting,false)
 
+## <desc>
+## <p>
 ## Allow http daemon to tcp connect 
+## </p>
+## </desc>
 gen_tunable(httpd_can_network_connect,false)
 
-## allow httpd to connect to mysql/posgresql 
+## <desc>
+## <p>
+## Allow httpd to connect to mysql/posgresql 
+## </p>
+## </desc>
 gen_tunable(httpd_can_network_connect_db, false)
 
-## allow httpd to act as a relay 
+## <desc>
+## <p>
+## Allow httpd to act as a relay 
+## </p>
+## </desc>
 gen_tunable(httpd_can_network_relay, false)
 
+## <desc>
+## <p>
 ## Allow httpd cgi support
+## </p>
+## </desc>
 gen_tunable(httpd_enable_cgi,false)
 
+## <desc>
+## <p>
 ## Allow httpd to act as a FTP server by
 ## listening on the ftp port.
+## </p>
+## </desc>
 gen_tunable(httpd_enable_ftp_server,false)
 
+## <desc>
+## <p>
 ## Allow httpd to read home directories
+## </p>
+## </desc>
 gen_tunable(httpd_enable_homedirs,false)
 
+## <desc>
+## <p>
 ## Run SSI execs in system CGI script domain.
+## </p>
+## </desc>
 gen_tunable(httpd_ssi_exec,false)
 
+## <desc>
+## <p>
 ## Allow http daemon to communicate with the TTY
+## </p>
+## </desc>
 gen_tunable(httpd_tty_comm,false)
 
+## <desc>
+## <p>
 ## Run CGI in the main httpd domain
+## </p>
+## </desc>
 gen_tunable(httpd_unified,false)
 
+## <desc>
+## <p>
 ## Allow BIND to write the master zone files.
 ## Generally this is used for dynamic DNS.
+## </p>
+## </desc>
 gen_tunable(named_write_master_zones,false)
 
+## <desc>
+## <p>
 ## Allow nfs to be exported read/write.
+## </p>
+## </desc>
 gen_tunable(nfs_export_all_rw,false)
 
+## <desc>
+## <p>
 ## Allow nfs to be exported read only
+## </p>
+## </desc>
 gen_tunable(nfs_export_all_ro,false)
 
+## <desc>
+## <p>
 ## Allow pppd to load kernel modules for certain modems
+## </p>
+## </desc>
 gen_tunable(pppd_can_insmod,false)
 
+## <desc>
+## <p>
 ## Allow reading of default_t files.
+## </p>
+## </desc>
 gen_tunable(read_default_t,false)
 
+## <desc>
+## <p>
 ## Allow ssh to run from inetd instead of as a daemon.
+## </p>
+## </desc>
 gen_tunable(run_ssh_inetd,false)
 
+## <desc>
+## <p>
 ## Allow samba to export user home directories.
+## </p>
+## </desc>
 gen_tunable(samba_enable_home_dirs,false)
 
+## <desc>
+## <p>
 ## Allow spamassassin to do DNS lookups
+## </p>
+## </desc>
 gen_tunable(spamassasin_can_network,false)
 
+## <desc>
+## <p>
 ## Allow squid to connect to all ports, not just
 ## HTTP, FTP, and Gopher ports.
+## </p>
+## </desc>
 gen_tunable(squid_connect_any,false)
 
+## <desc>
+## <p>
 ## Allow ssh logins as sysadm_r:sysadm_t
+## </p>
+## </desc>
 gen_tunable(ssh_sysadm_login,false)
 
+## <desc>
+## <p>
 ## Configure stunnel to be a standalone daemon or
 ## inetd service.
+## </p>
+## </desc>
 gen_tunable(stunnel_is_daemon,false)
 
+## <desc>
+## <p>
 ## Support NFS home directories
+## </p>
+## </desc>
 gen_tunable(use_nfs_home_dirs,false)
 
+## <desc>
+## <p>
 ## Support SAMBA home directories
+## </p>
+## </desc>
 gen_tunable(use_samba_home_dirs,false)
 
+## <desc>
+## <p>
 ## Control users use of ping and traceroute
+## </p>
+## </desc>
 gen_tunable(user_ping,false)
 
 ########################################
@@ -153,69 +323,141 @@
 #
 
 ifdef(`targeted_policy',`',`
+## <desc>
+## <p>
 ## Allow gpg executable stack
+## </p>
+## </desc>
 gen_tunable(allow_gpg_execstack,false)
 
+## <desc>
+## <p>
 ## allow host key based authentication
+## </p>
+## </desc>
 gen_tunable(allow_ssh_keysign,false)
 
+## <desc>
+## <p>
 ## Allow users to connect to mysql
+## </p>
+## </desc>
 gen_tunable(allow_user_mysql_connect,false)
 
+## <desc>
+## <p>
 ## Allow cdrecord to read various content.
 ## nfs, samba, removable devices, user temp
 ## and untrusted content files
+## </p>
+## </desc>
 gen_tunable(cdrecord_read_content,false)
 
+## <desc>
+## <p>
 ## Allow system cron jobs to relabel filesystem
 ## for restoring file contexts.
+## </p>
+## </desc>
 gen_tunable(cron_can_relabel,false)
 
+## <desc>
+## <p>
 ## Allow pppd to be run for a regular user
+## </p>
+## </desc>
 gen_tunable(pppd_for_user,false)
 
+## <desc>
+## <p>
 ## Allow applications to read untrusted content
 ## If this is disallowed, Internet content has
 ## to be manually relabeled for read access to be granted
+## </p>
+## </desc>
 gen_tunable(read_untrusted_content,false)
 
+## <desc>
+## <p>
 ## Allow user spamassassin clients to use the network.
+## </p>
+## </desc>
 gen_tunable(spamassassin_can_network,false)
 
+## <desc>
+## <p>
 ## Allow staff_r users to search the sysadm home 
 ## dir and read files (such as ~/.bashrc)
+## </p>
+## </desc>
 gen_tunable(staff_read_sysadm_file,false)
 
+## <desc>
+## <p>
 ## Allow regular users direct mouse access 
+## </p>
+## </desc>
 gen_tunable(user_direct_mouse,false)
 
+## <desc>
+## <p>
 ## Allow users to read system messages.
+## </p>
+## </desc>
 gen_tunable(user_dmesg,false)
 
+## <desc>
+## <p>
 ## Allow users to control network interfaces
 ## (also needs USERCTL=true)
+## </p>
+## </desc>
 gen_tunable(user_net_control,false)
 
+## <desc>
+## <p>
 ## Allow user to r/w files on filesystems
 ## that do not have extended attributes (FAT, CDROM, FLOPPY)
+## </p>
+## </desc>
 gen_tunable(user_rw_noexattrfile,false)
 
+## <desc>
+## <p>
 ## Allow users to rw usb devices
+## </p>
+## </desc>
 gen_tunable(user_rw_usb,false)
 
+## <desc>
+## <p>
 ## Allow users to run TCP servers (bind to ports and accept connection from
 ## the same domain and outside users)  disabling this forces FTP passive mode
 ## and may change other protocols.
+## </p>
+## </desc>
 gen_tunable(user_tcp_server,false)
 
+## <desc>
+## <p>
 ## Allow w to display everyone
+## </p>
+## </desc>
 gen_tunable(user_ttyfile_stat,false)
 
+## <desc>
+## <p>
 ## Allow applications to write untrusted content
 ## If this is disallowed, no Internet content
 ## will be stored.
+## </p>
+## </desc>
 gen_tunable(write_untrusted_content,false)
 
+## <desc>
+## <p>
 ## Allow xdm logins as sysadm
+## </p>
+## </desc>
 gen_tunable(xdm_sysadm_login,false)
 ')

--Boundary-00=_0kO7DiLW39ZGI0r
Content-Type: text/plain;
  charset="us-ascii";
  name="param.sed"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="param.sed"

/<param .*>/a\
##	<summary>
/<\/param>/i\
##	</summary>

--Boundary-00=_0kO7DiLW39ZGI0r--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
