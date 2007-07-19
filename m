Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6J3OUjU005901
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 23:24:30 -0400
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6J3OTRg026633
	for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2007 03:24:30 GMT
Received: by nz-out-0506.google.com with SMTP id l1so363444nzf
        for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 20:24:29 -0700 (PDT)
Message-ID: <469ED825.8040902@gmail.com>
Date: Thu, 19 Jul 2007 11:19:01 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: vmware policy modification problems
Content-Type: text/plain; charset=GB18030
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov




hi, all:

i have a problem about policy development, the problem context can
refer to:

http://marc.info/?l=fedora-selinux-list&m=118431011713104&w=2

i want to modify vmware policy to make the device node created by
net-services.sh to be labeled "vmware_device_t" automaitically.

i add following line in vmware.fc:

/usr/lib/vmware/net-services.sh --
gen_context(system_u:object_r:vmware_host_exec_t,s0)

and add some rules in vmware.te:

type_transition vmware_host_t tmpfs_t:chr_file vmware_device_t;
allow vmware_host_t bin_t:file entrypoint;
corecmd_bin_domtrans(vmware_host_t,bin_t)
kernel_read_system_state(vmware_host_t)
sysnet_domtrans_ifconfig(vmware_host_t)

(the vmware.[te,fc] i use is from selinux-policy-targeted-3.0.2-8.fc8)

after modifying, i build and install:

# make -f /usr/share/selinux/devel/Makefile
# sudo semdoule -i vmware.pp

but i got some errors:

libsepol.check_assertion_helper: assertion on line 0 violated by allow
vmware_host_t bin_t:process { transition };
libsepol.check_assertion_helper: assertion on line 0 violated by allow
vmware_host_t bin_t:process { transition };
libsepol.check_assertions: 2 assertion violations occured
libsemanage.semanage_expand_sandbox: Expand module failed
semodule:  Failed!

additionally, there is an avc errors:

avc: denied { getattr } for comm="semodule" dev=sda7 name="/" pid=4875
scontext=system_u:system_r:semanage_t:s0 tclass=filesystem
tcontext=system_u:object_r:fs_t:s0

the selinux infrastructures i use are:

libselinux-2.0.24-1.fc8.i386
libsepol-2.0.4-1.fc8.i386
policycoreutils-2.0.22-5.fc8.i386

in a word, all are from F8 rawhide.


briefly, i have two problems about these errors:

1
what libsepol assertion mean? what kinds of behaviours will introduce
these errors? i have checked the "check_assertion_helper()" func, but had
not any hints.

firstly, i guess the reason is the transition constrain, so i add a rule
for verifying my guess:

domain_unconfined(vmware_host_t)

but the violated assertions were still there.

2
concerning the vmware problem i want to solve, is my method appropriate?

with Daniel hints, i know /etc/rc.d/init.d/vmware(initrc_exec_t) will
transit to vmware_host_t, so i label net-services.sh(vmware_host_exec_t),
and want to make device nodes(/dev/vmnet*) to be created with
"vmware_device_t" label automatically, because i find the /dev is tmpfs_t
file system. The files created in such FS, can use fs_use_trans to label
automatically.

# cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext3 rw,data=ordered 0 0
/dev /dev tmpfs rw 0 0
......



thanks in advance



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
