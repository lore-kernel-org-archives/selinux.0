Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5U7Clgg016321
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2011 03:12:47 -0400
Received: from snt0-omc4-s18.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p5U7CUec005779
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2011 07:12:31 GMT
Message-ID: <SNT139-w20B1A1E8C4A8738E18E36AB580@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_30bdc2e6-c721-48de-8074-faf73ae79ee4_"
From: HarryCiao <harrytaurus2002@hotmail.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        lawrence steve
	<slawrence@tresys.com>, <method@manicmethod.com>,
        selinux-mailing-list
	<selinux@tycho.nsa.gov>
Subject: RE: v3 Add role attribute support to libsepol
Date: Thu, 30 Jun 2011 07:11:07 +0000
In-Reply-To: <4E0AD0BC.8040708@windriver.com>
References: <1309249126-5224-1-git-send-email-qingtao.cao@windriver.com>
 <SNT139-w61848BC20E4E7F40D1E43DAB560@phx.gbl>,<4E0AD0BC.8040708@windriver.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_30bdc2e6-c721-48de-8074-faf73ae79ee4_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit




> Date: Wed, 29 Jun 2011 15:14:04 +0800
> From: qingtao.cao@windriver.com
> To: harrytaurus2002@hotmail.com
> CC: cpebenito@tresys.com; slawrence@tresys.com; method@manicmethod.com; selinux@tycho.nsa.gov
> Subject: Re: v3 Add role attribute support to libsepol
> 
> Hi Chris,
> 
> On 06/28/2011 04:28 PM, HarryCiao wrote:
> > Attach the refpolicy debug patches that would generate the test results 
> > mentioned below.
> > 
> > Thanks,
> > Harry
> > 
> >  > From: qingtao.cao@windriver.com
> >  > To: cpebenito@tresys.com; slawrence@tresys.com; method@manicmethod.com
> >  > CC: selinux@tycho.nsa.gov
> >  > Subject: v3 Add role attribute support to libsepol
> >  > Date: Tue, 28 Jun 2011 16:18:40 +0800
> >  >
> >  >
> >  > Differences from v2 patchset
> >  > -----------------------------
> >  > 1. For the 0001 patch,
> >  > Modify symtab_insert() to allow multiple declarations only for the 
> > regular
> >  > roles, while a role attribute can't be declared more than once and can't
> >  > share a same name with another regular role.
> >  >
> >  > 2. For the 0006 patch,
> >  > Although in the link stage all role identifiers defined in any
> >  > block/decl of any module would be copied into the base->p_roles.table,
> >  > the role-attribute relationships would still ! be recorded in the decl's
> >  > local symtab[SYM_ROLES] table(see get_local_role()), so before all the
> >  > escalation of sub role attribute's roles ebitmap into that of parent ever
> >  > happens, all decl in the base->global list except the global block would
> >  > have to be traversed so as to populate potential role-attribute 
> > attributes
> >  > from decl up to the base module.
> >  >
> >  >
> >  > Remaining issues
> >  > -----------------
> >  > 1. If built by "MONOLITHIC = y", run into below errors that not witnessed
> >  > when building in modular way:
> >  >
> >  > /usr/bin/checkpolicy -M -U allow policy.conf -o policy.26
> >  > /usr/bin/checkpolicy: loading policy configuration from policy.conf
> >  > policy/modules/services/likewise.te":140:ERROR 'role attribute 
> > semanage_roles is not declared' at token ';' on line 1494287:
> >  > #line 140
> >  > roleattribute system_r semanage_roles;
> >  > ! checkpolicy: error(s) encountered while parsing configuration
> >  > ; make: *** [policy.26] Error 1
> >  >
> 
> Turns out this is a very interesting thing that is only related with the
> refpolicy debug patch, has nothing to do with this v3 patchset.
> 
> The reason is that seutil_run_semanage() is called in the global block
> of the likewise.te, and when building in a monolithic way, the
> gen_require macro used in the global block would simply be expanded as
> EMPTY, resulting in the semanage_roles attribute is referenced BEFORE
> it's ever declared.
> 
> This problem could be fixed by moving the declaration of semanage_roles
> attribute from selinuxutil.te to kernel.te, but use gen_require macro to
> require it in selinuxutil.te. This would have both hands meet :-)
> 
> Same thing should happen to rpm_roles attribute.
> 
> I have attached the updated 0002 debug patch for above improvement.
> 
> Thanks,
> Harry
> 
> >  > 2. The policy.X's binary representation and SELinux kernel role_datum_t
> >  > structure don't have to be changed, so the max version number for 
> > policy.X
> >  > won't have to be bumped.
> >  >
> >  > But it may be desirable to bump the max module version number.
> >  >

