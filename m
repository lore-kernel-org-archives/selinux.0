Message-ID: <SNT139-w392B170053BA55B438ED80AB780@phx.gbl>
Content-Type: multipart/mixed;
	boundary="_cef754e5-daf5-4a46-93d3-b4eec741a280_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley
	<sds@tycho.nsa.gov>, <method@manicmethod.com>,
        <jmorris@namei.org>, <eparis@parisplace.org>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: v1 Add role attribute support to libsepol
Date: Sun, 29 May 2011 10:41:52 +0000
In-Reply-To: <SNT139-w55F310E84EDBF5249B5C59AB780@phx.gbl>
References: 
 <1306643819-30374-1-git-send-email-qingtao.cao@windriver.com>,<SNT139-w55F310E84EDBF5249B5C59AB780@phx.gbl>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_cef754e5-daf5-4a46-93d3-b4eec741a280_
Content-Type: multipart/alternative;
	boundary="_41ed9ba5-5536-4c67-8131-7b6aa9b4e6a6_"

--_41ed9ba5-5536-4c67-8131-7b6aa9b4e6a6_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi,

Sorry I seems to have some problem to send the last 6/6 patch by git send-mail, try again and re-send it by attachment. 

This 6/6 patch adds support to adding one role attribute into another, while the first 5 patches are the same as v0.

Thanks!
Harry

From: harrytaurus2002@hotmail.com
To: qingtao.cao@windriver.com; cpebenito@tresys.com; sds@tycho.nsa.gov; method@manicmethod.com; jmorris@namei.org; eparis@parisplace.org
CC: selinux@tycho.nsa.gov
Subject: RE: v1 Add role attribute support to libsepol
Date: Sun, 29 May 2011 04:51:26 +0000








Attach the refpolicy patch to test adding one role attribute into another.

> From: qingtao.cao@windriver.com
> To: cpebenito@tresys.com; sds@tycho.nsa.gov; method@manicmethod.com; jmorris@namei.org; eparis@parisplace.org
> CC: selinux@tycho.nsa.gov
> Subject: v1 Add role attribute support to libsepol
> Date: Sun, 29 May 2011 12:36:53 +0800
> 
> 
> 
> Comments
> ---------
> 
>     Support adding one role attribute into another.
>     
>     When the link process is completed, the types type_set_t and roles
>     ebitmap in a role attribute are settled, then we could go on scan
>     all role attributes in the base.p_roles table checking if any non-zero
>     bit in its roles ebitmap is indeed another role attribute.
>     
>     If this is the case, then we need to escalate the roles ebitmap of
>     the sub-attribute into that of the parent attribute, a!
 nd remove the
>     sub-attribute from parent's roles ebitmap.
>     
>     Since sub-attribute's roles ebitmap may further contain other role
>     attributes, we need to re-scan the updated parent's roles ebitmap.
>     
>     Also if a loop dependency is detected, no escalation of sub-attribute's
>     roles ebitmap is needed.
> 
> 
>     In order to highlight this patch I've decided to introduce a new
>     separate commit, while all the rest 5 commits are the same as v0.
> 
> 
> Tests of adding one role attribute into another
> ------------------------------------------------
>    
> 1. Apply the patch for rpm.* and selinuxuti.*, to introduce rpm_roles and
>    semanage_roles attributes and eliminate the "chain of run interfaces",
>    make policy.X and dump its hexdump, check out the policy value for
>    related identifiers:
>    
>    0!
 035b00: 5f74 0500 0000 4103 0000 0100 0000 0000  _t....A.........
&
gt;    0035b10: 0000 7270 6d5f 7407 0000 0042 0300 0001  ..rpm_t....
>    
>    rpm_t: policy value = 0x341
>    
>    0040460: 740c 0000 0075 0700 0001 0000 0000 0000  t....u..........
>    0040470: 0072 706d 5f73 6372 6970 745f 740f 0000  .rpm_script_t.
>    
>    rpm_script_t: policy value = 0x775
>    
>    004c900: 6563 7572 6974 795f 740a 0000 001e 0c00  ecurity_t.......
>    004c910: 0001 0000 0000 0000 0073 656d 616e 6167  .........semanag
>    004c920: 655f 7409 0000 001f 0c00 0003 0000 0000  e_t
>    
>    semanage_t: policy value = 0xc1e
>    
>    004c760: 0a00 0000 140c 0000 0100 0000 0000 0000  ................
>    004c770: 7365 7466 696c 6573 5f74 1400 0000 ec0a  setfiles_t......
>    
>    setfiles_t: policy value = 0xc14
>    
>    00484e0: 740d 0000 008b 0a00 0001 0000 0000 0000  t...............
>    00484f0: 006c 6f61 645f 706f 6c!
 69 6379 5f74 0c00  .load_policy_t..
