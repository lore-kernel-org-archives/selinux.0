Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862DCC43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 14:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34111206A5
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 14:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="XRZcxPMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfLPOJX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:09:23 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:23740 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfLPOJW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 09:09:22 -0500
X-EEMSG-check-017: 38533622|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,321,1571702400"; 
   d="scan'208";a="38533622"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Dec 2019 14:09:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576505357; x=1608041357;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=3wxClXhBuXNA2kJ0rmw97vK0A2me77cygJ3VrM4zEKM=;
  b=XRZcxPMljE2f4irHKEcRVTi98lcxqcsI8NwKsz6Uu2qVX3kNLHRszjLZ
   bpQvZJRwOFB2qjxmS+wP+RChPffW52DYW/gERI1F+diwsGB38cQQVQouV
   b2Y61b14IXQxnqZMpDsHMdHv8FLrCR7JaW0pGgzD3Tv/vhwtZLgtXMQ6n
   iawlGnqrkMjholoNLT4VGvm/dZf0vQ7gJriL336GPAJSORz5x9E7p0jk/
   bk7882KnINDoGsFLbEg4B0N4b07XOxl2mP5OcuEPi261uT0m6fgnMbjnI
   0JgW1e7WBO9vGDLseEoCe+tGQykOjRGW+D/5w/ZG6jYmU9F3PlaJki8uY
   w==;
X-IronPort-AV: E=Sophos;i="5.69,321,1571702400"; 
   d="scan'208";a="36782824"
IronPort-PHdr: =?us-ascii?q?9a23=3ALUP6yRD3HHTIdV5BB4ZSUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP37pM+wAkXT6L1XgUPTWs2DsrQY0rGQ6fi9EjJYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsswndqskbjYRjJ6ot1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTWJwuCsi17ELtp?=
 =?us-ascii?q?G2cDIKxZg63RLTdfOKf5aS7h7+UuuaPC12i2h/eL2lgha/6U2gyurhWcaqyF?=
 =?us-ascii?q?tKtS9FksXUtnAKyhzT9tCLSvtj8Uel3jaCzxzT5fteIUA1iKrbMIQtwr82lp?=
 =?us-ascii?q?odtkTDBTH5l1nsgK+KdkQr5uio6+P9brXgupCcLJN7hhv7MqQvnsyzGeU4Mg?=
 =?us-ascii?q?4QUGiH4emwybLu8ELjTLhKk/E6iLfVvZ/EKcgBu6K1GwpV3Zwi6xa7ATemyt?=
 =?us-ascii?q?MYnXwfIVJeZR2HlJPkO03OIf/kDfe/hE6gkDFwx//cJLHhDZLNLmbbnLf7Yb?=
 =?us-ascii?q?l981JcyBY0zd1H/ZJUC60OIPLpVU/rqdPXFgM2PBS0w+n9CdV90J0RWXmUD6?=
 =?us-ascii?q?CCLKPSsFmI5v4xLOmWYo8apir9J+I56P7piH8zgUUdcrWx3ZsLdHC4GexrI1?=
 =?us-ascii?q?6Hbnrog9cBF3oKvwUlQez0h12NTyRTa2yxX60i/DE7DpypDYPZSoCqmryB0z?=
 =?us-ascii?q?+xHodKaWBeFlCMDXDoep2DW/cJbyKSOclhnSYYWre/UIIhzw+huxL6y7V9Mu?=
 =?us-ascii?q?rY4DEXtZXm1Is92+qGrxA59TVuA4y92mCLQno8ynkJTD8/xqxIqnt9w1aF3L?=
 =?us-ascii?q?NQieBZE8Be/fVETkExMpuKi6RhBtTzXB/RVsmGRUzgQdi8Bzw1CNUrzJtGRE?=
 =?us-ascii?q?BxAdigxjXExCyjCLIW3+iMAZsv9KvX0lDrKsp9wmqA364k2QoIWMxKYFa6i7?=
 =?us-ascii?q?Z/+g6bPIvAl0GUhu7+bqgH9DLc/2eEi2yVtQdXVxAmAvaNZmwWekaD9Yex3U?=
 =?us-ascii?q?jFVbL7TO18YwY=3D?=
X-IPAS-Result: =?us-ascii?q?A2DnAACgjvdd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gRhVIBIqhASJA4VpAYEMBoESJYEBiGmRRQkBAQEBAQEBAQEjFAEBh?=
 =?us-ascii?q?EACgjg4EwIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgnoBBRoBCBVRCxgCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBgl8/AYJGAwklrhSBMoVPgzqBSIEOKIwyeYEHgREnDAOCKDU+g?=
 =?us-ascii?q?huCExssgmSCPCIEjTWJVEZ3ljSCPoI/hGqOVgYbgkN0i0OLTo5MgUabFCKBW?=
 =?us-ascii?q?CsIAhgIIQ87gmwJRxEUjR4XhVmIaCMDMI1mgWFfAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Dec 2019 14:09:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBGE8s6X143779;
        Mon, 16 Dec 2019 09:08:55 -0500