Write flavor flag and roles ebitmap into a pp file and read them out unconditionally, this would only run into problem only under one condition, that libsepol/checkpolicy are upgraded with this patchset but the pp files are built before the upgrade took place, which I think could be easily fixed by re-building all pp files by the upgraded libsepol/checkpolicy.

So I think we don't have to bump MOD_POLICYDB_VERSION_MAX higher.

Am I right?

BTW, how do we trigger a pp downgrade? Anything like OUTPUT_POLICY or policy-version to trigger policy downgrade?

Thanks,
Harry

> >  > (I am still working on these two areas, any comments are greatly 
> > welcomed)
> >  >
> >  >
> >  > Tests I've done
> >  > -----------------
> >  > 1. test_t is able to transition into rpm_t, but could not direclty 
> > transition
> >  > into rpm_script_t, semanage_t, load_policy_t/setfiles_t:
> >  >
> >  > sh-3.2# sesearch -SCA -s test_t -t rpm_t -c process -p transition
> >  > Found 1 semantic av rules:
> >  > allow test_t rpm_t : process transition ;
> >  >
> >  > sh-3.2# sesearch -SCA -s test_t -t rpm_script_t -c process -p transition
> >  >
> >  > sh-3.2# sesearch -SCA -s tes! t_t -t semanage_t -c process -p transition
> >  >
> >  > sh-3.2# sesearch -SCA -s test_t -t load_policy_t -c process -p transition
> >  >
> >  > sh-3.2# sesearch -SCA -s test_t -t setfiles_t -c process -p transition
> >  >
> >  > 2. rpm_t is able to transition into rpm_script_t, but could not directly
> >  > transition into semanage_t, load_policy_t/setfiles_t:
> >  >
> >  > sh-3.2# sesearch -SCA -s rpm_t -t rpm_script_t -c process -p transition
> >  > Found 1 semantic av rules:
> >  > allow rpm_t rpm_script_t : process transition ;
> >  >
> >  > sh-3.2# sesearch -SCA -s rpm_t -t semanage_t -c process -p transition
> >  >
> >  > sh-3.2# sesearch -SCA -s rpm_t -t load_policy_t -c process -p transition
> >  >
> >  > sh-3.2# sesearch -SCA -s rpm_t -t setfiles_t -c process -p transition
> >  >
> >  > 3. rpm_script_t is able to transition into semanage_t, but could not 
> > directly
> >  > transitio! n into load_policy_t/setfiles_t:
> >  >
> >  > sh-3.2# sesear ch -SCA -s rpm_script_t -t semanage_t -c process -p 
> > transition
> >  > Found 1 semantic av rules:
> >  > allow rpm_script_t semanage_t : process transition ;
> >  >
> >  > sh-3.2# sesearch -SCA -s rpm_script_t -t load_policy_t -c process -p 
> > transition
> >  >
> >  > sh-3.2# sesearch -SCA -s rpm_script_t -t setfiles_t -c process -p 
> > transition
> >  >
> >  > 4. semanage_t is able to transition into load_policy_t & setfiles_t:
> >  >
> >  > sh-3.2# sesearch -SCA -s semanage_t -t load_policy_t -c process -p 
> > transition
> >  > Found 1 semantic av rules:
> >  > allow semanage_t load_policy_t : process transition ;
> >  >
> >  > sh-3.2# sesearch -SCA -s semanage_t -t setfiles_t -c process -p 
> > transition
> >  > Found 1 semantic av rules:
> >  > allow semanage_t setfiles_t : process transition ;
> >  >
> >  > 5. test_r is able to type with rpm_t, rpm_script_t, semanage_t, 
> > setfiles_t
> >  > and load! _policy_t:
> >  >
> >  > sh-3.2# compute_create root:test_r:test_t:s0 
> > system_u:object_r:rpm_exec_t:s0 process
> >  > root:test_r:rpm_t:s0
> >  > sh-3.2#
> >  >
> >  > sh-3.2# compute_create root:test_r:rpm_script_t:s0 
> > system_u:object_r:semanage_exec_t:s0 process
> >  > root:test_r:semanage_t:s0
> >  > sh-3.2#
> >  >
> >  > sh-3.2# compute_create root:test_r:semanage_t:s0 
> > system_u:object_r:setfiles_exec_t:s0 process
> >  > root:test_r:setfiles_t:s0
> >  > sh-3.2#
> >  >
> >  > sh-3.2# compute_create root:test_r:semanage_t:s0 
> > system_u:object_r:load_policy_exec_t:s0 process
> >  > root:test_r:load_policy_t:s0
> >  > sh-3.2#
> >  >
> >  > 6. Use the apol tool to analyze what types the test_r role could type 
> > with:
> >  > (Since the apol installed on Ubuntu so far only support max version .24,
> >  > we need to setup "policy-version = 24" in semanage.conf)
> >  >
> >  > test_r (28 type! s)
> >  > chfn_t
> >  > chkpwd_t
> >  > consol etype_t
> >  > ddclient_t
> >  > dhcpc_t
> >  > hostname_t
> >  > ifconfig_t
> >  > insmod_t
> >  > iptables_t
> >  > load_policy_t
> >  > loadkeys_t
> >  > netutils_t
> >  > newrole_t
> >  > pam_t
> >  > passwd_t
> >  > ping_t
> >  > pppd_t
> >  > pptp_t
> >  > rpm_script_t
> >  > rpm_t
> >  > semanage_t
> >  > setfiles_t
> >  > test_t
> >  > traceroute_t
> >  > updpwd_t
> >  > user_home_t
> >  > usernetctl_t
> >  > utempter_t
> >  >
> >  > rpm_roles (2 types)
> >  > rpm_script_t
> >  > rpm_t
> >  >
> >  > semanage_roles (3 types)
> >  > load_policy_t
> >  > semanage_t
> >  > setfiles_t
> >  >
> >  > 7. Verify policy.X's binary representation that test_r's 
> > role_datum_t.types.types ebitmap records all these domains:!
> >  >
> >  > 0047a40: 7406 0000 0024 0a00 0001 0000 0000 0000 t....$..........
> >  > 0047a50: 0074 6573 745f 7407 0000 0025 0a00 0001 .test_t....%....
> >  >
> >  > test_t: policy value = 0xa24
> >  >
> >  > 0036560: 0000 004a 0300 0001 0000 0000 0000 0072 ...J...........r
> >  > 0036570: 706d 5f74 0700 0000 4b03 0000 0100 0000 pm_t....K.......
> >  >
> >  > rpm_t: policy value = 0x34a
> >  >
> >  > 0041050: 0000 6d6f 6e6f 7064 5f65 7463 5f74 0c00 ..monopd_etc_t..
> >  > 0041060: 0000 8907 0000 0100 0000 0000 0000 7270 ..............rp
> >  > 0041070: 6d5f 7363 7269 7074 5f74 0f00 0000 8a07 m_script_t......
> >  >
> >  > rpm_script_t: policy value = 0x789
> >  >
> >  > 004d800: 7365 6375 7269 7479 5f74 0a00 0000 490c security_t....I.
> >  > 004d810: 0000 0100 0000 0000 0000 7365 6d61 6e61 ..........semana
> >  > 004d820: 6765 5f74 0900 0000 4a0c 0000 0300 0000 ge_t....J......! .
> >  >
> >  > semanage_t: policy value = 0xc49
> >  > < br>> 00492c0: 7075 745f 7865 7665 6e74 5f74 0d00 0000 put_xevent_t....
> >  > 00492d0: ae0a 0000 0100 0000 0000 0000 6c6f 6164 ............load
> >  > 00492e0: 5f70 6f6c 6963 795f 740c 0000 00af 0a00 _policy_t.......
> >  >
> >  > load_policy_t: policy value = 0xaae
> >  >
> >  > 004d660: 740a 0000 003f 0c00 0001 0000 0000 0000 t....?..........
> >  > 004d670: 0073 6574 6669 6c65 735f 7414 0000 0010 .setfiles_t.....
> >  >
> >  > setfiles_t: policy value = 0xc3f
> >  >
> >  >
> >  > 002d050: 0600 0000 0000 0000 7465 7374 5f72 4000 ........test_r@.
> >  > 002d060: 0000 4000 0000 0100 0000 0000 0000 2000 ..@........... .
> >  > 002d070: 0000 0000 0000 4000 0000 800c 0000 1400 ......@.........
> >  > 002d080: 0000 8000 0000 0000 0000 0400 0000 4001 ..............@.
> >  > 002d090: 0000 0000 0000 0001 0000 0002 0000 0000 ................
> >  > 002d0a0: 0000 0000 0001 4002 0000 0000 0000 001! 0 ......@.........
> >  > 002d0b0: 0000 8002 0000 0000 0040 0000 0000 0003 .........@......
> >  > 002d0c0: 0000 0000 0004 0000 0030, 4003 0000 0002 .........0@.....
> >  > 002d0d0: 0000 0000 0000, c003 0000 0000 0000 0000 ................
> >  > 002d0e0: 0080 0004 0000 0000 0000 0000 0008 8005 ................
> >  > 002d0f0: 0000 0000 0008 0000 0000 4006 0000 1000 ..........@.....
> >  > 002d100: 0000 0000 0000 8006 0000 0200 0000 0000 ................
> >  > 002d110: 0000, 8007 0000 0001 0000 0000 0000 8009 ................
> >  > 002d120: 0000 0000 0210 0000 0410 c009 0000 0000 ................
> >  > 002d130: 0100 0000 0000, 000a 0000 3000 0000 0800 ..........0.....
> >  > 002d140: 0000, 800a 0000 0000 0000 0020 0000, 000b ........... ....
> >  > 002d150: 0000 0008 0000 0000 0000, 000c 0000 0000 ................
> >  > 002d160: 0000 0000 0040, 400c 0000 0001 0000 0020 .....@@........
> >  > 002d170: 0000!
> >  >
> >  > test_r: policy value = 0x06
> >  > dominates:
> >  > mz = 0x40, highbit = 0x40, node = 1
> >  > startbit = 0, map: 2000 0000 0000 0000
> >  > policy value: 0x06(test_r)
> >  > types.types:
> >  > mz = 0x40, highbit = 0xc80, node = 0x14
> >  > ......
> >  > startbit = 0x340, map: 0002 0000 0000 0000
> >  > policy value: 0x34a(rpm_t)
> >  > ......
> >  > startbit = 0x780, map: 0001 0000 0000 0000
> >  > policy value: 0x789(rpm_script_t)
> >  > ......
> >  > startbit = 0xa00, map: 3000 0000 0800 0000
> >  > policy value: 0xa01, 0xa02, 0xa24(test_t)
> >  > startbit = 0xa80, map: 0000 0000 0020 0000
> >  > policy value: 0xaae(load_policy_t)
> >  > startbit = 0xc00, map: 0000 0000 0000 0040
> >  > policy value: 0xc3f(setfiles_t)
> >  > startbit = 0xc40, map: 0001 0000 0020 0000
> >  > policy value: 0xc49(semanage_t), 0xc6e
> >  >
> >  > --
> >  > This message ! was distributed to subscribers of the selinux mailing 
> > list.
> >  > If you no longer wish to subscribe, send mail to 
> > majordomo@tycho.nsa.gov with
> >  > the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_30bdc2e6-c721-48de-8074-faf73ae79ee4_
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
<br><br><div>&gt; Date: Wed, 29 Jun 2011 15:14:04 +0800<br>&gt; From: qingtao.cao@windriver.com<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: cpebenito@tresys.com; slawrence@tresys.com; method@manicmethod.com; selinux@tycho.nsa.gov<br>&gt; Subject: Re: v3 Add role attribute support to libsepol<br>&gt; <br>&gt; Hi Chris,<br>&gt; <br>&gt; On 06/28/2011 04:28 PM, HarryCiao wrote:<br>&gt; &gt; Attach the refpolicy debug patches that would generate the test results <br>&gt; &gt; mentioned below.<br>&gt; &gt; <br>&gt; &gt; Thanks,<br>&gt; &gt; Harry<br>&gt; &gt; <br>&gt; &gt;  &gt; From: qingtao.cao@windriver.com<br>&gt; &gt;  &gt; To: cpebenito@tresys.com; slawrence@tresys.com; method@manicmethod.com<br>&gt; &gt;  &gt; CC: selinux@tycho.nsa.gov<br>&gt; &gt;  &gt; Subject: v3 Add role attribute support to libsepol<br>&gt; &gt;  &gt; Date: Tue, 28 Jun 2011 16:18:40 +0800<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; Differences from v2 patchset<br>&gt; &gt;  &gt; -!
 ----------------------------<br>&gt; &gt;  &gt; 1. For the 0001 patch,<br>&gt; &gt;  &gt; Modify symtab_insert() to allow multiple declarations only for the <br>&gt; &gt; regular<br>&gt; &gt;  &gt; roles, while a role attribute can't be declared more than once and can't<br>&gt; &gt;  &gt; share a same name with another regular role.<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; 2. For the 0006 patch,<br>&gt; &gt;  &gt; Although in the link stage all role identifiers defined in any<br>&gt; &gt;  &gt; block/decl of any module would be copied into the base-&gt;p_roles.table,<br>&gt; &gt;  &gt; the role-attribute relationships would still ! be recorded in the decl's<br>&gt; &gt;  &gt; local symtab[SYM_ROLES] table(see get_local_role()), so before all the<br>&gt; &gt;  &gt; escalation of sub role attribute's roles ebitmap into that of parent ever<br>&gt; &gt;  &gt; happens, all decl in the base-&gt;global list except the global block would<br>&gt; &gt;  &gt; have to be traversed so as t!
 o populate potential role-attribute <br>&gt; &gt; attributes<br>&gt; &
