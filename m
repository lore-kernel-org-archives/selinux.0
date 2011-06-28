Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5S8SBfY023162
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 04:28:11 -0400
Received: from snt0-omc4-s21.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5S8S9po011642
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 08:28:10 GMT
Message-ID: <SNT139-w61848BC20E4E7F40D1E43DAB560@phx.gbl>
Content-Type: multipart/mixed;
	boundary="_d889d054-dc49-4cec-bea3-5776d97859ea_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        lawrence steve
	<slawrence@tresys.com>, <method@manicmethod.com>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: v3 Add role attribute support to libsepol
Date: Tue, 28 Jun 2011 08:28:08 +0000
In-Reply-To: <1309249126-5224-1-git-send-email-qingtao.cao@windriver.com>
References: <1309249126-5224-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_d889d054-dc49-4cec-bea3-5776d97859ea_
Content-Type: multipart/alternative;
	boundary="_7feb0f94-be38-4785-a1a6-37f1ab3d7292_"

--_7feb0f94-be38-4785-a1a6-37f1ab3d7292_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Attach the refpolicy debug patches that would generate the test results mentioned below.

Thanks,
Harry

> From: qingtao.cao@windriver.com
> To: cpebenito@tresys.com; slawrence@tresys.com; method@manicmethod.com
> CC: selinux@tycho.nsa.gov
> Subject: v3 Add role attribute support to libsepol
> Date: Tue, 28 Jun 2011 16:18:40 +0800
> 
> 
> Differences from v2 patchset
> -----------------------------
> 1. For the 0001 patch, 
>    Modify symtab_insert() to allow multiple declarations only for the regular
>    roles, while a role attribute can't be declared more than once and can't
>    share a same name with another regular role.
>    
> 2. For the 0006 patch,
>    Although in the link stage all role identifiers defined in any
>    block/decl of any module would be copied into the base->p_roles.table,
>    the role-attribute relationships would still be recorded in the decl's
>    local symtab[SYM_ROLES] table(see get_local_role()), so before all the
>    escalation of sub role attribute's roles ebitmap into that of parent ever
>    happens, all decl in the base->global list except the global block would
>    have to be traversed so as to populate potential role-attribute attributes
>    from decl up to the base module.
>    
>    
> Remaining issues
> -----------------
> 1. If built by "MONOLITHIC = y", run into below errors that not witnessed
>    when building in modular way:
>     
>    /usr/bin/checkpolicy -M -U allow policy.conf -o policy.26
>    /usr/bin/checkpolicy:  loading policy configuration from policy.conf
>    policy/modules/services/likewise.te":140:ERROR 'role attribute semanage_roles is not declared' at token ';' on line 1494287:
>    #line 140
>    	roleattribute system_r semanage_roles;
>    checkpolicy:  error(s) encountered while parsing configuration
>    make: *** [policy.26] Error 1
>    
> 2. The policy.X's binary representation and SELinux kernel role_datum_t
>    structure don't have to be changed, so the max version number for policy.X
>    won't have to be bumped.
> 
>    But it may be desirable to bump the max module version number.
>    
>    (I am still working on these two areas, any comments are greatly welcomed)
>    
>    
> Tests I've done
> -----------------
> 1. test_t is able to transition into rpm_t, but could not direclty transition
>    into rpm_script_t, semanage_t, load_policy_t/setfiles_t:
>    
>    sh-3.2# sesearch -SCA -s test_t -t rpm_t -c process -p transition
>    Found 1 semantic av rules:
>       allow test_t rpm_t : process transition ; 
>    
>    sh-3.2# sesearch -SCA -s test_t -t rpm_script_t -c process -p transition
>    
>    sh-3.2# sesearch -SCA -s test_t -t semanage_t -c process -p transition
>    
>    sh-3.2# sesearch -SCA -s test_t -t load_policy_t -c process -p transition
>    
>    sh-3.2# sesearch -SCA -s test_t -t setfiles_t -c process -p transition
>    
> 2. rpm_t is able to transition into rpm_script_t, but could not directly
>    transition into semanage_t, load_policy_t/setfiles_t:
>    
>    sh-3.2# sesearch -SCA -s rpm_t -t rpm_script_t -c process -p transition
>    Found 1 semantic av rules:
>       allow rpm_t rpm_script_t : process transition ; 
>    
>    sh-3.2# sesearch -SCA -s rpm_t -t semanage_t -c process -p transition
>    
>    sh-3.2# sesearch -SCA -s rpm_t -t load_policy_t -c process -p transition
>    
>    sh-3.2# sesearch -SCA -s rpm_t -t setfiles_t -c process -p transition
>    
> 3. rpm_script_t is able to transition into semanage_t, but could not directly
>    transition into load_policy_t/setfiles_t:
>    
>    sh-3.2# sesearch -SCA -s rpm_script_t -t semanage_t -c process -p transition
>    Found 1 semantic av rules:
>       allow rpm_script_t semanage_t : process transition ; 
>    
>    sh-3.2# sesearch -SCA -s rpm_script_t -t load_policy_t -c process -p transition
>    
>    sh-3.2# sesearch -SCA -s rpm_script_t -t setfiles_t -c process -p transition
>    
> 4. semanage_t is able to transition into load_policy_t & setfiles_t:
>    
>    sh-3.2# sesearch -SCA -s semanage_t -t load_policy_t -c process -p transition
>    Found 1 semantic av rules:
>       allow semanage_t load_policy_t : process transition ; 
>    
>    sh-3.2# sesearch -SCA -s semanage_t -t setfiles_t -c process -p transition
>    Found 1 semantic av rules:
>       allow semanage_t setfiles_t : process transition ; 
>    
> 5. test_r is able to type with rpm_t, rpm_script_t, semanage_t, setfiles_t
>    and load_policy_t:
>    
>    sh-3.2# compute_create root:test_r:test_t:s0 system_u:object_r:rpm_exec_t:s0 process
>    root:test_r:rpm_t:s0
>    sh-3.2# 
>    
>    sh-3.2# compute_create root:test_r:rpm_script_t:s0 system_u:object_r:semanage_exec_t:s0 process
>    root:test_r:semanage_t:s0
>    sh-3.2# 
>    
>    sh-3.2# compute_create root:test_r:semanage_t:s0 system_u:object_r:setfiles_exec_t:s0 process
>    root:test_r:setfiles_t:s0
>    sh-3.2# 
>    
>    sh-3.2# compute_create root:test_r:semanage_t:s0 system_u:object_r:load_policy_exec_t:s0 process
>    root:test_r:load_policy_t:s0
>    sh-3.2# 
>    
> 6. Use the apol tool to analyze what types the test_r role could type with:
>    (Since the apol installed on Ubuntu so far only support max version .24,
>     we need to setup "policy-version = 24" in semanage.conf)
>    
>    test_r (28 types)
>        chfn_t
>        chkpwd_t
>        consoletype_t
>        ddclient_t
>        dhcpc_t
>        hostname_t
>        ifconfig_t
>        insmod_t
>        iptables_t
>        load_policy_t
>        loadkeys_t
>        netutils_t
>        newrole_t
>        pam_t
>        passwd_t
>        ping_t
>        pppd_t
>        pptp_t
>        rpm_script_t
>        rpm_t
>        semanage_t
>        setfiles_t
>        test_t
>        traceroute_t
>        updpwd_t
>        user_home_t
>        usernetctl_t
>        utempter_t
>    
>    rpm_roles (2 types)
>        rpm_script_t
>        rpm_t
>    
>    semanage_roles (3 types)
>        load_policy_t
>        semanage_t
>        setfiles_t
>    
> 7. Verify policy.X's binary representation that test_r's role_datum_t.types.types ebitmap records all these domains:
>    
>    0047a40: 7406 0000 0024 0a00 0001 0000 0000 0000  t....$..........
>    0047a50: 0074 6573 745f 7407 0000 0025 0a00 0001  .test_t....%....
>    
>    test_t: policy value = 0xa24
>    
>    0036560: 0000 004a 0300 0001 0000 0000 0000 0072  ...J...........r
>    0036570: 706d 5f74 0700 0000 4b03 0000 0100 0000  pm_t....K.......
>    
>    rpm_t: policy value = 0x34a
>    
>    0041050: 0000 6d6f 6e6f 7064 5f65 7463 5f74 0c00  ..monopd_etc_t..
>    0041060: 0000 8907 0000 0100 0000 0000 0000 7270  ..............rp
>    0041070: 6d5f 7363 7269 7074 5f74 0f00 0000 8a07  m_script_t......
>    
>    rpm_script_t: policy value = 0x789
>    
>    004d800: 7365 6375 7269 7479 5f74 0a00 0000 490c  security_t....I.
>    004d810: 0000 0100 0000 0000 0000 7365 6d61 6e61  ..........semana
>    004d820: 6765 5f74 0900 0000 4a0c 0000 0300 0000  ge_t....J.......
>    
>    semanage_t: policy value = 0xc49
>    
>    00492c0: 7075 745f 7865 7665 6e74 5f74 0d00 0000  put_xevent_t....
>    00492d0: ae0a 0000 0100 0000 0000 0000 6c6f 6164  ............load
>    00492e0: 5f70 6f6c 6963 795f 740c 0000 00af 0a00  _policy_t.......
>    
>    load_policy_t: policy value = 0xaae
>    
>    004d660: 740a 0000 003f 0c00 0001 0000 0000 0000  t....?..........
>    004d670: 0073 6574 6669 6c65 735f 7414 0000 0010  .setfiles_t.....
>    
>    setfiles_t: policy value = 0xc3f
>    
>    
>    002d050: 0600 0000 0000 0000 7465 7374 5f72 4000  ........test_r@.
>    002d060: 0000 4000 0000 0100 0000 0000 0000 2000  ..@........... .
>    002d070: 0000 0000 0000 4000 0000 800c 0000 1400  ......@.........
>    002d080: 0000 8000 0000 0000 0000 0400 0000 4001  ..............@.
>    002d090: 0000 0000 0000 0001 0000 0002 0000 0000  ................
>    002d0a0: 0000 0000 0001 4002 0000 0000 0000 0010  ......@.........
>    002d0b0: 0000 8002 0000 0000 0040 0000 0000 0003  .........@......
>    002d0c0: 0000 0000 0004 0000 0030, 4003 0000 0002  .........0@.....
>    002d0d0: 0000 0000 0000, c003 0000 0000 0000 0000  ................
>    002d0e0: 0080 0004 0000 0000 0000 0000 0008 8005  ................
>    002d0f0: 0000 0000 0008 0000 0000 4006 0000 1000  ..........@.....
>    002d100: 0000 0000 0000 8006 0000 0200 0000 0000  ................
>    002d110: 0000, 8007 0000 0001 0000 0000 0000 8009  ................
>    002d120: 0000 0000 0210 0000 0410 c009 0000 0000  ................
>    002d130: 0100 0000 0000, 000a 0000 3000 0000 0800  ..........0.....
>    002d140: 0000, 800a 0000 0000 0000 0020 0000, 000b  ........... ....
>    002d150: 0000 0008 0000 0000 0000, 000c 0000 0000  ................
>    002d160: 0000 0000 0040, 400c 0000 0001 0000 0020  .....@@........ 
>    002d170: 0000
>    
>       test_r: policy value = 0x06
>       	dominates:
>      		mz = 0x40, highbit = 0x40, node = 1
>    		startbit = 0, map: 2000 0000 0000 0000
>    			policy value: 0x06(test_r)
>       	types.types:
>       		mz = 0x40, highbit = 0xc80, node = 0x14
>    		......
>       		startbit = 0x340, map: 0002 0000 0000 0000
>    			policy value: 0x34a(rpm_t)
>    		......
>       		startbit = 0x780, map: 0001 0000 0000 0000
>    			policy value: 0x789(rpm_script_t)
>    		......
>       		startbit = 0xa00, map: 3000 0000 0800 0000
>    			policy value: 0xa01, 0xa02, 0xa24(test_t)
>       		startbit = 0xa80, map: 0000 0000 0020 0000 
>    			policy value: 0xaae(load_policy_t)
>       		startbit = 0xc00, map: 0000 0000 0000 0040 
>    			policy value: 0xc3f(setfiles_t)
>       		startbit = 0xc40, map: 0001 0000 0020 0000
>    			policy value: 0xc49(semanage_t), 0xc6e
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_7feb0f94-be38-4785-a1a6-37f1ab3d7292_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'><div dir='ltr'>
Attach the refpolicy debug patches that would generate the test results mentioned below.<br><br>Thanks,<br>Harry<br><br><div>&gt; From: qingtao.cao@windriver.com<br>&gt; To: cpebenito@tresys.com; slawrence@tresys.com; method@manicmethod.com<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; Subject: v3 Add role attribute support to libsepol<br>&gt; Date: Tue, 28 Jun 2011 16:18:40 +0800<br>&gt; <br>&gt; <br>&gt; Differences from v2 patchset<br>&gt; -----------------------------<br>&gt; 1. For the 0001 patch, <br>&gt;    Modify symtab_insert() to allow multiple declarations only for the regular<br>&gt;    roles, while a role attribute can't be declared more than once and can't<br>&gt;    share a same name with another regular role.<br>&gt;    <br>&gt; 2. For the 0006 patch,<br>&gt;    Although in the link stage all role identifiers defined in any<br>&gt;    block/decl of any module would be copied into the base-&gt;p_roles.table,<br>&gt;    the role-attribute relationships would still !
 be recorded in the decl's<br>&gt;    local symtab[SYM_ROLES] table(see get_local_role()), so before all the<br>&gt;    escalation of sub role attribute's roles ebitmap into that of parent ever<br>&gt;    happens, all decl in the base-&gt;global list except the global block would<br>&gt;    have to be traversed so as to populate potential role-attribute attributes<br>&gt;    from decl up to the base module.<br>&gt;    <br>&gt;    <br>&gt; Remaining issues<br>&gt; -----------------<br>&gt; 1. If built by "MONOLITHIC = y", run into below errors that not witnessed<br>&gt;    when building in modular way:<br>&gt;     <br>&gt;    /usr/bin/checkpolicy -M -U allow policy.conf -o policy.26<br>&gt;    /usr/bin/checkpolicy:  loading policy configuration from policy.conf<br>&gt;    policy/modules/services/likewise.te":140:ERROR 'role attribute semanage_roles is not declared' at token ';' on line 1494287:<br>&gt;    #line 140<br>&gt;    	roleattribute system_r semanage_roles;<br>&gt;   !
  checkpolicy:  error(s) encountered while parsing configuration<br>&gt
