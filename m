Return-Path: <SRS0=WkJB=NS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE631C0044C
	for <selinux@archiver.kernel.org>; Wed,  7 Nov 2018 15:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6254E20827
	for <selinux@archiver.kernel.org>; Wed,  7 Nov 2018 15:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6254E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeKHBNi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:13:38 -0500
Received: from uphb19pa12.eemsg.mail.mil ([214.24.26.86]:29293 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726897AbeKHBNi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Nov 2018 20:13:38 -0500
X-EEMSG-check-008: 158202219|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Nov 2018 15:42:41 +0000
X-IronPort-AV: E=Sophos;i="5.54,475,1534809600"; 
   d="scan'208";a="20379361"
IronPort-PHdr: =?us-ascii?q?9a23=3AR56EbB/haC5qL/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0uoWIJqq85mqBkHD//Il1AaPAd2Eraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HRbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RS?=
 =?us-ascii?q?qt4LtqSB/wiScIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyaOuB+fqfAdt0EQ2?=
 =?us-ascii?q?RPUNtaWyhYDo+hc4cDCuwMNvtaoYbgvVsDtQawCxeiBO3vyTFGiHH50qI43O?=
 =?us-ascii?q?s9Hg/LxxAgEtEUvXjIsNn4OqUfXOaox6fI1zXDaPZW1C/g5ojUbB8hufGMUq?=
 =?us-ascii?q?x2ccHM1EcvEhnKjlGUqYP7PzKey+MAs3OG4Op7Tu+vl24mpB1xojio3MssjJ?=
 =?us-ascii?q?LJiZgPxlDL8iV53p84KNulQ0B1Zt6kFYFftyCcN4ZuTMMtXXxnuCEgyrIcoZ?=
 =?us-ascii?q?67Zi8KyJY5yBHDd/yLaY+I4gjsVOuXPDx2h2pldaqiixu9/kWs0O3xWtSu3F?=
 =?us-ascii?q?pUoSdJjMPAum0L2hfO8MaIUOF98V2k2TuX0gDT7fxLLl4smKrALp4h3qYwlp?=
 =?us-ascii?q?0OsUTfBiP2mFv5jKuRdkg85uin8f7nYrT7pp+HLYN0lgH/Pbgumsy4G+g4NB?=
 =?us-ascii?q?QBX3OH9uim0b3j/En5TK1Ljv0wjKbZrIjXKdkUq6O2GQNY0psv5wyhAzqpzt?=
 =?us-ascii?q?gUh2QLIEpAeB2djojpP1/OIOr/Dfe6m1msiypkx+vdM739ApTCMnjDkLD7cb?=
 =?us-ascii?q?Z78E5T0hA/zd9Y55JKEr0BOu78WlfttNzECR80Kxa0w+H8CNV9zIweX3yADr?=
 =?us-ascii?q?WYMKPJsV+H/PgvLPOXaY8avTbyMfkl5/r0gXAlnl8deLGj3YELZ3CgAvRmP0?=
 =?us-ascii?q?KZbGL3gtgfFWcKvww+TPHliVCZTz5TaGi9X7gm6jE4Fo2mF4HDSZ6pgLCb2y?=
 =?us-ascii?q?e7BJJWbHhcCl+QCXfoa5mEW/AUZS2PLM5uiDgEVaOhS4I6zxGhqhL1y7p9Ie?=
 =?us-ascii?q?rI4CEXqZXj1N1t7e3JiR4y7SB0D9ia02yVS2F0gHkISCUt069hvUNw0U2D3r?=
 =?us-ascii?q?ZljPxYD9NT++lFXRs9NZ7Z1+Z6Ecz9WhrdfteVT1arWs2mDissTtI12NIOe1?=
 =?us-ascii?q?xyG8imjhza2iqqBLgVl6aVC5Au7q3c2H3xdI5BzCPnz6kolVBubMZVM2Sgiq?=
 =?us-ascii?q?k3oxLUHI7AlUjflr2qfL4V9CHI/WaHi2GJuRccGBV9VaTDQGA3eETbt5L661?=
 =?us-ascii?q?nEQrvoDq4oYSVbzsvXEbdHct3kix19Qf7nPNnPKzaql3yYGQeDxrTKapHjPW?=
 =?us-ascii?q?oawnOOWwA/jwkP8CPeZkAFDSC7rjebVWU2GA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AvAACCBuNb/wHyM5BkGgEBAQEBAgEBAQEHAgEBAQGBV?=
 =?us-ascii?q?AIBAQEBCwGBVQUpZk8zJ4N4lBRNAQEBAQEGgTWJEZAVBCUNBgGEQAKDayI3C?=
 =?us-ascii?q?g0BAwEBAQEBAQIBbBwMgjYkAYJfAQEBAQIBASIECwEFQQULCQIOCgICEgEBD?=
 =?us-ascii?q?AYCAigvBgEMCAEBghZIPwGBdAUID4w6m1B7M4NAgXyEZQWBC4ptF3mBB4ERJ?=
 =?us-ascii?q?4JrgxsFgRgwXgIFgjWCVwKIegMIhXl2To5/CYZvhg0jg20GGIFXiCOGbo0Zj?=
 =?us-ascii?q?CcigVUrCAIYCCEPO4I4ATSCJheIXoVcIQMxAQEDfwEBig8NFQKCJwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 07 Nov 2018 15:42:40 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wA7FgdUI013076;
        Wed, 7 Nov 2018 10:42:39 -0500
Subject: Re: SELinux MLS for Apache Process
To:     Ishara Fernando <roshane.ishara@gmail.com>, selinux@vger.kernel.org
Cc:     dwalsh@redhat.com, SELinux <selinux@tycho.nsa.gov>,
        Lukas Vrabec <lvrabec@redhat.com>,
        Paul Moore <paul@paul-moore.com>
References: <CAOQ2Cef9DMjJeFf2wwhaLx54mLDsHdTRouie4gXQJ3B7qZe7_g@mail.gmail.com>
 <ddc4e042-522f-4aa2-84a3-15af58c95e3b@tycho.nsa.gov>
 <CAOQ2CedQ5_3txFSDOw4HRmtJeBvnESVGDpK0zpzr_6L2aKaLkQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <34369eaf-4f99-91c5-c69d-a28de6cf39d8@tycho.nsa.gov>
Date:   Wed, 7 Nov 2018 10:44:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAOQ2CedQ5_3txFSDOw4HRmtJeBvnESVGDpK0zpzr_6L2aKaLkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/7/18 2:04 AM, Ishara Fernando wrote:
> Thanks Stephen , so below are the details of my SELinux setup
> 
> 
> *Centos Version* : CentOS release 6.2 (Final)
> *Kernel version* : 2.6.32-220.el6.x86_64
> *RPM package* : selinux-policy-mls-3.7.19-312.el6.noarch

That's quite old.  Any particular reason you aren't at least on the 
latest CentOS 6.x release if not CentOS 7.x? 
CentOS/Fedora/RHEL-specific questions likely should go to the Fedora 
selinux list,
https://lists.fedoraproject.org/admin/lists/selinux.lists.fedoraproject.org/

> 
> *cat /etc/selinux/mls/contexts/securetty_types *
> console_device_t
> sysadm_tty_device_t
> user_tty_device_t
> staff_tty_device_t
> auditadm_tty_device_t
> secureadm_tty_device_t
> user_devpts_t
> sshd_devpts_t
> 
> *
> *
> *sestatus -v *
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   enforcing
> Mode from config file:          enforcing
> Policy version:                 24
> Policy from config file:        mls
> 
> Process contexts:
> Current context:                system_u:system_r:sshd_t:s0-s15:c0.c1023

Your shell shouldn't be running in sshd_t; sshd should have transitioned 
to a user context (like root:sysadm_r:sysadm_t:... or 
staff_u:staff_r:staff_t:... or user_u:user_r:user_t:...).  Were there 
errors from sshd in /var/log/secure or elsewhere?

> Init context:                   unknown (Permission denied)
> 
> File contexts:
> Controlling term:               system_u:object_r:sshd_devpts_t:s0
> /etc/passwd                     system_u:object_r:etc_t:s0
> /bin/bash                       system_u:object_r:shell_exec_t:s0
> /bin/sh                         system_u:object_r:bin_t:s0 -> 
> system_u:object_r:shell_exec_t:s0
> /usr/sbin/sshd                  system_u:object_r:sshd_exec_t:s0
> 
> 
> *Regarding the httpd process , i started the process by switching to a 
> new role as follows , so that's why it has obtained the sshd_t type on 
> the 'httpd' process*
> 
> [root@msc-ishara-system1 ~]# newrole -l s4-s5:c1,c2
> Password:
> 
> [root@msc-ishara-system1 ~]# id -Z
> system_u:system_r:*sshd_t*:s4-s5:c1,c2*
> *
> [root@msc-ishara-system1 ~]# /etc/init.d/httpd start

You first need to be in a proper user context before you do anything 
else.  Otherwise any processes you start are likely to be in the wrong 
context too.

I created a CentOS 6.10 VM, installed the mls policy, changed 
/etc/selinux/config to specify permissive and mls, touched 
/.autorelabel, rebooted to relabel filesystems, then changed 
/etc/selinux/config to enforcing and rebooted again.  If I try to ssh in 
as root, I get an error ("Unable to get valid context for root") and the 
connection is closed; /var/log/secure contains some additional error 
reporting from sshd.  That seems like a bug in selinux-policy-mls.

If I run the following command:
# semanage login -m -s staff_u root # map root to staff role
then I can ssh in as root albeit with some errors about accessing /root 
files.

Then I can do the following to switch to the sysadm role:
# newrole -r sysadm_r

I can't directly run /etc/init.d/httpd at all:
# /etc/init.d/httpd start
-bash: /etc/init.d/httpd: Permission denied

Or via service:
# service httpd start
env: /etc/init.d/httpd: Permission denied

I think -mls policy required the use of run_init to run init scripts in 
the proper context, ala the original SELinux policy:
# run_init /etc/init.d/httpd start
# ps -eZ | grep httpd
system_u:system_r:httpd_t:s0-s15:c0.c1023 1704 ? 00:00:00 httpd
system_u:system_r:httpd_t:s0-s15:c0.c1023 1706 ? 00:00:00 httpd
system_u:system_r:httpd_t:s0-s15:c0.c1023 1707 ? 00:00:00 httpd
system_u:system_r:httpd_t:s0-s15:c0.c1023 1708 ? 00:00:00 httpd
system_u:system_r:httpd_t:s0-s15:c0.c1023 1709 ? 00:00:00 httpd
system_u:system_r:httpd_t:s0-s15:c0.c1023 1710 ? 00:00:00 httpd
system_u:system_r:httpd_t:s0-s15:c0.c1023 1711 ? 00:00:00 httpd
system_u:system_r:httpd_t:s0-s15:c0.c1023 1712 ? 00:00:00 httpd
system_u:system_r:httpd_t:s0-s15:c0.c1023 1713 ? 00:00:00 httpd

However, if I switch levels before trying to do this, it fails:
# newrole -l s4-s5:c1,c2
# run_init /etc/init.d/httpd restart
execvp: Permission denied

And the denial is due to the change in levels:
# ausearch -i -m AVC -ts recent
type=SYSCALL msg=audit(11/07/2018 09:37:14.703:318) : arch=x86_64 
syscall=execve success=no exit=-13(Permission denied) a0=0x7fffaf68a871 
a1=0x7fffaf6893d0 a2=0x7fffaf6893e8 a3=0x7fffaf689030 items=0 ppid=1824 
pid=1838 auid=root uid=root gid=root euid=root suid=root fsuid=root 
egid=root sgid=root fsgid=root tty=pts0 ses=7 comm=run_init 
exe=/usr/sbin/run_init subj=staff_u:sysadm_r:run_init_t:s4-s5:c1,c2 
key=(null)
type=AVC msg=audit(11/07/2018 09:37:14.703:318) : avc:  denied  { 
transition } for  pid=1838 comm=run_init path=/etc/rc.d/init.d/httpd 
dev=dm-0 ino=133288 scontext=staff_u:sysadm_r:run_init_t:s4-s5:c1,c2 
tcontext=system_u:system_r:initrc_t:s0-s15:c0.c1023 tclass=process

run_init always tries to run the init script in the initrc_context, so 
you'd lose the caller's level even if you altered policy to allow this.

If I define a range_transition policy rule instead to automatically 
start httpd in that level:
# cat > httpdtrans.te <<EOF
policy_module(httpdtrans, 1.0)

require {
	type initrc_t;
	type httpd_exec_t;
	type httpd_t;
}

range_transition initrc_t httpd_exec_t:process s4 - s5:c1,c2;

mls_rangetrans_source(initrc_t)
mls_rangetrans_target(httpd_t)
EOF
# make -f /usr/share/selinux/devel/Makefile httpdtrans.pp
# semodule -i httpdtrans.pp

And then try to start httpd:
# run_init /etc/init.d/httpd start
Starting httpd:                                            [FAILED]

it still fails but due to various denials when httpd tries to write to 
various directories/files that are labeled s0.

# ausearch -i -m AVC -ts recent
type=SYSCALL msg=audit(11/07/2018 10:13:37.915:445) : arch=x86_64 
syscall=open success=no exit=-13(Permission denied) a0=0x5565fcd6a070 
a1=O_RDWR|O_CREAT|O_EXCL a2=0600 a3=0x7ffd99b94c80 items=0 ppid=2324 
pid=2325 auid=root uid=root gid=root euid=root suid=root fsuid=root 
egid=root sgid=root fsgid=root tty=(none) ses=7 comm=httpd 
exe=/usr/sbin/httpd subj=system_u:system_r:httpd_t:s4-s5:c1,c2 key=(null)
type=AVC msg=audit(11/07/2018 10:13:37.915:445) : avc:  denied  { write 
} for  pid=2325 comm=httpd name=tmp dev=dm-0 ino=12 
scontext=system_u:system_r:httpd_t:s4-s5:c1,c2 
tcontext=system_u:object_r:tmp_t:s0-s15:c0.c1023 tclass=dir
----
type=SYSCALL msg=audit(11/07/2018 10:13:37.919:450) : arch=x86_64 
syscall=open success=no exit=-13(Permission denied) a0=0x5565fcde6e88 
a1=O_WRONLY|O_CREAT|O_APPEND|O_CLOEXEC a2=0666 a3=0x7f9275f59af0 items=0 
ppid=2324 pid=2325 auid=root uid=root gid=root euid=root suid=root 
fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=7 comm=httpd 
exe=/usr/sbin/httpd subj=system_u:system_r:httpd_t:s4-s5:c1,c2 key=(null)
type=AVC msg=audit(11/07/2018 10:13:37.919:450) : avc:  denied  { append 
} for  pid=2325 comm=httpd name=error_log dev=dm-0 ino=261766 
scontext=system_u:system_r:httpd_t:s4-s5:c1,c2 
tcontext=system_u:object_r:httpd_log_t:s0 tclass=file

You'd have to run httpd with a private /tmp and label httpd's persistent 
data directories/files appropriately to make that work. Doing this 
without using containers or VMs looks painful.  And if using 
containers/VMs, you'd get MCS labeling and isolation for free under the 
default targeted policy, without needing to use MLS.

> 
> 
> [root@msc-ishara-system1 ~]# ps auxZ  |  grep -i httpd
> system_u:system_r:*sshd_t*:s4-s5:c1,c2 root 29220 0.0  0.4 262888  9244 
> ?        Ss   00:18   0:00 /usr/sbin/httpd
> system_u:system_r:*sshd_t*:s4-s5:c1,c2 apache 29223 0.0  0.2 262888 5264 
> ?       S    00:18   0:00 /usr/sbin/httpd
> 
> *
> *
> *And on the mlsconstraint statements for file read , i see the following 
> constrain *
> 
> mlsconstrain { file } { read getattr execute  }
> (  l1 l2  dom  t1 { sysadm_t aide_t system_cronjob_t ksmtuned_t sssd_t 
> virtd_t xserver_t } ==  h1 l2  dom  &&  ||  t1 { bootloader_t 
> pam_console_t logrotate_t dmidecode_t iptables_t auditadm_wm_t 
> myuser_wm_t setfiles_mac_t initrc_t mcelog_t secadm_t sysadm_t fsadm_t 
> getty_t kudzu_t lvm_t mdadm_t quota_t rpm_t xdm_t xguest_wm_t 
> myuser2_wm_t setsebool_t newrole_t setrans_t user_wm_t local_login_t 
> rpm_script_t tmpreaper_t devicekit_disk_t NetworkManager_t audisp_t 
> auditd_t kernel_t crond_t cupsd_t hald_t init_t kdump_t klogd_t mount_t 
> rshd_t sshd_t udev_t fsdaemon_t sssd_selinux_manager_t load_policy_t 
> remote_login_t secadm_wm_t readahead_t system_dbusd_t staff_wm_t 
> setfiles_t semanage_t consoletype_t auditctl_t rlogind_t vbetool_t } ==  
> ||  t2 { cupsd_var_run_t sssd_var_lib_t kvm_device_t null_device_t 
> zero_device_t system_dbusd_var_run_t devlog_t devtty_t tmpfs_t xdm_t 
> vhost_device_t httpd_bool_t tun_tap_device_t faillog_t setrans_t 
> qemu_var_run_t anon_inodefs_t setrans_var_run_t crond_t cupsd_t ptmx_t 
> *sshd_t* sssd_t virt_log_t system_dbusd_t proc_numa_t security_t 
> initctl_t sudo_db_t syslogd_t xserver_t } ==  || );

Due to your kernel/policy version, the attribute names aren't preserved 
in the binary policy constraints so the above is the expanded list of 
types instead of showing the attribute name used in the source policy. 
You can see the attribute name in the source policy from the .src.rpm or 
from the upstream refpolicy.  As noted above, sshd_t is exempted by the 
constraint so it isn't being confined for MLS file reads.

> Also I would like to understand about the precedence check by the 
> SELinux security server , assume if a *type is allowed* to read the file 
> by the mlsconstrain statements as shown above , then does the security 
> server check and compare for the security levels as well of the source 
> process and the destination ? (In this case the apache process runs in 
> *s4-s5:c1,c2 *, the linux user running the curl is mapped on SELinux 
> user *s4-s5:c1,c2 *and the php file : /var/www/html/info.php is on *s0:c3 *)

The permission has to first be allowed by a TE allow rule, and then any 
constraints on the permission are evaluated and the permission is only 
allowed if all such constraints evaluate to true.  This constraint 
includes the dominance comparison. In source form, the constraint is:
# the file "read" ops (note the check is dominance of the low level)
mlsconstrain { file } { read getattr execute }
         (( l1 dom l2 ) or
          (( t1 == mlsfilereadtoclr ) and ( h1 dom l2 )) or
          ( t1 == mlsfileread ) or
          ( t2 == mlstrustedobject ));

which means:
File read/getattr/execute permission are only allowed if:
1) the process low-level (l1) dominates the file low-level (l2), or
2) the process type (t1) has the mlsfilereadtoclr (read-up-to-clearance) 
atttribute and the process high-level (h1) dominates the file low-level 
(l2), or
3) the process type (t1) has the mlsfileread (read-up) attribute, or
4) the file type (t2) has the mlstrustedobject (e.g. /dev/null) attribute.

> **
> 
> So in that case , any suggestions to bypass the constrain rule ?
> 
> I tried to create a new SELinux role so that it has no types at all 
> (This didn't work though as it gets the selinux types for *user_u* for 
> some reason) . Then I was planning to add just 1 new type (eg: 
> testuser_t) and then map this new 'type' to the new SELinux role and 
> then map this role to a Linux User . So in that case the Linux User will 
> have one single type accessible and then I can run the 'curl' command on 
> the apache endpoint to see if the Bell Lapadula condition works :) .

You would just need apache to run in its own domain (or any other domain 
that lacks mlsfileread).  The problem you are currently having is that 
it is running in sshd's domain.