gt;  &gt; from decl up to the base module.<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; Remaining issues<br>&gt; &gt;  &gt; -----------------<br>&gt; &gt;  &gt; 1. If built by "MONOLITHIC = y", run into below errors that not witnessed<br>&gt; &gt;  &gt; when building in modular way:<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; /usr/bin/checkpolicy -M -U allow policy.conf -o policy.26<br>&gt; &gt;  &gt; /usr/bin/checkpolicy: loading policy configuration from policy.conf<br>&gt; &gt;  &gt; policy/modules/services/likewise.te":140:ERROR 'role attribute <br>&gt; &gt; semanage_roles is not declared' at token ';' on line 1494287:<br>&gt; &gt;  &gt; #line 140<br>&gt; &gt;  &gt; roleattribute system_r semanage_roles;<br>&gt; &gt;  &gt; ! checkpolicy: error(s) encountered while parsing configuration<br>&gt; &gt;  &gt; ; make: *** [policy.26] Error 1<br>&gt; &gt;  &gt;<br>&gt; <br>&gt; Turns out this is a very interesting thing that is only related with the<br>&gt; refpolicy debu!
 g patch, has nothing to do with this v3 patchset.<br>&gt; <br>&gt; The reason is that seutil_run_semanage() is called in the global block<br>&gt; of the likewise.te, and when building in a monolithic way, the<br>&gt; gen_require macro used in the global block would simply be expanded as<br>&gt; EMPTY, resulting in the semanage_roles attribute is referenced BEFORE<br>&gt; it's ever declared.<br>&gt; <br>&gt; This problem could be fixed by moving the declaration of semanage_roles<br>&gt; attribute from selinuxutil.te to kernel.te, but use gen_require macro to<br>&gt; require it in selinuxutil.te. This would have both hands meet :-)<br>&gt; <br>&gt; Same thing should happen to rpm_roles attribute.<br>&gt; <br>&gt; I have attached the updated 0002 debug patch for above improvement.<br>&gt; <br>&gt; Thanks,<br>&gt; Harry<br>&gt; <br>&gt; &gt;  &gt; 2. The policy.X's binary representation and SELinux kernel role_datum_t<br>&gt; &gt;  &gt; structure don't have to be changed, so th!
 e max version number for <br>&gt; &gt; policy.X<br>&gt; &gt;  &gt; won
