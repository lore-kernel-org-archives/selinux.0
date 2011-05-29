From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <sds@tycho.nsa.gov>, <method@manicmethod.com>,
        <jmorris@namei.org>, <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: v1 Add role attribute support to libsepol
Date: Sun, 29 May 2011 12:36:53 +0800
Message-ID: <1306643819-30374-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Comments
---------

    Support adding one role attribute into another.
    
    When the link process is completed, the types type_set_t and roles
    ebitmap in a role attribute are settled, then we could go on scan
    all role attributes in the base.p_roles table checking if any non-zero
    bit in its roles ebitmap is indeed another role attribute.
    
    If this is the case, then we need to escalate the roles ebitmap of
    the sub-attribute into that of the parent attribute, and remove the
    sub-attribute from parent's roles ebitmap.
    
    Since sub-attribute's roles ebitmap may further contain other role
    attributes, we need to re-scan the updated parent's roles ebitmap.
    
    Also if a loop dependency is detected, no escalation of sub-attribute's
    roles ebitmap is needed.


    In order to highlight this patch I've decided to introduce a new
    separate commit, while all the rest 5 commits are the same as v0.


Tests of adding one role attribute into another
------------------------------------------------
   
1. Apply the patch for rpm.* and selinuxuti.*, to introduce rpm_roles and
   semanage_roles attributes and eliminate the "chain of run interfaces",
   make policy.X and dump its hexdump, check out the policy value for
   related identifiers:
   
   0035b00: 5f74 0500 0000 4103 0000 0100 0000 0000  _t....A.........
   0035b10: 0000 7270 6d5f 7407 0000 0042 0300 0001  ..rpm_t....
   
   rpm_t: policy value = 0x341
   
   0040460: 740c 0000 0075 0700 0001 0000 0000 0000  t....u..........
   0040470: 0072 706d 5f73 6372 6970 745f 740f 0000  .rpm_script_t.
   
   rpm_script_t: policy value = 0x775
   
   004c900: 6563 7572 6974 795f 740a 0000 001e 0c00  ecurity_t.......
   004c910: 0001 0000 0000 0000 0073 656d 616e 6167  .........semanag
   004c920: 655f 7409 0000 001f 0c00 0003 0000 0000  e_t
   
   semanage_t: policy value = 0xc1e
   
   004c760: 0a00 0000 140c 0000 0100 0000 0000 0000  ................
   004c770: 7365 7466 696c 6573 5f74 1400 0000 ec0a  setfiles_t......
   
   setfiles_t: policy value = 0xc14
   
   00484e0: 740d 0000 008b 0a00 0001 0000 0000 0000  t...............
   00484f0: 006c 6f61 645f 706f 6c69 6379 5f74 0c00  .load_policy_t..
   
   load_policy_t: policy value = 0xa8b
   
   
2. Check out rpm_roles.types ebitmap:
   
   002d2c0: 0000 0400 0000 0000 0000 0900 0000 0f00  ................
   002d2d0: 0000 0000 0000 7270 6d5f 726f 6c65 7340  ......rpm_roles@
   002d2e0: 0000 0040 0000 0001 0000 0000 0000 0000  ...@............
   002d2f0: 4000 0000 0000 0040 0000 0080 0700 0002  @......@........
   002d300: 0000 0040 0300 0001 0000 0000 0000 0040  ...@...........@
   002d310: 0700 0000 0000 0000 0010 000b 0000 0010  ................
   002d320: 0000 0000 0000 006e 785f 7365 7276 6572  .......
   
   rpm_roles: policy value = 0x0f
   	dominates:
  		mz = 0x40, highbit = 0x40, node = 1
		startbit = 0, map: 00 4000 0000 0000 00 
			policy value: 0x0f(rpm_roles)
   	types.types:
   		mz = 0x40, highbit = 0x780, node = 2
   		startbit = 0x340, map: 01 0000 0000 0000 00
			policy value: 0x341(rpm_t)
   		startbit = 0x740, map: 00 0000 0000 0010 00
			policy value: 0x775(rpm_script_t)
   
   
3. Check out semanage_roles.types ebitmap:
   
   002caa0: 0000 0000 0e00 0000 0800 0000 0000 0000  ................
   002cab0: 7365 6d61 6e61 6765 5f72 6f6c 6573 4000  semanage_roles@.
   002cac0: 0000 4000 0000 0100 0000 0000 0000 8000  ..@.............
   002cad0: 0000 0000 0000 4000 0000 400c 0000 0200  ......@...@.....
   002cae0: 0000 800a 0000 0004 0000 0000 0000 000c  ................
   002caf0: 0000 0000 0820 0000 0000 1000 0000 0900  ..... ..........
   002cb00: 0000 0000 0000 726f 6c65 5f61 7474 7269  ......
   
   semanage_roles: policy value = 0x08
   	dominates:
  		mz = 0x40, highbit = 0x40, node = 1, 
		startbit = 0, map: 8000 0000 0000 0000 
			policy value: 8(semanage_roles)
   	types.types:
   		mz = 0x40, highbit = 0xc40 node = 2
		startbit = 0xa80, map: 0004 0000 0000 0000
			policy value: 0xa8b(load_policy_t)
		startbit = 0xc00, map: 0000 0820 0000 0000
			policy value: 0xc14(setfiles_t), 0xc1e(semanage_t)
   
   
