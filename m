Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6FHixmn027962
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 13:44:59 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6FHiwd3019351
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 17:44:58 GMT
Received: by fg-out-1718.google.com with SMTP id 16so2330294fgg.40
        for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 10:44:57 -0700 (PDT)
Message-ID: <cadfc0e40807151044t62062e1ap7950c5a0f2c1e5a4@mail.gmail.com>
Date: Tue, 15 Jul 2008 12:44:57 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux List" <selinux@tycho.nsa.gov>
Subject: rawhide policy on FC9 build fails
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I wanted to experiment with running the latest policy (I want the
latest X policy) on FC9 so I got the source rpm and tried to build it.
I update to the required checkpolicy version and also update libsepol
since rawhide and FC9 use the same version. The rpmbuild however fails

m4 -D enable_mls -D distro_redhat -D mls_num_sens=16 -D
mls_num_cats=1024 -D mcs_num_cats=1024 -D hide_broken_symptoms -D
self_contained_policy policy/support/file_patterns.spt
policy/support/ipc_patterns.spt policy/support/loadable_module.spt
policy/support/misc_macros.spt policy/support/misc_patterns.spt
policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
tmp/generated_definitions.conf policy/global_booleans
policy/global_tunables > tmp/global_bools.conf
Creating mls base module base.conf
cat tmp/pre_te_files.conf tmp/all_attrs_types.conf
tmp/global_bools.conf tmp/only_te_rules.conf tmp/all_post.conf >
base.conf
Compiling mls base module
/usr/bin/checkmodule -M -U deny base.conf -o tmp/base.mod
/usr/bin/checkmodule:  loading policy configuration from base.conf
libsepol.expand_module: Error while indexing out symbols
/usr/bin/checkmodule:  expand module failed
make: *** [tmp/base.mod] Error 1
error: Bad exit status from /var/tmp/rpm-tmp.2964 (%install)


RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.2964 (%install)

I know this is a bit out of the mainstream but I'd appreciate any help.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