't have to be bumped.<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; But it may be desirable to bump the max module version number.<br>&gt; &gt;  &gt;<br><br>Write flavor flag and roles ebitmap into a pp file and read them out unconditionally, this would only run into problem only under one condition, that libsepol/checkpolicy are upgraded with this patchset but the pp files are built before the upgrade took place, which I think could be easily fixed by re-building all pp files by the upgraded libsepol/checkpolicy.<br><br>So I think we don't have to bump MOD_POLICYDB_VERSION_MAX higher.<br><br>Am I right?<br><br>BTW, how do we trigger a pp downgrade? Anything like OUTPUT_POLICY or policy-version to trigger policy downgrade?<br><br>Thanks,<br>Harry<br><br>&gt; &gt;  &gt; (I am still working on these two areas, any comments are greatly <br>&gt; &gt; welcomed)<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; Tests I've done<br>&gt; &gt;  &gt; -----------------<br>&gt; &gt;  &gt;!
  1. test_t is able to transition into rpm_t, but could not direclty <br>&gt; &gt; transition<br>&gt; &gt;  &gt; into rpm_script_t, semanage_t, load_policy_t/setfiles_t:<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# sesearch -SCA -s test_t -t rpm_t -c process -p transition<br>&gt; &gt;  &gt; Found 1 semantic av rules:<br>&gt; &gt;  &gt; allow test_t rpm_t : process transition ;<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# sesearch -SCA -s test_t -t rpm_script_t -c process -p transition<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# sesearch -SCA -s tes! t_t -t semanage_t -c process -p transition<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# sesearch -SCA -s test_t -t load_policy_t -c process -p transition<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# sesearch -SCA -s test_t -t setfiles_t -c process -p transition<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; 2. rpm_t is able to transition into rpm_script_t, but could not directly<br>&gt; &gt;  &gt; transition into semanage_t, load_po!
 licy_t/setfiles_t:<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# sesea
