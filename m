Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5S8IsKO022453
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 04:18:57 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5S8Itpo010504
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 08:18:56 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>, <method@manicmethod.com>
CC: <selinux@tycho.nsa.gov>
Subject: v3 Add role attribute support to libsepol
Date: Tue, 28 Jun 2011 16:18:40 +0800
Message-ID: <1309249126-5224-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Differences from v2 patchset
-----------------------------
1. For the 0001 patch, 
   Modify symtab_insert() to allow multiple declarations only for the regular
   roles, while a role attribute can't be declared more than once and can't
   share a same name with another regular role.
   
2. For the 0006 patch,
   Although in the link stage all role identifiers defined in any
   block/decl of any module would be copied into the base->p_roles.table,
   the role-attribute relationships would still be recorded in the decl's
   local symtab[SYM_ROLES] table(see get_local_role()), so before all the
   escalation of sub role attribute's roles ebitmap into that of parent ever
   happens, all decl in the base->global list except the global block would
   have to be traversed so as to populate potential role-attribute attributes
   from decl up to the base module.
   
   
Remaining issues
-----------------
1. If built by "MONOLITHIC = y", run into below errors that not witnessed
   when building in modular way:
    
   /usr/bin/checkpolicy -M -U allow policy.conf -o policy.26
   /usr/bin/checkpolicy:  loading policy configuration from policy.conf
   policy/modules/services/likewise.te":140:ERROR 'role attribute semanage_roles is not declared' at token ';' on line 1494287:
   #line 140
   	roleattribute system_r semanage_roles;
   checkpolicy:  error(s) encountered while parsing configuration
   make: *** [policy.26] Error 1
   
2. The policy.X's binary representation and SELinux kernel role_datum_t
   structure don't have to be changed, so the max version number for policy.X
   won't have to be bumped.

   But it may be desirable to bump the max module version number.
   
   (I am still working on these two areas, any comments are greatly welcomed)
   
   
Tests I've done
-----------------
1. test_t is able to transition into rpm_t, but could not direclty transition
   into rpm_script_t, semanage_t, load_policy_t/setfiles_t:
   
   sh-3.2# sesearch -SCA -s test_t -t rpm_t -c process -p transition
   Found 1 semantic av rules:
      allow test_t rpm_t : process transition ; 
   
   sh-3.2# sesearch -SCA -s test_t -t rpm_script_t -c process -p transition
   
   sh-3.2# sesearch -SCA -s test_t -t semanage_t -c process -p transition
   
   sh-3.2# sesearch -SCA -s test_t -t load_policy_t -c process -p transition
   
   sh-3.2# sesearch -SCA -s test_t -t setfiles_t -c process -p transition
   
2. rpm_t is able to transition into rpm_script_t, but could not directly
   transition into semanage_t, load_policy_t/setfiles_t:
   
   sh-3.2# sesearch -SCA -s rpm_t -t rpm_script_t -c process -p transition
   Found 1 semantic av rules:
      allow rpm_t rpm_script_t : process transition ; 
   
   sh-3.2# sesearch -SCA -s rpm_t -t semanage_t -c process -p transition
   
   sh-3.2# sesearch -SCA -s rpm_t -t load_policy_t -c process -p transition
   
   sh-3.2# sesearch -SCA -s rpm_t -t setfiles_t -c process -p transition
   
3. rpm_script_t is able to transition into semanage_t, but could not directly
   transition into load_policy_t/setfiles_t:
   
   sh-3.2# sesearch -SCA -s rpm_script_t -t semanage_t -c process -p transition
   Found 1 semantic av rules:
      allow rpm_script_t semanage_t : process transition ; 
   
   sh-3.2# sesearch -SCA -s rpm_script_t -t load_policy_t -c process -p transition
   
   sh-3.2# sesearch -SCA -s rpm_script_t -t setfiles_t -c process -p transition
   
4. semanage_t is able to transition into load_policy_t & setfiles_t:
   
   sh-3.2# sesearch -SCA -s semanage_t -t load_policy_t -c process -p transition
   Found 1 semantic av rules:
      allow semanage_t load_policy_t : process transition ; 
   
   sh-3.2# sesearch -SCA -s semanage_t -t setfiles_t -c process -p transition
   Found 1 semantic av rules:
      allow semanage_t setfiles_t : process transition ; 
   
5. test_r is able to type with rpm_t, rpm_script_t, semanage_t, setfiles_t
   and load_policy_t:
   
   sh-3.2# compute_create root:test_r:test_t:s0 system_u:object_r:rpm_exec_t:s0 process
   root:test_r:rpm_t:s0
   sh-3.2# 
   
   sh-3.2# compute_create root:test_r:rpm_script_t:s0 system_u:object_r:semanage_exec_t:s0 process
   root:test_r:semanage_t:s0
   sh-3.2# 
   
   sh-3.2# compute_create root:test_r:semanage_t:s0 system_u:object_r:setfiles_exec_t:s0 process
   root:test_r:setfiles_t:s0
   sh-3.2# 
   
   sh-3.2# compute_create root:test_r:semanage_t:s0 system_u:object_r:load_policy_exec_t:s0 process
   root:test_r:load_policy_t:s0
   sh-3.2# 
   