;    make: *** [policy.26] Error 1<br>&gt;    <br>&gt; 2. The policy.X's binary representation and SELinux kernel role_datum_t<br>&gt;    structure don't have to be changed, so the max version number for policy.X<br>&gt;    won't have to be bumped.<br>&gt; <br>&gt;    But it may be desirable to bump the max module version number.<br>&gt;    <br>&gt;    (I am still working on these two areas, any comments are greatly welcomed)<br>&gt;    <br>&gt;    <br>&gt; Tests I've done<br>&gt; -----------------<br>&gt; 1. test_t is able to transition into rpm_t, but could not direclty transition<br>&gt;    into rpm_script_t, semanage_t, load_policy_t/setfiles_t:<br>&gt;    <br>&gt;    sh-3.2# sesearch -SCA -s test_t -t rpm_t -c process -p transition<br>&gt;    Found 1 semantic av rules:<br>&gt;       allow test_t rpm_t : process transition ; <br>&gt;    <br>&gt;    sh-3.2# sesearch -SCA -s test_t -t rpm_script_t -c process -p transition<br>&gt;    <br>&gt;    sh-3.2# sesearch -SCA -s tes!
 t_t -t semanage_t -c process -p transition<br>&gt;    <br>&gt;    sh-3.2# sesearch -SCA -s test_t -t load_policy_t -c process -p transition<br>&gt;    <br>&gt;    sh-3.2# sesearch -SCA -s test_t -t setfiles_t -c process -p transition<br>&gt;    <br>&gt; 2. rpm_t is able to transition into rpm_script_t, but could not directly<br>&gt;    transition into semanage_t, load_policy_t/setfiles_t:<br>&gt;    <br>&gt;    sh-3.2# sesearch -SCA -s rpm_t -t rpm_script_t -c process -p transition<br>&gt;    Found 1 semantic av rules:<br>&gt;       allow rpm_t rpm_script_t : process transition ; <br>&gt;    <br>&gt;    sh-3.2# sesearch -SCA -s rpm_t -t semanage_t -c process -p transition<br>&gt;    <br>&gt;    sh-3.2# sesearch -SCA -s rpm_t -t load_policy_t -c process -p transition<br>&gt;    <br>&gt;    sh-3.2# sesearch -SCA -s rpm_t -t setfiles_t -c process -p transition<br>&gt;    <br>&gt; 3. rpm_script_t is able to transition into semanage_t, but could not directly<br>&gt;    transitio!
 n into load_policy_t/setfiles_t:<br>&gt;    <br>&gt;    sh-3.2# sesear
