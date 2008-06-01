Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m52EQ8u9015321
	for <selinux@tycho.nsa.gov>; Mon, 2 Jun 2008 10:26:08 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m52EQ8wL014372
	for <selinux@tycho.nsa.gov>; Mon, 2 Jun 2008 14:26:08 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id m52EPWDm003916
	for <selinux@tycho.nsa.gov>; Mon, 2 Jun 2008 10:25:32 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id m52EPWVK003915
	for selinux@tycho.nsa.gov; Mon, 2 Jun 2008 10:25:32 -0400
Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5196D3B005963
	for <selinux@tycho.nsa.gov>; Sun, 1 Jun 2008 05:06:17 -0400
Received: from ladon.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5196CIv018751
	for <selinux@tycho.nsa.gov>; Sun, 1 Jun 2008 09:06:12 GMT
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Recent problems recompiling libsemanage with new libustr (1.0.4)
Date: Sun, 01 Jun 2008 03:53:05 -0500
Message-ID: <874p8dy1se.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi folks,

        I  tried recompiling libsemanage on a recent Debian unstable
 box, and the build failed (error below). The same build, with the same
 code, had worked on  18 Mar 2008 . 

        The difference seems to be libustr version 1.0.3 works, and
 1.0.4 fails. I do not see anything in the upstream ChangeLog to explain
 this, offhand, though there have been a whole slew of new files in
 /usr/include for version 1.0.4 -- though there was no so name bump.

        This is just a heads up, I'll follow up with the ustr folks.

        manoj

--8<---------------cut here---------------start------------->8---
__> rgrep -n ustr_dup_buf /usr/include/
/usr/include/ustr-main.h:502:#define USTR_DUP_OBJ(y)     ustr_dup_buf(y, sizeof(y))
/usr/include/ustr-main.h:503:#define USTR_DUP_OSTR(y)    ustr_dup_buf(y, sizeof(y) - 1)
/usr/include/ustr-main.h:730:USTR_CONF_E_PROTO struct Ustr *ustr_dup_buf(const void *, size_t)
/usr/include/ustr-main.h:959:{ return (ustr_dup_buf(cstr, strlen(cstr))); }
--8<---------------cut here---------------end--------------->8---

cc -O2 -g -I../include -I/usr/include -D_GNU_SOURCE  -fPIC -DSHARED -c -o utilities.lo utilities.c
cc -O2 -g -I../include -I/usr/include -D_GNU_SOURCE -fPIC -DSHARED -c -o conf-scan.lo conf-scan.c
cc -O2 -g -I../include -I/usr/include -D_GNU_SOURCE -fPIC -DSHARED -c -o conf-parse.lo conf-parse.c
cc -O2 -g -I../include -I/usr/include -D_GNU_SOURCE  -s -s -shared -o libsemanage.so.1 boolean_record.lo booleans_active.lo booleans_activedb.lo booleans_file.lo booleans_local.lo booleans_policy.lo booleans_policydb.lo context_record.lo database.lo database_activedb.lo database_file.lo database_join.lo database_llist.lo database_policydb.lo debug.lo direct_api.lo fcontext_record.lo fcontexts_file.lo fcontexts_local.lo fcontexts_policy.lo genhomedircon.lo handle.lo iface_record.lo interfaces_file.lo interfaces_local.lo interfaces_policy.lo interfaces_policydb.lo modules.lo node_record.lo nodes_file.lo nodes_local.lo nodes_policy.lo nodes_policydb.lo parse_utils.lo policy_components.lo port_record.lo ports_file.lo ports_local.lo ports_policy.lo ports_policydb.lo semanage_store.lo seuser_record.lo seusers_file.lo seusers_local.lo seusers_policy.lo user_base_record.lo user_extra_record.lo user_record.lo users_base_file.lo users_base_policydb.lo users_extra_file.lo users_join.lo!
  users_local.lo users_policy.lo utilities.lo conf-scan.lo conf-parse.lo -lsepol -lselinux -L/usr/lib -Wl,-soname,libsemanage.so.1,--version-script=libsemanage.map,-z,defs