>    
>    load_policy_t: policy value = 0xa8b
>    
>    
> 2. Check out rpm_roles.types ebitmap:
>    
>    002d2c0: 0000 0400 0000 0000 0000 0900 0000 0f00  ................
>    002d2d0: 0000 0000 0000 7270 6d5f 726f 6c65 7340  ......rpm_roles@
>    002d2e0: 0000 0040 0000 0001 0000 0000 0000 0000  ...@............
>    002d2f0: 4000 0000 0000 0040 0000 0080 0700 0002  @......@........
>    002d300: 0000 0040 0300 0001 0000 0000 0000 0040  ...@...........@
>    002d310: 0700 0000 0000 0000 0010 000b 0000 0010  ................
>    002d320: 0000 0000 0000 006e 785f 7365 7276 6572  .......
>    
>    rpm_roles: policy value = 0x0f
>    	dominates:
>   		mz = 0x40, highbit = 0x40, node = 1
> 		startbit = 0, map: 00 4000 0000 0000 00 
> 			policy value: 0x0f(rpm_roles)
>    	types.types:
>    		mz = 0x40, highbit !
 = 0x780, node = 2
>    		startbit = 0x340, map: 01 0000 0000 000
0 00
> 			policy value: 0x341(rpm_t)
>    		startbit = 0x740, map: 00 0000 0000 0010 00
> 			policy value: 0x775(rpm_script_t)
>    
>    
> 3. Check out semanage_roles.types ebitmap:
>    
>    002caa0: 0000 0000 0e00 0000 0800 0000 0000 0000  ................
>    002cab0: 7365 6d61 6e61 6765 5f72 6f6c 6573 4000  semanage_roles@.
>    002cac0: 0000 4000 0000 0100 0000 0000 0000 8000  ..@.............
>    002cad0: 0000 0000 0000 4000 0000 400c 0000 0200  ......@...@.....
>    002cae0: 0000 800a 0000 0004 0000 0000 0000 000c  ................
>    002caf0: 0000 0000 0820 0000 0000 1000 0000 0900  ..... ..........
>    002cb00: 0000 0000 0000 726f 6c65 5f61 7474 7269  ......
>    
>    semanage_roles: policy value = 0x08
>    	dominates:
>   		mz = 0x40, highbit = 0x40, node = 1, 
> 		startbit = 0, map: 8000 0000 0000 0000 
> 			policy value: 8(semanage_rol!
 es)
>    	types.types:
>    		mz = 0x40, highbit = 0xc40 node = 2
> 		startbit = 0xa80, map: 0004 0000 0000 0000
> 			policy value: 0xa8b(load_policy_t)
> 		startbit = 0xc00, map: 0000 0820 0000 0000
> 			policy value: 0xc14(setfiles_t), 0xc1e(semanage_t)
>    
>    
> 4. Verify that once rpm_roles attribute becomes a sub-attribute of
>    semanage_roles attribute, then all regular roles belonging to rpm_roles
>    such as sysadm_r should be able to type all those types of the parent role
>    attribute's types(that is, semanage_roles.types):
>    
>    002ccc0: 0000 0800 0000 0b00 0000 0000 0000 7379  ..............sy
>    002ccd0: 7361 646d 5f72 4000 0000 4000 0000 0100  sadm_r@...@.....
>    002cce0: 0000 0000 0000 0004 0000 0000 0000 4000  ..............@.
>    002ccf0: 0000 800d 0000 2d00 0000 8000 0000 0000  ......-.........
>    ...
>    002cd70: 5808, 40!
 03 0000 0906 0200 0000 0000, 8003  X.@.............
>    ...

>    002cdf0: 4000 0000 0900 c006 0000 0000 0008 0000  @...............
>    002ce00: 0000, 4007 0000 4000 0000 0000 1006, 8007  ..@...@.........
>    002ce10: 0000 0000 000a 0000 0000 c007 0000 0080  ................
>    ...
>    002ce90: 8000, 400a 0000 0000 0000 0000 0040, 800a  ..@..........@..
>    002cea0: 0000 0004 0002 0000 0000 c00a 0000 0000  ................
>    002ceb0: 0000 8000 0000 000b 0000 0000 0080 0080  ................
>    002cec0: 0000 c00b 0000 0000 0000 1000 0000, 000c  ................
>    002ced0: 0000 0000 3820 0004 0000 400c 0000 0400  ....8 ....@.....
>    ...
>    
>    sysadm_r: policy value = 0x0b
>    	dominates:
>    		mz = 0x40, highbit = 0x40, node = 1
>    		startbit = 0x0, map: 0004 0000 0000 0000
> 			policy value: 0x0b(sysadm_r)
>    	types.types:
>    		mz = 0x40, highbit = 0xd80, node = 0x2d
>    		startbit = 0x340, map: !
 0906 0200 0000 0000
>    			policy value: 341(rpm_t), 344, 34a, 34b
>    
>    		startbit = 0x740, map: 4000 0000 0000 1006
>    			policy value: 747, 775(rpm_script_t), 77a, 77b
>    
>    		startbit = 0xa80, map: 0004 0002 0000 0000
>    			policy value: a8b(load_policy_t), a9a
>    
>    		startbit = 0xc00, map: 0000 3820 0004 0000 
>    			policy value: c14(setfiles_t), c15, c16, c1e(semanage_t)
>    
>    
> 5. Extra loop depenency tests.
>    
> 5.1 When there is no loop dependency between rpm_roles and semanage_roles
>    attributes, the secadm_r that belongs to semanage_roles attributes is
>    not able to type those types of the rpm_roles.types, such as rpm_t or
>    rpm_script_t:
>    
>    002cb60: 0000 0a00 0000 0000 0000 7365 6361 646d  ..........secadm
>    002cb70: 5f72 4000 0000 4000 0000 0100 0000 0000  _r@...@.........
>    00!
 2cb80: 0000 0002 0000 0000 0000 4000 0000 400d  ..........@...@.