rch -SCA -s rpm_t -t rpm_script_t -c process -p transition<br>&gt; &gt;  &gt; Found 1 semantic av rules:<br>&gt; &gt;  &gt; allow rpm_t rpm_script_t : process transition ;<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# sesearch -SCA -s rpm_t -t semanage_t -c process -p transition<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# sesearch -SCA -s rpm_t -t load_policy_t -c process -p transition<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# sesearch -SCA -s rpm_t -t setfiles_t -c process -p transition<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; 3. rpm_script_t is able to transition into semanage_t, but could not <br>&gt; &gt; directly<br>&gt; &gt;  &gt; transitio! n into load_policy_t/setfiles_t:<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# sesear ch -SCA -s rpm_script_t -t semanage_t -c process -p <br>&gt; &gt; transition<br>&gt; &gt;  &gt; Found 1 semantic av rules:<br>&gt; &gt;  &gt; allow rpm_script_t semanage_t : process transition ;<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# ses!
 earch -SCA -s rpm_script_t -t load_policy_t -c process -p <br>&gt; &gt; transition<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# sesearch -SCA -s rpm_script_t -t setfiles_t -c process -p <br>&gt; &gt; transition<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; 4. semanage_t is able to transition into load_policy_t &amp; setfiles_t:<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# sesearch -SCA -s semanage_t -t load_policy_t -c process -p <br>&gt; &gt; transition<br>&gt; &gt;  &gt; Found 1 semantic av rules:<br>&gt; &gt;  &gt; allow semanage_t load_policy_t : process transition ;<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# sesearch -SCA -s semanage_t -t setfiles_t -c process -p <br>&gt; &gt; transition<br>&gt; &gt;  &gt; Found 1 semantic av rules:<br>&gt; &gt;  &gt; allow semanage_t setfiles_t : process transition ;<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; 5. test_r is able to type with rpm_t, rpm_script_t, semanage_t, <br>&gt; &gt; setfiles_t<br>&gt; &gt;  &gt; and load! _policy_t:<br>&gt!
 ; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# compute_create root:test_r:tes