genhomedircon.lo: In function `ustr_dup_cstr':
/usr/include/ustr-main.h:959: undefined reference to `ustr_dup_buf'
genhomedircon.lo: In function `ustr_replace_cstr':
/usr/include/ustr-replace.h:58: undefined reference to `ustr_replace_buf'
genhomedircon.lo: In function `replace_all':
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:434: undefined reference to `ustr_sc_free'
genhomedircon.lo: In function `extract_context':
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:446: undefined reference to `ustr_spn_chrs_rev'
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:449: undefined reference to `ustr_cspn_chrs_rev'
genhomedircon.lo: In function `ustr_io_putfileline':
/usr/include/ustr-io.h:78: undefined reference to `ustr_io_putline'
genhomedircon.lo: In function `write_user_context':
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:558: undefined reference to `ustr_sc_free'
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:563: undefined reference to `ustr_sc_free'
genhomedircon.lo: In function `ustr_io_putfileline':
/usr/include/ustr-io.h:78: undefined reference to `ustr_io_putline'
genhomedircon.lo: In function `write_home_dir_context':
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:503: undefined reference to `ustr_sc_free'
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:508: undefined reference to `ustr_sc_free'
genhomedircon.lo: In function `ustr_dup_cstr':
/usr/include/ustr-main.h:959: undefined reference to `ustr_dup_buf'
genhomedircon.lo: In function `ustr_add_cstr':
/usr/include/ustr-main.h:945: undefined reference to `ustr_add_buf'
genhomedircon.lo: In function `ustr_io_putfileline':
/usr/include/ustr-io.h:78: undefined reference to `ustr_io_putline'
genhomedircon.lo: In function `write_home_root_context':
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:529: undefined reference to `ustr_sc_free'
genhomedircon.lo: In function `write_context_file':
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:910: undefined reference to `ustr_sc_free'
genhomedircon.lo: In function `write_home_root_context':
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:534: undefined reference to `ustr_sc_free'
genhomedircon.lo: In function `write_context_file':
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:905: undefined reference to `ustr_sc_free'
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:887: undefined reference to `ustr_sc_free'
genhomedircon.lo: In function `ustr_dup_cstr':
/usr/include/ustr-main.h:959: undefined reference to `ustr_dup_buf'
genhomedircon.lo: In function `ustr_add_cstr':
/usr/include/ustr-main.h:945: undefined reference to `ustr_add_buf'
genhomedircon.lo: In function `fcontext_matches':
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:209: undefined reference to `ustr_free'
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:185: undefined reference to `ustr_del'
/home/srivasta/libsemanage-2.0.24/src/genhomedircon.c:191: undefined reference to `ustr_del'
genhomedircon.lo: In function `ustr_add_cstr':
/usr/include/ustr-main.h:945: undefined reference to `ustr_add_buf'
utilities.lo: In function `semanage_split_on_space':
/home/srivasta/libsemanage-2.0.24/src/utilities.c:102: undefined reference to `ustr_sc_free'
utilities.lo: In function `ustr_dup_cstr':
/usr/include/ustr-main.h:959: undefined reference to `ustr_dup_buf'
utilities.lo: In function `semanage_split_on_space':
/home/srivasta/libsemanage-2.0.24/src/utilities.c:86: undefined reference to `ustr_split_spn_chrs'
/home/srivasta/libsemanage-2.0.24/src/utilities.c:92: undefined reference to `ustr_sc_free'
/home/srivasta/libsemanage-2.0.24/src/utilities.c:95: undefined reference to `ustr_dup_subustr'
/home/srivasta/libsemanage-2.0.24/src/utilities.c:99: undefined reference to `ustr_sc_free'
utilities.lo: In function `ustr_dup_cstr':
/usr/include/ustr-main.h:959: undefined reference to `ustr_dup_buf'
utilities.lo: In function `ustr_split_cstr':
/usr/include/ustr-split.h:83: undefined reference to `ustr_split_buf'
utilities.lo: In function `semanage_split':
/home/srivasta/libsemanage-2.0.24/src/utilities.c:122: undefined reference to `ustr_sc_free'
/home/srivasta/libsemanage-2.0.24/src/utilities.c:126: undefined reference to `ustr_dup_subustr'
/home/srivasta/libsemanage-2.0.24/src/utilities.c:130: undefined reference to `ustr_sc_free'
/home/srivasta/libsemanage-2.0.24/src/utilities.c:133: undefined reference to `ustr_sc_free'
collect2: ld returned 1 exit status
make[3]: *** [libsemanage.so.1] Error 1
make[3]: Leaving directory `/home/srivasta/libsemanage-2.0.24/src'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/srivasta/libsemanage-2.0.24'
make[1]: *** [debian/stamp/build/libsemanage1] Error 2
make[1]: Leaving directory `/home/srivasta/libsemanage-2.0.24'
make: *** [debian/stamp/do-build-arch] Error 2
dpkg-buildpackage: failure: debian/rules build gave error exit status 2

-- 
[...] or some clown changed the chips on a board and not its
name. (Don't laugh!  Look at the SMC etherpower for that.) -- from
/usr/src/linux/MAINTAINERS
Manoj Srivastava <manoj.srivastava@stdc.com> <srivasta@acm.org>        
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