6. Use the apol tool to analyze what types the test_r role could type with:
   (Since the apol installed on Ubuntu so far only support max version .24,
    we need to setup "policy-version = 24" in semanage.conf)
   
   test_r (28 types)
       chfn_t
       chkpwd_t
       consoletype_t
       ddclient_t
       dhcpc_t
       hostname_t
       ifconfig_t
       insmod_t
       iptables_t
       load_policy_t
       loadkeys_t
       netutils_t
       newrole_t
       pam_t
       passwd_t
       ping_t
       pppd_t
       pptp_t
       rpm_script_t
       rpm_t
       semanage_t
       setfiles_t
       test_t
       traceroute_t
       updpwd_t
       user_home_t
       usernetctl_t
       utempter_t
   
   rpm_roles (2 types)
       rpm_script_t
       rpm_t
   
   semanage_roles (3 types)
       load_policy_t
       semanage_t
       setfiles_t
   
7. Verify policy.X's binary representation that test_r's role_datum_t.types.types ebitmap records all these domains:
   
   0047a40: 7406 0000 0024 0a00 0001 0000 0000 0000  t....$..........
   0047a50: 0074 6573 745f 7407 0000 0025 0a00 0001  .test_t....%....
   
   test_t: policy value = 0xa24
   
   0036560: 0000 004a 0300 0001 0000 0000 0000 0072  ...J...........r
   0036570: 706d 5f74 0700 0000 4b03 0000 0100 0000  pm_t....K.......
   
   rpm_t: policy value = 0x34a
   
   0041050: 0000 6d6f 6e6f 7064 5f65 7463 5f74 0c00  ..monopd_etc_t..
   0041060: 0000 8907 0000 0100 0000 0000 0000 7270  ..............rp
   0041070: 6d5f 7363 7269 7074 5f74 0f00 0000 8a07  m_script_t......
   
   rpm_script_t: policy value = 0x789
   
   004d800: 7365 6375 7269 7479 5f74 0a00 0000 490c  security_t....I.
   004d810: 0000 0100 0000 0000 0000 7365 6d61 6e61  ..........semana
   004d820: 6765 5f74 0900 0000 4a0c 0000 0300 0000  ge_t....J.......
   
   semanage_t: policy value = 0xc49
   
   00492c0: 7075 745f 7865 7665 6e74 5f74 0d00 0000  put_xevent_t....
   00492d0: ae0a 0000 0100 0000 0000 0000 6c6f 6164  ............load
   00492e0: 5f70 6f6c 6963 795f 740c 0000 00af 0a00  _policy_t.......
   
   load_policy_t: policy value = 0xaae
   
   004d660: 740a 0000 003f 0c00 0001 0000 0000 0000  t....?..........
   004d670: 0073 6574 6669 6c65 735f 7414 0000 0010  .setfiles_t.....
   
   setfiles_t: policy value = 0xc3f
   
   
   002d050: 0600 0000 0000 0000 7465 7374 5f72 4000  ........test_r@.
   002d060: 0000 4000 0000 0100 0000 0000 0000 2000  ..@........... .
   002d070: 0000 0000 0000 4000 0000 800c 0000 1400  ......@.........
   002d080: 0000 8000 0000 0000 0000 0400 0000 4001  ..............@.
   002d090: 0000 0000 0000 0001 0000 0002 0000 0000  ................
   002d0a0: 0000 0000 0001 4002 0000 0000 0000 0010  ......@.........
   002d0b0: 0000 8002 0000 0000 0040 0000 0000 0003  .........@......
   002d0c0: 0000 0000 0004 0000 0030, 4003 0000 0002  .........0@.....
   002d0d0: 0000 0000 0000, c003 0000 0000 0000 0000  ................
   002d0e0: 0080 0004 0000 0000 0000 0000 0008 8005  ................
   002d0f0: 0000 0000 0008 0000 0000 4006 0000 1000  ..........@.....
   002d100: 0000 0000 0000 8006 0000 0200 0000 0000  ................
   002d110: 0000, 8007 0000 0001 0000 0000 0000 8009  ................
   002d120: 0000 0000 0210 0000 0410 c009 0000 0000  ................
   002d130: 0100 0000 0000, 000a 0000 3000 0000 0800  ..........0.....
   002d140: 0000, 800a 0000 0000 0000 0020 0000, 000b  ........... ....
   002d150: 0000 0008 0000 0000 0000, 000c 0000 0000  ................
   002d160: 0000 0000 0040, 400c 0000 0001 0000 0020  .....@@........ 
   002d170: 0000
   
      test_r: policy value = 0x06
      	dominates:
     		mz = 0x40, highbit = 0x40, node = 1
   		startbit = 0, map: 2000 0000 0000 0000
   			policy value: 0x06(test_r)
      	types.types:
      		mz = 0x40, highbit = 0xc80, node = 0x14
   		......
      		startbit = 0x340, map: 0002 0000 0000 0000
   			policy value: 0x34a(rpm_t)
   		......
      		startbit = 0x780, map: 0001 0000 0000 0000
   			policy value: 0x789(rpm_script_t)
   		......
      		startbit = 0xa00, map: 3000 0000 0800 0000
   			policy value: 0xa01, 0xa02, 0xa24(test_t)
      		startbit = 0xa80, map: 0000 0000 0020 0000 
   			policy value: 0xaae(load_policy_t)
      		startbit = 0xc00, map: 0000 0000 0000 0040 
   			policy value: 0xc3f(setfiles_t)
      		startbit = 0xc40, map: 0001 0000 0020 0000
   			policy value: 0xc49(semanage_t), 0xc6e

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