ch -SCA -s rpm_script_t -t semanage_t -c process -p transition<br>&gt;    Found 1 semantic av rules:<br>&gt;       allow rpm_script_t semanage_t : process transition ; <br>&gt;    <br>&gt;    sh-3.2# sesearch -SCA -s rpm_script_t -t load_policy_t -c process -p transition<br>&gt;    <br>&gt;    sh-3.2# sesearch -SCA -s rpm_script_t -t setfiles_t -c process -p transition<br>&gt;    <br>&gt; 4. semanage_t is able to transition into load_policy_t &amp; setfiles_t:<br>&gt;    <br>&gt;    sh-3.2# sesearch -SCA -s semanage_t -t load_policy_t -c process -p transition<br>&gt;    Found 1 semantic av rules:<br>&gt;       allow semanage_t load_policy_t : process transition ; <br>&gt;    <br>&gt;    sh-3.2# sesearch -SCA -s semanage_t -t setfiles_t -c process -p transition<br>&gt;    Found 1 semantic av rules:<br>&gt;       allow semanage_t setfiles_t : process transition ; <br>&gt;    <br>&gt; 5. test_r is able to type with rpm_t, rpm_script_t, semanage_t, setfiles_t<br>&gt;    and load!
 _policy_t:<br>&gt;    <br>&gt;    sh-3.2# compute_create root:test_r:test_t:s0 system_u:object_r:rpm_exec_t:s0 process<br>&gt;    root:test_r:rpm_t:s0<br>&gt;    sh-3.2# <br>&gt;    <br>&gt;    sh-3.2# compute_create root:test_r:rpm_script_t:s0 system_u:object_r:semanage_exec_t:s0 process<br>&gt;    root:test_r:semanage_t:s0<br>&gt;    sh-3.2# <br>&gt;    <br>&gt;    sh-3.2# compute_create root:test_r:semanage_t:s0 system_u:object_r:setfiles_exec_t:s0 process<br>&gt;    root:test_r:setfiles_t:s0<br>&gt;    sh-3.2# <br>&gt;    <br>&gt;    sh-3.2# compute_create root:test_r:semanage_t:s0 system_u:object_r:load_policy_exec_t:s0 process<br>&gt;    root:test_r:load_policy_t:s0<br>&gt;    sh-3.2# <br>&gt;    <br>&gt; 6. Use the apol tool to analyze what types the test_r role could type with:<br>&gt;    (Since the apol installed on Ubuntu so far only support max version .24,<br>&gt;     we need to setup "policy-version = 24" in semanage.conf)<br>&gt;    <br>&gt;    test_r (28 type!
 s)<br>&gt;        chfn_t<br>&gt;        chkpwd_t<br>&gt;        consol
etype_t<br>&gt;        ddclient_t<br>&gt;        dhcpc_t<br>&gt;        hostname_t<br>&gt;        ifconfig_t<br>&gt;        insmod_t<br>&gt;        iptables_t<br>&gt;        load_policy_t<br>&gt;        loadkeys_t<br>&gt;        netutils_t<br>&gt;        newrole_t<br>&gt;        pam_t<br>&gt;        passwd_t<br>&gt;        ping_t<br>&gt;        pppd_t<br>&gt;        pptp_t<br>&gt;        rpm_script_t<br>&gt;        rpm_t<br>&gt;        semanage_t<br>&gt;        setfiles_t<br>&gt;        test_t<br>&gt;        traceroute_t<br>&gt;        updpwd_t<br>&gt;        user_home_t<br>&gt;        usernetctl_t<br>&gt;        utempter_t<br>&gt;    <br>&gt;    rpm_roles (2 types)<br>&gt;        rpm_script_t<br>&gt;        rpm_t<br>&gt;    <br>&gt;    semanage_roles (3 types)<br>&gt;        load_policy_t<br>&gt;        semanage_t<br>&gt;        setfiles_t<br>&gt;    <br>&gt; 7. Verify policy.X's binary representation that test_r's role_datum_t.types.types ebitmap records all these domains:!
 <br>&gt;    <br>&gt;    0047a40: 7406 0000 0024 0a00 0001 0000 0000 0000  t....$..........<br>&gt;    0047a50: 0074 6573 745f 7407 0000 0025 0a00 0001  .test_t....%....<br>&gt;    <br>&gt;    test_t: policy value = 0xa24<br>&gt;    <br>&gt;    0036560: 0000 004a 0300 0001 0000 0000 0000 0072  ...J...........r<br>&gt;    0036570: 706d 5f74 0700 0000 4b03 0000 0100 0000  pm_t....K.......<br>&gt;    <br>&gt;    rpm_t: policy value = 0x34a<br>&gt;    <br>&gt;    0041050: 0000 6d6f 6e6f 7064 5f65 7463 5f74 0c00  ..monopd_etc_t..<br>&gt;    0041060: 0000 8907 0000 0100 0000 0000 0000 7270  ..............rp<br>&gt;    0041070: 6d5f 7363 7269 7074 5f74 0f00 0000 8a07  m_script_t......<br>&gt;    <br>&gt;    rpm_script_t: policy value = 0x789<br>&gt;    <br>&gt;    004d800: 7365 6375 7269 7479 5f74 0a00 0000 490c  security_t....I.<br>&gt;    004d810: 0000 0100 0000 0000 0000 7365 6d61 6e61  ..........semana<br>&gt;    004d820: 6765 5f74 0900 0000 4a0c 0000 0300 0000  ge_t....J......!
 .<br>&gt;    <br>&gt;    semanage_t: policy value = 0xc49<br>&gt;    <
