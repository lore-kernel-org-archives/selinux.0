Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7C6IofA015831
	for <selinux@tycho.nsa.gov>; Fri, 12 Aug 2011 02:18:54 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7C6In5m000226
	for <selinux@tycho.nsa.gov>; Fri, 12 Aug 2011 06:18:49 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: v0 Skip role attributes for policy.X
Date: Fri, 12 Aug 2011 14:18:42 +0800
Message-ID: <1313129923-23763-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Comments
----------
   Role attributes are redundant for policy.X, their destiny has been
   fulfilled in the expand phase when their types.types ebitmap have
   been populated to that of their sub regular roles.

   Deduct the number of role attributes from p_roles.table->nel and
   skip writing them to policy.X.

   (Thanks Steve for pointing this out)


Tests I've done
-----------------
1. Apply the role attribute test patch from Chris, adding a new test_r
   role and calls rpm_run() for it.
   
2. Use the apol tool to analyze what types the test_r role could type with:
   (Since the apol installed on Ubuntu so far only support max version .24,
    we need to setup "policy-version = 24" in semanage.conf)
   
Note: there is no role attributes such as portage/semanage/rpm_roles
      in policy.24

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

3. Use the apol tool to anaylze the domain transitions starting from test_t:

   test_t -> rpm_t -> rpm_script_t -> semanage_t -> load_policy_t
                                                 -> setfiles_t

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
