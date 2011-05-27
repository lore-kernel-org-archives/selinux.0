Message-ID: <SNT139-W605A5765C70F866CB944B5AB760@phx.gbl>
Content-Type: multipart/mixed;
	boundary="_9c742671-a4fc-4a4d-8bee-6a66c26fc1bf_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, <method@manicmethod.com>,
        <jmorris@namei.org>, <eparis@parisplace.org>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: v0 Add role attribute support to libsepol
Date: Fri, 27 May 2011 02:00:13 +0000
In-Reply-To: <1306459464-2497-1-git-send-email-qingtao.cao@windriver.com>
References: <1306459464-2497-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_9c742671-a4fc-4a4d-8bee-6a66c26fc1bf_
Content-Type: multipart/alternative;
	boundary="_2d9ffc20-9433-47cb-bce3-8206e5c60bdf_"

--_2d9ffc20-9433-47cb-bce3-8206e5c60bdf_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi,

The attached is the refpolicy patch used for role attribute testing.

Thanks,
Harry

> From: qingtao.cao@windriver.com
> To: sds@tycho.nsa.gov; method@manicmethod.com; jmorris@namei.org; eparis@parisplace.org
> CC: selinux@tycho.nsa.gov
> Subject: v0 Add role attribute support to libsepol
> Date: Fri, 27 May 2011 09:24:19 +0800
> 
> 
> 
> Comments:
> ---------
> Add role attribute to SELinux, which aims at replacing the deprecated
> role dominance rule.
> 
> Previous discussions could be found here:
> http://www.spinics.net/lists/selinux/msg00974.html
> 
> A role attribute could be declared by the rule of
> "attribute <role_attribute_name> role;" and further used in the
> user-roles, role-types, role-allows and role_transition rules. In order
> to avoid ambiguity, the role-types would no longer to declare a role,
> another new rule of role-attr is added to declare a regular role and
> optionally a list of role attribute that the regular role belongs to
> (like the type rule). Also the role-attribute association could be
> declared by a new rule of roleattribute.
> 
> BTW, since the flavor and roles ebitmap of a role_datum_t structure
> are not needed to be written to policy.X, the SELinux kernel driver
> would not need any change. The maximum version number in both libsepol
> and kernel remain the same.
> 
> FIXME_1:
> I may need some help to specify the "kind" of a required attribute
> (of a type attribute or role attribute), please see the notes left in
> the patches. BTW, since multiple declarations of role/user are allowed,
> so far I just explicitly declare the required role attribute :-P
> 
> 
> Testings I've done:
> -------------------
> 1. Use role attribute in several different modules to test if a role
>    attribute used in user-roles, role-types, role-allows and role-transition
>    rules could be properly compiled/linked/expanded.
>    
>    Also in order to support that role-types rule no longer is used to
>    declare a regular role, we have to use the role-attr rule to declare
>    the related role explicitly (so far only nx_server_r and unconfined_r).
>    
>    Please refer to the attached refpolicy patch for above tests, then make
>    policy.
>    
> 
> 2. Make a hexdump of policy.26 by xxd tool, then check out the policy value
>    for those identifiers related with this test:
>    
>    0035b40:                       07 0000 004a 0300  r_tmpfs_t....J..
>    0035b50: 0001 0000 0000 0000 0076 6c6f 636b 5f74  .........vlock_t
>    
>    vlock_t: len = 7, policy value = 0x34a, prop = 01, bounds = 0
>    
>    00353b0:                          0800 0000 fa02  ..shadow_t......
>    00353c0: 0000 0100 0000 00000000  7379 7361 646d  ..........sysadm
>    00353d0: 5f74 1200 0000 cb01 0000 0000 0000 0000  _t
>    
>    sysadm_t: len = 8, policy value = 0x2fa, prop = 01, bounds = 0
>    
>    003d3f0: 635f 7409 0000 0034 0600 0001 0000 0000  c_t....4........
>    003d400: 0000 006e 6577 726f 6c65 5f74 0900 0000  ...newrole_t....
>    
>    newrole_t: len = 9, policy value = 0x634, prop = 0x01, bounds = 0
>    
>    0045dc0:                                    0800  ......cgroup_t..
>    0045dd0: 0000 7309 0000 0100 0000 0000 0000 6368  ..s...........ch
>    0045de0: 6b70 7764 5f74 0800 0000 7409 0000 0100  kpwd_t
>    
>    chkpwd_t: len = 0x08, policy value = 0x973, prop = 0x01, bounds = 0
>    
>    002c6a0:                                      07  ................
>    002c6b0: 0000 0005 0000 0000 0000 0073 7461 6666  ...........staff
>    002c6c0: 5f72 4000 0000 4000 0000 0100 0000 0000  _r@...@.........
>    
>    staff_r: len = 0x07, policy value = 0x05, bounds = 0
>    
>    002cc60:                               0800 0000  .......@........
>    002cc70: 0a00 0000 0000 0000 7379 7361 646d 5f72  ........sysadm_r
>    
>    sysadm_r: len = 0x08, policy value = 0x0a, bounds = 0
>    
>    002cec0:                               0800 0000  @...............
>    002ced0: 0b00 0000 0000 0000 7379 7374 656d 5f72  ........system_r
>    
>    system_r: len = 0x08, policy value = 0x0b, bounds = 0
>    
>    
> 3. Check out the hexdump for the sysadm_r_2 and sysadm_r_3 role, verify
>    if their types.types ebitmap records all types specified in the
>    "role role_attribute_1 types xxx;" rule:
>    
>    002d470:                  0a 0000 0010 0000 0000  ................
>    002d480: 0000 0073 7973 6164 6d5f 725f 3240 0000  ...sysadm_r_2@..
>    002d490: 0040 0000 0001 0000 0000 0000 0000 8000  .@..............
>    002d4a0: 0000 0000 0040 0000 0080 0900 0004 0000  .....@..........
>    002d4b0: 00c0 0200 0000 0000 0000 0000 0240 0300  .............@..
>    002d4c0: 0000 0200 0000 0000 0000 0600 0000 0000  ................
>    002d4d0: 0000 0008 0040 0900 0000 0000 0000 0004  .....@..........
>    002d4e0: 000a 0000 0011 0000 0000 0000 0073 7973  .............sys
>    002d4f0: 6164 6d5f 725f 3340 0000 0040 0000 0001  adm_r_3@...@....
>    002d500: 0000 0000 0000 0000 0001 0000 0000 0040  ...............@
>    002d510: 0000 0080 0900 0004 0000 00c0 0200 0000  ................
>    002d520: 0000 0000 0000 0240 0300 0000 0200 0000  .......@........
>    002d530: 0000 0000 0600 0000 0000 0000 0008 0040  ...............@
>    002d540: 0900 0000 0000 0000 0004 0065 0d00 00fa  ...........e....
>    
>    sysadm_r_2:
>    	len = 0x0a, policy value = 0x10, bounds = 0
>    	dominates:
>    		ms = 0x40, highbit = 0x40, node = 0x01, 
> 		startbit = 0, map: 00 8000 0000 0000 00 (policy value = 0x10)
>    	types.types:
>    		ms = 0x40, highbit = 0x980, node = 0x04, 
> 		startbit = 0x2c0, map: 00 0000 0000 0000 02 (policy value = 0x2fa, sysadm_t)
> 		startbit = 0x340, map: 00 0200 0000 0000 00 (policy value = 0x34a, vlock_t)
>    		startbit = 0x600, map: 00 0000 0000 0008 00 (policy value = 0x634, newrole_t)
>    		startbit = 0x940, map: 00 0000 0000 0004 00 (policy value = 0x973, chkpwd_t)
>    
>    sysadm_r_3:
>    	len = 0x0a, policy value = 0x11, bounds = 0
>    	(The dominates and types.types ebitmaps are the same as that
> 	 of sysadm_r_2)	
>    
>    
> 4. Check out the hexdump of the root user, verify if its roles.roles ebitmap
>    records the policy values of sysadm_r_2 and sysadm_r_3 that specified in
>    the "user root roles role_attribute_1 ...;" rule:
>    
>    004fc20:                            04 0000 0003  ................
>    004fc30: 0000 0000 0000 0072 6f6f 7440 0000 0040  .......root@...@
>    004fc40: 0000 0001 0000 0000 0000 0012 8701 0000  ................
>    004fc50: 0000 0002 0000 0001 0000 0010 0000 0040  ...............@
>    004fc60: 0000 0000 0000 0000 0000 0040 0000 0000  ...........@....
>    004fc70: 0400 0010 0000 0000 0000 00ff ffff ffff  ................
>    004fc80: ffff ff40 0000 00ff ffff ffff ffff ff80  ...@............
>    
>    root:
>    	len = 0x04, policy value = 0x03, bounds = 0x0
>    	roles.roles:
>    		ms = 0x40, highbit = 0x40, node = 0x01,
>    		startbit = 0, map: 12 8701 0000 0000 00
>    
>    roles.roles ebitmap for the root user recorded following policy values:
>    	2, 5, 9, 10, 11, 16, 17
>    where 5 == staff_r, 10 == sysadmd_r, 11 == system_r, 16 == sysadm_r_2,
> 	 17 == sysadm_r_3
>    
>    
> 5. Boot up the system with the latest Eric SELinux tree:
>    
>    [root/sysadm_r/s0@~]# sestatus 
>    SELinux status:                 enabled
>    SELinuxfs mount:                /selinux
>    Current mode:                   enforcing
>    Mode from config file:          enforcing
>    Policy version:                 26
>    Policy from config file:        refpolicy-mls
>    [root/sysadm_r/s0@~]# 
>    [root/sysadm_r/s0@~]# echo "sysadm_r_2:sysadm_t" >> /etc/selinux/refpolicy-mls/contexts/default_type 
>    [root/sysadm_r/s0@~]# echo "sysadm_r_3:sysadm_t" >> /etc/selinux/refpolicy-mls/contexts/default_type 
>    [root/sysadm_r/s0@~]#
>    
> 
> 6. Use newrole command to switch between sysadm_r and sysadm_r_2/3, to
>    prove that the role_attribute_1 used in relevant
>    role-allow/user-roles/role-types rules have been properly linked/expanded:
>    
>    [root/sysadm_r/s0@~]# newrole -r sysadm_r_2 -p
>    Password: 
>    [root/sysadm_r_2/s0@~]#
>    [root/sysadm_r_2/s0@~]# id -Z
>    root:sysadm_r_2:sysadm_t:s0-s15:c0.c1023
>    [root/sysadm_r_2/s0@~]# 
>    [root/sysadm_r_2/s0@~]# newrole -r sysadm_r -p
>    Password: 
>    [root/sysadm_r/s0@~]# 
>    [root/sysadm_r/s0@~]# newrole -r sysadm_r_3 -p
>    Password: 
>    [root/sysadm_r_3/s0@~]# 
>    [root/sysadm_r_3/s0@~]# newrole -r sysadm_r -p
>    Password: 
>    [root/sysadm_r/s0@~]# id -Z
>    root:sysadm_r:sysadm_t:s0-s15:c0.c1023
>    [root/sysadm_r/s0@~]# 
>    
> 
> 7. Use the compute_create command to prove that the role_attribute_1 used
>    in relevant role_transition rule has been properly linked/expanded:
>    
>    [root/sysadm_r_2/s0@~]# ls -Z /usr/sbin/vlock-main 
>    -rws--x--x  root root system_u:object_r:vlock_exec_t:s0 /usr/sbin/vlock-main
>    [root/sysadm_r_2/s0@~]# 
>    [root/sysadm_r_2/s0@~]# compute_create `id -Z` system_u:object_r:vlock_exec_t:s0 process
>    root:system_r:vlock_t:s0-s15:c0.c1023
>    [root/sysadm_r_2/s0@~]# 
>    
>    [root/sysadm_r_3/s0@~]# compute_create `id -Z` system_u:object_r:vlock_exec_t:s0 process
>    root:system_r:vlock_t:s0-s15:c0.c1023
>    [root/sysadm_r_3/s0@~]# 
>    
> 
> 8. FIXME_2:
>    The result of compute_create in the above steps has showed that the
>    domain transition from sysadm_t to vlock_t, and the role transition from
>    sysadm_r_2/3 to system_r could have taken place correctly. BTW, since
>    security_compute_sid() has called policydb_context_isvalid(), so the
>    "root:system_r:vlock_t:s0-s15:c0.c1023" context is valid.
>    
>    However, the root:sysadm_r_2:sysadm_t would fail to run the vlock
>    program with the below AVC denied message, what else refpolicy rule
>    should I have added ?
>    
>    [root/sysadm_r_2/s0@~]# date
>    Thu May 26 06:27:29 GMT 2011
>    [root/sysadm_r_2/s0@~]# vlock
>    /usr/bin/vlock: line 224: /usr/sbin/vlock-main: Permission denied
>    [root/sysadm_r_2/s0@~]# exit
>    
>    [root/sysadm_r/s0@~]# audhigh "ausearch -ts 06:27:29 -sv no"
>    Password: 
>    ----
>    time->Thu May 26 06:27:32 2011
>    type=SYSCALL msg=audit(1306391252.699:38): arch=40000003 syscall=11 success=no exit=-13 a0=80db080 a1=80da830 a2=80d07b0 a3=80da830 items=0 ppid=723 pid=849 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=ttyS0 ses=4294967295 comm="vlock" exe="/bin/bash" subj=root:sysadm_r_2:sysadm_t:s0-s15:c0.c1023 key=(null)
>    type=AVC msg=audit(1306391252.699:38): avc:  denied  { transition } for  pid=849 comm="vlock" path="/usr/sbin/vlock-main" dev=sda ino=50097 scontext=root:sysadm_r_2:sysadm_t:s0-s15:c0.c1023 tcontext=root:system_r:vlock_t:s0-s15:c0.c1023 tclass=process
>    [root/sysadm_r/s0@~]# 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_2d9ffc20-9433-47cb-bce3-8206e5c60bdf_
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
Hi,<br><br>The attached is the refpolicy patch used for role attribute testing.<br><br>Thanks,<br>Harry<br><br>&gt; From: qingtao.cao@windriver.com<br>&gt; To: sds@tycho.nsa.gov; method@manicmethod.com; jmorris@namei.org; eparis@parisplace.org<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; Subject: v0 Add role attribute support to libsepol<br>&gt; Date: Fri, 27 May 2011 09:24:19 +0800<br>&gt; <br>&gt; <br>&gt; <br>&gt; Comments:<br>&gt; ---------<br>&gt; Add role attribute to SELinux, which aims at replacing the deprecated<br>&gt; role dominance rule.<br>&gt; <br>&gt; Previous discussions could be found here:<br>&gt; http://www.spinics.net/lists/selinux/msg00974.html<br>&gt; <br>&gt; A role attribute could be declared by the rule of<br>&gt; "attribute &lt;role_attribute_name&gt; role;" and further used in the<br>&gt; user-roles, role-types, role-allows and role_transition rules. In order<br>&gt; to avoid ambiguity, the role-types would no longer to declare a role,<br>&gt; another!
  new rule of role-attr is added to declare a regular role and<br>&gt; optionally a list of role attribute that the regular role belongs to<br>&gt; (like the type rule). Also the role-attribute association could be<br>&gt; declared by a new rule of roleattribute.<br>&gt; <br>&gt; BTW, since the flavor and roles ebitmap of a role_datum_t structure<br>&gt; are not needed to be written to policy.X, the SELinux kernel driver<br>&gt; would not need any change. The maximum version number in both libsepol<br>&gt; and kernel remain the same.<br>&gt; <br>&gt; FIXME_1:<br>&gt; I may need some help to specify the "kind" of a required attribute<br>&gt; (of a type attribute or role attribute), please see the notes left in<br>&gt; the patches. BTW, since multiple declarations of role/user are allowed,<br>&gt; so far I just explicitly declare the required role attribute :-P<br>&gt; <br>&gt; <br>&gt; Testings I've done:<br>&gt; -------------------<br>&gt; 1. Use role attribute in several di!
 fferent modules to test if a role<br>&gt;    attribute used in user-ro