&g
t;    002cb90: 0000 1900 0000 8000 0000 0000 0000 0200  ................
>    ...
>    002cbe0: 0000 0400 0200 0000 1800, 4003 0000 0002  ..........@.....
>    002cbf0: 0000 0000 0000 c003 0000 0000 0000 0000  ................
>    ...
>    002cc30: 0800 4006 0000 0000 0000 0000 0100, 4007  ..@...........@.
>    002cc40: 0000 0000 0000 0000 2000 4009 0000 0000  ........ .@.....
>    002cc50: 0000 0000 0420 8009 0000 0000 0820 0000  ..... ....... ..
>    
>    secadm_r:
>    	types.types:
>    		mz = 0x40, highbit = 0xd40, node = 0x19
>    		startbit = 0x340, map: 0002 0000 0000 0000
>    			policy value: 34a, ... 
>    		
>    		startbit = 0x740, map: 0000 0000 0000 2000
>    			policy value: 776
>    
>    
> 5.2 Add below statements in selinuxutil.te to create a loop dependcy
>    between rpm_roles and semanage_roles attributes:
>    
>    att!
 ribute rpm_roles ROLE;
>    roleattribute semanage_roles rpm_roles;
>    
>    Then rebuild policy.X in modular way, the loop dependency should be
>    properly handled, and secadm_r that belongs to the semanage_roles
>    should be able to type all those types in rpm_roles.types ebitmap,
>    such as rpm_t and rpm_script_t:
>    
>    002cb60: 0000 0a00 0000 0000 0000 7365 6361 646d  ..........secadm
>    002cb70: 5f72 4000 0000 4000 0000 0100 0000 0000  _r@...@.........
>    002cb80: 0000 0002 0000 0000 0000 4000 0000 400d  ..........@...@.
>    002cb90: 0000 1900 0000 8000 0000 0000 0000 0200  ................
>    ...
>    002cbe0: 0000 0400 0200 0000 1800, 4003 0000 0102  ..........@.....
>    002cbf0: 0000 0000 0000 c003 0000 0000 0000 0000  ................
>    ...
>    002cc30: 0800 4006 0000 0000 0000 0000 0100, 4007  ..@...........@.
>    002cc40: 0000 0000 0000 !
 0000 3000 4009 0000 0000  ........0.@.....
>    002cc50: 0000 00
00 0420 8009 0000 0000 0820 0000  ..... ....... ..
>    
>    secadm_r:
>    	types.types:
>    		mz = 0x40, highbit = 0xd40, node = 0x19
>    		startbit = 0x340, map: 0102 0000 0000 0000
>    			policy value: 341(rpm_t), ... 
>    		
>    		startbit = 0x740, map: 0000 0000 0000 3000
>    			policy value: 775(rpm_script_t), 776
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_41ed9ba5-5536-4c67-8131-7b6aa9b4e6a6_
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
<body class='hmmessage'>
Hi,<br><br>Sorry I seems to have some problem to send the last 6/6 patch by git send-mail, try again and re-send it by attachment. <br><br>This 6/6 patch adds support to adding one role attribute into another, while the first 5 patches are the same as v0.<br><br>Thanks!<br>Harry<br><br><hr id="stopSpelling">From: harrytaurus2002@hotmail.com<br>To: qingtao.cao@windriver.com; cpebenito@tresys.com; sds@tycho.nsa.gov; method@manicmethod.com; jmorris@namei.org; eparis@parisplace.org<br>CC: selinux@tycho.nsa.gov<br>Subject: RE: v1 Add role attribute support to libsepol<br>Date: Sun, 29 May 2011 04:51:26 +0000<br><br>

<meta http-equiv="Content-Type" content="text/html; charset=unicode">
<meta name="Generator" content="Microsoft SafeHTML">
<style>
.ExternalClass .ecxhmmessage P
{padding:0px;}
.ExternalClass body.ecxhmmessage
{font-size:10pt;font-family:Î¢ÈíÑÅºÚ;}

</style>


