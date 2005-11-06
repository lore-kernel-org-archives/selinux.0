Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA6CC7MA014095
	for <selinux@tycho.nsa.gov>; Sun, 6 Nov 2005 07:12:09 -0500 (EST)
Received: from xproxy.gmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA6C6Kcn017287
	for <selinux@tycho.nsa.gov>; Sun, 6 Nov 2005 12:06:20 GMT
Received: by xproxy.gmail.com with SMTP id i29so185469wxd
        for <selinux@tycho.nsa.gov>; Sun, 06 Nov 2005 04:06:20 -0800 (PST)
Message-ID: <ef5305790511060406x26fb2221mff3168b980b68f27@mail.gmail.com>
Date: Mon, 7 Nov 2005 01:06:20 +1300
From: Goo GGooo <googgooo@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Problems with policy-1.26
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,
I have downloaded selinuc 1.26 and am trying to use it with linuxkernel 2.6.12.6. Unfortunately I have problems with policy-1.26. Whendoing "make install" I'm constantly getting complaints about missing/etc/libuser.conf:
/etc/selinux # make installBuilding file contexts files...Validating file contexts files .../usr/sbin/setfiles -q -c /etc/selinux/strict/policy/policy.20file_contexts/file_contextsinstall -m 644 tmp/system.users /etc/selinux/strict/users/system.usersinstall -m 644 tmp/customizable_types/etc/selinux/strict/contexts/customizable_typesinstall -m 644 tmp/port_types /etc/selinux/strict/contexts/port_typesInstalling file contexts files...install -m 644 file_contexts/homedir_template/etc/selinux/strict/contexts/files/homedir_templateinstall -m 644 file_contexts/file_contexts/etc/selinux/strict/contexts/files/file_contextsgrep: /etc/libuser.conf: No such file or directoryYou do not have access to /etc/libuser.conf LU_HOMEDIRECTORY=/var/lib is already defined in /etc/selinux/strict/contexts/files/file_contexts,/usr/sbin/genhomedircon will not create a new context.
Then with "make load" I'm getting error w.r.t. missing/etc/selinux/targeted/users//{local.users,system.users}, while/etc/selinux/targeted/users is a file, not a directory containing anyfiles:
# make loadLoading Policy .../usr/sbin/load_policy /etc/selinux/strict/policy/policy.20sepol_genusers: Can't load system.users:  Not a directory/usr/sbin/load_policy:  Error while setting user configuration from/etc/selinux/targeted/users//{local.users,system.users}:  Not adirectorysepol_genbools_array:  boolean secure_mode_insmod no longer in policysepol_genbools_array:  boolean secure_mode_policyload no longer in policy/usr/sbin/load_policy:  Warning!  Unable to reset all booleans/usr/sbin/load_policy:  security_load_policy failedmake: *** [tmp/load] Error 3
What am I doing wrong?
Thanks!
Goo

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