les, role-types, role-allows and role-transition<br>&gt;    rules could be properly compiled/linked/expanded.<br>&gt;    <br>&gt;    Also in order to support that role-types rule no longer is used to<br>&gt;    declare a regular role, we have to use the role-attr rule to declare<br>&gt;    the related role explicitly (so far only nx_server_r and unconfined_r).<br>&gt;    <br>&gt;    Please refer to the attached refpolicy patch for above tests, then make<br>&gt;    policy.<br>&gt;    <br>&gt; <br>&gt; 2. Make a hexdump of policy.26 by xxd tool, then check out the policy value<br>&gt;    for those identifiers related with this test:<br>&gt;    <br>&gt;    0035b40:                       07 0000 004a 0300  r_tmpfs_t....J..<br>&gt;    0035b50: 0001 0000 0000 0000 0076 6c6f 636b 5f74  .........vlock_t<br>&gt;    <br>&gt;    vlock_t: len = 7, policy value = 0x34a, prop = 01, bounds = 0<br>&gt;    <br>&gt;    00353b0:                          0800 0000 fa02  ..shadow_t......<br>&gt;!
     00353c0: 0000 0100 0000 00000000  7379 7361 646d  ..........sysadm<br>&gt;    00353d0: 5f74 1200 0000 cb01 0000 0000 0000 0000  _t<br>&gt;    <br>&gt;    sysadm_t: len = 8, policy value = 0x2fa, prop = 01, bounds = 0<br>&gt;    <br>&gt;    003d3f0: 635f 7409 0000 0034 0600 0001 0000 0000  c_t....4........<br>&gt;    003d400: 0000 006e 6577 726f 6c65 5f74 0900 0000  ...newrole_t....<br>&gt;    <br>&gt;    newrole_t: len = 9, policy value = 0x634, prop = 0x01, bounds = 0<br>&gt;    <br>&gt;    0045dc0:                                    0800  ......cgroup_t..<br>&gt;    0045dd0: 0000 7309 0000 0100 0000 0000 0000 6368  ..s...........ch<br>&gt;    0045de0: 6b70 7764 5f74 0800 0000 7409 0000 0100  kpwd_t<br>&gt;    <br>&gt;    chkpwd_t: len = 0x08, policy value = 0x973, prop = 0x01, bounds = 0<br>&gt;    <br>&gt;    002c6a0:                                      07  ................<br>&gt;    002c6b0: 0000 0005 0000 0000 0000 0073 7461 6666  ...........staff<br>&gt;    002c!
 6c0: 5f72 4000 0000 4000 0000 0100 0000 0000  _r@...@.........<br>&gt;
    <br>&gt;    staff_r: len = 0x07, policy value = 0x05, bounds = 0<br>&gt;    <br>&gt;    002cc60:                               0800 0000  .......@........<br>&gt;    002cc70: 0a00 0000 0000 0000 7379 7361 646d 5f72  ........sysadm_r<br>&gt;    <br>&gt;    sysadm_r: len = 0x08, policy value = 0x0a, bounds = 0<br>&gt;    <br>&gt;    002cec0:                               0800 0000  @...............<br>&gt;    002ced0: 0b00 0000 0000 0000 7379 7374 656d 5f72  ........system_r<br>&gt;    <br>&gt;    system_r: len = 0x08, policy value = 0x0b, bounds = 0<br>&gt;    <br>&gt;    <br>&gt; 3. Check out the hexdump for the sysadm_r_2 and sysadm_r_3 role, verify<br>&gt;    if their types.types ebitmap records all types specified in the<br>&gt;    "role role_attribute_1 types xxx;" rule:<br>&gt;    <br>&gt;    002d470:                  0a 0000 0010 0000 0000  ................<br>&gt;    002d480: 0000 0073 7973 6164 6d5f 725f 3240 0000  ...sysadm_r_2@..<br>&gt;    002d490: 0040 0000 0!
 001 0000 0000 0000 0000 8000  .@..............<br>&gt;    002d4a0: 0000 0000 0040 0000 0080 0900 0004 0000  .....@..........<br>&gt;    002d4b0: 00c0 0200 0000 0000 0000 0000 0240 0300  .............@..<br>&gt;    002d4c0: 0000 0200 0000 0000 0000 0600 0000 0000  ................<br>&gt;    002d4d0: 0000 0008 0040 0900 0000 0000 0000 0004  .....@..........<br>&gt;    002d4e0: 000a 0000 0011 0000 0000 0000 0073 7973  .............sys<br>&gt;    002d4f0: 6164 6d5f 725f 3340 0000 0040 0000 0001  adm_r_3@...@....<br>&gt;    002d500: 0000 0000 0000 0000 0001 0000 0000 0040  ...............@<br>&gt;    002d510: 0000 0080 0900 0004 0000 00c0 0200 0000  ................<br>&gt;    002d520: 0000 0000 0000 0240 0300 0000 0200 0000  .......@........<br>&gt;    002d530: 0000 0000 0600 0000 0000 0000 0008 0040  ...............@<br>&gt;    002d540: 0900 0000 0000 0000 0004 0065 0d00 00fa  ...........e....<br>&gt;    <br>&gt;    sysadm_r_2:<br>&gt;    	len = 0x0a, policy value = 0x10, bou!
 nds = 0<br>&gt;    	dominates:<br>&gt;    		ms = 0x40, highbit = 0x40,
 node = 0x01, <br>&gt; 		startbit = 0, map: 00 8000 0000 0000 00 (policy value = 0x10)<br>&gt;    	types.types:<br>&gt;    		ms = 0x40, highbit = 0x980, node = 0x04, <br>&gt; 		startbit = 0x2c0, map: 00 0000 0000 0000 02 (policy value = 0x2fa, sysadm_t)<br>&gt; 		startbit = 0x340, map: 00 0200 0000 0000 00 (policy value = 0x34a, vlock_t)<br>&gt;    		startbit = 0x600, map: 00 0000 0000 0008 00 (policy value = 0x634, newrole_t)<br>&gt;    		startbit = 0x940, map: 00 0000 0000 0004 00 (policy value = 0x973, chkpwd_t)<br>&gt;    <br>&gt;    sysadm_r_3:<br>&gt;    	len = 0x0a, policy value = 0x11, bounds = 0<br>&gt;    	(The dominates and types.types ebitmaps are the same as that<br>&gt; 	 of sysadm_r_2)	<br>&gt;    <br>&gt;    <br>&gt; 4. Check out the hexdump of the root user, verify if its roles.roles ebitmap<br>&gt;    records the policy values of sysadm_r_2 and sysadm_r_3 that specified in<br>&gt;    the "user root roles role_attribute_1 ...;" rule:<br>&gt;    <br>&gt;    0!
 04fc20:                            04 0000 0003  ................<br>&gt;    004fc30: 0000 0000 0000 0072 6f6f 7440 0000 0040  .......root@...@<br>&gt;    004fc40: 0000 0001 0000 0000 0000 0012 8701 0000  ................<br>&gt;    004fc50: 0000 0002 0000 0001 0000 0010 0000 0040  ...............@<br>&gt;    004fc60: 0000 0000 0000 0000 0000 0040 0000 0000  ...........@....<br>&gt;    004fc70: 0400 0010 0000 0000 0000 00ff ffff ffff  ................<br>&gt;    004fc80: ffff ff40 0000 00ff ffff ffff ffff ff80  ...@............<br>&gt;    <br>&gt;    root:<br>&gt;    	len = 0x04, policy value = 0x03, bounds = 0x0<br>&gt;    	roles.roles:<br>&gt;    		ms = 0x40, highbit = 0x40, node = 0x01,<br>&gt;    		startbit = 0, map: 12 8701 0000 0000 00<br>&gt;    <br>&gt;    roles.roles ebitmap for the root user recorded following policy values:<br>&gt;    	2, 5, 9, 10, 11, 16, 17<br>&gt;    where 5 == staff_r, 10 == sysadmd_r, 11 == system_r, 16 == sysadm_r_2,<br>&gt; 	 17 == sysadm_!
 r_3<br>&gt;    <br>&gt;    <br>&gt; 5. Boot up the system with the lat