Attach the refpolicy patch to test adding one role attribute into another.<br><br>&gt; From: qingtao.cao@windriver.com<br>&gt; To: cpebenito@tresys.com; sds@tycho.nsa.gov; method@manicmethod.com; jmorris@namei.org; eparis@parisplace.org<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; Subject: v1 Add role attribute support to libsepol<br>&gt; Date: Sun, 29 May 2011 12:36:53 +0800<br>&gt; <br>&gt; <br>&gt; <br>&gt; Comments<br>&gt; ---------<br>&gt; <br>&gt;     Support adding one role attribute into another.<br>&gt;     <br>&gt;     When the link process is completed, the types type_set_t and roles<br>&gt;     ebitmap in a role attribute are settled, then we could go on scan<br>&gt;     all role attributes in the base.p_roles table checking if any non-zero<br>&gt;     bit in its roles ebitmap is indeed another role attribute.<br>&gt;     <br>&gt;     If this is the case, then we need to escalate the roles ebitmap of<br>&gt;     the sub-attribute into that of the parent attribute, a!
 nd remove the<br>&gt;     sub-attribute from parent's roles ebitmap.<br>&gt;     <br>&gt;     Since sub-attribute's roles ebitmap may further contain other role<br>&gt;     attributes, we need to re-scan the updated parent's roles ebitmap.<br>&gt;     <br>&gt;     Also if a loop dependency is detected, no escalation of sub-attribute's<br>&gt;     roles ebitmap is needed.<br>&gt; <br>&gt; <br>&gt;     In order to highlight this patch I've decided to introduce a new<br>&gt;     separate commit, while all the rest 5 commits are the same as v0.<br>&gt; <br>&gt; <br>&gt; Tests of adding one role attribute into another<br>&gt; ------------------------------------------------<br>&gt;    <br>&gt; 1. Apply the patch for rpm.* and selinuxuti.*, to introduce rpm_roles and<br>&gt;    semanage_roles attributes and eliminate the "chain of run interfaces",<br>&gt;    make policy.X and dump its hexdump, check out the policy value for<br>&gt;    related identifiers:<br>&gt;    <br>&gt;    0!
 035b00: 5f74 0500 0000 4103 0000 0100 0000 0000  _t....A.........<br>&amp;
gt;    0035b10: 0000 7270 6d5f 7407 0000 0042 0300 0001  ..rpm_t....<br>&gt;    <br>&gt;    rpm_t: policy value = 0x341<br>&gt;    <br>&gt;    0040460: 740c 0000 0075 0700 0001 0000 0000 0000  t....u..........<br>&gt;    0040470: 0072 706d 5f73 6372 6970 745f 740f 0000  .rpm_script_t.<br>&gt;    <br>&gt;    rpm_script_t: policy value = 0x775<br>&gt;    <br>&gt;    004c900: 6563 7572 6974 795f 740a 0000 001e 0c00  ecurity_t.......<br>&gt;    004c910: 0001 0000 0000 0000 0073 656d 616e 6167  .........semanag<br>&gt;    004c920: 655f 7409 0000 001f 0c00 0003 0000 0000  e_t<br>&gt;    <br>&gt;    semanage_t: policy value = 0xc1e<br>&gt;    <br>&gt;    004c760: 0a00 0000 140c 0000 0100 0000 0000 0000  ................<br>&gt;    004c770: 7365 7466 696c 6573 5f74 1400 0000 ec0a  setfiles_t......<br>&gt;    <br>&gt;    setfiles_t: policy value = 0xc14<br>&gt;    <br>&gt;    00484e0: 740d 0000 008b 0a00 0001 0000 0000 0000  t...............<br>&gt;    00484f0: 006c 6f61 645f 706f 6c!
 69 6379 5f74 0c00  .load_policy_t..<br>&gt;    <br>&gt;    load_policy_t: policy value = 0xa8b<br>&gt;    <br>&gt;    <br>&gt; 2. Check out rpm_roles.types ebitmap:<br>&gt;    <br>&gt;    002d2c0: 0000 0400 0000 0000 0000 0900 0000 0f00  ................<br>&gt;    002d2d0: 0000 0000 0000 7270 6d5f 726f 6c65 7340  ......rpm_roles@<br>&gt;    002d2e0: 0000 0040 0000 0001 0000 0000 0000 0000  ...@............<br>&gt;    002d2f0: 4000 0000 0000 0040 0000 0080 0700 0002  @......@........<br>&gt;    002d300: 0000 0040 0300 0001 0000 0000 0000 0040  ...@...........@<br>&gt;    002d310: 0700 0000 0000 0000 0010 000b 0000 0010  ................<br>&gt;    002d320: 0000 0000 0000 006e 785f 7365 7276 6572  .......<br>&gt;    <br>&gt;    rpm_roles: policy value = 0x0f<br>&gt;    	dominates:<br>&gt;   		mz = 0x40, highbit = 0x40, node = 1<br>&gt; 		startbit = 0, map: 00 4000 0000 0000 00 <br>&gt; 			policy value: 0x0f(rpm_roles)<br>&gt;    	types.types:<br>&gt;    		mz = 0x40, highbit !
 = 0x780, node = 2<br>&gt;    		startbit = 0x340, map: 01 0000 0000 000
