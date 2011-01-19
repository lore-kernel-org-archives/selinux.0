Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0JI6bcQ000392
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2011 13:06:38 -0500
Received: from mail-px0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0JI6bH7027015
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2011 18:06:38 GMT
Received: by pxi2 with SMTP id 2so225588pxi.12
        for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2011 10:06:37 -0800 (PST)
Message-ID: <4D372829.5090509@gmail.com>
Date: Wed, 19 Jan 2011 10:06:33 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: refpolicy@oss1.tresys.com
CC: selinux@tycho.nsa.gov
Subject: WARNING: at kernel/printk.c:430 do_syslog+0x40d/0x441()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

this is showing up with the latest kernel in enforcing mode..
(I have not update the policy and/or selinux userspace)

[   12.803882] type=1400 audit(1295457694.801:3): avc:  denied  { syslog 
} for  pid=1540 comm="rsyslogd" capability=34 
scontext=system_u:system_r:init_t:s0 
tcontext=system_u:system_r:init_t:s0 tclass=capability2
[   12.803888] ------------[ cut here ]------------
[   12.803894] WARNING: at kernel/printk.c:430 do_syslog+0x40d/0x441()
[   12.803896] Hardware name: iMac9,1
[   12.803898] Attempt to access syslog with CAP_SYS_ADMIN but no 
CAP_SYSLOG (deprecated and denied).
[   12.803900] Modules linked in: twofish_generic twofish_x86_64 
twofish_common ctr ah4 esp4 authenc uhci_hcd hci_uart rfcomm 
lib80211_crypt_tkip nf_nat_irc hidp nf_conntrack_irc wl(P) nf_nat_ftp 
l2cap nf_nat nf_conntrack_ipv4 coretemp nf_defrag_ipv4 acpi_cpufreq 
mperf appletouch nf_conntrack_ftp nf_conntrack iptable_filter button 
uvcvideo processor btusb ip_tables videodev evdev bluetooth x_tables 
applesmc i2c_nforce2 firewire_ohci firewire_core forcedeth ohci_hcd ehci_hcd
[   12.803943] Pid: 1540, comm: rsyslogd Tainted: P            2.6.38-rc1 #5
[   12.803946] Call Trace:
[   12.803950]  [<ffffffff81060c64>] ? warn_slowpath_common+0x80/0x98
[   12.803954]  [<ffffffff81060d10>] ? warn_slowpath_fmt+0x41/0x43
[   12.803958]  [<ffffffff81062088>] ? do_syslog+0x40d/0x441
[   12.803963]  [<ffffffff811fcc1f>] ? do_raw_spin_lock+0x6b/0x118
[   12.803968]  [<ffffffff81143ca7>] ? kmsg_open+0x17/0x19
[   12.803972]  [<ffffffff8113b01f>] ? proc_reg_open+0xac/0x149
[   12.803975]  [<ffffffff81143c90>] ? kmsg_open+0x0/0x19
[   12.803979]  [<ffffffff81143c78>] ? kmsg_release+0x0/0x18
[   12.803982]  [<ffffffff8113af73>] ? proc_reg_open+0x0/0x149
[   12.803987]  [<ffffffff810f7b2f>] ? __dentry_open+0x15d/0x282
[   12.803991]  [<ffffffff810f7d25>] ? nameidata_to_filp+0x50/0x57
[   12.803995]  [<ffffffff8110336b>] ? finish_open+0x9c/0x1a3
[   12.803999]  [<ffffffff81104964>] ? do_path_lookup+0x66/0x109
[   12.804015]  [<ffffffff81105816>] ? do_filp_open+0x1b6/0x6a4
[   12.804019]  [<ffffffff810f42a8>] ? check_object+0x13b/0x1e8
[   12.804023]  [<ffffffff811fcbab>] ? do_raw_spin_unlock+0x8f/0x98
[   12.804027]  [<ffffffff8110f481>] ? alloc_fd+0x111/0x123
[   12.804031]  [<ffffffff810f7903>] ? do_sys_open+0x5b/0xed
[   12.804035]  [<ffffffff810f79be>] ? sys_open+0x1b/0x1d
[   12.804039]  [<ffffffff8102d092>] ? system_call_fastpath+0x16/0x1b
[   12.804042] ---[ end trace 03d1aa6aedda8529 ]---

when using audit2allow I get:

allow init_t self:capability2 syslog;

which gives an error when trying to install the module, due to the 
policy not knowing what capability2 is

system is ubuntu maverick, if this is already in(refpolicy) then I'll 
pull the latest when I get a chance..

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