br>&gt;    00492c0: 7075 745f 7865 7665 6e74 5f74 0d00 0000  put_xevent_t....<br>&gt;    00492d0: ae0a 0000 0100 0000 0000 0000 6c6f 6164  ............load<br>&gt;    00492e0: 5f70 6f6c 6963 795f 740c 0000 00af 0a00  _policy_t.......<br>&gt;    <br>&gt;    load_policy_t: policy value = 0xaae<br>&gt;    <br>&gt;    004d660: 740a 0000 003f 0c00 0001 0000 0000 0000  t....?..........<br>&gt;    004d670: 0073 6574 6669 6c65 735f 7414 0000 0010  .setfiles_t.....<br>&gt;    <br>&gt;    setfiles_t: policy value = 0xc3f<br>&gt;    <br>&gt;    <br>&gt;    002d050: 0600 0000 0000 0000 7465 7374 5f72 4000  ........test_r@.<br>&gt;    002d060: 0000 4000 0000 0100 0000 0000 0000 2000  ..@........... .<br>&gt;    002d070: 0000 0000 0000 4000 0000 800c 0000 1400  ......@.........<br>&gt;    002d080: 0000 8000 0000 0000 0000 0400 0000 4001  ..............@.<br>&gt;    002d090: 0000 0000 0000 0001 0000 0002 0000 0000  ................<br>&gt;    002d0a0: 0000 0000 0001 4002 0000 0000 0000 001!
 0  ......@.........<br>&gt;    002d0b0: 0000 8002 0000 0000 0040 0000 0000 0003  .........@......<br>&gt;    002d0c0: 0000 0000 0004 0000 0030, 4003 0000 0002  .........0@.....<br>&gt;    002d0d0: 0000 0000 0000, c003 0000 0000 0000 0000  ................<br>&gt;    002d0e0: 0080 0004 0000 0000 0000 0000 0008 8005  ................<br>&gt;    002d0f0: 0000 0000 0008 0000 0000 4006 0000 1000  ..........@.....<br>&gt;    002d100: 0000 0000 0000 8006 0000 0200 0000 0000  ................<br>&gt;    002d110: 0000, 8007 0000 0001 0000 0000 0000 8009  ................<br>&gt;    002d120: 0000 0000 0210 0000 0410 c009 0000 0000  ................<br>&gt;    002d130: 0100 0000 0000, 000a 0000 3000 0000 0800  ..........0.....<br>&gt;    002d140: 0000, 800a 0000 0000 0000 0020 0000, 000b  ........... ....<br>&gt;    002d150: 0000 0008 0000 0000 0000, 000c 0000 0000  ................<br>&gt;    002d160: 0000 0000 0040, 400c 0000 0001 0000 0020  .....@@........ <br>&gt;    002d170: 0000!
 <br>&gt;    <br>&gt;       test_r: policy value = 0x06<br>&gt;       	
dominates:<br>&gt;      		mz = 0x40, highbit = 0x40, node = 1<br>&gt;    		startbit = 0, map: 2000 0000 0000 0000<br>&gt;    			policy value: 0x06(test_r)<br>&gt;       	types.types:<br>&gt;       		mz = 0x40, highbit = 0xc80, node = 0x14<br>&gt;    		......<br>&gt;       		startbit = 0x340, map: 0002 0000 0000 0000<br>&gt;    			policy value: 0x34a(rpm_t)<br>&gt;    		......<br>&gt;       		startbit = 0x780, map: 0001 0000 0000 0000<br>&gt;    			policy value: 0x789(rpm_script_t)<br>&gt;    		......<br>&gt;       		startbit = 0xa00, map: 3000 0000 0800 0000<br>&gt;    			policy value: 0xa01, 0xa02, 0xa24(test_t)<br>&gt;       		startbit = 0xa80, map: 0000 0000 0020 0000 <br>&gt;    			policy value: 0xaae(load_policy_t)<br>&gt;       		startbit = 0xc00, map: 0000 0000 0000 0040 <br>&gt;    			policy value: 0xc3f(setfiles_t)<br>&gt;       		startbit = 0xc40, map: 0001 0000 0020 0000<br>&gt;    			policy value: 0xc49(semanage_t), 0xc6e<br>&gt; <br>&gt; --<br>&gt; This message !
 was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br></div> 		 	   		  </div></body>
</html>
--_7feb0f94-be38-4785-a1a6-37f1ab3d7292_--

--_d889d054-dc49-4cec-bea3-5776d97859ea_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Role-attribute-debug.patch"