0 00<br>&gt; 			policy value: 0x341(rpm_t)<br>&gt;    		startbit = 0x740, map: 00 0000 0000 0010 00<br>&gt; 			policy value: 0x775(rpm_script_t)<br>&gt;    <br>&gt;    <br>&gt; 3. Check out semanage_roles.types ebitmap:<br>&gt;    <br>&gt;    002caa0: 0000 0000 0e00 0000 0800 0000 0000 0000  ................<br>&gt;    002cab0: 7365 6d61 6e61 6765 5f72 6f6c 6573 4000  semanage_roles@.<br>&gt;    002cac0: 0000 4000 0000 0100 0000 0000 0000 8000  ..@.............<br>&gt;    002cad0: 0000 0000 0000 4000 0000 400c 0000 0200  ......@...@.....<br>&gt;    002cae0: 0000 800a 0000 0004 0000 0000 0000 000c  ................<br>&gt;    002caf0: 0000 0000 0820 0000 0000 1000 0000 0900  ..... ..........<br>&gt;    002cb00: 0000 0000 0000 726f 6c65 5f61 7474 7269  ......<br>&gt;    <br>&gt;    semanage_roles: policy value = 0x08<br>&gt;    	dominates:<br>&gt;   		mz = 0x40, highbit = 0x40, node = 1, <br>&gt; 		startbit = 0, map: 8000 0000 0000 0000 <br>&gt; 			policy value: 8(semanage_rol!
 es)<br>&gt;    	types.types:<br>&gt;    		mz = 0x40, highbit = 0xc40 node = 2<br>&gt; 		startbit = 0xa80, map: 0004 0000 0000 0000<br>&gt; 			policy value: 0xa8b(load_policy_t)<br>&gt; 		startbit = 0xc00, map: 0000 0820 0000 0000<br>&gt; 			policy value: 0xc14(setfiles_t), 0xc1e(semanage_t)<br>&gt;    <br>&gt;    <br>&gt; 4. Verify that once rpm_roles attribute becomes a sub-attribute of<br>&gt;    semanage_roles attribute, then all regular roles belonging to rpm_roles<br>&gt;    such as sysadm_r should be able to type all those types of the parent role<br>&gt;    attribute's types(that is, semanage_roles.types):<br>&gt;    <br>&gt;    002ccc0: 0000 0800 0000 0b00 0000 0000 0000 7379  ..............sy<br>&gt;    002ccd0: 7361 646d 5f72 4000 0000 4000 0000 0100  sadm_r@...@.....<br>&gt;    002cce0: 0000 0000 0000 0004 0000 0000 0000 4000  ..............@.<br>&gt;    002ccf0: 0000 800d 0000 2d00 0000 8000 0000 0000  ......-.........<br>&gt;    ...<br>&gt;    002cd70: 5808, 40!
 03 0000 0906 0200 0000 0000, 8003  X.@.............<br>&gt;    ...<br>
&gt;    002cdf0: 4000 0000 0900 c006 0000 0000 0008 0000  @...............<br>&gt;    002ce00: 0000, 4007 0000 4000 0000 0000 1006, 8007  ..@...@.........<br>&gt;    002ce10: 0000 0000 000a 0000 0000 c007 0000 0080  ................<br>&gt;    ...<br>&gt;    002ce90: 8000, 400a 0000 0000 0000 0000 0040, 800a  ..@..........@..<br>&gt;    002cea0: 0000 0004 0002 0000 0000 c00a 0000 0000  ................<br>&gt;    002ceb0: 0000 8000 0000 000b 0000 0000 0080 0080  ................<br>&gt;    002cec0: 0000 c00b 0000 0000 0000 1000 0000, 000c  ................<br>&gt;    002ced0: 0000 0000 3820 0004 0000 400c 0000 0400  ....8 ....@.....<br>&gt;    ...<br>&gt;    <br>&gt;    sysadm_r: policy value = 0x0b<br>&gt;    	dominates:<br>&gt;    		mz = 0x40, highbit = 0x40, node = 1<br>&gt;    		startbit = 0x0, map: 0004 0000 0000 0000<br>&gt; 			policy value: 0x0b(sysadm_r)<br>&gt;    	types.types:<br>&gt;    		mz = 0x40, highbit = 0xd80, node = 0x2d<br>&gt;    		startbit = 0x340, map: !
 0906 0200 0000 0000<br>&gt;    			policy value: 341(rpm_t), 344, 34a, 34b<br>&gt;    <br>&gt;    		startbit = 0x740, map: 4000 0000 0000 1006<br>&gt;    			policy value: 747, 775(rpm_script_t), 77a, 77b<br>&gt;    <br>&gt;    		startbit = 0xa80, map: 0004 0002 0000 0000<br>&gt;    			policy value: a8b(load_policy_t), a9a<br>&gt;    <br>&gt;    		startbit = 0xc00, map: 0000 3820 0004 0000 <br>&gt;    			policy value: c14(setfiles_t), c15, c16, c1e(semanage_t)<br>&gt;    <br>&gt;    <br>&gt; 5. Extra loop depenency tests.<br>&gt;    <br>&gt; 5.1 When there is no loop dependency between rpm_roles and semanage_roles<br>&gt;    attributes, the secadm_r that belongs to semanage_roles attributes is<br>&gt;    not able to type those types of the rpm_roles.types, such as rpm_t or<br>&gt;    rpm_script_t:<br>&gt;    <br>&gt;    002cb60: 0000 0a00 0000 0000 0000 7365 6361 646d  ..........secadm<br>&gt;    002cb70: 5f72 4000 0000 4000 0000 0100 0000 0000  _r@...@.........<br>&gt;    00!
 2cb80: 0000 0002 0000 0000 0000 4000 0000 400d  ..........@...@.<br>&amp;g