est Eric SELinux tree:<br>&gt;    <br>&gt;    [root/sysadm_r/s0@~]# sestatus <br>&gt;    SELinux status:                 enabled<br>&gt;    SELinuxfs mount:                /selinux<br>&gt;    Current mode:                   enforcing<br>&gt;    Mode from config file:          enforcing<br>&gt;    Policy version:                 26<br>&gt;    Policy from config file:        refpolicy-mls<br>&gt;    [root/sysadm_r/s0@~]# <br>&gt;    [root/sysadm_r/s0@~]# echo "sysadm_r_2:sysadm_t" &gt;&gt; /etc/selinux/refpolicy-mls/contexts/default_type <br>&gt;    [root/sysadm_r/s0@~]# echo "sysadm_r_3:sysadm_t" &gt;&gt; /etc/selinux/refpolicy-mls/contexts/default_type <br>&gt;    [root/sysadm_r/s0@~]#<br>&gt;    <br>&gt; <br>&gt; 6. Use newrole command to switch between sysadm_r and sysadm_r_2/3, to<br>&gt;    prove that the role_attribute_1 used in relevant<br>&gt;    role-allow/user-roles/role-types rules have been properly linked/expanded:<br>&gt;    <br>&gt;    [root/sysadm_r/s0@~]# new!
 role -r sysadm_r_2 -p<br>&gt;    Password: <br>&gt;    [root/sysadm_r_2/s0@~]#<br>&gt;    [root/sysadm_r_2/s0@~]# id -Z<br>&gt;    root:sysadm_r_2:sysadm_t:s0-s15:c0.c1023<br>&gt;    [root/sysadm_r_2/s0@~]# <br>&gt;    [root/sysadm_r_2/s0@~]# newrole -r sysadm_r -p<br>&gt;    Password: <br>&gt;    [root/sysadm_r/s0@~]# <br>&gt;    [root/sysadm_r/s0@~]# newrole -r sysadm_r_3 -p<br>&gt;    Password: <br>&gt;    [root/sysadm_r_3/s0@~]# <br>&gt;    [root/sysadm_r_3/s0@~]# newrole -r sysadm_r -p<br>&gt;    Password: <br>&gt;    [root/sysadm_r/s0@~]# id -Z<br>&gt;    root:sysadm_r:sysadm_t:s0-s15:c0.c1023<br>&gt;    [root/sysadm_r/s0@~]# <br>&gt;    <br>&gt; <br>&gt; 7. Use the compute_create command to prove that the role_attribute_1 used<br>&gt;    in relevant role_transition rule has been properly linked/expanded:<br>&gt;    <br>&gt;    [root/sysadm_r_2/s0@~]# ls -Z /usr/sbin/vlock-main <br>&gt;    -rws--x--x  root root system_u:object_r:vlock_exec_t:s0 /usr/sbin/vlock-main<br!
 >&gt;    [root/sysadm_r_2/s0@~]# <br>&gt;    [root/sysadm_r_2/s0@~]# c
