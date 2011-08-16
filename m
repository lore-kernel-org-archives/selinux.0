Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7G891k1013528
	for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2011 04:09:01 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7G890dV017374
	for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2011 08:09:00 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: v2 Skip role attributes for policy.X and downgraded pp
Date: Tue, 16 Aug 2011 16:08:51 +0800
Message-ID: <1313482132-15188-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Differnece from v1
--------------------
1. Skip role attributes when pp is downgraded, as well as for policy.X.

   When pp is downgraded the flavor flag and roles ebitmap would be
   discarded, resulting in role attributes useless at all. So in such
   case role attributes should be skipped for pp too.


Tests I've done
-----------------
1. Apply the role attribute test patch from Chris, adding a new test_r
   role and calls rpm_run() for it.
   
2. Use the apol tool to analyze what types the test_r role could type with:
   (Since the apol installed on Ubuntu so far only support max version .24,
    we need to setup "policy-version = 24" in semanage.conf)
   
Note: 
. There is no role attributes such as portage/semanage/rpm_roles in policy.24
. By default pp's version is 13.

test_r (36 types)
    bootloader_t
    chfn_t
    chkpwd_t
    consoletype_t
    ddclient_t
    depmod_t
    dhcpc_t
    groupadd_t
    hostname_t
    ifconfig_t
    insmod_t
    iptables_t
    ldconfig_t
    load_policy_t
    loadkeys_t
    lvm_t
    netutils_t
    newrole_t
    nscd_t
    pam_t
    passwd_t
    ping_t
    pppd_t
    pptp_t
    prelink_t
    rpm_script_t
    rpm_t
    semanage_t
    setfiles_t
    test_t
    traceroute_t
    tzdata_t
    updpwd_t
    useradd_t
    usernetctl_t
    utempter_t

3. In write_binary_policy() in checkmodule.c, trigger pp downgrade
   by adding "policyvers = MOD_POLICYDB_VERSION_MAX - 1;", then use
   apol to analyze what types the test_r role could type with:

Note:
. After downgrade, pp's version is 12 now.

test_r (22 types)
    chfn_t
    chkpwd_t
    consoletype_t
    ddclient_t
    dhcpc_t
    hostname_t
    ifconfig_t
    insmod_t
    iptables_t
    loadkeys_t
    netutils_t
    newrole_t
    pam_t
    passwd_t
    ping_t
    pppd_t
    pptp_t
    test_t
    traceroute_t
    updpwd_t
    usernetctl_t
    utempter_t

   Where we can see that test_r could no longer type with all those
   types that are typed by rpm_roles and semanage_roles.

   (BTW, this means that once role attributes are endorsed in refpolicy,
    the influence of pp downgrade could be far-reaching and perhaps
    undesirable.)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