t_t:s0 <br>&gt; &gt; system_u:object_r:rpm_exec_t:s0 process<br>&gt; &gt;  &gt; root:test_r:rpm_t:s0<br>&gt; &gt;  &gt; sh-3.2#<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# compute_create root:test_r:rpm_script_t:s0 <br>&gt; &gt; system_u:object_r:semanage_exec_t:s0 process<br>&gt; &gt;  &gt; root:test_r:semanage_t:s0<br>&gt; &gt;  &gt; sh-3.2#<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# compute_create root:test_r:semanage_t:s0 <br>&gt; &gt; system_u:object_r:setfiles_exec_t:s0 process<br>&gt; &gt;  &gt; root:test_r:setfiles_t:s0<br>&gt; &gt;  &gt; sh-3.2#<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; sh-3.2# compute_create root:test_r:semanage_t:s0 <br>&gt; &gt; system_u:object_r:load_policy_exec_t:s0 process<br>&gt; &gt;  &gt; root:test_r:load_policy_t:s0<br>&gt; &gt;  &gt; sh-3.2#<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; 6. Use the apol tool to analyze what types the test_r role could type <br>&gt; &gt; with:<br>&gt; &gt;  &gt; (Since the apol installed on Ubuntu so far only supp!
 ort max version .24,<br>&gt; &gt;  &gt; we need to setup "policy-version = 24" in semanage.conf)<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; test_r (28 type! s)<br>&gt; &gt;  &gt; chfn_t<br>&gt; &gt;  &gt; chkpwd_t<br>&gt; &gt;  &gt; consol etype_t<br>&gt; &gt;  &gt; ddclient_t<br>&gt; &gt;  &gt; dhcpc_t<br>&gt; &gt;  &gt; hostname_t<br>&gt; &gt;  &gt; ifconfig_t<br>&gt; &gt;  &gt; insmod_t<br>&gt; &gt;  &gt; iptables_t<br>&gt; &gt;  &gt; load_policy_t<br>&gt; &gt;  &gt; loadkeys_t<br>&gt; &gt;  &gt; netutils_t<br>&gt; &gt;  &gt; newrole_t<br>&gt; &gt;  &gt; pam_t<br>&gt; &gt;  &gt; passwd_t<br>&gt; &gt;  &gt; ping_t<br>&gt; &gt;  &gt; pppd_t<br>&gt; &gt;  &gt; pptp_t<br>&gt; &gt;  &gt; rpm_script_t<br>&gt; &gt;  &gt; rpm_t<br>&gt; &gt;  &gt; semanage_t<br>&gt; &gt;  &gt; setfiles_t<br>&gt; &gt;  &gt; test_t<br>&gt; &gt;  &gt; traceroute_t<br>&gt; &gt;  &gt; updpwd_t<br>&gt; &gt;  &gt; user_home_t<br>&gt; &gt;  &gt; usernetctl_t<br>&gt; &gt;  &gt; utempter_t<br>&gt; &gt;  &gt;<br!
 >&gt; &gt;  &gt; rpm_roles (2 types)<br>&gt; &gt;  &gt; rpm_script_t<b