ompute_create `id -Z` system_u:object_r:vlock_exec_t:s0 process<br>&gt;    root:system_r:vlock_t:s0-s15:c0.c1023<br>&gt;    [root/sysadm_r_2/s0@~]# <br>&gt;    <br>&gt;    [root/sysadm_r_3/s0@~]# compute_create `id -Z` system_u:object_r:vlock_exec_t:s0 process<br>&gt;    root:system_r:vlock_t:s0-s15:c0.c1023<br>&gt;    [root/sysadm_r_3/s0@~]# <br>&gt;    <br>&gt; <br>&gt; 8. FIXME_2:<br>&gt;    The result of compute_create in the above steps has showed that the<br>&gt;    domain transition from sysadm_t to vlock_t, and the role transition from<br>&gt;    sysadm_r_2/3 to system_r could have taken place correctly. BTW, since<br>&gt;    security_compute_sid() has called policydb_context_isvalid(), so the<br>&gt;    "root:system_r:vlock_t:s0-s15:c0.c1023" context is valid.<br>&gt;    <br>&gt;    However, the root:sysadm_r_2:sysadm_t would fail to run the vlock<br>&gt;    program with the below AVC denied message, what else refpolicy rule<br>&gt;    should I have added ?<br>&gt; !
    <br>&gt;    [root/sysadm_r_2/s0@~]# date<br>&gt;    Thu May 26 06:27:29 GMT 2011<br>&gt;    [root/sysadm_r_2/s0@~]# vlock<br>&gt;    /usr/bin/vlock: line 224: /usr/sbin/vlock-main: Permission denied<br>&gt;    [root/sysadm_r_2/s0@~]# exit<br>&gt;    <br>&gt;    [root/sysadm_r/s0@~]# audhigh "ausearch -ts 06:27:29 -sv no"<br>&gt;    Password: <br>&gt;    ----<br>&gt;    time-&gt;Thu May 26 06:27:32 2011<br>&gt;    type=SYSCALL msg=audit(1306391252.699:38): arch=40000003 syscall=11 success=no exit=-13 a0=80db080 a1=80da830 a2=80d07b0 a3=80da830 items=0 ppid=723 pid=849 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=ttyS0 ses=4294967295 comm="vlock" exe="/bin/bash" subj=root:sysadm_r_2:sysadm_t:s0-s15:c0.c1023 key=(null)<br>&gt;    type=AVC msg=audit(1306391252.699:38): avc:  denied  { transition } for  pid=849 comm="vlock" path="/usr/sbin/vlock-main" dev=sda ino=50097 scontext=root:sysadm_r_2:sysadm_t:s0-s15:c0.c1023 tcontext=root:system_r:vloc!
 k_t:s0-s15:c0.c1023 tclass=process<br>&gt;    [root/sysadm_r/s0@~]# <b
