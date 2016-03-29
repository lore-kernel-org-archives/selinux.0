Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2TErE71006594
 for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2016 10:53:14 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 2F45C7F08D
 for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2016 14:53:10 +0000 (UTC)
Received: from dhcp-10-19-62-196.boston.devel.redhat.com
 (dhcp-25-88.bos.redhat.com [10.18.25.88])
 by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 u2TEr9IE023792
 for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2016 10:53:09 -0400
To: SELinux <selinux@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Subject: On Fedora 24 I am seeing something strange with CIL
Message-ID: <56FA96D5.4010806@redhat.com>
Date: Tue, 29 Mar 2016 10:53:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When I compile and install this policy

---------------------------------------------------------------
# cat /tmp/container.te
policy_module(container, 1.0)

virt_sandbox_domain_template(container)

----------------------------------------------------------------
I end up with mknod capability.

sesearch -A -s container_t -t container_t  -c capability
Found 1 semantic av rules:
    allow container_t container_t : capability mknod ;

But I didn't add mknod to the policy.

grep mknod tmp/container.tmp
     class capability { chown dac_override dac_read_search fowner fsetid 
kill setgid setuid setpcap linux_immutable net_bind_service 
net_broadcast net_admin net_raw ipc_lock ipc_owner sys_module sys_rawio 
sys_chroot sys_ptrace sys_pacct sys_admin sys_boot sys_nice sys_resource 
sys_time sys_tty_config mknod lease audit_write audit_control setfcap };

Any ideas?
