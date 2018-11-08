Return-Path: <SRS0=8Fqr=NT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AB8ECDE4B
	for <selinux@archiver.kernel.org>; Thu,  8 Nov 2018 13:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88982081D
	for <selinux@archiver.kernel.org>; Thu,  8 Nov 2018 13:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88982081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeKHX0K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:26:10 -0500
Received: from ucol19pa09.eemsg.mail.mil ([214.24.24.82]:44466 "EHLO
        ucol19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeKHX0K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Nov 2018 18:26:10 -0500
X-EEMSG-check-008: 790430158|UCOL19PA09_EEMSG_MP7.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,478,1534809600"; 
   d="scan'208";a="790430158"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Nov 2018 13:50:34 +0000
X-IronPort-AV: E=Sophos;i="5.54,478,1534809600"; 
   d="scan'208";a="17671220"
IronPort-PHdr: =?us-ascii?q?9a23=3AVze12x02/Bw4Cs4esmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWLfrxwZ3uMQTl6Ol3ixeRBMOHs60C07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwdFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9Qr4uWT?=
 =?us-ascii?q?Sm8qxlVhnmhikaPDI96W3blNB8gKddrRm8pRJw3pTUbZmIOvRgcKPTfdAUS2?=
 =?us-ascii?q?RPUcleVSNOHoyyYpATD+cCJ+tUs5XxqlUMoBa4GAKiBPnvyjhNhnLuwKM6z/?=
 =?us-ascii?q?ouERnG3AM+GdIFrWnarNDvO6cWVeC60qnJxijEYvNNxDj985PFcgwhoP6QXb?=
 =?us-ascii?q?JwdtDdyU80FwzflFmQpovlPy2M2+kLrmOV4e1gVee1hG4mrQF8ujivxtswio?=
 =?us-ascii?q?nRm40V0krE9SJlz4krPt24U1R7YcOiEJtWtiGaMYR2QsIkQ2F0uCY11KYGuY?=
 =?us-ascii?q?W7fCcX1JQo2hnfa/mdfIiJ5BLvTv2RITB+iXl4e7y/nw6//VWvx+DzTMW50E?=
 =?us-ascii?q?tGojBbntTDqHwBzQHf586aQfVn5EihwyyA1wXL5+FBJkA7iLTUJoY6wr41ip?=
 =?us-ascii?q?oTqUPDHjLqmEnujK+ZaEEk+u+w5uT7eLrmvJ6cN5Jvig3kLqQvmtCwAeQ/Mg?=
 =?us-ascii?q?QUWWiU5f+826H58U38QbVKiuU6kqjfsJ/EOcQWvrO1DgBa34o56xuzEi2q3M?=
 =?us-ascii?q?oXkHUZNl5JZQqLj43zNFHPJPD4A+2/g1OpkDpz3PDJI6bhD47RLnnDjLjhfb?=
 =?us-ascii?q?F951RayAoo199T/Z1UCrYfIP7rQE/+qMTYDgMlMwyz2+vnEtJ91pgeWW2VBK?=
 =?us-ascii?q?+WLrnesV6T5uIvOeaMfpUatS3yK/gg/fHujHs5lUUBcqmu2JsdcGq4Eeh+I0?=
 =?us-ascii?q?WFfXrshc8MEXwUsQo6TezqjkCCUDFIanasUKIz+Cs7BJilDYjdXICthqKO3C?=
 =?us-ascii?q?OhEp1RfGBGBUiGEW30eIWcR/cMdCWSL9d8nT0KT7ehT5Qh1RG1uQ/g1bVoM+?=
 =?us-ascii?q?rU9TcEtZ75yNd14OjTnwko9TNoF8Sdz32NT2Zsk2MMWT82xrpwrldjxVifyq?=
 =?us-ascii?q?V4meJXGsFT5/xTTgc2L4LTz+t/C9rqQALOYs+JSEq6QtWhGTwxVsg+w8IKY0?=
 =?us-ascii?q?tmA9WtlA3D3y6zD78QkLyLA4Y0/bzG03ftIMZ9ziWO6K50rkImS9FGfUOrnK?=
 =?us-ascii?q?h28QTUT9rTlF6ZnqCnM6UH3CfX/U+MyGOPuAdTVwsmAovfWnVKXVfbtdT04A?=
 =?us-ascii?q?v5SraqDbk2el9axdWqNrpBatqvi05PAvjkJoKNMCqKh26sCEPQlfu3Z43wdj?=
 =?us-ascii?q?BYhn3Q?=
X-IPAS-Result: =?us-ascii?q?A2AaAABSPuRb/wHyM5BjGwEBAQEDAQEBBwMBAQGBUwQBA?=
 =?us-ascii?q?QELAYFaKWZPM4QflBJNAQQGgQgtiRKOIBSBZjgBhEACgxUiNgsNAQMBAQEBA?=
 =?us-ascii?q?QECAWwogjYkgmEBBSMECwEFQRAJAg4KAgISAQEMBgICVwYNCAEBgl4/AYF0D?=
 =?us-ascii?q?YwBm1B7M4NAgXyEcIELim4XeYEHgTiCa4RGgQACBYI1glcCiHwDDoZrTo8CC?=
 =?us-ascii?q?Y0ig24GGJBsmToNJIFVKwgCGAghD4MogiYXjjohA4E1AQGKGw0VAoInAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 08 Nov 2018 13:50:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wA8DoXgf009027;
        Thu, 8 Nov 2018 08:50:33 -0500
Subject: Re: SELinux MLS for Apache Process
To:     Ishara Fernando <roshane.ishara@gmail.com>
Cc:     selinux@vger.kernel.org, dwalsh@redhat.com, selinux@tycho.nsa.gov,
        lvrabec@redhat.com, paul@paul-moore.com
References: <CAOQ2Cef9DMjJeFf2wwhaLx54mLDsHdTRouie4gXQJ3B7qZe7_g@mail.gmail.com>
 <ddc4e042-522f-4aa2-84a3-15af58c95e3b@tycho.nsa.gov>
 <CAOQ2CedQ5_3txFSDOw4HRmtJeBvnESVGDpK0zpzr_6L2aKaLkQ@mail.gmail.com>
 <34369eaf-4f99-91c5-c69d-a28de6cf39d8@tycho.nsa.gov>
 <CAOQ2Cee3_K+g-KLh4eSeU9vbTVqz9fPAujN81GM0P7OVXKFb8w@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ae6c2f1a-de02-07e3-49ef-7df43116cd94@tycho.nsa.gov>
Date:   Thu, 8 Nov 2018 08:52:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAOQ2Cee3_K+g-KLh4eSeU9vbTVqz9fPAujN81GM0P7OVXKFb8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/8/18 8:33 AM, Ishara Fernando wrote:
> Dear Stephen ,
> 
> Many thanks for the detailed information , it has been very useful . 
> Infact I have tested your steps in a similar environment (CentOS 6.10 , 
> see versions below) as of yours in a Virtual machine based on 
> Virtualbox  , I have reached to the step where the *selinux module is 
> installed* on doing the range transition to enforce httpd to run on 
> s4-s5:c1,c2 .
> 
> Unfortunately I still see the range transition denied errors in the 
> audit logs (After installing the selinux module) and I do not see any 
> errors related to *httpd trying to perform writes* on various 
> directories/files that are labeled s0 as per your explanation .
> 
> Kindly see the details below
> 
> [root@msc-ishara-system1 ~]# sestatus -v
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   enforcing
> Mode from config file:          enforcing
> Policy version:                 24
> Policy from config file:        mls
> 
> Process contexts:
> Current context:                staff_u:sysadm_r:sysadm_t:s4-s5:c1,c2
> Init context:                   system_u:system_r:init_t:s0-s15:c0.c1023
> /sbin/mingetty                  system_u:system_r:getty_t:s0-s15:c0.c1023
> /usr/sbin/sshd                  system_u:system_r:sshd_t:s0-s15:c0.c1023
> 
> File contexts:
> Controlling term:               staff_u:object_r:user_devpts_t:s4
> /etc/passwd                     system_u:object_r:etc_t:s0
> /etc/shadow                     system_u:object_r:shadow_t:s0
> /bin/bash                       system_u:object_r:shell_exec_t:s0
> /bin/login                      system_u:object_r:login_exec_t:s0
> /bin/sh                         system_u:object_r:bin_t:s0 -> 
> system_u:object_r:shell_exec_t:s0
> /sbin/agetty                    system_u:object_r:getty_exec_t:s0
> /sbin/init                      system_u:object_r:init_exec_t:s0
> /sbin/mingetty                  system_u:object_r:getty_exec_t:s0
> /usr/sbin/sshd                  system_u:object_r:sshd_exec_t:s0
> 
> 
> 
> Dist: CentOS release 6.10 (Final)
> Kernel : 2.6.32-754.6.3.el6.x86_64
> SELinux MLS Policy RPM: selinux-policy-mls-3.7.19-312.el6.noarch
> SELinux Policy version: 24
> 
> 
> [root@msc-ishara-system1 ~]# id -Z
> staff_u:sysadm_r:sysadm_t:s4-s5:c1,c2

This is the problem - you switched levels before running run_init.
And run_init tries to do an explicit transition to the context 
configured in /etc/selinux/$SELINUXTYPE/contexts/initrc_context.  Just 
leave your shell in s0-s15:c0.1023, and let the range_transition rule 
handle transitioning httpd into s4-s5:c1,c2 for you automatically.

> 
> 
> [root@msc-ishara-system1 ~]# ls -lZ /usr/sbin/httpd
> -rwxr-xr-x. root root system_u:object_r:httpd_exec_t:s0 /usr/sbin/httpd
> 
> 
> 
> [root@msc-ishara-system1 ~]# which run_init
> /usr/sbin/run_init
> [root@msc-ishara-system1 ~]# ls -lZ /usr/sbin/run_init
> -rwxr-xr-x. root root system_u:object_r:run_init_exec_t:s0 
> /usr/sbin/run_init
> 
> 
> 
> [root@msc-ishara-system1 /]# cat httpdtrans.te
> policy_module(httpdtrans, 1.0)
> 
> require {
>          type initrc_t;
>          type httpd_exec_t;
>          type httpd_t;
> }
> 
> range_transition initrc_t httpd_exec_t:process s4 - s5:c1,c2;
> 
> mls_rangetrans_source(initrc_t)
> mls_rangetrans_target(httpd_t)
> 
> 
> 
> [root@msc-ishara-system1 /]# semodule -l | grep -i httpd
> httpdtrans    1.0
> 
> 
> 
> [root@msc-ishara-system1 ~]# sesearch --type | grep -i initrc_t | grep 
> -i httpd_exec
>     type_transition initrc_t httpd_exec_t : process httpd_t;
> 
> 
> [root@msc-ishara-system1 ~]# id -Z
> staff_u:sysadm_r:sysadm_t:s4-s5:c1,c2
> 
> 
> [root@msc-ishara-system1 ~]# run_init /etc/init.d/httpd start
> Authenticating root.
> Password:
> execvp: Permission denied
> 
> 
> [root@msc-ishara-system1 ~]# ausearch -i -m AVC -ts recent
> ----
> type=SYSCALL msg=audit(11/08/2018 18:32:36.457:160) : arch=x86_64 
> syscall=execve success=no exit=-13(Permission denied) a0=0x7ffd2309581a 
> a1=0x7ffd230949b0 a2=0x7ffd230949c8 a3=0x7ffd23094610 items=0 ppid=1802 
> pid=3074 auid=root uid=root gid=root euid=root suid=root fsuid=root 
> egid=root sgid=root fsgid=root tty=pts0 ses=3 comm=run_init 
> exe=/usr/sbin/run_init subj=staff_u:sysadm_r:run_init_t:s4-s5:c1,c2 
> key=(null)
> type=AVC msg=audit(11/08/2018 18:32:36.457:160) :*avc:  denied  { 
> transition } f*or  pid=3074 comm=run_init path=/etc/rc.d/init.d/httpd 
> dev=dm-0 ino=262967 scontext=staff_u:sysadm_r:run_init_t:s4-s5:c1,c2 
> tcontext=system_u:system_r:initrc_t:s0-s15:c0.c1023 tclass=process
> 
> 
> [root@msc-ishara-system1 /]# cat  /var/log/audit/audit.log | grep -i 
> httpd | grep -i write
> [root@msc-ishara-system1 /]#
> 
> [root@msc-ishara-system1 /]# cat  /var/log/audit/audit.log | grep -i 
> httpd | grep -i append
> [root@msc-ishara-system1 /]#
> 
> 
> 
> I followed all your steps but not sure whether I have missed something 
> which I still couldn't point out
> 
> 
> Also regarding the constraint rules , now I understand how it works 
> after your explanation about the httpd process running in the sshd_t 
> domain :) . So therefore I have installed the SRC rpm to see the types 
> for mlsfileread attribute to understand how it works .
> 
> 
> [root@msc-ishara-system1 serefpolicy-3.7.19]# cd 
> /root/rpmbuild/BUILD/serefpolicy-3.7.19
> 
> [root@msc-ishara-system1 serefpolicy-3.7.19]# grep -ir 'mlsfileread' 
> ./tmp/all_te_files.conf  | grep -v toclr | sed -e 's/typeattribute//g' | 
> sed -e 's/mlsfileread//g' | sed -e 's/attribute//g' | grep -i ssh
> *     sshd_t ;*
> 
> 
> So in that case If i have understood it right , I need to run the httpd 
> process in a domain (type) which does NOT belong to the 'mlsfileread' 
> attribute right ? Can we have it done using the same "httpdtrans.te" 
> file you shared ?

Just getting it running in httpd_t would suffice.  Or you could just run 
the equivalent test for your own custom network daemon running in user_t 
or any other domains that doesn't have mlsfileread.

