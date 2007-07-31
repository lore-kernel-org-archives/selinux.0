Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6VL5vM2010405
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 17:05:57 -0400
Received: from scarecrow.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6VL5tfo024758
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 21:05:55 GMT
Message-Id: <20070731195342.340369019@manicmethod.com>
References: <20070731195112.978592561@manicmethod.com>
Date: Tue, 31 Jul 2007 15:51:14 -0400
From: method@manicmethod.com
To: kmacmillan@mentalrootkit.com, selinux@tycho.nsa.gov
Subject: [POLICYREP][patchv3 2/3] policy package implementation
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This includes 2 classes, one for handling "files" --> "policy package" (PolicyPackageArchive) and one for handling "policy package" <--> "package class" (PolicyPackage). Currently PolicyPackage::write() doesn't work but it is all implemented so I just return; at the top of that function for now.

This policy package format uses xar and uses the file attribute "selinuxfiletype" to determine what kind of file each one in the archive is (eg., module, file_contexts, etc).

---
 libpolicyrep/src/policy_package.cpp |  463 ++++++++++++++++++++++++++++++++++++
 1 file changed, 463 insertions(+)

--- /dev/null
+++ policyrep-policy_package/libpolicyrep/src/policy_package.cpp
@@ -0,0 +1,463 @@
+/*
+ * Author : Joshua Brindle <method@manicmethod.com>
+ *
+ * Copyright (C) 2007 Tresys Technology, llc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+extern "C" {
+#include <xar/xar.h>
+#include <string.h>
+}
+
+#define SELINUX_XAR_PROPERTY "selinuxfiletype"
+
+#include <policyrep/parse.hpp>
+#include <policyrep/policy_package.hpp>
+#include <sstream>
+#include <iostream>
+#include <stdexcept>
+
+namespace policyrep {
+
+struct PolicyPackageImpl {
+	Module & policy_module;
+	char *file_contexts;
+	char *seusers;
+	char *user_extra;
+	char *netfilter_contexts;
+};
+
+void PolicyPackage::init() {
+	impl = new PolicyPackageImpl;
+	impl->file_contexts = NULL;
+	impl->seusers = NULL;
+	impl->user_extra = NULL;
+	impl->netfilter_contexts = NULL;
+}
+
+PolicyPackage::PolicyPackage() {
+	init();
+}
+
+Module & PolicyPackage::get_policy_module() const {
+	return impl->policy_module;
+}
+
+void PolicyPackage::set_policy_module(Module & module) {
+	impl->policy_module = module;
+}
+
+char *PolicyPackage::get_file_contexts() const {
+	return impl->file_contexts;
+}
+
+void PolicyPackage::set_file_contexts(char *fc) {
+	impl->file_contexts = fc;
+}
+
+char *PolicyPackage::get_seusers() const {
+	return impl->seusers;
+}
+
+void PolicyPackage::set_seusers(char *se) {
+	impl->seusers = se;
+}
+
+char *PolicyPackage::get_user_extra() const {
+	return impl->user_extra;
+}
+
+void PolicyPackage::set_user_extra(char *ue) {
+	impl->user_extra = ue;
+}
+
+char *PolicyPackage::get_netfilter_contexts() const {
+	return impl->netfilter_contexts;
+}
+
+void PolicyPackage::set_netfilter_contexts(char *nc) {
+	impl->netfilter_contexts = nc;
+}
+
+void PolicyPackage::read(char *filename) {
+	xar_t x;
+	xar_file_t f;
+	xar_iter_t i;
+
+	i = xar_iter_new();
+
+	if (i == NULL) {
+		throw std::bad_alloc();
+	}
+
+	x = xar_open(filename, READ);
+
+	if (x == NULL) {
+		throw std::
+		runtime_error("Unable to open policy package");
+	}
+
+	for (f = xar_file_first(x, i); f; f = xar_file_next(i)) {
+		size_t sz;
+		char *fbuf;
+		const char *filetype;
+		int32_t ret;
+
+		ret = xar_extract_tobuffersz(x, f, &fbuf, &sz);
+
+		if (ret) {
+			// This can happen if the file is 0 bytes
+			// or is a symlink, directory, etc. We might want
+			// to put code here to check those cases and bail
+			// but for now we just ignore them and continue.
+			continue;
+		}
+
+		ret = xar_prop_get(f, SELINUX_XAR_PROPERTY, &filetype);
+
+		if (ret) {
+			xar_close(x);
+			throw std::runtime_error("Error getting name property of file");
+		}
+
+		if (strcmp(filetype, "policy_module") == 0) {
+			Parser p;
+			// TODO add parser constructor that takes a char * and call here
+			continue;
+		} else if (strcmp(filetype, "file_contexts") == 0) {
+			if (impl->file_contexts) {
+				xar_close(x);
+				throw std::range_error("Multiple file_contexts files in policy package");
+			}
+
+			impl->file_contexts = fbuf;
+
+			continue;
+		} else if (strcmp(filetype, "seusers") == 0) {
+			if (impl->seusers) {
+				xar_close(x);
+				throw std::range_error("Multiple seusers files in policy package");
+			}
+
+			impl->seusers = fbuf;
+
+			continue;
+		} else if (strcmp(filetype, "user_extra") == 0) {
+			if (impl->user_extra) {
+				xar_close(x);
+				throw std::range_error("Multiple user_extra files in policy package");
+			}
+
+			impl->user_extra = fbuf;
+
+			continue;
+		} else if (strcmp(filetype, "netfilter_contexts") == 0) {
+			if (impl->netfilter_contexts) {
+				xar_close(x);
+				throw std::range_error("Multiple netfilter_contexts files in policy package");
+			}
+
+			impl->netfilter_contexts = fbuf;
+
+			continue;
+		} else {
+			// unrecognized file, just skip it
+			free(fbuf);
+			continue;
+		}
+
+	}
+
+	xar_close(x);
+}
+
+void PolicyPackage::write(char *filename) {
+
+	// just return -1 for now, this method exposes a xar bug and won't
+	// work until the bug is fixed.
+
+	return;
+
+	xar_t x;
+	xar_file_t f;
+
+	x = xar_open(filename, WRITE);
+
+	if (x == NULL) {
+		throw std::
+		runtime_error("Unable to open policy package");
+	}
+
+	if (!impl->policy_module.get_name().empty()) {
+		std::stringstream s;
+		char *buf;
+
+		// TODO fix this when the output system has been updated - jjb
+#if 0
+		output_tree(s, impl->policy_module);
+
+		if (s.str().empty()) {
+			throw std::runtime_error("Error serializing module");
+		}
+
+		buf = strdup(s.str().c_str());
+
+		f = xar_add_frombuffer(x, NULL, "policy_module", buf, s.str().length());
+		free(buf);
+
+		if (!f) {
+			xar_close(x);
+			throw std::runtime_error("Error writing policy module to policy package");
+		}
+
+		if (xar_prop_set(f, SELINUX_XAR_PROPERTY, "policy_module")) {
+			xar_close(x);
+			throw std::runtime_error("Error setting policy_module property in policy package");
+		}
+
+#endif
+	}
+
+	if (impl->file_contexts) {
+		f = xar_add_frombuffer(x, NULL, "file_contexts",
+		                       impl->file_contexts,
+		                       strlen(impl->file_contexts));
+
+		if (!f) {
+			xar_close(x);
+			throw std::runtime_error("Error writing file_contexts to policy package");
+		}
+
+		if (xar_prop_set(f, SELINUX_XAR_PROPERTY, "file_contexts")) {
+			xar_close(x);
+			throw std::runtime_error("Error setting file_contexts property in policy package");
+		}
+	}
+
+	if (impl->seusers) {
+		f = xar_add_frombuffer(x, NULL, "seusers",
+		                       impl->seusers,
+		                       strlen(impl->seusers));
+
+		if (!f) {
+			xar_close(x);
+			throw std::runtime_error("Error writing seusers to policy package");
+		}
+
+		if (xar_prop_set(f, SELINUX_XAR_PROPERTY, "seusers")) {
+			xar_close(x);
+			throw std::runtime_error("Error setting seusers property in policy package");
+		}
+	}
+
+	if (impl->user_extra) {
+		f = xar_add_frombuffer(x, NULL, "user_extra",
+		                       impl->user_extra,
+		                       strlen(impl->user_extra));
+
+		if (!f) {
+			xar_close(x);
+			throw std::runtime_error("Error writing user_extra to policy package");
+		}
+
+		if (xar_prop_set(f, SELINUX_XAR_PROPERTY, "user_extra")) {
+			xar_close(x);
+			throw std::runtime_error("Error setting user_extra property in policy package");
+		}
+	}
+
+	if (impl->netfilter_contexts) {
+		f = xar_add_frombuffer(x, NULL, "netfilter_contexts",
+		                       impl->netfilter_contexts,
+		                       strlen(impl->
+		                              netfilter_contexts));
+
+		if (!f) {
+			xar_close(x);
+			throw std::runtime_error("Error writing netfilter_contexts to policy package");
+		}
+
+		if (xar_prop_set(f, SELINUX_XAR_PROPERTY, "netfilter_contexts")) {
+			xar_close(x);
+			throw std::runtime_error("Error setting netfilter_contexts property in policy package");
+		}
+	}
+
+	xar_close(x);
+}
+
+PolicyPackage::~PolicyPackage() {
+	delete impl;
+}
+
+//
+// PolicyPackageArchive
+// This class is used for creating a policy package file from individual files.
+// Set the filenames for each kind of file (module, file_contexts, etc) then
+// call create_archive.
+
+struct PolicyPackageArchiveImpl {
+	char *mod_file;
+	char *fc_file;
+	char *seusers_file;
+	char *user_extra_file;
+	char *nc_file;
+};
+
+void PolicyPackageArchive::init() {
+	impl = new PolicyPackageArchiveImpl;
+	impl->mod_file = NULL;
+	impl->fc_file = NULL;
+	impl->seusers_file = NULL;
+	impl->user_extra_file = NULL;
+	impl->nc_file = NULL;
+}
+
+PolicyPackageArchive::PolicyPackageArchive() {
+	init();
+}
+
+void PolicyPackageArchive::set_mod_file(char *mod) {
+	impl->mod_file = mod;
+}
+
+char *PolicyPackageArchive::get_mod_file() const {
+	return impl->mod_file;
+}
+
+void PolicyPackageArchive::set_fc_file(char *fc) {
+	impl->fc_file = fc;
+}
+
+char *PolicyPackageArchive::get_fc_file() const {
+	return impl->fc_file;
+}
+
+void PolicyPackageArchive::set_seusers_file(char *su) {
+	impl->seusers_file = su;
+}
+
+char *PolicyPackageArchive::get_seusers_file() const {
+	return impl->seusers_file;
+}
+
+void PolicyPackageArchive::set_user_extra_file(char *ue) {
+	impl->user_extra_file = ue;
+}
+
+char *PolicyPackageArchive::get_user_extra_file() const {
+	return impl->user_extra_file;
+}
+
+void PolicyPackageArchive::set_nc_file(char *nc) {
+	impl->nc_file = nc;
+}
+
+char *PolicyPackageArchive::get_nc_file() const {
+	return impl->nc_file;
+}
+
+void PolicyPackageArchive::create_archive(char *filename) {
+	xar_t x;
+	xar_file_t f;
+
+	x = xar_open(filename, WRITE);
+
+	if (x == NULL) {
+		throw std::runtime_error("Unable to open policy package");
+	}
+
+	if (impl->mod_file) {
+		f = xar_add(x, impl->mod_file);
+
+		if (!f) {
+			xar_close(x);
+			throw std::runtime_error("Error writing module to policy package");
+		}
+
+		if (xar_prop_set(f, SELINUX_XAR_PROPERTY, "module")) {
+			xar_close(x);
+			throw std::runtime_error("Error setting module property in policy package");
+		}
+	}
+
+	if (impl->fc_file) {
+		f = xar_add(x, impl->fc_file);
+
+		if (!f) {
+			xar_close(x);
+			throw std::runtime_error("Error writing file_contexts to policy package");
+		}
+
+		if (xar_prop_set
+		                (f, SELINUX_XAR_PROPERTY, "file_contexts")) {
+			xar_close(x);
+			throw std::runtime_error("Error setting file_contexts property in policy package");
+		}
+	}
+
+	if (impl->seusers_file) {
+		f = xar_add(x, impl->seusers_file);
+
+		if (!f) {
+			xar_close(x);
+			throw std::runtime_error("Error writing seusers to policy package");
+		}
+
+		if (xar_prop_set(f, SELINUX_XAR_PROPERTY, "seusers")) {
+			xar_close(x);
+			throw std::runtime_error("Error setting seusers property in policy package");
+		}
+	}
+
+	if (impl->user_extra_file) {
+		f = xar_add(x, impl->user_extra_file);
+
+		if (!f) {
+			xar_close(x);
+			throw std::runtime_error("Error writing user_extra to policy package");
+		}
+
+		if (xar_prop_set(f, SELINUX_XAR_PROPERTY, "user_extra")) {
+			xar_close(x);
+			throw std::runtime_error("Error setting user_extra property in policy package");
+		}
+	}
+
+	if (impl->nc_file) {
+		f = xar_add(x, impl->nc_file);
+
+		if (!f) {
+			xar_close(x);
+			throw std::runtime_error("Error writing netfilter_contexts to policy package");
+		}
+
+		if (xar_prop_set
+		                (f, SELINUX_XAR_PROPERTY, "netfilter_contexts")) {
+			xar_close(x);
+			throw std::runtime_error("Error setting netfilter_contexts property in policy package");
+		}
+	}
+
+	xar_close(x);
+}
+
+PolicyPackageArchive::~PolicyPackageArchive() {
+	delete impl;
+}
+
+} // namespace policyrep

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