r>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_2d9ffc20-9433-47cb-bce3-8206e5c60bdf_--

--_9c742671-a4fc-4a4d-8bee-6a66c26fc1bf_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Role-attribute-debug.patch"

RnJvbSA0ZTJiZDBhN2NlNTcwMTBiMDlhYjU0ZmQ0YWY1MGFmNTdkMjZhNzkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJyeSBDaWFvIDxxaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29t
PgpEYXRlOiBXZWQsIDI1IE1heSAyMDExIDE3OjM0OjQ3ICswODAwClN1YmplY3Q6IFtQQVRDSCAx
LzFdIFJvbGUgYXR0cmlidXRlIGRlYnVnLgoKVXNlIHJvbGUgYXR0cmlidXRlIGluIHNldmVyYWwg
ZGlmZmVyZW50IG1vZHVsZXMgdG8gdGVzdCBpZiBhIHJvbGUKYXR0cmlidXRlIHVzZWQgaW4gdXNl
ci1yb2xlcywgcm9sZS10eXBlcywgcm9sZS1hbGxvd3MgYW5kIHJvbGUtdHJhbnNpdGlvbgpydWxl
cyBjb3VsZCBiZSBwcm9wZXJseSBjb21waWxlZC9saW5rZWQvZXhwYW5kZWQuCgpBbHNvIGluIG9y
ZGVyIHRvIHN1cHBvcnQgdGhhdCByb2xlLXR5cGVzIHJ1bGUgbm8gbG9uZ2VyIGlzIHVzZWQgdG8K
ZGVjbGFyZSBhIHJlZ3VsYXIgcm9sZSwgd2UgaGF2ZSB0byB1c2UgdGhlIHJvbGUtYXR0ciBydWxl
IHRvIGRlY2xhcmUKdGhlIHJlbGF0ZWQgcm9sZSBleHBsaWNpdGx5IChzbyBmYXIgb25seSBueF9z
ZXJ2ZXJfciBhbmQgdW5jb25maW5lZF9yKS4KClNpZ25lZC1vZmYtYnk6IEhhcnJ5IENpYW8gPHFp
bmd0YW8uY2FvQHdpbmRyaXZlci5jb20+Ci0tLQogcG9saWN5L21vZHVsZXMvYXBwcy92bG9jay50
ZSAgICAgICAgIHwgICAxNCArKysrKysrKysrKysrKwogcG9saWN5L21vZHVsZXMvcm9sZXMvc3lz
YWRtLnRlICAgICAgIHwgICAyNSArKysrKysrKysrKysrKysrKysrKysrKysrCiBwb2xpY3kvbW9k
dWxlcy9zZXJ2aWNlcy9saWtld2lzZS50ZSAgfCAgICAyICstCiBwb2xpY3kvbW9kdWxlcy9zZXJ2
aWNlcy9ueC50ZSAgICAgICAgfCAgICAxICsKIHBvbGljeS9tb2R1bGVzL3N5c3RlbS9zZWxpbnV4
dXRpbC50ZSB8ICAgMTkgKysrKysrKysrKysrKysrKysrKwogcG9saWN5L21vZHVsZXMvc3lzdGVt
L3VuY29uZmluZWQudGUgIHwgICAgMSArCiA2IGZpbGVzIGNoYW5nZWQsIDYxIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcG9saWN5L21vZHVsZXMvYXBwcy92bG9j
ay50ZSBiL3BvbGljeS9tb2R1bGVzL2FwcHMvdmxvY2sudGUKaW5kZXggMDNmYzcwMS4uNGQzMjk1
ZiAxMDA2NDQKLS0tIGEvcG9saWN5L21vZHVsZXMvYXBwcy92bG9jay50ZQorKysgYi9wb2xpY3kv
bW9kdWxlcy9hcHBzL3Zsb2NrLnRlCkBAIC01MSwzICs1MSwxNyBAQCBtaXNjZmlsZXNfcmVhZF9s
b2NhbGl6YXRpb24odmxvY2tfdCkKIAogdXNlcmRvbV9kb250YXVkaXRfc2VhcmNoX3VzZXJfaG9t
ZV9kaXJzKHZsb2NrX3QpCiB1c2VyZG9tX3VzZV91c2VyX3Rlcm1pbmFscyh2bG9ja190KQorCitv
cHRpb25hbF9wb2xpY3koYAorCWdlbl9yZXF1aXJlKGAKKwkJcm9sZSBzeXN0ZW1fcjsKKwknKQor
CisJIyBzbyBmYXIgSSBkbyBub3Qga25vdyBob3cgdG8gcmVxdWlyZSBhIHJvbGUgYXR0cmlidXRl
IHlldAorCWF0dHJpYnV0ZSByb2xlX2F0dHJpYnV0ZV8xIFJPTEU7CisKKwkjIGFzc3VtZSB0aGUg
c3lzdGVtX3Igcm9sZSBvbmNlIHRyYW5zaXRpb25lZCB0byB2bG9ja190IGRvbWFpbgorCXJvbGVf
dHJhbnNpdGlvbiByb2xlX2F0dHJpYnV0ZV8xIHZsb2NrX2V4ZWNfdCBzeXN0ZW1fcjsKKwlyb2xl
IHN5c3RlbV9yIHR5cGVzIHZsb2NrX3Q7CisJdXNlciByb290IHJvbGVzIHN5c3RlbV9yIGxldmVs
IHMwIHJhbmdlIHMwIC0gczE1OmMwLmMxMDIzOworJykKZGlmZiAtLWdpdCBhL3BvbGljeS9tb2R1
bGVzL3JvbGVzL3N5c2FkbS50ZSBiL3BvbGljeS9tb2R1bGVzL3JvbGVzL3N5c2FkbS50ZQppbmRl
eCAyZjJiYzc3Li42N2E4NDE1IDEwMDY0NAotLS0gYS9wb2xpY3kvbW9kdWxlcy9yb2xlcy9zeXNh
ZG0udGUKKysrIGIvcG9saWN5L21vZHVsZXMvcm9sZXMvc3lzYWRtLnRlCkBAIC00NTQsMyArNDU0
LDI4IEBAIG9wdGlvbmFsX3BvbGljeShgCiAJJykKICMnKQogCisKKyMgMS4gZGVmaW5lIGEgcm9s
ZSBhdHRyaWJ1dGUgYnkgdGhlIG1vZGlmaWVkIGF0dHJpYnV0ZSBydWxlCisjIE5vdGUsIHNvIGZh
ciB0aGUgZHVwbGljYXRlZCBkZWNsYXJhdGlvbnMgb2Ygcm9sZS91c2VyIGFyZSBhbGxvd2VkCisj
IChzeW10YWJfaW5zZXJ0KQorYXR0cmlidXRlIHJvbGVfYXR0cmlidXRlXzEgcm9sZTsKK2F0dHJp
YnV0ZSByb2xlX2F0dHJpYnV0ZV8xIFJPTEU7CisKKyMgMi4gZGVmaW5lIGEgcmVndWxhciByb2xl
IGJ5IHRoZSBuZXcgcm9sZV9hdHRyIHJ1bGUsCisjIHNwZWNpZnlpbmcgdGhlIHJvbGUgYXR0cmli
dXRlIHRoYXQgYSByZWd1bGFyIHJvbGUgYmVsb25ncyB0bworcm9sZSBzeXNhZG1fcl8yLCByb2xl
X2F0dHJpYnV0ZV8xOworCisjIDMuIGRlZmluZSBhIHJlZ3VsYXIgcm9sZSBieSB0aGUgZXhpc3Rp
bmcgcm9sZV90eXBlIHJ1bGUKK3JvbGUgc3lzYWRtX3JfMzsKKworIyA0LiBhZGQgYSByZWd1bGFy
IHJvbGUgaW50byBhIHJvbGUgYXR0cmlidXRlCityb2xlYXR0cmlidXRlIHN5c2FkbV9yXzMgcm9s
ZV9hdHRyaWJ1dGVfMTsKKworb3B0aW9uYWxfcG9saWN5KGAKKwlnZW5fcmVxdWlyZShgCisJCXVz
ZXIgcm9vdDsKKwkJdHlwZSB2bG9ja190OworCScpCisJCisJdXNlciByb290IHJvbGVzIHJvbGVf
YXR0cmlidXRlXzEgbGV2ZWwgczAgcmFuZ2UgczAgLSBzMTU6YzAuYzEwMjM7CisnKQpkaWZmIC0t
Z2l0IGEvcG9saWN5L21vZHVsZXMvc2VydmljZXMvbGlrZXdpc2UudGUgYi9wb2xpY3kvbW9kdWxl
cy9zZXJ2aWNlcy9saWtld2lzZS50ZQppbmRleCAzYWNiZjFkLi44NGY0YmFmIDEwMDY0NAotLS0g
YS9wb2xpY3kvbW9kdWxlcy9zZXJ2aWNlcy9saWtld2lzZS50ZQorKysgYi9wb2xpY3kvbW9kdWxl
cy9zZXJ2aWNlcy9saWtld2lzZS50ZQpAQCAtMTM3LDcgKzEzNyw3IEBAIHNlbGludXhfdmFsaWRh
dGVfY29udGV4dChsc2Fzc2RfdCkKIHNldXRpbF9yZWFkX2NvbmZpZyhsc2Fzc2RfdCkKIHNldXRp
bF9yZWFkX2RlZmF1bHRfY29udGV4dHMobHNhc3NkX3QpCiBzZXV0aWxfcmVhZF9maWxlX2NvbnRl
eHRzKGxzYXNzZF90KQotc2V1dGlsX3J1bl9zZW1hbmFnZShsc2Fzc2RfdCwgbHNhc3NkX3QpCisj
c2V1dGlsX3J1bl9zZW1hbmFnZShsc2Fzc2RfdCwgbHNhc3NkX3QpCiAKIHN5c25ldF91c2VfbGRh
cChsc2Fzc2RfdCkKIHN5c25ldF9yZWFkX2NvbmZpZyhsc2Fzc2RfdCkKZGlmZiAtLWdpdCBhL3Bv
bGljeS9tb2R1bGVzL3NlcnZpY2VzL254LnRlIGIvcG9saWN5L21vZHVsZXMvc2VydmljZXMvbngu
dGUKaW5kZXggZWJiOTU4Mi4uYTM1NTlmMiAxMDA2NDQKLS0tIGEvcG9saWN5L21vZHVsZXMvc2Vy
dmljZXMvbngudGUKKysrIGIvcG9saWN5L21vZHVsZXMvc2VydmljZXMvbngudGUKQEAgLTEyLDYg
KzEyLDcgQEAgZG9tYWluX2VudHJ5X2ZpbGUobnhfc2VydmVyX3QsIG54X3NlcnZlcl9leGVjX3Qp
CiBkb21haW5fdXNlcl9leGVtcHRpb25fdGFyZ2V0KG54X3NlcnZlcl90KQogIyB3ZSBuZWVkIGFu
IGV4dHJhIHJvbGUgYmVjYXVzZSBueHNlcnZlciBpcyBjYWxsZWQgZnJvbSBzc2hkCiAjIGNqcDog
ZG8gd2UgcmVhbGx5IG5lZWQgdGhpcz8KK3JvbGUgbnhfc2VydmVyX3I7CiByb2xlIG54X3NlcnZl
cl9yIHR5cGVzIG54X3NlcnZlcl90OwogYWxsb3cgc3lzdGVtX3Igbnhfc2VydmVyX3I7CiAKZGlm
ZiAtLWdpdCBhL3BvbGljeS9tb2R1bGVzL3N5c3RlbS9zZWxpbnV4dXRpbC50ZSBiL3BvbGljeS9t
b2R1bGVzL3N5c3RlbS9zZWxpbnV4dXRpbC50ZQppbmRleCAyODRjN2Y4Li42NWUwNjk4IDEwMDY0
NAotLS0gYS9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vc2VsaW51eHV0aWwudGUKKysrIGIvcG9saWN5
L21vZHVsZXMvc3lzdGVtL3NlbGludXh1dGlsLnRlCkBAIC02MDMsMyArNjAzLDIyIEBAIGlmZGVm
KGBoaWRlX2Jyb2tlbl9zeW1wdG9tcycsYAogb3B0aW9uYWxfcG9saWN5KGAKIAlob3RwbHVnX3Vz
ZV9mZHMoc2V0ZmlsZXNfdCkKICcpCisKK29wdGlvbmFsX3BvbGljeShgCisJZ2VuX3JlcXVpcmUo
YAorCQlyb2xlIHN5c2FkbV9yOworCQl0eXBlIHN5c2FkbV90LCBjaGtwd2RfdDsKKwknKQorCisJ
IyBzbyBmYXIgSSBkbyBub3Qga25vdyBob3cgdG8gcmVxdWlyZSBhIHJvbGUgYXR0cmlidXRlIHll
dAorCWF0dHJpYnV0ZSByb2xlX2F0dHJpYnV0ZV8xIFJPTEU7CisJCisJIyBhbGxvdyB0aGUgdHJh
bnNpdGlvbiBmcm9tIHN5c2FkbV9yIHRvIGFsbCByZWd1bGFyIHJvbGVzIHRoYXQKKwkjIGJlbG9u
ZyB0byB0aGUgcm9sZV9hdHRyaWJ1dGVfMSBhbmQgdmljZSB2ZXJzYSBieSB0aGUgbmV3cm9sZSBj
bWQKKwlhbGxvdyBzeXNhZG1fciByb2xlX2F0dHJpYnV0ZV8xOworCWFsbG93IHJvbGVfYXR0cmli
dXRlXzEgc3lzYWRtX3I7CisKKwlyb2xlIHJvbGVfYXR0cmlidXRlXzEgdHlwZXMgbmV3cm9sZV90
OworCXJvbGUgcm9sZV9hdHRyaWJ1dGVfMSB0eXBlcyBjaGtwd2RfdDsKKwlyb2xlIHJvbGVfYXR0
cmlidXRlXzEgdHlwZXMgc3lzYWRtX3Q7CisnKQpkaWZmIC0tZ2l0IGEvcG9saWN5L21vZHVsZXMv
c3lzdGVtL3VuY29uZmluZWQudGUgYi9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vdW5jb25maW5lZC50
ZQppbmRleCBlYWU1MDAxLi45YzVmOTMxIDEwMDY0NAotLS0gYS9wb2xpY3kvbW9kdWxlcy9zeXN0
ZW0vdW5jb25maW5lZC50ZQorKysgYi9wb2xpY3kvbW9kdWxlcy9zeXN0ZW0vdW5jb25maW5lZC50
ZQpAQCAtMTksNiArMTksNyBAQCBpbml0X3N5c3RlbV9kb21haW4odW5jb25maW5lZF90LCB1bmNv
bmZpbmVkX2V4ZWNfdCkKIHR5cGUgdW5jb25maW5lZF9leGVjbWVtX3Q7CiB0eXBlIHVuY29uZmlu
ZWRfZXhlY21lbV9leGVjX3Q7CiBpbml0X3N5c3RlbV9kb21haW4odW5jb25maW5lZF9leGVjbWVt
X3QsIHVuY29uZmluZWRfZXhlY21lbV9leGVjX3QpCityb2xlIHVuY29uZmluZWRfcjsKIHJvbGUg
dW5jb25maW5lZF9yIHR5cGVzIHVuY29uZmluZWRfZXhlY21lbV90OwogCiAjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCi0tIAoxLjcuMC40Cgo=

--_9c742671-a4fc-4a4d-8bee-6a66c26fc1bf_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