t;    002cb90: 0000 1900 0000 8000 0000 0000 0000 0200  ................<br>&gt;    ...<br>&gt;    002cbe0: 0000 0400 0200 0000 1800, 4003 0000 0002  ..........@.....<br>&gt;    002cbf0: 0000 0000 0000 c003 0000 0000 0000 0000  ................<br>&gt;    ...<br>&gt;    002cc30: 0800 4006 0000 0000 0000 0000 0100, 4007  ..@...........@.<br>&gt;    002cc40: 0000 0000 0000 0000 2000 4009 0000 0000  ........ .@.....<br>&gt;    002cc50: 0000 0000 0420 8009 0000 0000 0820 0000  ..... ....... ..<br>&gt;    <br>&gt;    secadm_r:<br>&gt;    	types.types:<br>&gt;    		mz = 0x40, highbit = 0xd40, node = 0x19<br>&gt;    		startbit = 0x340, map: 0002 0000 0000 0000<br>&gt;    			policy value: 34a, ... <br>&gt;    		<br>&gt;    		startbit = 0x740, map: 0000 0000 0000 2000<br>&gt;    			policy value: 776<br>&gt;    <br>&gt;    <br>&gt; 5.2 Add below statements in selinuxutil.te to create a loop dependcy<br>&gt;    between rpm_roles and semanage_roles attributes:<br>&gt;    <br>&gt;    att!
 ribute rpm_roles ROLE;<br>&gt;    roleattribute semanage_roles rpm_roles;<br>&gt;    <br>&gt;    Then rebuild policy.X in modular way, the loop dependency should be<br>&gt;    properly handled, and secadm_r that belongs to the semanage_roles<br>&gt;    should be able to type all those types in rpm_roles.types ebitmap,<br>&gt;    such as rpm_t and rpm_script_t:<br>&gt;    <br>&gt;    002cb60: 0000 0a00 0000 0000 0000 7365 6361 646d  ..........secadm<br>&gt;    002cb70: 5f72 4000 0000 4000 0000 0100 0000 0000  _r@...@.........<br>&gt;    002cb80: 0000 0002 0000 0000 0000 4000 0000 400d  ..........@...@.<br>&gt;    002cb90: 0000 1900 0000 8000 0000 0000 0000 0200  ................<br>&gt;    ...<br>&gt;    002cbe0: 0000 0400 0200 0000 1800, 4003 0000 0102  ..........@.....<br>&gt;    002cbf0: 0000 0000 0000 c003 0000 0000 0000 0000  ................<br>&gt;    ...<br>&gt;    002cc30: 0800 4006 0000 0000 0000 0000 0100, 4007  ..@...........@.<br>&gt;    002cc40: 0000 0000 0000 !
 0000 3000 4009 0000 0000  ........0.@.....<br>&gt;    002cc50: 0000 00
00 0420 8009 0000 0000 0820 0000  ..... ....... ..<br>&gt;    <br>&gt;    secadm_r:<br>&gt;    	types.types:<br>&gt;    		mz = 0x40, highbit = 0xd40, node = 0x19<br>&gt;    		startbit = 0x340, map: 0102 0000 0000 0000<br>&gt;    			policy value: 341(rpm_t), ... <br>&gt;    		<br>&gt;    		startbit = 0x740, map: 0000 0000 0000 3000<br>&gt;    			policy value: 775(rpm_script_t), 776<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_41ed9ba5-5536-4c67-8131-7b6aa9b4e6a6_--

--_cef754e5-daf5-4a46-93d3-b4eec741a280_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0006-Support-adding-one-role-attribute-into-another.patch"