4. Verify that once rpm_roles attribute becomes a sub-attribute of
   semanage_roles attribute, then all regular roles belonging to rpm_roles
   such as sysadm_r should be able to type all those types of the parent role
   attribute's types(that is, semanage_roles.types):
   
   002ccc0: 0000 0800 0000 0b00 0000 0000 0000 7379  ..............sy
   002ccd0: 7361 646d 5f72 4000 0000 4000 0000 0100  sadm_r@...@.....
   002cce0: 0000 0000 0000 0004 0000 0000 0000 4000  ..............@.
   002ccf0: 0000 800d 0000 2d00 0000 8000 0000 0000  ......-.........
   ...
   002cd70: 5808, 4003 0000 0906 0200 0000 0000, 8003  X.@.............
   ...
   002cdf0: 4000 0000 0900 c006 0000 0000 0008 0000  @...............
   002ce00: 0000, 4007 0000 4000 0000 0000 1006, 8007  ..@...@.........
   002ce10: 0000 0000 000a 0000 0000 c007 0000 0080  ................
   ...
   002ce90: 8000, 400a 0000 0000 0000 0000 0040, 800a  ..@..........@..
   002cea0: 0000 0004 0002 0000 0000 c00a 0000 0000  ................
   002ceb0: 0000 8000 0000 000b 0000 0000 0080 0080  ................
   002cec0: 0000 c00b 0000 0000 0000 1000 0000, 000c  ................
   002ced0: 0000 0000 3820 0004 0000 400c 0000 0400  ....8 ....@.....
   ...
   
   sysadm_r: policy value = 0x0b
   	dominates:
   		mz = 0x40, highbit = 0x40, node = 1
   		startbit = 0x0, map: 0004 0000 0000 0000
			policy value: 0x0b(sysadm_r)
   	types.types:
   		mz = 0x40, highbit = 0xd80, node = 0x2d
   		startbit = 0x340, map: 0906 0200 0000 0000
   			policy value: 341(rpm_t), 344, 34a, 34b
   
   		startbit = 0x740, map: 4000 0000 0000 1006
   			policy value: 747, 775(rpm_script_t), 77a, 77b
   
   		startbit = 0xa80, map: 0004 0002 0000 0000
   			policy value: a8b(load_policy_t), a9a
   
   		startbit = 0xc00, map: 0000 3820 0004 0000 
   			policy value: c14(setfiles_t), c15, c16, c1e(semanage_t)
   
   
5. Extra loop depenency tests.
   
5.1 When there is no loop dependency between rpm_roles and semanage_roles
   attributes, the secadm_r that belongs to semanage_roles attributes is
   not able to type those types of the rpm_roles.types, such as rpm_t or
   rpm_script_t:
   
   002cb60: 0000 0a00 0000 0000 0000 7365 6361 646d  ..........secadm
   002cb70: 5f72 4000 0000 4000 0000 0100 0000 0000  _r@...@.........
   002cb80: 0000 0002 0000 0000 0000 4000 0000 400d  ..........@...@.
   002cb90: 0000 1900 0000 8000 0000 0000 0000 0200  ................
   ...
   002cbe0: 0000 0400 0200 0000 1800, 4003 0000 0002  ..........@.....
   002cbf0: 0000 0000 0000 c003 0000 0000 0000 0000  ................
   ...
   002cc30: 0800 4006 0000 0000 0000 0000 0100, 4007  ..@...........@.
   002cc40: 0000 0000 0000 0000 2000 4009 0000 0000  ........ .@.....
   002cc50: 0000 0000 0420 8009 0000 0000 0820 0000  ..... ....... ..
   
   secadm_r:
   	types.types:
   		mz = 0x40, highbit = 0xd40, node = 0x19
   		startbit = 0x340, map: 0002 0000 0000 0000
   			policy value: 34a, ... 
   		
   		startbit = 0x740, map: 0000 0000 0000 2000
   			policy value: 776
   
   
5.2 Add below statements in selinuxutil.te to create a loop dependcy
   between rpm_roles and semanage_roles attributes:
   
   attribute rpm_roles ROLE;
   roleattribute semanage_roles rpm_roles;
   
   Then rebuild policy.X in modular way, the loop dependency should be
   properly handled, and secadm_r that belongs to the semanage_roles
   should be able to type all those types in rpm_roles.types ebitmap,
   such as rpm_t and rpm_script_t:
   
   002cb60: 0000 0a00 0000 0000 0000 7365 6361 646d  ..........secadm
   002cb70: 5f72 4000 0000 4000 0000 0100 0000 0000  _r@...@.........
   002cb80: 0000 0002 0000 0000 0000 4000 0000 400d  ..........@...@.
   002cb90: 0000 1900 0000 8000 0000 0000 0000 0200  ................
   ...
   002cbe0: 0000 0400 0200 0000 1800, 4003 0000 0102  ..........@.....
   002cbf0: 0000 0000 0000 c003 0000 0000 0000 0000  ................
   ...
   002cc30: 0800 4006 0000 0000 0000 0000 0100, 4007  ..@...........@.
   002cc40: 0000 0000 0000 0000 3000 4009 0000 0000  ........0.@.....
   002cc50: 0000 0000 0420 8009 0000 0000 0820 0000  ..... ....... ..
   
   secadm_r:
   	types.types:
   		mz = 0x40, highbit = 0xd40, node = 0x19
   		startbit = 0x340, map: 0102 0000 0000 0000
   			policy value: 341(rpm_t), ... 
   		
   		startbit = 0x740, map: 0000 0000 0000 3000
   			policy value: 775(rpm_script_t), 776

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