RnJvbSAwYzc4YWU0ZGMxMmJmNmIyM2FlZjhjYTlmM2NlYjQxNjU1ZjU1ZDA1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJyeSBDaWFvIDxxaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29t
PgpEYXRlOiBXZWQsIDI1IE1heSAyMDExIDE3OjM0OjQ3ICswODAwClN1YmplY3Q6IFtQQVRDSCAx
LzJdIFJvbGUgYXR0cmlidXRlIGRlYnVnLgoKVXNlIHJvbGUgYXR0cmlidXRlIGluIHNldmVyYWwg
ZGlmZmVyZW50IG1vZHVsZXMgdG8gdGVzdCBpZiBhIHJvbGUKYXR0cmlidXRlIHVzZWQgaW4gdXNl
ci1yb2xlcywgcm9sZS10eXBlcywgcm9sZS1hbGxvd3MgYW5kIHJvbGUtdHJhbnNpdGlvbgpydWxl
cyBjb3VsZCBiZSBwcm9wZXJseSBjb21waWxlZC9saW5rZWQvZXhwYW5kZWQuCgpBbHNvIGluIG9y
ZGVyIHRvIHN1cHBvcnQgdGhhdCByb2xlLXR5cGVzIHJ1bGUgbm8gbG9uZ2VyIGlzIHVzZWQgdG8K
ZGVjbGFyZSBhIHJlZ3VsYXIgcm9sZSwgd2UgaGF2ZSB0byB1c2UgdGhlIHJvbGUtYXR0ciBydWxl
IHRvIGRlY2xhcmUKdGhlIHJlbGF0ZWQgcm9sZSBleHBsaWNpdGx5IChzbyBmYXIgb25seSBueF9z
ZXJ2ZXJfciBhbmQgdW5jb25maW5lZF9yKS4KClNpZ25lZC1vZmYtYnk6IEhhcnJ5IENpYW8gPHFp
bmd0YW8uY2FvQHdpbmRyaXZlci5jb20+Ci0tLQogcG9saWN5L21vZHVsZXMvYXBwcy92bG9jay50
ZSAgICAgICAgIHwgICAxMyArKysrKysrKysrKysrCiBwb2xpY3kvbW9kdWxlcy9yb2xlcy9zeXNh
ZG0udGUgICAgICAgfCAgIDE1ICsrKysrKysrKysrKysrKwogcG9saWN5L21vZHVsZXMvc2Vydmlj
ZXMvbngudGUgICAgICAgIHwgICAgMSArCiBwb2xpY3kvbW9kdWxlcy9zeXN0ZW0vc2VsaW51eHV0
aWwudGUgfCAgIDE3ICsrKysrKysrKysrKysrKysrCiBwb2xpY3kvbW9kdWxlcy9zeXN0ZW0vdW5j
b25maW5lZC50ZSAgfCAgICAxICsKIDUgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwg
MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9wb2xpY3kvbW9kdWxlcy9hcHBzL3Zsb2NrLnRl
IGIvcG9saWN5L21vZHVsZXMvYXBwcy92bG9jay50ZQppbmRleCAwM2ZjNzAxLi4yMmFlNDQ0IDEw
MDY0NAotLS0gYS9wb2xpY3kvbW9kdWxlcy9hcHBzL3Zsb2NrLnRlCisrKyBiL3BvbGljeS9tb2R1
bGVzL2FwcHMvdmxvY2sudGUKQEAgLTUxLDMgKzUxLDE2IEBAIG1pc2NmaWxlc19yZWFkX2xvY2Fs
aXphdGlvbih2bG9ja190KQogCiB1c2VyZG9tX2RvbnRhdWRpdF9zZWFyY2hfdXNlcl9ob21lX2Rp
cnModmxvY2tfdCkKIHVzZXJkb21fdXNlX3VzZXJfdGVybWluYWxzKHZsb2NrX3QpCisKK29wdGlv
bmFsX3BvbGljeShgCisJZ2VuX3JlcXVpcmUoYAorCQlyb2xlIHN5c3RlbV9yOworCQlhdHRyaWJ1
dGVfcm9sZSByb2xlX2F0dHJpYnV0ZV8xOworCScpCisKKwkjIGFzc3VtZSB0aGUgc3lzdGVtX3Ig
cm9sZSBvbmNlIHRyYW5zaXRpb25lZCB0byB2bG9ja190IGRvbWFpbgorCXJvbGVfdHJhbnNpdGlv
biByb2xlX2F0dHJpYnV0ZV8xIHZsb2NrX2V4ZWNfdCBzeXN0ZW1fcjsKKwlyb2xlIHJvbGVfYXR0
cmlidXRlXzEgdHlwZXMgdmxvY2tfdDsKKwlyb2xlIHN5c3RlbV9yIHR5cGVzIHZsb2NrX3Q7CisJ
dXNlciByb290IHJvbGVzIHN5c3RlbV9yIGxldmVsIHMwIHJhbmdlIHMwIC0gczE1OmMwLmMxMDIz
OworJykKZGlmZiAtLWdpdCBhL3BvbGljeS9tb2R1bGVzL3JvbGVzL3N5c2FkbS50ZSBiL3BvbGlj
eS9tb2R1bGVzL3JvbGVzL3N5c2FkbS50ZQppbmRleCA4Y2ZhYjA2Li4wYzdiYThlIDEwMDY0NAot
LS0gYS9wb2xpY3kvbW9kdWxlcy9yb2xlcy9zeXNhZG0udGUKKysrIGIvcG9saWN5L21vZHVsZXMv
cm9sZXMvc3lzYWRtLnRlCkBAIC0yMCw2ICsyMCwyMSBAQCBpZm5kZWYoYGVuYWJsZV9tbHMnLGAK
IAl1c2VyZG9tX3NlY3VyaXR5X2FkbWluX3RlbXBsYXRlKHN5c2FkbV90LCBzeXNhZG1fcikKICcp
CiAKKyMgVGVzdCBmb3Igcm9sZSBhdHRyaWJ1dGUKK2F0dHJpYnV0ZV9yb2xlIHJvbGVfYXR0cmli
dXRlXzE7Cityb2xlIHN5c2FkbV9yXzIsIHJvbGVfYXR0cmlidXRlXzE7Cityb2xlIHN5c2FkbV9y
XzM7Cityb2xlYXR0cmlidXRlIHN5c2FkbV9yXzMgcm9sZV9hdHRyaWJ1dGVfMTsKKworb3B0aW9u
YWxfcG9saWN5KGAKKwlnZW5fcmVxdWlyZShgCisJCXVzZXIgcm9vdDsKKwkJdHlwZSB2bG9ja190
OworCScpCisJCisJdXNlciByb290IHJvbGVzIHJvbGVfYXR0cmlidXRlXzEgbGV2ZWwgczAgcmFu
Z2UgczAgLSBzMTU6YzAuYzEwMjM7CisnKQorCiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjCiAjCiAjIExvY2FsIHBvbGljeQpkaWZmIC0tZ2l0IGEvcG9saWN5L21vZHVs
ZXMvc2VydmljZXMvbngudGUgYi9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9ueC50ZQppbmRleCBl
YmI5NTgyLi5hMzU1OWYyIDEwMDY0NAotLS0gYS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9ueC50
ZQorKysgYi9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9ueC50ZQpAQCAtMTIsNiArMTIsNyBAQCBk
b21haW5fZW50cnlfZmlsZShueF9zZXJ2ZXJfdCwgbnhfc2VydmVyX2V4ZWNfdCkKIGRvbWFpbl91
c2VyX2V4ZW1wdGlvbl90YXJnZXQobnhfc2VydmVyX3QpCiAjIHdlIG5lZWQgYW4gZXh0cmEgcm9s
ZSBiZWNhdXNlIG54c2VydmVyIGlzIGNhbGxlZCBmcm9tIHNzaGQKICMgY2pwOiBkbyB3ZSByZWFs
bHkgbmVlZCB0aGlzPworcm9sZSBueF9zZXJ2ZXJfcjsKIHJvbGUgbnhfc2VydmVyX3IgdHlwZXMg
bnhfc2VydmVyX3Q7CiBhbGxvdyBzeXN0ZW1fciBueF9zZXJ2ZXJfcjsKIApkaWZmIC0tZ2l0IGEv
cG9saWN5L21vZHVsZXMvc3lzdGVtL3NlbGludXh1dGlsLnRlIGIvcG9saWN5L21vZHVsZXMvc3lz
dGVtL3NlbGludXh1dGlsLnRlCmluZGV4IDI4NGM3ZjguLmE3YTgxODYgMTAwNjQ0Ci0tLSBhL3Bv
bGljeS9tb2R1bGVzL3N5c3RlbS9zZWxpbnV4dXRpbC50ZQorKysgYi9wb2xpY3kvbW9kdWxlcy9z
eXN0ZW0vc2VsaW51eHV0aWwudGUKQEAgLTYwMywzICs2MDMsMjAgQEAgaWZkZWYoYGhpZGVfYnJv
a2VuX3N5bXB0b21zJyxgCiBvcHRpb25hbF9wb2xpY3koYAogCWhvdHBsdWdfdXNlX2ZkcyhzZXRm
aWxlc190KQogJykKKworb3B0aW9uYWxfcG9saWN5KGAKKwlnZW5fcmVxdWlyZShgCisJCXJvbGUg
c3lzYWRtX3I7CisJCXR5cGUgc3lzYWRtX3QsIGNoa3B3ZF90OworCQlhdHRyaWJ1dGVfcm9sZSBy
b2xlX2F0dHJpYnV0ZV8xOworCScpCisKKwkjIGFsbG93IHRoZSB0cmFuc2l0aW9uIGZyb20gc3lz
YWRtX3IgdG8gYWxsIHJlZ3VsYXIgcm9sZXMgdGhhdAorCSMgYmVsb25nIHRvIHRoZSByb2xlX2F0
dHJpYnV0ZV8xIGFuZCB2aWNlIHZlcnNhIGJ5IHRoZSBuZXdyb2xlIGNtZAorCWFsbG93IHN5c2Fk
bV9yIHJvbGVfYXR0cmlidXRlXzE7CisJYWxsb3cgcm9sZV9hdHRyaWJ1dGVfMSBzeXNhZG1fcjsK
KworCXJvbGUgcm9sZV9hdHRyaWJ1dGVfMSB0eXBlcyBuZXdyb2xlX3Q7CisJcm9sZSByb2xlX2F0
dHJpYnV0ZV8xIHR5cGVzIGNoa3B3ZF90OworCXJvbGUgcm9sZV9hdHRyaWJ1dGVfMSB0eXBlcyBz
eXNhZG1fdDsKKycpCmRpZmYgLS1naXQgYS9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vdW5jb25maW5l
ZC50ZSBiL3BvbGljeS9tb2R1bGVzL3N5c3RlbS91bmNvbmZpbmVkLnRlCmluZGV4IGVhZTUwMDEu
LjljNWY5MzEgMTAwNjQ0Ci0tLSBhL3BvbGljeS9tb2R1bGVzL3N5c3RlbS91bmNvbmZpbmVkLnRl
CisrKyBiL3BvbGljeS9tb2R1bGVzL3N5c3RlbS91bmNvbmZpbmVkLnRlCkBAIC0xOSw2ICsxOSw3
IEBAIGluaXRfc3lzdGVtX2RvbWFpbih1bmNvbmZpbmVkX3QsIHVuY29uZmluZWRfZXhlY190KQog
dHlwZSB1bmNvbmZpbmVkX2V4ZWNtZW1fdDsKIHR5cGUgdW5jb25maW5lZF9leGVjbWVtX2V4ZWNf
dDsKIGluaXRfc3lzdGVtX2RvbWFpbih1bmNvbmZpbmVkX2V4ZWNtZW1fdCwgdW5jb25maW5lZF9l
eGVjbWVtX2V4ZWNfdCkKK3JvbGUgdW5jb25maW5lZF9yOwogcm9sZSB1bmNvbmZpbmVkX3IgdHlw
ZXMgdW5jb25maW5lZF9leGVjbWVtX3Q7CiAKICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKLS0gCjEuNy4wLjQKCg==