Subject: Re: [RFC PATCH 1/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
References: <20191215170620.73506-1-richard_c_haines@btinternet.com>
 <20191215170620.73506-2-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ace92ec4-2276-9af8-bb52-c942d0be7605@tycho.nsa.gov>
Date:   Mon, 16 Dec 2019 09:09:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191215170620.73506-2-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/15/19 12:06 PM, Richard Haines wrote:
> Test filesystem permissions using mount(2)/umount(2).
> 
>  From kernels 5.5 filesystem { watch } is also tested.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

This didn't pass travis-ci, looks like a combination of failing 
check-syntax and FAN_MARK_FILESYSTEM not being defined (maybe the kernel 
headers are too old in the base distro?).

> ---
>   defconfig                     |   6 +
>   policy/Makefile               |   4 +
>   policy/test_mount.te          | 235 ++++++++++++++
>   tests/Makefile                |   4 +
>   tests/mount/.gitignore        |   7 +
>   tests/mount/Makefile          |   7 +
>   tests/mount/fanotify_test.c   |  77 +++++
>   tests/mount/grim_reaper.c     |  63 ++++
>   tests/mount/may_create_test.c | 121 +++++++
>   tests/mount/mount.c           | 130 ++++++++
>   tests/mount/quotas_test.c     | 134 ++++++++
>   tests/mount/statfs_test.c     |  65 ++++
>   tests/mount/test              | 579 ++++++++++++++++++++++++++++++++++
>   tests/mount/umount.c          |  85 +++++
>   tests/mount/watch.cil         |   7 +
>   15 files changed, 1524 insertions(+)
>   create mode 100644 policy/test_mount.te
>   create mode 100644 tests/mount/.gitignore
>   create mode 100644 tests/mount/Makefile
>   create mode 100644 tests/mount/fanotify_test.c
>   create mode 100644 tests/mount/grim_reaper.c
>   create mode 100644 tests/mount/may_create_test.c
>   create mode 100644 tests/mount/mount.c
>   create mode 100644 tests/mount/quotas_test.c
>   create mode 100644 tests/mount/statfs_test.c
>   create mode 100755 tests/mount/test
>   create mode 100644 tests/mount/umount.c
>   create mode 100644 tests/mount/watch.cil
> 
> diff --git a/defconfig b/defconfig
> index 3bea332..c8d4762 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -88,3 +88,9 @@ CONFIG_TUN=m
>   CONFIG_HAVE_PERF_EVENTS=y
>   CONFIG_PERF_EVENTS=y
>   CONFIG_TRACEPOINTS=y
> +
> +# Test mounting filesystems and their quotas.
> +# This is not required for SELinux operation itself.
> +CONFIG_BLK_DEV_LOOP=m
> +CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
> +CONFIG_QFMT_V2=y
> diff --git a/policy/Makefile b/policy/Makefile
> index f0de669..932909f 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -109,6 +109,10 @@ ifeq ($(shell grep -q perf_event $(POLDEV)/include/support/all_perms.spt && echo
>   TARGETS += test_perf_event.te
>   endif
>   
> +ifeq ($(shell grep -q filesystem $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +TARGETS += test_mount.te
> +endif
> +
>   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
>   endif
> diff --git a/policy/test_mount.te b/policy/test_mount.te
> new file mode 100644
> index 0000000..affaf00
> --- /dev/null
> +++ b/policy/test_mount.te
> @@ -0,0 +1,235 @@
> +#
> +######### Test mount filesystem policy module ##########
> +#
> +attribute mountdomain;
> +
> +################# Test all functions ##########################
> +type test_mount_t;
> +domain_type(test_mount_t)
> +unconfined_runs_test(test_mount_t)
> +typeattribute test_mount_t testdomain;
> +typeattribute test_mount_t mountdomain;
> +
> +allow test_mount_t self:capability { sys_admin };
> +allow test_mount_t self:filesystem { mount remount quotamod relabelfrom relabelto unmount quotaget };
> +allow test_mount_t self:dir { mounton add_name write };
> +allow test_mount_t test_file_t:dir { mounton write remove_name rmdir };
> +# Create test file
> +allow test_mount_t self:dir { add_name write };
> +allow test_mount_t self:file { create relabelfrom relabelto };
> +
> +fs_mount_all_fs(test_mount_t)
> +fs_remount_all_fs(test_mount_t)
> +fs_unmount_all_fs(test_mount_t)
> +fs_relabelfrom_all_fs(test_mount_t)
> +fs_get_xattr_fs_quotas(test_mount_t)
> +files_search_all(test_mount_t)
> +# Required for mount opts "rootcontext=system_u:object_r:test_mount_t:s0";
> +fs_associate(test_mount_t)
> +fs_getattr_xattr_fs(test_mount_t)
> +
> +# For running quotacheck(8)
> +files_type(test_mount_t)
> +# Update quotas
> +fs_set_all_quotas(test_mount_t)
> +allow test_mount_t self:file { quotaon };
> +# Create test file and change context:
> +allow test_mount_t test_mount_no_getattr_t:file { open read relabelto write };
> +dontaudit test_mount_t kernel_t:process { setsched };
> +
> +#################### Deny filesystem { getattr } ######################
> +type test_mount_no_getattr_t;
> +domain_type(test_mount_no_getattr_t)
> +unconfined_runs_test(test_mount_no_getattr_t)
> +typeattribute test_mount_no_getattr_t testdomain;
> +typeattribute test_mount_no_getattr_t mountdomain;
> +
> +allow test_mount_no_getattr_t self:capability { sys_admin };
> +fs_mount_all_fs(test_mount_no_getattr_t)
> +fs_unmount_all_fs(test_mount_no_getattr_t)
> +fs_relabelfrom_all_fs(test_mount_no_getattr_t)
> +fs_associate(test_mount_no_getattr_t)
> +allow test_mount_no_getattr_t self:dir { mounton };
> +allow test_mount_no_getattr_t test_file_t:dir { mounton write remove_name rmdir };
> +dontaudit test_mount_no_getattr_t kernel_t:process { setsched };
> +
> +#################### Deny filesystem { remount } ######################
> +type test_mount_no_remount_t;
> +domain_type(test_mount_no_remount_t)
> +unconfined_runs_test(test_mount_no_remount_t)
> +typeattribute test_mount_no_remount_t testdomain;
> +typeattribute test_mount_no_remount_t mountdomain;
> +
> +allow test_mount_no_remount_t self:capability { sys_admin };
> +fs_mount_all_fs(test_mount_no_remount_t)
> +fs_unmount_all_fs(test_mount_no_remount_t)
> +fs_relabelfrom_all_fs(test_mount_no_remount_t)
> +fs_associate(test_mount_no_remount_t)
> +allow test_mount_no_remount_t self:dir { mounton };
> +allow test_mount_no_remount_t test_file_t:dir { mounton write remove_name rmdir };
> +dontaudit test_mount_no_remount_t kernel_t:process { setsched };
> +
> +#################### Deny filesystem { mount } ######################
> +type test_mount_no_mount_t;
> +domain_type(test_mount_no_mount_t)
> +unconfined_runs_test(test_mount_no_mount_t)
> +typeattribute test_mount_no_mount_t testdomain;
> +typeattribute test_mount_no_mount_t mountdomain;
> +
> +allow test_mount_no_mount_t self:capability { sys_admin };
> +fs_relabelfrom_all_fs(test_mount_no_mount_t)
> +fs_associate(test_mount_no_mount_t)
> +allow test_mount_no_mount_t self:dir { mounton };
> +allow test_mount_no_mount_t test_file_t:dir { mounton write remove_name rmdir };
> +dontaudit test_mount_no_mount_t kernel_t:process { setsched };
> +
> +#################### Deny filesystem { unmount } ######################
> +type test_mount_no_unmount_t;
> +domain_type(test_mount_no_unmount_t)
> +unconfined_runs_test(test_mount_no_unmount_t)
> +typeattribute test_mount_no_unmount_t testdomain;
> +typeattribute test_mount_no_unmount_t mountdomain;
> +
> +allow test_mount_no_unmount_t self:capability { sys_admin };
> +fs_mount_all_fs(test_mount_no_unmount_t)
> +fs_relabelfrom_all_fs(test_mount_no_unmount_t)
> +fs_associate(test_mount_no_unmount_t)
> +allow test_mount_no_unmount_t self:dir { mounton };
> +allow test_mount_no_unmount_t test_file_t:dir { mounton write remove_name rmdir };
> +dontaudit test_mount_no_unmount_t kernel_t:process { setsched };
> +
> +#################### Deny filesystem { relabelfrom } ######################
> +type test_mount_no_relabelfrom_t;
> +domain_type(test_mount_no_relabelfrom_t)
> +unconfined_runs_test(test_mount_no_relabelfrom_t)
> +typeattribute test_mount_no_relabelfrom_t testdomain;
> +typeattribute test_mount_no_relabelfrom_t mountdomain;
> +
> +allow test_mount_no_relabelfrom_t self:capability { sys_admin };
> +fs_associate(test_mount_no_relabelfrom_t)
> +allow test_mount_no_relabelfrom_t self:dir { mounton };
> +allow test_mount_no_relabelfrom_t test_file_t:dir { mounton write remove_name rmdir };
> +dontaudit test_mount_no_relabelfrom_t kernel_t:process { setsched };
> +
> +#################### Deny filesystem { relabelto } ######################
> +type test_mount_no_relabelto_t;
> +domain_type(test_mount_no_relabelto_t)
> +unconfined_runs_test(test_mount_no_relabelto_t)
> +typeattribute test_mount_no_relabelto_t testdomain;
> +typeattribute test_mount_no_relabelto_t mountdomain;
> +
> +allow test_mount_no_relabelto_t self:capability { sys_admin };
> +fs_mount_all_fs(test_mount_no_relabelto_t)
> +fs_relabelfrom_all_fs(test_mount_no_relabelto_t)
> +fs_associate(test_mount_no_relabelto_t)
> +allow test_mount_no_relabelto_t self:dir { mounton };
> +allow test_mount_no_relabelto_t test_file_t:dir { mounton write remove_name rmdir };
> +dontaudit test_mount_no_relabelto_t kernel_t:process { setsched };
> +
> +#################### Deny filesystem { associate } ######################
> +type test_mount_no_associate_t;
> +type test_mount_no_associate1_t;
> +domain_type(test_mount_no_associate_t)
> +unconfined_runs_test(test_mount_no_associate_t)
> +typeattribute test_mount_no_associate_t testdomain;
> +typeattribute test_mount_no_associate_t mountdomain;
> +
> +allow test_mount_no_associate_t self:capability { sys_admin };
> +allow test_mount_no_associate_t self:filesystem { relabelto mount relabelfrom };
> +fs_mount_all_fs(test_mount_no_associate_t)
> +fs_relabelfrom_all_fs(test_mount_no_associate_t)
> +allow test_mount_no_associate_t self:dir { mounton };
> +allow test_mount_no_associate_t test_file_t:dir { mounton write remove_name rmdir };
> +dontaudit test_mount_no_associate_t kernel_t:process { setsched };
> +
> +########## Deny filesystem { associate } for create file ################
> +type test_mount_no_associate_file_t;
> +domain_type(test_mount_no_associate_file_t)
> +unconfined_runs_test(test_mount_no_associate_file_t)
> +typeattribute test_mount_no_associate_file_t testdomain;
> +typeattribute test_mount_no_associate_file_t mountdomain;
> +
> +allow test_mount_no_associate_file_t self:capability { sys_admin };
> +allow test_mount_no_associate_file_t self:filesystem { mount relabelfrom relabelto unmount associate };
> +allow test_mount_no_associate_file_t self:dir { mounton add_name write };
> +allow test_mount_no_associate_file_t test_file_t:dir { mounton write remove_name rmdir };
> +
> +fs_mount_all_fs(test_mount_no_associate_file_t)
> +fs_unmount_all_fs(test_mount_no_associate_file_t)
> +fs_relabelfrom_all_fs(test_mount_no_associate_file_t)
> +fs_associate(test_mount_no_associate_file_t)
> +fs_getattr_xattr_fs(test_mount_no_associate_file_t)
> +dontaudit test_mount_no_associate_file_t kernel_t:process { setsched };
> +
> +# Create test file
> +allow test_mount_no_associate_file_t self:file { create relabelfrom relabelto };
> +############ hooks.c may_create() FILESYSTEM__ASSOCIATE #############
> +# FOR: neverallow unlabeled_t test_mount_no_associate_file_t:filesystem { associate };
> +allow test_mount_no_associate_file_t unconfined_t:file { open read write };
> +allow test_mount_no_associate_file_t unlabeled_t:dir { add_name search write };
> +allow test_mount_no_associate_file_t unlabeled_t:file { create open relabelfrom write };
> +############ hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE ##########
> +# FOR: neverallow unconfined_t test_mount_no_associate_file_t:filesystem { associate };
> +allow test_mount_no_associate_file_t unconfined_t:dir { add_name write };
> +allow test_mount_no_associate_file_t unconfined_t:file { create relabelfrom relabelto };
> +
> +#################### Deny filesystem { quotamod } ######################
> +type test_mount_no_quotamod_t;
> +domain_type(test_mount_no_quotamod_t)
> +unconfined_runs_test(test_mount_no_quotamod_t)
> +typeattribute test_mount_no_quotamod_t testdomain;
> +typeattribute test_mount_no_quotamod_t mountdomain;
> +
> +allow test_mount_no_quotamod_t self:capability { sys_admin };
> +allow test_mount_no_quotamod_t self:filesystem { quotaget relabelto mount unmount};
> +fs_mount_all_fs(test_mount_no_quotamod_t)
> +fs_relabelfrom_all_fs(test_mount_no_quotamod_t)
> +fs_associate(test_mount_no_quotamod_t)
> +# Required as $private_path to quota files
> +files_search_all(test_mount_no_quotamod_t)
> +allow test_mount_no_quotamod_t self:dir { mounton };
> +allow test_mount_no_quotamod_t test_file_t:dir { mounton write remove_name rmdir };
> +dontaudit test_mount_no_quotamod_t kernel_t:process { setsched };
> +
> +#################### Deny filesystem { quotaget } ######################
> +type test_mount_no_quotaget_t;
> +domain_type(test_mount_no_quotaget_t)
> +unconfined_runs_test(test_mount_no_quotaget_t)
> +typeattribute test_mount_no_quotaget_t testdomain;
> +typeattribute test_mount_no_quotaget_t mountdomain;
> +
> +allow test_mount_no_quotaget_t self:capability { sys_admin };
> +allow test_mount_no_quotaget_t self:filesystem { quotamod relabelto mount unmount relabelfrom };
> +allow test_mount_no_quotaget_t self:dir { mounton };
> +allow test_mount_no_quotaget_t test_file_t:dir { mounton write remove_name rmdir };
> +allow test_mount_no_quotaget_t self:file { quotaon };
> +fs_mount_all_fs(test_mount_no_quotaget_t)
> +fs_relabelfrom_all_fs(test_mount_no_quotaget_t)
> +fs_associate(test_mount_no_quotaget_t)
> +# Required as $private_path to quota files
> +files_search_all(test_mount_no_quotaget_t)
> +# For running quotacheck(8)
> +files_type(test_mount_no_quotaget_t)
> +dontaudit test_mount_no_quotaget_t kernel_t:process { setsched };
> +
> +#################### Deny filesystem { watch } ######################
> +type test_mount_no_watch_t;
> +domain_type(test_mount_no_watch_t)
> +unconfined_runs_test(test_mount_no_watch_t)
> +typeattribute test_mount_no_watch_t testdomain;
> +typeattribute test_mount_no_watch_t mountdomain;
> +
> +allow test_mount_no_watch_t self:capability { sys_admin };
> +allow test_mount_no_watch_t self:filesystem { associate relabelto mount unmount relabelfrom };
> +allow test_mount_no_watch_t self:dir { mounton };
> +allow test_mount_no_watch_t test_file_t:dir { mounton write remove_name rmdir };
> +fs_mount_all_fs(test_mount_no_watch_t)
> +fs_relabelfrom_all_fs(test_mount_no_watch_t)
> +fs_associate(test_mount_no_watch_t)
> +dontaudit test_mount_no_watch_t kernel_t:process { setsched };
> +
> +#
> +########### Allow these domains to be entered from sysadm domain ############
> +#
> +miscfiles_domain_entry_test_files(mountdomain)
> +userdom_sysadm_entry_spec_domtrans_to(mountdomain)
> diff --git a/tests/Makefile b/tests/Makefile
> index 9a890be..3b968d1 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -87,6 +87,10 @@ ifeq ($(shell grep -q perf_event $(POLDEV)/include/support/all_perms.spt && echo
>   SUBDIRS += perf_event
>   endif
>   
> +ifeq ($(shell grep -q filesystem $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +SUBDIRS += mount
> +endif
> +
>   ifeq ($(DISTRO),RHEL4)
>       SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
>   endif
> diff --git a/tests/mount/.gitignore b/tests/mount/.gitignore
> new file mode 100644
> index 0000000..d8f0df7
> --- /dev/null
> +++ b/tests/mount/.gitignore
> @@ -0,0 +1,7 @@
> +mount
> +umount
> +quotas_test
> +statfs_test
> +fanotify_test
> +may_create_test
> +grim_reaper
> diff --git a/tests/mount/Makefile b/tests/mount/Makefile
> new file mode 100644
> index 0000000..1f74425
> --- /dev/null
> +++ b/tests/mount/Makefile
> @@ -0,0 +1,7 @@
> +TARGETS = mount umount quotas_test statfs_test fanotify_test may_create_test grim_reaper
> +LDLIBS += -lselinux
> +
> +all: $(TARGETS)
> +
> +clean:
> +	rm -f $(TARGETS)
> diff --git a/tests/mount/fanotify_test.c b/tests/mount/fanotify_test.c
> new file mode 100644
> index 0000000..0dd60bf
> --- /dev/null
> +++ b/tests/mount/fanotify_test.c
> @@ -0,0 +1,77 @@
> +#define _GNU_SOURCE 1
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <sys/fanotify.h>
> +#include <selinux/selinux.h>
> +
> +static void print_usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-v] -t\n"
> +		"Where:\n\t"
> +		"-t  Target path\n\t"
> +		"-v  Print information.\n", progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int mask = FAN_OPEN, flags = FAN_MARK_ADD | FAN_MARK_FILESYSTEM;
> +	int fd, result, opt, save_err;
> +	char *context, *tgt = NULL;
> +	bool verbose = false;
> +
> +	while ((opt = getopt(argc, argv, "t:v")) != -1) {
> +		switch (opt) {
> +		case 't':
> +			tgt = optarg;
> +			break;
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			print_usage(argv[0]);
> +		}
> +	}
> +
> +	if (!tgt)
> +		print_usage(argv[0]);
> +
> +	if (verbose) {
> +		result = getcon(&context);
> +		if (result < 0) {
> +			fprintf(stderr, "Failed to obtain process context\n");
> +			exit(-1);
> +		}
> +		printf("Process context:\n\t%s\n", context);
> +		free(context);
> +	}
> +
> +	fd = fanotify_init(FAN_CLASS_CONTENT, O_RDWR);
> +	if (fd < 0) {
> +		fprintf(stderr, "fanotify_init(2) Failed: %s\n",
> +			strerror(errno));
> +		exit(-1);
> +	}
> +
> +	result = fanotify_mark(fd, flags, mask, AT_FDCWD, tgt);
> +	save_err = errno;
> +	if (result < 0) {
> +		fprintf(stderr, "fanotify_mark(2) Failed: %s\n",
> +			strerror(errno));
> +		close(fd);
> +		return save_err;
> +	}
> +
> +	if (verbose)
> +		printf("Set fanotify_mark(2) on filesystem: %s\n", tgt);
> +
> +	close(fd);
> +	return 0;
> +}
> diff --git a/tests/mount/grim_reaper.c b/tests/mount/grim_reaper.c
> new file mode 100644
> index 0000000..0105ab6
> --- /dev/null
> +++ b/tests/mount/grim_reaper.c
> @@ -0,0 +1,63 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <sys/mount.h>
> +#include <selinux/selinux.h>
> +
> +#define WAIT_COUNT 60
> +#define USLEEP_TIME 10000
> +
> +/* Remove any mounts associated with the loop device in argv[1] */
> +int main(int argc, char *argv[])
> +{
> +	FILE *fp;
> +	size_t len;
> +	ssize_t num;
> +	int index = 0, i, result = 0;
> +	char *mount_info[2];
> +	char *buf = NULL, *item;
> +
> +	if (!argv[1])
> +		return -1;
> +
> +	fp = fopen("/proc/mounts", "re");
> +	if (!fp) {
> +		fprintf(stderr, "Failed to open /proc/mounts: %s\n",
> +			strerror(errno));
> +		return -1;
> +	}
> +
> +	while ((num = getline(&buf, &len, fp)) != -1) {
> +		index = 0;
> +		item = strtok(buf, " ");
> +		while (item != NULL) {
> +			mount_info[index] = item;
> +			index++;
> +			if (index == 2)
> +				break;
> +			item = strtok(NULL, " ");
> +		}
> +
> +		if (strcmp(mount_info[0], argv[1]) == 0) {
> +			for (i = 0; i < WAIT_COUNT; i++) {
> +				result = umount(mount_info[1]);
> +				if (!result)
> +					break;
> +
> +				if (errno != EBUSY) {
> +					fprintf(stderr, "Failed umount(2): %s\n",
> +						strerror(errno));
> +					break;
> +				}
> +				usleep(USLEEP_TIME);
> +			}
> +		}
> +	}
> +
> +	free(buf);
> +	fclose(fp);
> +	return result;
> +}
> diff --git a/tests/mount/may_create_test.c b/tests/mount/may_create_test.c
> new file mode 100644
> index 0000000..9a99d8d
> --- /dev/null
> +++ b/tests/mount/may_create_test.c
> @@ -0,0 +1,121 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <linux/unistd.h>
> +#include <selinux/selinux.h>
> +#include <selinux/context.h>
> +
> +static void print_usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-v] -t -f\n"
> +		"Where:\n\t"
> +		"-t  Type for context of created file\n\t"
> +		"-f  File to create\n\t"
> +		"-v  Print information.\n", progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int opt, result, fd, save_err;
> +	char *context, *newcon, *orgfcon, *type = NULL, *file = NULL;
> +	bool verbose = false;
> +	context_t con_t;
> +
> +	while ((opt = getopt(argc, argv, "t:f:v")) != -1) {
> +		switch (opt) {
> +		case 't':
> +			type = optarg;
> +			break;
> +		case 'f':
> +			file = optarg;
> +			break;
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			print_usage(argv[0]);
> +		}
> +	}
> +
> +	if (!type || !file)
> +		print_usage(argv[0]);
> +
> +	result = getcon(&context);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain process context\n");
> +		exit(-1);
> +	}
> +
> +	/* Build new file context */
> +	con_t = context_new(context);
> +	if (!con_t) {
> +		fprintf(stderr, "Unable to create context structure\n");
> +		exit(-1);
> +	}
> +
> +	if (context_type_set(con_t, type)) {
> +		fprintf(stderr, "Unable to set new type\n");
> +		exit(-1);
> +	}
> +
> +	newcon = context_str(con_t);
> +	if (!newcon) {
> +		fprintf(stderr, "Unable to obtain new context string\n");
> +		exit(-1);
> +	}
> +
> +	if (verbose) {
> +		printf("Process context:\n\t%s\n", context);
> +		printf("is creating test file:\n\t%s\n", file);
> +		printf("and changing its context to:\n\t%s\n", newcon);
> +	}
> +
> +	/* hooks.c may_create() FILESYSTEM__ASSOCIATE */
> +	fd = creat(file, O_RDWR);
> +	save_err = errno;
> +	if (fd < 0) {
> +		fprintf(stderr, "creat(2) Failed: %s\n", strerror(errno));
> +		result = save_err;
> +		goto err;
> +	}
> +
> +	result = fgetfilecon(fd, &orgfcon);
> +	if (result < 0) {
> +		fprintf(stderr, "fgetfilecon(3) Failed: %s\n", strerror(errno));
> +		result = -1;
> +		goto err;
> +	}
> +
> +	if (verbose)
> +		printf("Current test file context is: %s\n", orgfcon);
> +
> +	free(orgfcon);
> +
> +	/* hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE */
> +	result = fsetfilecon(fd, newcon);
> +	save_err = errno;
> +	if (result < 0) {
> +		fprintf(stderr, "fsetfilecon(3) Failed: %s\n", strerror(errno));
> +		result = save_err;
> +		goto err;
> +	}
> +
> +	fd = open(file, O_RDWR);
> +	if (fd < 0) {
> +		fprintf(stderr, "open(2) Failed: %s\n", strerror(errno));
> +		result = -1;
> +	}
> +
> +err:
> +	free(context);
> +	free(newcon);
> +	close(fd);
> +	return result;
> +
> +}
> diff --git a/tests/mount/mount.c b/tests/mount/mount.c
> new file mode 100644
> index 0000000..034f0ec
> --- /dev/null
> +++ b/tests/mount/mount.c
> @@ -0,0 +1,130 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <sys/mount.h>
> +#include <selinux/selinux.h>
> +
> +static void print_usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-s src] -t tgt [-f fs_type] [-o options] [-bmprv]\n"
> +		"Where:\n\t"
> +		"-s  Source path\n\t"
> +		"-t  Target path\n\t"
> +		"-f  Filesystem type\n\t"
> +		"-o  Options list (comma separated list)\n\t"
> +		"Zero or one of the following flags:\n\t"
> +		"\t-b  MS_BIND\n\t"
> +		"\t-m  MS_MOVE\n\t"
> +		"\t-p  MS_PRIVATE\n\t"
> +		"\t-r  MS_REMOUNT\n\t"
> +		"-v  Print information.\n", progname);
> +	exit(-1);
> +}
> +
> +static int ck_mount(char *mntpoint)
> +{
> +	int result = 0;
> +	FILE *fp;
> +	size_t len;
> +	ssize_t num;
> +	char *buf = NULL;
> +
> +	fp = fopen("/proc/mounts", "re");
> +	if (fp == NULL) {
> +		fprintf(stderr, "Failed to open /proc/mounts: %s\n",
> +			strerror(errno));
> +		return -1;
> +	}
> +
> +	while ((num = getline(&buf, &len, fp)) != -1) {
> +		if (strstr(buf, mntpoint) != NULL) {
> +			result = 1;
> +			break;
> +		}
> +	}
> +
> +	free(buf);
> +	fclose(fp);
> +	return result;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int opt, result, save_err, flags = 0;
> +	char *context, *src = NULL, *tgt = NULL, *fs_type = NULL, *opts = NULL;
> +	bool verbose = false;
> +
> +	while ((opt = getopt(argc, argv, "s:t:f:o:pbmrv")) != -1) {
> +		switch (opt) {
> +		case 's':
> +			src = optarg;
> +			break;
> +		case 't':
> +			tgt = optarg;
> +			break;
> +		case 'f':
> +			fs_type = optarg;
> +			break;
> +		case 'o':
> +			opts = optarg;
> +			break;
> +		case 'b':
> +			flags = MS_BIND;
> +			break;
> +		case 'p':
> +			flags = MS_PRIVATE;
> +			break;
> +		case 'm':
> +			flags = MS_MOVE;
> +			break;
> +		case 'r':
> +			flags = MS_REMOUNT;
> +			break;
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			print_usage(argv[0]);
> +		}
> +	}
> +
> +	if (!tgt)
> +		print_usage(argv[0]);
> +
> +	if (verbose) {
> +		result = getcon(&context);
> +		if (result < 0) {
> +			fprintf(stderr, "Failed to obtain process context\n");
> +			return -1;
> +		}
> +		printf("Process context:\n\t%s\n", context);
> +		free(context);
> +	}
> +
> +	if (verbose)
> +		printf("Mounting\n\tsrc: %s\n\ttgt: %s\n\tfs_type: %s flags: 0x%x\n\topts: %s\n",
> +		       src, tgt, fs_type, flags, opts);
> +
> +	result = mount(src, tgt, fs_type, flags, opts);
> +	save_err = errno;
> +	if (result < 0) {
> +		fprintf(stderr, "Failed mount(2): %s\n", strerror(errno));
> +		return save_err;
> +	}
> +
> +	if (flags == MS_MOVE) {
> +		if (!ck_mount(src) && ck_mount(tgt)) {
> +			if (verbose)
> +				printf("MS_MOVE: Moved mountpoint\n");
> +		} else {
> +			fprintf(stderr, "MS_MOVE: Move mountpoint failed\n");
> +			return -1;
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/tests/mount/quotas_test.c b/tests/mount/quotas_test.c
> new file mode 100644
> index 0000000..34aaca9
> --- /dev/null
> +++ b/tests/mount/quotas_test.c
> @@ -0,0 +1,134 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <sys/quota.h>
> +#include <selinux/selinux.h>
> +
> +static void print_usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s -s src -t tgt\n"
> +		"Where:\n\t"
> +		"-s  Source path (e.g. /dev/loop0)\n\t"
> +		"-t  Target quota file (Full path with either 'aquota.user'\n\t"
> +		"    or 'aquota.group' appended)\n\t"
> +		"-v  Print information.\n", progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int opt, result, qcmd, save_err, test_id = geteuid();
> +	char *context, *src = NULL, *tgt = NULL;
> +	bool verbose = false;
> +	char fmt_buf[2];
> +
> +	while ((opt = getopt(argc, argv, "s:t:v")) != -1) {
> +		switch (opt) {
> +		case 's':
> +			src = optarg;
> +			break;
> +		case 't':
> +			tgt = optarg;
> +			break;
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			print_usage(argv[0]);
> +		}
> +	}
> +
> +	if (!src || !tgt)
> +		print_usage(argv[0]);
> +
> +	if (verbose) {
> +		result = getcon(&context);
> +		if (result < 0) {
> +			fprintf(stderr, "Failed to obtain process context\n");
> +			return -1;
> +		}
> +		printf("Process context:\n\t%s\n", context);
> +		free(context);
> +	}
> +
> +	if (strstr(tgt, "aquota.user") != NULL) {
> +		qcmd = QCMD(Q_QUOTAON, USRQUOTA);
> +		result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> +		save_err = errno;
> +		if (result < 0) {
> +			fprintf(stderr, "quotactl(Q_QUOTAON, USRQUOTA) Failed: %s\n",
> +				strerror(errno));
> +			return save_err;
> +		}
> +		if (verbose)
> +			printf("User Quota - ON\n");
> +
> +		qcmd = QCMD(Q_GETFMT, USRQUOTA);
> +		result = quotactl(qcmd, src, test_id, fmt_buf);
> +		save_err = errno;
> +		if (result < 0) {
> +			fprintf(stderr, "quotactl(Q_GETFMT, USRQUOTA) Failed: %s\n",
> +				strerror(errno));
> +			return save_err;
> +		}
> +		if (verbose)
> +			printf("User Format: 0x%x\n", fmt_buf[0]);
> +
> +		qcmd = QCMD(Q_QUOTAOFF, USRQUOTA);
> +		result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> +		save_err = errno;
> +		if (result < 0) {
> +			fprintf(stderr, "quotactl(Q_QUOTAOFF, USRQUOTA) Failed: %s\n",
> +				strerror(errno));
> +			return save_err;
> +		}
> +		if (verbose)
> +			printf("User Quota - OFF\n");
> +
> +		return 0;
> +
> +	} else if (strstr(tgt, "aquota.group") != NULL) {
> +		qcmd = QCMD(Q_QUOTAON, GRPQUOTA);
> +		result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> +		save_err = errno;
> +		if (result < 0) {
> +			fprintf(stderr, "quotactl(Q_QUOTAON, GRPQUOTA) Failed: %s\n",
> +				strerror(errno));
> +			return save_err;
> +		}
> +		if (verbose)
> +			printf("Group Quota - ON\n");
> +
> +		qcmd = QCMD(Q_GETFMT, GRPQUOTA);
> +		result = quotactl(qcmd, src, test_id, fmt_buf);
> +		save_err = errno;
> +		if (result < 0) {
> +			fprintf(stderr, "quotactl(Q_GETFMT, GRPQUOTA) Failed: %s\n",
> +				strerror(errno));
> +			return save_err;
> +		}
> +		if (verbose)
> +			printf("Group Format: 0x%x\n", fmt_buf[0]);
> +
> +		qcmd = QCMD(Q_QUOTAOFF, GRPQUOTA);
> +		result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> +		save_err = errno;
> +		if (result < 0) {
> +			fprintf(stderr, "quotactl(Q_QUOTAOFF, GRPQUOTA) Failed: %s\n",
> +				strerror(errno));
> +			return save_err;
> +		}
> +		if (verbose)
> +			printf("Group Quota - OFF\n");
> +
> +		return 0;
> +	}
> +
> +	fprintf(stderr, "Required %s to specify 'aquota.user' or 'aquota.group' file\n",
> +		tgt);
> +	return -1;
> +}
> diff --git a/tests/mount/statfs_test.c b/tests/mount/statfs_test.c
> new file mode 100644
> index 0000000..5de49b1
> --- /dev/null
> +++ b/tests/mount/statfs_test.c
> @@ -0,0 +1,65 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <sys/statfs.h>
> +#include <selinux/selinux.h>
> +
> +static void print_usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-v] -t\n"
> +		"Where:\n\t"
> +		"-t  Target path\n\t"
> +		"-v  Print information.\n", progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int opt, result, save_err;
> +	char *context, *tgt = NULL;
> +	bool verbose = false;
> +	struct statfs statfs_t;
> +
> +	while ((opt = getopt(argc, argv, "t:v")) != -1) {
> +		switch (opt) {
> +		case 't':
> +			tgt = optarg;
> +			break;
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			print_usage(argv[0]);
> +		}
> +	}
> +
> +	if (!tgt)
> +		print_usage(argv[0]);
> +
> +	if (verbose) {
> +		result = getcon(&context);
> +		if (result < 0) {
> +			fprintf(stderr, "Failed to obtain process context\n");
> +			return -1;
> +		}
> +		printf("Process context:\n\t%s\n", context);
> +		free(context);
> +	}
> +
> +	result = statfs(tgt, &statfs_t);
> +	save_err = errno;
> +	if (result < 0) {
> +		fprintf(stderr, "statfs(2) Failed: %s\n", strerror(errno));
> +		return save_err;
> +	}
> +
> +	if (verbose)
> +		printf("statfs(2) returned magic filesystem: 0x%lx\n",
> +		       statfs_t.f_type);
> +
> +	return 0;
> +}
> diff --git a/tests/mount/test b/tests/mount/test
> new file mode 100755
> index 0000000..90c5a7c
> --- /dev/null
> +++ b/tests/mount/test
> @@ -0,0 +1,579 @@
> +#!/usr/bin/perl
> +use Test::More;
> +
> +BEGIN {
> +    $basedir = $0;
> +    $basedir =~ s|(.*)/[^/]*|$1|;
> +
> +    $test_count = 41;
> +
> +    # Allow info to be shown.
> +    $v = $ARGV[0];
> +    if ($v) {
> +        if ( $v ne "-v" ) {
> +            plan skip_all => "Invalid option (use -v)";
> +        }
> +    }
> +    else {
> +        $v = " ";
> +    }
> +
> +    # From kernel 5.5 support for fanotify(7) with filesystem { watch }
> +    $kvercur = `uname -r`;
> +    chomp($kvercur);
> +    $kverminstream = "5.5";
> +
> +    $result = `$basedir/../kvercmp $kvercur $kverminstream`;
> +    if ( $result > 0 ) {
> +        $test_watch = 1;
> +        $test_count += 4;
> +    }
> +
> +    plan tests => $test_count;
> +}
> +
> +# context     - Useful when mounting filesystems that do not support extended
> +#               attributes
> +# fscontext   - Sets the overarching filesystem label to a specific security
> +#               context. This filesystem label is separate from the individual
> +#               labels on the files.
> +# defcontext  - Set default security context for unlabeled files.
> +#               This overrides the value set for unlabeled files in policy
> +#               and requires a filesystem that supports xattr labeling.
> +# rootcontext - Explicitly label the root inode of the filesystem being
> +#               mounted before that filesystem or inode becomes visible
> +#               to userspace.
> +
> +# mount(2) MS_BIND | MS_PRIVATE requires an absolute path to a private mount
> +# point before MS_MOVE
> +$cwd = `pwd 2>/dev/null`;
> +chomp($cwd);
> +$private_path = "$cwd";
> +if ( $basedir eq "." ) {
> +    $private_path = "$cwd/mntpoint";
> +}
> +else {
> +    $private_path = "$cwd/$basedir/mntpoint";
> +}
> +
> +# Set filesystem type
> +$fs_type = "ext4";
> +
> +# For list of devices used
> +$device_count = 0;
> +
> +sub make_fs {
> +    print "Create $basedir/fstest with dd\n";
> +    $result = system(
> +        "dd if=/dev/zero of=$basedir/fstest bs=1024 count=10240 2>/dev/null");
> +    if ( $result != 0 ) {
> +        print "dd failed to create fstest\n";
> +        exit -1;
> +    }
> +
> +    print "Finding free /dev/loop entry\n";
> +    $dev = `losetup -f 2>/dev/null`;
> +    chomp($dev);
> +    if ( $dev eq "" ) {
> +        print "losetup failed to obtain /dev/loop entry\n";
> +        cleanup();
> +        exit -1;
> +    }
> +
> +    # Keep list of devices for cleanup later
> +    if ( $device_count eq 0 ) {
> +        $device_list[$device_count] = $dev;
> +        $device_count += 1;
> +    }
> +    elsif ( $dev ne $device_list[ $device_count - 1 ] ) {
> +            $device_list[$device_count] = $dev;
> +            $device_count += 1;
> +    }
> +
> +    print "Attaching $basedir/fstest to $dev\n";
> +    $result = system("losetup $dev $basedir/fstest 2>/dev/null");
> +    if ( $result != 0 ) {
> +        print "Failed to attach $basedir/fstest to $dev\n";
> +        cleanup();
> +        exit -1;
> +    }
> +
> +    print "Make $fs_type filesystem on $dev\n";
> +    $result = system("mkfs.$fs_type $dev >& /dev/null");
> +    if ( $result != 0 ) {
> +        system("losetup -d $dev 2>/dev/null");
> +        cleanup();
> +        print "mkfs.$fs_type failed to create filesystem on $dev\n";
> +        exit -1;
> +    }
> +}
> +
> +sub mk_mntpoint_1 {
> +    system("rm -rf $private_path/mp1 2>/dev/null");
> +    system("mkdir -p $private_path/mp1 2>/dev/null");
> +}
> +
> +sub mk_mntpoint_2 {
> +    system("rm -rf $private_path/mp2 2>/dev/null");
> +    system("mkdir -p $private_path/mp2 2>/dev/null");
> +}
> +
> +sub cleanup {
> +    system("rm -rf $basedir/fstest 2>/dev/null");
> +    system("rm -rf $basedir/mntpoint 2>/dev/null");
> +}
> +
> +sub cleanup1 {
> +    system("losetup -d $dev 2>/dev/null");
> +    system("rm -rf $basedir/fstest 2>/dev/null");
> +    system("rm -rf $basedir/mntpoint 2>/dev/null");
> +}
> +
> +############### Test Basic Mount/Unmount ##########################
> +cleanup();
> +mk_mntpoint_1();
> +make_fs();
> +$mount_opts1 =
> +  "quota,usrquota,grpquota,defcontext=system_u:object_r:test_mount_t:s0";
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$mount_opts1\n";
> +$result = system(
> +"runcon -t test_mount_t $basedir/mount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts1 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Then remount\n";
> +$result = system(
> +"runcon -t test_mount_t $basedir/mount -r -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts1 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Running quotacheck(8) to init user/group quota files\n";
> +$result = system("quotacheck -ugF vfsv0 $private_path/mp1");
> +ok( $result eq 0 );
> +
> +print "Toggle User & Group quotas on/off\n";
> +$result = system(
> +"runcon -t test_mount_t $basedir/quotas_test -s $dev -t $private_path/mp1/aquota.user $v"
> +);
> +ok( $result eq 0 );
> +$result = system(
> +"runcon -t test_mount_t $basedir/quotas_test -s $dev -t $private_path/mp1/aquota.group $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Get statfs(2)\n";
> +$result =
> +  system("runcon -t test_mount_t $basedir/statfs_test -t $basedir/mntpoint $v");
> +ok( $result eq 0 );
> +
> +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> +$result =
> +  system(
> +"runcon -t test_mount_t $basedir/may_create_test -t test_mount_no_getattr_t -f $private_path/mp1/test_file $v"
> +  );
> +ok( $result eq 0 );
> +
> +if ($test_watch) {
> +    print "fanotify(7) test\n";
> +    $result = system(
> +"runcon -t test_mount_t $basedir/fanotify_test $v -t $basedir/mntpoint/mp1"
> +    );
> +    ok( $result eq 0 );
> +}
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result =
> +  system("runcon -t test_mount_t $basedir/umount -t $private_path/mp1 $v");
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Test Move Mount ##########################
> +make_fs();
> +$mount_opts2 =
> +  "quota,usrquota,grpquota,rootcontext=system_u:object_r:test_mount_t:s0";
> +system("mkdir -p $private_path 2>/dev/null");
> +
> +print "Set mount MS_BIND on filesystem\n";
> +$result = system(
> +"runcon -t test_mount_t $basedir/mount -s $private_path -t $private_path -b $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Set mount MS_PRIVATE on filesystem\n";
> +$result =
> +  system("runcon -t test_mount_t $basedir/mount -t $private_path -p $v");
> +ok( $result eq 0 );
> +
> +mk_mntpoint_1();
> +mk_mntpoint_2();
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$mount_opts2\n";
> +$result = system(
> +"runcon -t test_mount_t $basedir/mount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts2 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Set mount MS_MOVE on filesystem\n";
> +$result = system(
> +"runcon -t test_mount_t $basedir/mount -s $private_path/mp1 -t $private_path/mp2 -m  $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp2\n";
> +$result =
> +  system("runcon -t test_mount_t $basedir/umount -t $private_path/mp2 $v");
> +ok( $result eq 0 );
> +
> +print "Unmount filesystem from $basedir/mntpoint\n";
> +$result = system("runcon -t test_mount_t $basedir/umount -t $private_path $v");
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { relabelfrom } ##########################
> +# hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELFROM
> +
> +$opts_no_relabelfrom =
> +"defcontext=system_u:object_r:test_mount_no_relabelfrom_t:s0,fscontext=system_u:object_r:test_mount_no_relabelfrom_t:s0";
> +mk_mntpoint_1();
> +make_fs();
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_relabelfrom\n";
> +$result = system(
> +"runcon -t test_mount_no_relabelfrom_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelfrom $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { relabelto } ##########################
> +# hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELTO
> +
> +$opts_no_relabelto = "fscontext=system_u:object_r:test_mount_no_relabelto_t:s0";
> +mk_mntpoint_1();
> +make_fs();
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_relabelto\n";
> +$result = system(
> +"runcon -t test_mount_no_relabelto_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelto $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { relabelfrom } ##########################
> +# hooks.c may_context_mount_inode_relabel() FILESYSTEM__RELABELFROM
> +
> +$opts_no_relabelfrom =
> +  "rootcontext=system_u:object_r:test_mount_no_relabelfrom_t:s0";
> +mk_mntpoint_1();
> +make_fs();
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_relabelfrom\n";
> +$result = system(
> +"runcon -t test_mount_no_relabelfrom_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelfrom $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { associate } ##########################
> +# hooks.c may_context_mount_inode_relabel() FILESYSTEM__ASSOCIATE
> +
> +$opts_no_associate =
> +"defcontext=system_u:object_r:test_mount_no_associate_t:s0,fscontext=system_u:object_r:test_mount_no_associate_t:s0";
> +mk_mntpoint_1();
> +make_fs();
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_associate\n";
> +$result = system(
> +"runcon -t test_mount_no_associate_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { associate } ##########################
> +# hooks.c may_create() FILESYSTEM__ASSOCIATE
> +cleanup();
> +mk_mntpoint_1();
> +make_fs();
> +$opts_no_associate_file =
> +  "fscontext=system_u:object_r:test_mount_no_associate_file_t:s0";
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_associate_file\n";
> +$result = system(
> +"runcon -t test_mount_no_associate_file_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate_file $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> +$result =
> +  system(
> +"runcon -t test_mount_no_associate_file_t $basedir/may_create_test -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
> +  );
> +ok( $result >> 8 eq 13 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result =
> +  system(
> +"runcon -t test_mount_no_associate_file_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +  );
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { quotamod } ##########################
> +# hooks.c selinux_quotactl() FILESYSTEM__QUOTAMOD
> +
> +$opts_no_quotamod =
> +"quota,usrquota,grpquota,fscontext=system_u:object_r:test_mount_no_quotamod_t:s0";
> +mk_mntpoint_1();
> +make_fs();
> +system("mkdir -p $private_path 2>/dev/null");
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_quotamod\n";
> +$result = system(
> +"runcon -t test_mount_no_quotamod_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotamod $v 2>&1"
> +);
> +ok( $result eq 0 );
> +
> +# No need to run quotacheck(8) as never gets far enough to read quota file
> +print "Toggle User & Group quotas on/off\n";    # Must have full path
> +$result = system(
> +"runcon -t test_mount_no_quotamod_t $basedir/quotas_test -s $dev -t $private_path/mp1/aquota.user $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result = system(
> +"runcon -t test_mount_no_quotamod_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { quotaget } ##########################
> +# hooks.c selinux_quotactl() FILESYSTEM__QUOTAGET
> +
> +$opts_no_quotaget =
> +"quota,usrquota,grpquota,context=system_u:object_r:test_mount_no_quotaget_t:s0";
> +mk_mntpoint_1();
> +make_fs();
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_quotaget\n";
> +$result = system(
> +"runcon -t test_mount_no_quotaget_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotaget $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Running quotacheck(8) to init user/group quota files\n";
> +$result = system("quotacheck -ugF vfsv0 $private_path/mp1");
> +ok( $result eq 0 );
> +
> +print "Toggle User & Group quotas on/off\n";    # Must have full path
> +$result = system(
> +"runcon -t test_mount_no_quotaget_t $basedir/quotas_test -s $dev -t $private_path/mp1/aquota.user $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result = system(
> +"runcon -t test_mount_no_quotaget_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { mount } ##########################
> +# hooks.c selinux_sb_kern_mount() FILESYSTEM__MOUNT
> +
> +$opts_no_mount = "rootcontext=system_u:object_r:test_mount_no_mount_t:s0";
> +mk_mntpoint_1();
> +make_fs();
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_mount\n";
> +$result = system(
> +"runcon -t test_mount_no_mount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_mount $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { getattr } ##########################
> +# hooks.c selinux_sb_statfs() FILESYSTEM__GETATTR
> +
> +$opts_no_getattr = "rootcontext=system_u:object_r:test_mount_no_getattr_t:s0";
> +mk_mntpoint_1();
> +make_fs();
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_getattr\n";
> +$result = system(
> +"runcon -t test_mount_no_getattr_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_getattr $v"
> +);
> +ok( $result eq 0 );
> +
> +$result = system(
> +"runcon -t test_mount_no_getattr_t $basedir/statfs_test -t $basedir/mntpoint $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result = system(
> +"runcon -t test_mount_no_getattr_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { remount } ##########################
> +# hooks.c selinux_mount() FILESYSTEM__REMOUNT
> +
> +$opts_no_remount = "rootcontext=system_u:object_r:test_mount_no_remount_t:s0";
> +mk_mntpoint_1();
> +make_fs();
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_remount\n";
> +$result = system(
> +"runcon -t test_mount_no_remount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_remount $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Then remount\n";
> +$result = system(
> +"runcon -t test_mount_no_remount_t $basedir/mount -r -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_remount $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result = system(
> +"runcon -t test_mount_no_remount_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { unmount } ##########################
> +# hooks.c selinux_umount() FILESYSTEM__UNMOUNT
> +
> +$opts_no_unmount = "rootcontext=system_u:object_r:test_mount_no_unmount_t:s0";
> +mk_mntpoint_1();
> +make_fs();
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_unmount\n";
> +$result = system(
> +"runcon -t test_mount_no_unmount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_unmount $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result = system(
> +"runcon -t test_mount_no_unmount_t $basedir/umount -t $basedir/mntpoint/mp1 $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +# Make sure it does get unmounted
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result =
> +  system("runcon -t test_mount_t $basedir/umount -t $basedir/mntpoint/mp1 $v");
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { associate }  ##########################
> +# hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE
> +cleanup();
> +mk_mntpoint_1();
> +make_fs();
> +$opts_no_associate_file =
> +"defcontext=system_u:object_r:test_mount_no_associate_file_t:s0,fscontext=system_u:object_r:test_mount_no_associate_file_t:s0";
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_associate_file\n";
> +$result = system(
> +"runcon -t test_mount_no_associate_file_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate_file $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> +$result =
> +  system(
> +"runcon -t test_mount_no_associate_file_t $basedir/may_create_test -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
> +  );
> +ok( $result >> 8 eq 13 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result =
> +  system(
> +"runcon -t test_mount_no_associate_file_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +  );
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { watch }  ##########################
> +# hooks.c selinux_path_notify() FILESYSTEM__WATCH
> +if ($test_watch) {
> +    cleanup();
> +    mk_mntpoint_1();
> +    make_fs();
> +    $opts_no_watch = "context=system_u:object_r:test_mount_no_watch_t:s0";
> +
> +    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +    print "Using mount options:\n\t$opts_no_watch\n";
> +    $result = system(
> +"runcon -t test_mount_no_watch_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_watch $v"
> +    );
> +    ok( $result eq 0 );
> +
> +    print "test_fanotify\n";
> +    $result = system(
> +"runcon -t test_mount_no_watch_t $basedir/fanotify_test $v -t $basedir/mntpoint/mp1 2>&1"
> +    );
> +    ok( $result >> 8 eq 13 );
> +
> +    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +    $result = system(
> +"runcon -t test_mount_no_watch_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +    );
> +    ok( $result eq 0 );
> +
> +    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +    cleanup1();
> +}
> +
> +# Cleanup any attached /dev/loop entries
> +foreach my $n (@device_list) {
> +    system("$basedir/grim_reaper $n 2>/dev/null");
> +}
> +
> +exit;
> diff --git a/tests/mount/umount.c b/tests/mount/umount.c
> new file mode 100644
> index 0000000..50bb3fc
> --- /dev/null
> +++ b/tests/mount/umount.c
> @@ -0,0 +1,85 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <sys/mount.h>
> +#include <selinux/selinux.h>
> +
> +static void print_usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-v] [-t]\n"
> +		"Where:\n\t"
> +		"-t  Target path\n\t"
> +		"-v  Print information.\n", progname);
> +	exit(-1);
> +}
> +
> +#define WAIT_COUNT 60
> +#define USLEEP_TIME 100000
> +
> +int main(int argc, char *argv[])
> +{
> +	char *context, *tgt = NULL;
> +	int opt, result, i, save_err;
> +	bool verbose = false;
> +
> +	while ((opt = getopt(argc, argv, "t:v")) != -1) {
> +		switch (opt) {
> +		case 't':
> +			tgt = optarg;
> +			break;
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			print_usage(argv[0]);
> +		}
> +	}
> +
> +	if (!tgt)
> +		print_usage(argv[0]);
> +
> +	if (verbose) {
> +		result = getcon(&context);
> +		if (result < 0) {
> +			fprintf(stderr, "Failed to obtain process context\n");
> +			exit(-1);
> +		}
> +		printf("Process context:\n\t%s\n", context);
> +		free(context);
> +	}
> +
> +	/*
> +	 * umount(2) will sometimes return EBUSY when other tasks are
> +	 * checking mounts so wait around before bailing out.
> +	 */
> +	for (i = 0; i < WAIT_COUNT; i++) {
> +		result = umount(tgt);
> +		save_err = errno;
> +		if (!result) {
> +			if (verbose)
> +				printf("Unmounted: %s\n", tgt);
> +
> +			return 0;
> +		}
> +
> +		if (verbose && save_err == EBUSY)
> +			printf("umount(2) returned EBUSY %d times\n",
> +			       i + 1);
> +
> +		if (save_err != EBUSY) {
> +			fprintf(stderr, "Failed umount(2): %s\n",
> +				strerror(save_err));
> +			return save_err;
> +		}
> +		usleep(USLEEP_TIME);
> +	}
> +
> +	fprintf(stderr, "Failed to umount(2) after %d retries with: %s\n",
> +		WAIT_COUNT, strerror(save_err));
> +
> +	return save_err;
> +}
> diff --git a/tests/mount/watch.cil b/tests/mount/watch.cil
> new file mode 100644
> index 0000000..14d41ab
> --- /dev/null
> +++ b/tests/mount/watch.cil
> @@ -0,0 +1,7 @@
> +(common filesystem (watch))
> +(classcommon filesystem filesystem)
> +
> +(allow test_mount_t self(filesystem (watch)))
> +
> +; Until 'fs_watch_all_fs(test_mount_t)' in Policy use:
> +(allow test_mount_t fs_t (filesystem (watch)))
> 