RnJvbSBjNGYxMTExNzY0MjJlZWIzODVlZmYwNGJlODAxYzI3ZGIwY2E0Y2EzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJyeSBDaWFvIDxxaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29t
PgpEYXRlOiBTdW4sIDI5IE1heSAyMDExIDExOjUwOjQwICswODAwClN1YmplY3Q6IFt2MSBQQVRD
SCA2LzZdIFN1cHBvcnQgYWRkaW5nIG9uZSByb2xlIGF0dHJpYnV0ZSBpbnRvIGFub3RoZXIuCgpX
aGVuIHRoZSBsaW5rIHByb2Nlc3MgaXMgY29tcGxldGVkLCB0aGUgdHlwZXMgdHlwZV9zZXRfdCBh
bmQgcm9sZXMKZWJpdG1hcCBpbiBhIHJvbGUgYXR0cmlidXRlIGFyZSBzZXR0bGVkLCB0aGVuIHdl
IGNvdWxkIGdvIG9uIHNjYW4KYWxsIHJvbGUgYXR0cmlidXRlcyBpbiB0aGUgYmFzZS5wX3JvbGVz
IHRhYmxlIGNoZWNraW5nIGlmIGFueSBub24temVybwpiaXQgaW4gaXRzIHJvbGVzIGViaXRtYXAg
aXMgaW5kZWVkIGFub3RoZXIgcm9sZSBhdHRyaWJ1dGUuCgpJZiB0aGlzIGlzIHRoZSBjYXNlLCB0
aGVuIHdlIG5lZWQgdG8gZXNjYWxhdGUgdGhlIHJvbGVzIGViaXRtYXAgb2YKdGhlIHN1Yi1hdHRy
aWJ1dGUgaW50byB0aGF0IG9mIHRoZSBwYXJlbnQgYXR0cmlidXRlLCBhbmQgcmVtb3ZlIHRoZQpz
dWItYXR0cmlidXRlIGZyb20gcGFyZW50J3Mgcm9sZXMgZWJpdG1hcC4KClNpbmNlIHN1Yi1hdHRy
aWJ1dGUncyByb2xlcyBlYml0bWFwIG1heSBmdXJ0aGVyIGNvbnRhaW4gb3RoZXIgcm9sZQphdHRy
aWJ1dGVzLCB3ZSBuZWVkIHRvIHJlLXNjYW4gdGhlIHVwZGF0ZWQgcGFyZW50J3Mgcm9sZXMgZWJp
dG1hcC4KCkFsc28gaWYgYSBsb29wIGRlcGVuZGVuY3kgaXMgZGV0ZWN0ZWQsIG5vIGVzY2FsYXRp
b24gb2Ygc3ViLWF0dHJpYnV0ZSdzCnJvbGVzIGViaXRtYXAgaXMgbmVlZGVkLgoKU2lnbmVkLW9m
Zi1ieTogSGFycnkgQ2lhbyA8cWluZ3Rhby5jYW9Ad2luZHJpdmVyLmNvbT4KLS0tCiBjaGVja3Bv
bGljeS9wb2xpY3lfZGVmaW5lLmMgfCAgICA1ICsrLQogbGlic2Vwb2wvc3JjL2xpbmsuYyAgICAg
ICAgIHwgICA2MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAy
IGZpbGVzIGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvY2hlY2twb2xpY3kvcG9saWN5X2RlZmluZS5jIGIvY2hlY2twb2xpY3kvcG9saWN5X2Rl
ZmluZS5jCmluZGV4IDQwMjkxMmUuLjZmNDhjNTAgMTAwNjQ0Ci0tLSBhL2NoZWNrcG9saWN5L3Bv
bGljeV9kZWZpbmUuYworKysgYi9jaGVja3BvbGljeS9wb2xpY3lfZGVmaW5lLmMKQEAgLTE4OTUs
OCArMTg5NSw5IEBAIGludCBkZWZpbmVfcm9sZWF0dHJpYnV0ZSh2b2lkKQogCQlyZXR1cm4gLTE7
CiAJfQogCXIgPSBoYXNodGFiX3NlYXJjaChwb2xpY3lkYnAtPnBfcm9sZXMudGFibGUsIGlkKTsK
LQlpZiAoIXIgfHwgci0+Zmxhdm9yICE9IFJPTEVfUk9MRSkgewotCQl5eWVycm9yMigidW5rbm93
biByb2xlICVzLCBvciBub3QgYSByZWd1bGFyIHJvbGUiLCBpZCk7CisJLyogV2Ugc3VwcG9ydCBh
ZGRpbmcgb25lIHJvbGUgYXR0cmlidXRlIGludG8gYW5vdGhlciAqLworCWlmICghcikgeworCQl5
eWVycm9yMigidW5rbm93biByb2xlICVzIiwgaWQpOwogCQlmcmVlKGlkKTsKIAkJcmV0dXJuIC0x
OwogCX0KZGlmZiAtLWdpdCBhL2xpYnNlcG9sL3NyYy9saW5rLmMgYi9saWJzZXBvbC9zcmMvbGlu
ay5jCmluZGV4IDUzZmNmZjkuLjNhNmZhNWEgMTAwNjQ0Ci0tLSBhL2xpYnNlcG9sL3NyYy9saW5r
LmMKKysrIGIvbGlic2Vwb2wvc3JjL2xpbmsuYwpAQCAtMjMzNSw2ICsyMzM1LDYyIEBAIHN0YXRp
YyBpbnQgcHJlcGFyZV9iYXNlKGxpbmtfc3RhdGVfdCAqIHN0YXRlLCB1aW50MzJfdCBudW1fbW9k
X2RlY2xzKQogCXJldHVybiAwOwogfQogCitzdGF0aWMgaW50IGV4cGFuZF9yb2xlX2F0dHJpYnV0
ZXMoaGFzaHRhYl9rZXlfdCBrZXksIGhhc2h0YWJfZGF0dW1fdCBkYXR1bSwKKwkJCQkgIHZvaWQg
KiBkYXRhKQoreworCWNoYXIgKmlkOworCXJvbGVfZGF0dW1fdCAqcm9sZSwgKnN1Yl9hdHRyOwor
CWxpbmtfc3RhdGVfdCAqc3RhdGU7CisJdW5zaWduZWQgaW50IGk7CisJZWJpdG1hcF9ub2RlX3Qg
KnJub2RlOworCisJaWQgPSBrZXk7CisJcm9sZSA9IChyb2xlX2RhdHVtX3QgKilkYXR1bTsKKwlz
dGF0ZSA9IChsaW5rX3N0YXRlX3QgKilkYXRhOworCisJaWYgKHN0cmNtcChpZCwgT0JKRUNUX1Ip
ID09IDApeworCQkvKiBvYmplY3RfciBpcyBuZXZlciBhIHJvbGUgYXR0cmlidXRlIGJ5IGZhciAq
LworCQlyZXR1cm4gMDsKKwl9CisKKwlpZiAocm9sZS0+Zmxhdm9yICE9IFJPTEVfQVRUUklCKQor
CQlyZXR1cm4gMDsKKworCWlmIChzdGF0ZS0+dmVyYm9zZSkKKwkJSU5GTyhzdGF0ZS0+aGFuZGxl
LCAiZXhwYW5kaW5nIHJvbGUgYXR0cmlidXRlICVzIiwgaWQpOworCityZXN0YXJ0OgorCWViaXRt
YXBfZm9yX2VhY2hfYml0KCZyb2xlLT5yb2xlcywgcm5vZGUsIGkpIHsKKwkJaWYgKGViaXRtYXBf
bm9kZV9nZXRfYml0KHJub2RlLCBpKSkgeworCQkJc3ViX2F0dHIgPSBzdGF0ZS0+YmFzZS0+cm9s
ZV92YWxfdG9fc3RydWN0W2ldOworCQkJaWYgKHN1Yl9hdHRyLT5mbGF2b3IgIT0gUk9MRV9BVFRS
SUIpCisJCQkJY29udGludWU7CisJCQkKKwkJCS8qIHJlbW92ZSB0aGUgc3ViIHJvbGUgYXR0cmli
dXRlIGZyb20gdGhlIHBhcmVudAorCQkJICogcm9sZSBhdHRyaWJ1dGUncyByb2xlcyBlYml0bWFw
ICovCisJCQlpZiAoZWJpdG1hcF9zZXRfYml0KCZyb2xlLT5yb2xlcywgaSwgMCkpCisJCQkJcmV0
dXJuIC0xOworCisJCQkvKiBsb29wIGRlcGVuZGVuY3kgb2Ygcm9sZSBhdHRyaWJ1dGVzICovCisJ
CQlpZiAoc3ViX2F0dHItPnMudmFsdWUgPT0gcm9sZS0+cy52YWx1ZSkKKwkJCQljb250aW51ZTsK
KworCQkJLyogbm93IGdvIG9uIHRvIGV4cGFuZCBhIHN1YiByb2xlIGF0dHJpYnV0ZQorCQkJICog
YnkgZXNjYWxhdGluZyBpdHMgcm9sZXMgZWJpdG1hcCAqLworCQkJaWYgKGViaXRtYXBfdW5pb24o
JnJvbGUtPnJvbGVzLCAmc3ViX2F0dHItPnJvbGVzKSkgeworCQkJCUVSUihzdGF0ZS0+aGFuZGxl
LCAiT3V0IG9mIG1lbW9yeSEiKTsKKwkJCQlyZXR1cm4gLTE7CisJCQl9CisJCQkKKwkJCS8qIHN1
Yl9hdHRyLT5yb2xlcyBtYXkgY29udGFpbiBvdGhlciByb2xlIGF0dHJpYnV0ZXMsCisJCQkgKiBy
ZS1zY2FuIHRoZSBwYXJlbnQgcm9sZSBhdHRyaWJ1dGUncyByb2xlcyBlYml0bWFwICovCisJCQln
b3RvIHJlc3RhcnQ7CisJCX0KKwl9CisKKwlyZXR1cm4gMDsKK30KKwogLyogTGluayBhIHNldCBv
ZiBtb2R1bGVzIGludG8gYSBiYXNlIG1vZHVsZS4gVGhpcyBwcm9jZXNzIGlzIHNvbWV3aGF0CiAg
KiBzaW1pbGFyIHRvIGFuIGFjdHVhbCBjb21waWxlcjogaXQgcmVxdWlyZXMgYSBzZXQgb2Ygb3Jk
ZXIgZGVwZW5kZW50CiAgKiBzdGVwcy4gIFRoZSBiYXNlIGFuZCBldmVyeSBtb2R1bGUgbXVzdCBo
YXZlIGJlZW4gaW5kZXhlZCBwcmlvciB0bwpAQCAtMjQ1NSw2ICsyNTExLDEyIEBAIGludCBsaW5r
X21vZHVsZXMoc2Vwb2xfaGFuZGxlX3QgKiBoYW5kbGUsCiAJCWdvdG8gY2xlYW51cDsKIAl9CiAK
KwkvKiBub3cgdGhhdCBhbGwgcm9sZSBhdHRyaWJ1dGUncyByb2xlcyBlYml0bWFwIGhhdmUgYmVl
biBzZXR0bGVkLAorCSAqIGV4cGFuZCBzdWIgcm9sZSBhdHRyaWJ1dGUncyByb2xlcyBlYml0bWFw
IGludG8gdGhhdCBvZiBwYXJlbnQgKi8KKwlpZiAoaGFzaHRhYl9tYXAKKwkgICAgKHN0YXRlLmJh
c2UtPnBfcm9sZXMudGFibGUsIGV4cGFuZF9yb2xlX2F0dHJpYnV0ZXMsICZzdGF0ZSkpCisJCWdv
dG8gY2xlYW51cDsKKwogCXJldHZhbCA9IDA7CiAgICAgICBjbGVhbnVwOgogCWZvciAoaSA9IDA7
IG1vZHVsZXMgIT0gTlVMTCAmJiBpIDwgbGVuOyBpKyspIHsKLS0gCjEuNy4wLjQKCg==

--_cef754e5-daf5-4a46-93d3-b4eec741a280_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