r>&gt; &gt;  &gt; rpm_t<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; semanage_roles (3 types)<br>&gt; &gt;  &gt; load_policy_t<br>&gt; &gt;  &gt; semanage_t<br>&gt; &gt;  &gt; setfiles_t<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; 7. Verify policy.X's binary representation that test_r's <br>&gt; &gt; role_datum_t.types.types ebitmap records all these domains:!<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; 0047a40: 7406 0000 0024 0a00 0001 0000 0000 0000 t....$..........<br>&gt; &gt;  &gt; 0047a50: 0074 6573 745f 7407 0000 0025 0a00 0001 .test_t....%....<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; test_t: policy value = 0xa24<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; 0036560: 0000 004a 0300 0001 0000 0000 0000 0072 ...J...........r<br>&gt; &gt;  &gt; 0036570: 706d 5f74 0700 0000 4b03 0000 0100 0000 pm_t....K.......<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; rpm_t: policy value = 0x34a<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; 0041050: 0000 6d6f 6e6f 7064 5f65 7463 5f74 0c00 ..monopd_etc_t..<br>&gt; &gt;  &gt; 00410!
 60: 0000 8907 0000 0100 0000 0000 0000 7270 ..............rp<br>&gt; &gt;  &gt; 0041070: 6d5f 7363 7269 7074 5f74 0f00 0000 8a07 m_script_t......<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; rpm_script_t: policy value = 0x789<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; 004d800: 7365 6375 7269 7479 5f74 0a00 0000 490c security_t....I.<br>&gt; &gt;  &gt; 004d810: 0000 0100 0000 0000 0000 7365 6d61 6e61 ..........semana<br>&gt; &gt;  &gt; 004d820: 6765 5f74 0900 0000 4a0c 0000 0300 0000 ge_t....J......! .<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; semanage_t: policy value = 0xc49<br>&gt; &gt;  &gt; &lt; br&gt;&gt; 00492c0: 7075 745f 7865 7665 6e74 5f74 0d00 0000 put_xevent_t....<br>&gt; &gt;  &gt; 00492d0: ae0a 0000 0100 0000 0000 0000 6c6f 6164 ............load<br>&gt; &gt;  &gt; 00492e0: 5f70 6f6c 6963 795f 740c 0000 00af 0a00 _policy_t.......<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; load_policy_t: policy value = 0xaae<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; 004d660: 740a 0000 003f 0c00 0001 0000 !
 0000 0000 t....?..........<br>&gt; &gt;  &gt; 004d670: 0073 6574 6669 