--_d889d054-dc49-4cec-bea3-5776d97859ea_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0002-Test-adding-one-role-attribute-into-another.patch"

RnJvbSAxMzQzZjMxZmUwMGE0N2QyMWIxYTRiOTFmYTkwZGJjZTZlYWY3ZmM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJyeSBDaWFvIDxxaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29t
PgpEYXRlOiBTdW4sIDI5IE1heSAyMDExIDEyOjQ3OjQyICswODAwClN1YmplY3Q6IFtQQVRDSCAy
LzJdIFRlc3QgYWRkaW5nIG9uZSByb2xlIGF0dHJpYnV0ZSBpbnRvIGFub3RoZXIuCgpDcmVhdGUg
YW4gdW5wcml2aWxlZ2VkIHVzZXIgInRlc3QiIGFuZCBjYWxscyBycG1fcnVuKCkgZm9yIGl0LiBX
ZSB3b3VsZAp2ZXJpZnkgaWYgdGVzdF90IGNvdWxkIG9ubHkgdHJhbnNpdGlvbiBpbnRvIHJwbV90
LCB3aGljaCBpbiB0dXJuIHdvdWxkCnRyYW5zaXRpb24gaW50byBzZW1hbmFnZV90LCB3aGljaCBp
biB0dXJuIHdvdWxkIHRyYW5zaXRpb24gaW50byBvdGhlcgpzZWxpbnV4dXRpbCBkb21haW5zIHN1
Y2ggYXMgc2V0ZmlsZXNfdC4gSG93ZXZlciwgdGVzdF90IGNvdWxkIG5vdCBkaXJlY3RseQp0cmFu
c2l0aW9uIGludG8gdGhlc2UgZG9tYWlucywgYnV0IHRlc3RfciBpcyBhYmxlIHRvIHR5cGUgd2l0
aCB0aGVtLgoKU2lnbmVkLW9mZi1ieTogSGFycnkgQ2lhbyA8cWluZ3Rhby5jYW9Ad2luZHJpdmVy
LmNvbT4KLS0tCiBwb2xpY3kvbW9kdWxlcy9hZG1pbi9ycG0uaWYgICAgICAgICAgfCAgICA3ICsr
LS0tLS0KIHBvbGljeS9tb2R1bGVzL2FkbWluL3JwbS50ZSAgICAgICAgICB8ICAgMTUgKysrKysr
KysrKysrLS0tCiBwb2xpY3kvbW9kdWxlcy9rZXJuZWwva2VybmVsLnRlICAgICAgfCAgICAxICsK
IHBvbGljeS9tb2R1bGVzL3JvbGVzL3VucHJpdnVzZXIudGUgICB8ICAgIDYgKysrKysrCiBwb2xp
Y3kvbW9kdWxlcy9zeXN0ZW0vc2VsaW51eHV0aWwuaWYgfCAgICA2ICsrLS0tLQogcG9saWN5L21v
ZHVsZXMvc3lzdGVtL3NlbGludXh1dGlsLnRlIHwgICAxNSArKysrKysrKysrKysrKysKIHBvbGlj
eS91c2VycyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDQgKystLQogNyBmaWxlcyBjaGFu
Z2VkLCA0MCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9wb2xp
Y3kvbW9kdWxlcy9hZG1pbi9ycG0uaWYgYi9wb2xpY3kvbW9kdWxlcy9hZG1pbi9ycG0uaWYKaW5k
ZXggZDMzZGFhOC4uNmEyZjhjZiAxMDA2NDQKLS0tIGEvcG9saWN5L21vZHVsZXMvYWRtaW4vcnBt
LmlmCisrKyBiL3BvbGljeS9tb2R1bGVzL2FkbWluL3JwbS5pZgpAQCAtNzgsMTQgKzc4LDExIEBA
IGludGVyZmFjZShgcnBtX2RvbXRyYW5zX3NjcmlwdCcsYAogIwogaW50ZXJmYWNlKGBycG1fcnVu
JyxgCiAJZ2VuX3JlcXVpcmUoYAotCQl0eXBlIHJwbV90LCBycG1fc2NyaXB0X3Q7CisJCWF0dHJp
YnV0ZV9yb2xlIHJwbV9yb2xlczsJCiAJJykKIAogCXJwbV9kb210cmFucygkMSkKLQlyb2xlICQy
IHR5cGVzIHsgcnBtX3QgcnBtX3NjcmlwdF90IH07Ci0Jc2V1dGlsX3J1bl9sb2FkcG9saWN5KHJw
bV9zY3JpcHRfdCwgJDIpCi0Jc2V1dGlsX3J1bl9zZW1hbmFnZShycG1fc2NyaXB0X3QsICQyKQot
CXNldXRpbF9ydW5fc2V0ZmlsZXMocnBtX3NjcmlwdF90LCAkMikKKwlyb2xlYXR0cmlidXRlICQy
IHJwbV9yb2xlczsKICcpCiAKICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMKZGlmZiAtLWdpdCBhL3BvbGljeS9tb2R1bGVzL2FkbWluL3JwbS50ZSBiL3BvbGljeS9tb2R1
bGVzL2FkbWluL3JwbS50ZQppbmRleCA0N2E4ZjdkLi44MzNmMmQ2IDEwMDY0NAotLS0gYS9wb2xp
Y3kvbW9kdWxlcy9hZG1pbi9ycG0udGUKKysrIGIvcG9saWN5L21vZHVsZXMvYWRtaW4vcnBtLnRl
CkBAIC0xOTIsNiArMTkyLDExIEBAIHNldXRpbF9tYW5hZ2VfYmluX3BvbGljeShycG1fdCkKIHVz
ZXJkb21fdXNlX3VzZXJfdGVybWluYWxzKHJwbV90KQogdXNlcmRvbV91c2VfdW5wcml2X3VzZXJz
X2ZkcyhycG1fdCkKIAorIyBUZXN0OiBhZGQgb25lIHJvbGUgYXR0cmlidXRlIGludG8gYW5vdGhl
cgorYXR0cmlidXRlX3JvbGUgcnBtX3JvbGVzOworcm9sZSBycG1fcm9sZXMgdHlwZXMgeyBycG1f
dCBycG1fc2NyaXB0X3QgfTsKK3NldXRpbF9ydW5fc2VtYW5hZ2UocnBtX3NjcmlwdF90LCBycG1f
cm9sZXMpCisKIG9wdGlvbmFsX3BvbGljeShgCiAJY3Jvbl9zeXN0ZW1fZW50cnkocnBtX3QsIHJw
bV9leGVjX3QpCiAnKQpAQCAtMzM1LDkgKzM0MCwxMyBAQCBtaXNjZmlsZXNfcmVhZF9sb2NhbGl6
YXRpb24ocnBtX3NjcmlwdF90KQogbW9kdXRpbHNfZG9tdHJhbnNfZGVwbW9kKHJwbV9zY3JpcHRf
dCkKIG1vZHV0aWxzX2RvbXRyYW5zX2luc21vZChycG1fc2NyaXB0X3QpCiAKLXNldXRpbF9kb210
cmFuc19sb2FkcG9saWN5KHJwbV9zY3JpcHRfdCkKLXNldXRpbF9kb210cmFuc19zZXRmaWxlcyhy
cG1fc2NyaXB0X3QpCi1zZXV0aWxfZG9tdHJhbnNfc2VtYW5hZ2UocnBtX3NjcmlwdF90KQorIyBU
ZXN0IGZvciBhZGRpbmcgb25lIHJvbGUgYXR0cmlidXRlIGludG8gYW5vdGhlcgorIyBycG1fc2Ny
aXB0X3Qgb25seSBjb3VsZCB0cmFuc2l0aW9uIGludG8gc2VtYW5hZ2VfdCwgd2hpY2ggaW4gdHVy
bgorIyBjb3VsZCB0cmFuc2l0aW9uIGludG8gb3RoZXIgc2VsaW51eCB1dGlscyBkb21haW5zIAor
IworI3NldXRpbF9kb210cmFuc19sb2FkcG9saWN5KHJwbV9zY3JpcHRfdCkKKyNzZXV0aWxfZG9t
dHJhbnNfc2V0ZmlsZXMocnBtX3NjcmlwdF90KQorI3NldXRpbF9kb210cmFuc19zZW1hbmFnZShy
cG1fc2NyaXB0X3QpCiAKIHVzZXJkb21fdXNlX2FsbF91c2Vyc19mZHMocnBtX3NjcmlwdF90KQog
CmRpZmYgLS1naXQgYS9wb2xpY3kvbW9kdWxlcy9rZXJuZWwva2VybmVsLnRlIGIvcG9saWN5L21v
ZHVsZXMva2VybmVsL2tlcm5lbC50ZQppbmRleCBkOTFjNjJmLi41ZDZhOWFiIDEwMDY0NAotLS0g
YS9wb2xpY3kvbW9kdWxlcy9rZXJuZWwva2VybmVsLnRlCisrKyBiL3BvbGljeS9tb2R1bGVzL2tl
cm5lbC9rZXJuZWwudGUKQEAgLTI1LDYgKzI1LDcgQEAgcm9sZSBzeXN0ZW1fcjsKIHJvbGUgc3lz
YWRtX3I7CiByb2xlIHN0YWZmX3I7CiByb2xlIHVzZXJfcjsKK3JvbGUgdGVzdF9yOwogCiAjIGhl
cmUgdW50aWwgb3JkZXIgZGVwZW5kZW5jZSBpcyBmaXhlZDoKIHJvbGUgdW5jb25maW5lZF9yOwpk
aWZmIC0tZ2l0IGEvcG9saWN5L21vZHVsZXMvcm9sZXMvdW5wcml2dXNlci50ZSBiL3BvbGljeS9t
b2R1bGVzL3JvbGVzL3VucHJpdnVzZXIudGUKaW5kZXggZDc2OWZiMC4uNDY1YjJlZSAxMDA2NDQK
LS0tIGEvcG9saWN5L21vZHVsZXMvcm9sZXMvdW5wcml2dXNlci50ZQorKysgYi9wb2xpY3kvbW9k
dWxlcy9yb2xlcy91bnByaXZ1c2VyLnRlCkBAIC0xMiw2ICsxMiwxMiBAQCByb2xlIHVzZXJfcjsK
IAogdXNlcmRvbV91bnByaXZfdXNlcl90ZW1wbGF0ZSh1c2VyKQogCityb2xlIHRlc3RfcjsKK3Vz
ZXJkb21fdW5wcml2X3VzZXJfdGVtcGxhdGUodGVzdCkKK29wdGlvbmFsX3BvbGljeShgCisJcnBt
X3J1bih0ZXN0X3QsIHRlc3RfcikKKycpCisKIG9wdGlvbmFsX3BvbGljeShgCiAJYXBhY2hlX3Jv
bGUodXNlcl9yLCB1c2VyX3QpCiAnKQpkaWZmIC0tZ2l0IGEvcG9saWN5L21vZHVsZXMvc3lzdGVt
L3NlbGludXh1dGlsLmlmIGIvcG9saWN5L21vZHVsZXMvc3lzdGVtL3NlbGludXh1dGlsLmlmCmlu
ZGV4IDE3MGUyYzcuLjNiZDZjYjQgMTAwNjQ0Ci0tLSBhL3BvbGljeS9tb2R1bGVzL3N5c3RlbS9z
ZWxpbnV4dXRpbC5pZgorKysgYi9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vc2VsaW51eHV0aWwuaWYK
QEAgLTEwMjcsMTMgKzEwMjcsMTEgQEAgaW50ZXJmYWNlKGBzZXV0aWxfZG9tdHJhbnNfc2VtYW5h
Z2UnLGAKICMKIGludGVyZmFjZShgc2V1dGlsX3J1bl9zZW1hbmFnZScsYAogCWdlbl9yZXF1aXJl
KGAKLQkJdHlwZSBzZW1hbmFnZV90OworCQlhdHRyaWJ1dGVfcm9sZSBzZW1hbmFnZV9yb2xlczsJ
CiAJJykKIAogCXNldXRpbF9kb210cmFuc19zZW1hbmFnZSgkMSkKLQlzZXV0aWxfcnVuX3NldGZp
bGVzKHNlbWFuYWdlX3QsICQyKQotCXNldXRpbF9ydW5fbG9hZHBvbGljeShzZW1hbmFnZV90LCAk
MikKLQlyb2xlICQyIHR5cGVzIHNlbWFuYWdlX3Q7CisJcm9sZWF0dHJpYnV0ZSAkMiBzZW1hbmFn
ZV9yb2xlczsKICcpCiAKICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMK
ZGlmZiAtLWdpdCBhL3BvbGljeS9tb2R1bGVzL3N5c3RlbS9zZWxpbnV4dXRpbC50ZSBiL3BvbGlj
eS9tb2R1bGVzL3N5c3RlbS9zZWxpbnV4dXRpbC50ZQppbmRleCBhN2E4MTg2Li5kNjBkMmZjIDEw
MDY0NAotLS0gYS9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vc2VsaW51eHV0aWwudGUKKysrIGIvcG9s
aWN5L21vZHVsZXMvc3lzdGVtL3NlbGludXh1dGlsLnRlCkBAIC00ODIsNiArNDgyLDIxIEBAIHNl
dXRpbF9tYW5hZ2VfZGVmYXVsdF9jb250ZXh0cyhzZW1hbmFnZV90KQogdXNlcmRvbV9yZWFkX3Vz
ZXJfaG9tZV9jb250ZW50X2ZpbGVzKHNlbWFuYWdlX3QpCiB1c2VyZG9tX3JlYWRfdXNlcl90bXBf
ZmlsZXMoc2VtYW5hZ2VfdCkKIAorIyBUZXN0OiBzZW1hbmFnZV9yb2xlcyBhdHRyaWJ1dGUgYWJs
ZSB0byB0eXBlIGFsbCByZWxhdGVkIGRvbWFpbnMKK2F0dHJpYnV0ZV9yb2xlIHNlbWFuYWdlX3Jv
bGVzOworcm9sZSBzZW1hbmFnZV9yb2xlcyB0eXBlcyB7IHNlbWFuYWdlX3Qgc2V0ZmlsZXNfdCBs
b2FkX3BvbGljeV90IH07CisKKyMgQWRtaW5pc3RyYXRvciBvbmx5IG5lZWRzIHRvIGludm9rZSBz
ZXV0aWxfcnVuX3NlbWFuYWdlKCksIHdoaWxlCisjIHNlbWFuYWdlX3QgaXMgYWJsZSB0byB0cmFu
c2l0aW9uIGludG8gb3RoZXIgZG9tYWlucworc2V1dGlsX3J1bl9zZXRmaWxlcyhzZW1hbmFnZV90
LCBzZW1hbmFnZV9yb2xlcykKK3NldXRpbF9ydW5fbG9hZHBvbGljeShzZW1hbmFnZV90LCBzZW1h
bmFnZV9yb2xlcykKKworIyBVbmNvbW1lbnQgYmVsb3cgc25pcHBldCB0byBkbyAicm9sZSBhdHRy
aWJ1dGUgbG9vcCBkZXBlbmRlbmN5IiB0ZXN0CisjZ2VuX3JlcXVpcmUoYAorIwlhdHRyaWJ1dGVf
cm9sZSBycG1fcm9sZXM7CisjJykKKyNyb2xlYXR0cmlidXRlIHNlbWFuYWdlX3JvbGVzIHJwbV9y
b2xlczsKKwogaWZkZWYoYGRpc3Ryb19kZWJpYW4nLGAKIAlmaWxlc19yZWFkX3Zhcl9saWJfZmls
ZXMoc2VtYW5hZ2VfdCkKIAlmaWxlc19yZWFkX3Zhcl9saWJfc3ltbGlua3Moc2VtYW5hZ2VfdCkK
ZGlmZiAtLWdpdCBhL3BvbGljeS91c2VycyBiL3BvbGljeS91c2VycwppbmRleCBjNGViYzdlLi41
ZTA3MWM3IDEwMDY0NAotLS0gYS9wb2xpY3kvdXNlcnMKKysrIGIvcG9saWN5L3VzZXJzCkBAIC0z
OSw3ICszOSw3IEBAIGdlbl91c2VyKHVuY29uZmluZWRfdSwgdW5jb25maW5lZCwgdW5jb25maW5l
ZF9yLCBzMCwgczAgLSBtbHNfc3lzdGVtaGlnaCwgbWNzX2FsCiAjIG5vdCBpbiB0aGUgc3lzYWRt
X3IuCiAjCiBpZmRlZihgZGlyZWN0X3N5c2FkbV9kYWVtb24nLGAKLQlnZW5fdXNlcihyb290LCBz
eXNhZG0sIHN5c2FkbV9yIHN0YWZmX3IgaWZkZWYoYGVuYWJsZV9tbHMnLGBzZWNhZG1fciBhdWRp
dGFkbV9yJykgc3lzdGVtX3IsIHMwLCBzMCAtIG1sc19zeXN0ZW1oaWdoLCBtY3NfYWxsY2F0cykK
KwlnZW5fdXNlcihyb290LCBzeXNhZG0sIHN5c2FkbV9yIHN0YWZmX3IgdGVzdF9yIGlmZGVmKGBl
bmFibGVfbWxzJyxgc2VjYWRtX3IgYXVkaXRhZG1fcicpIHN5c3RlbV9yLCBzMCwgczAgLSBtbHNf
c3lzdGVtaGlnaCwgbWNzX2FsbGNhdHMpCiAnLGAKLQlnZW5fdXNlcihyb290LCBzeXNhZG0sIHN5
c2FkbV9yIHN0YWZmX3IgaWZkZWYoYGVuYWJsZV9tbHMnLGBzZWNhZG1fciBhdWRpdGFkbV9yJyks
IHMwLCBzMCAtIG1sc19zeXN0ZW1oaWdoLCBtY3NfYWxsY2F0cykKKwlnZW5fdXNlcihyb290LCBz
eXNhZG0sIHN5c2FkbV9yIHN0YWZmX3IgdGVzdF9yIGlmZGVmKGBlbmFibGVfbWxzJyxgc2VjYWRt
X3IgYXVkaXRhZG1fcicpLCBzMCwgczAgLSBtbHNfc3lzdGVtaGlnaCwgbWNzX2FsbGNhdHMpCiAn
KQotLSAKMS43LjAuNAoK

--_d889d054-dc49-4cec-bea3-5776d97859ea_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