6c65 735f 7414 0000 0010 .setfiles_t.....<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; setfiles_t: policy value = 0xc3f<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; 002d050: 0600 0000 0000 0000 7465 7374 5f72 4000 ........test_r@.<br>&gt; &gt;  &gt; 002d060: 0000 4000 0000 0100 0000 0000 0000 2000 ..@........... .<br>&gt; &gt;  &gt; 002d070: 0000 0000 0000 4000 0000 800c 0000 1400 ......@.........<br>&gt; &gt;  &gt; 002d080: 0000 8000 0000 0000 0000 0400 0000 4001 ..............@.<br>&gt; &gt;  &gt; 002d090: 0000 0000 0000 0001 0000 0002 0000 0000 ................<br>&gt; &gt;  &gt; 002d0a0: 0000 0000 0001 4002 0000 0000 0000 001! 0 ......@.........<br>&gt; &gt;  &gt; 002d0b0: 0000 8002 0000 0000 0040 0000 0000 0003 .........@......<br>&gt; &gt;  &gt; 002d0c0: 0000 0000 0004 0000 0030, 4003 0000 0002 .........0@.....<br>&gt; &gt;  &gt; 002d0d0: 0000 0000 0000, c003 0000 0000 0000 0000 ................<br>&gt; &gt;  &gt; 002d0e0: 0080 0004 0000 0000 0000 0000 0008 8005 .!
 ...............<br>&gt; &gt;  &gt; 002d0f0: 0000 0000 0008 0000 0000 4006 0000 1000 ..........@.....<br>&gt; &gt;  &gt; 002d100: 0000 0000 0000 8006 0000 0200 0000 0000 ................<br>&gt; &gt;  &gt; 002d110: 0000, 8007 0000 0001 0000 0000 0000 8009 ................<br>&gt; &gt;  &gt; 002d120: 0000 0000 0210 0000 0410 c009 0000 0000 ................<br>&gt; &gt;  &gt; 002d130: 0100 0000 0000, 000a 0000 3000 0000 0800 ..........0.....<br>&gt; &gt;  &gt; 002d140: 0000, 800a 0000 0000 0000 0020 0000, 000b ........... ....<br>&gt; &gt;  &gt; 002d150: 0000 0008 0000 0000 0000, 000c 0000 0000 ................<br>&gt; &gt;  &gt; 002d160: 0000 0000 0040, 400c 0000 0001 0000 0020 .....@@........<br>&gt; &gt;  &gt; 002d170: 0000!<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; test_r: policy value = 0x06<br>&gt; &gt;  &gt; dominates:<br>&gt; &gt;  &gt; mz = 0x40, highbit = 0x40, node = 1<br>&gt; &gt;  &gt; startbit = 0, map: 2000 0000 0000 0000<br>&gt; &gt;  &gt; policy value: 0x06(test_r!
 )<br>&gt; &gt;  &gt; types.types:<br>&gt; &gt;  &gt; mz = 0x40, highbi
t = 0xc80, node = 0x14<br>&gt; &gt;  &gt; ......<br>&gt; &gt;  &gt; startbit = 0x340, map: 0002 0000 0000 0000<br>&gt; &gt;  &gt; policy value: 0x34a(rpm_t)<br>&gt; &gt;  &gt; ......<br>&gt; &gt;  &gt; startbit = 0x780, map: 0001 0000 0000 0000<br>&gt; &gt;  &gt; policy value: 0x789(rpm_script_t)<br>&gt; &gt;  &gt; ......<br>&gt; &gt;  &gt; startbit = 0xa00, map: 3000 0000 0800 0000<br>&gt; &gt;  &gt; policy value: 0xa01, 0xa02, 0xa24(test_t)<br>&gt; &gt;  &gt; startbit = 0xa80, map: 0000 0000 0020 0000<br>&gt; &gt;  &gt; policy value: 0xaae(load_policy_t)<br>&gt; &gt;  &gt; startbit = 0xc00, map: 0000 0000 0000 0040<br>&gt; &gt;  &gt; policy value: 0xc3f(setfiles_t)<br>&gt; &gt;  &gt; startbit = 0xc40, map: 0001 0000 0020 0000<br>&gt; &gt;  &gt; policy value: 0xc49(semanage_t), 0xc6e<br>&gt; &gt;  &gt;<br>&gt; &gt;  &gt; --<br>&gt; &gt;  &gt; This message ! was distributed to subscribers of the selinux mailing <br>&gt; &gt; list.<br>&gt; &gt;  &gt; If you no longer wish to !
 subscribe, send mail to <br>&gt; &gt; majordomo@tycho.nsa.gov with<br>&gt; &gt;  &gt; the words "unsubscribe selinux" without quotes as the message.<br></div> 		 	   		  </div></body>
</html>
--_30bdc2e6-c721-48de-8074-faf73ae79ee4_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
