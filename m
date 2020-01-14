Return-Path: <SRS0=4X/7=3D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B20C33CB3
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0237424680
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZxBwRGTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgANNpn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:45:43 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:29484 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgANNpn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jan 2020 08:45:43 -0500
X-EEMSG-check-017: 45399883|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,432,1571702400"; 
   d="scan'208";a="45399883"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Jan 2020 13:45:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579009539; x=1610545539;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=9ciYWaVEG1j8SySI71yYWvR5xTMzz30/XqWKy24aMdE=;
  b=ZxBwRGTs0KQcXRu1l0FTDx7T57FIeOgmsnu09dSDM/QFsrUwJMlM+Nwi
   85Mjc/pGnOp8es4h2LrUVQFL8MoId/pdbrF8GiZ8MueorFWUYIhm7Wu1o
   EUbOODOBvjxhx6oofHLk7pfU/eGU3Y5vqtxugfPsnbZXcelbMNMmanFJ1
   egYzRfdUKmmdt+XVq69zvDhkPyNz2Lhx+25AR88ND2u2oaRLTgkcRYW29
   Tqqid7HVfgiCgMDR5sgKYPYkpRAoYGb1peV3wx6FDIYvZ/y/Tkt1TfL5x
   KdI0qokxMfbI+GmreBTe/aqxHKtcaNGOXXxRrdapF7n5352fLpB7FYi3V
   w==;
X-IronPort-AV: E=Sophos;i="5.69,432,1571702400"; 
   d="scan'208";a="31920155"
IronPort-PHdr: =?us-ascii?q?9a23=3A48Ybnx97GLw09v9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+sXIJqq85mqBkHD//Il1AaPAdyHraocwLGL++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMnYduNqk9xx?=
 =?us-ascii?q?XJr3BVf+ha2X5kKUickhrh6Mq85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2?=
 =?us-ascii?q?VfQslRVjRBAoKiYIsJE+oBJvtTo43kq1cTsReyGQygCeXhxT9Sgn/9wLM03e?=
 =?us-ascii?q?IvHwrb2AAsBtwDvXDRoNjzKawcU/26zLPQwDvecf1W1zfz5ovGfB8vrv6DX6?=
 =?us-ascii?q?5/f8XKxEkzFQ7IlEmcpZDrMj6X0OkGrmiV7/BnVeKqk2Mpth1xrSa3xscslI?=
 =?us-ascii?q?bJgJ8exE3B9SpjxIY1IcO3SU5matOjC5tfqjqaOpBqQsIiX25ouCE6xqcAuZ?=
 =?us-ascii?q?6gZicG0psnxxnBa/GedYWD/xztVOGUIThihXJlfqqyhxWs/ki6zO3zSM203E?=
 =?us-ascii?q?xNripfndnBsG0G2R/L6sWfV/dw8Uis1SyP2gzO8O1IP085mbTBJ5I8xLM7i4?=
 =?us-ascii?q?Advl7ZHiDsnUX7lKqWdkI59ee28+nnebDmpoOEN49zlwH+LrwimsyhDuQ8NQ?=
 =?us-ascii?q?gDR3Sb9v6m1L3i4E35W69GjvwwkqnXt5DaPtoUqbKjDw9J0ocs9xa/DzC83N?=
 =?us-ascii?q?QegXYHN05KdAiCj4joP1HCOPH4DfGhjFSwiDpn2v/LM7L7DpjNM3TPiqntcL?=
 =?us-ascii?q?lj50JG1QY/1dVf6IhVCrEFLvLzQEjxtNnAAx8iLgO02P3qCMl914wCWWKPBb?=
 =?us-ascii?q?WVMKXJsVCS/O4vLO6MZJENtDbnN/cl/+LujWM+mVIFZ6mp3IcYaHCiEfR8Pk?=
 =?us-ascii?q?qWeWbjjc8BEWgQvwo+SvLliEaZXDFIe3ayXqQ85i0lB4K8C4fMWJytjKad0y?=
 =?us-ascii?q?e8G51cfnpGBUyUEXf0a4WEXO8BaDmMLc9lkzwEU6WhSoA62BGwuw/11aBnIv?=
 =?us-ascii?q?DX+iIGr5Lj0sZ65+nJmRE17zx0AJfV72bYdWB/nmoSS3cW1aF5rFc1nk2C2q?=
 =?us-ascii?q?hxmfBvHutT7vJPXxwSP4LdyfB3Edb/RkTKedLfDB69T9GnBywhZsw+zsVIYE?=
 =?us-ascii?q?tnHdimyBfZ0HmEGbgQwoeXCYQ0/6SU5H34I8Jw2j6Sz6U6p0U3SctIc2u9j+?=
 =?us-ascii?q?hw8BaFVN2BqFmQi6v/LfdU5yXK7mrWiDPV7Uw=3D?=
X-IPAS-Result: =?us-ascii?q?A2BmAADJxB1e/wHyM5BfBhoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBe4F4BYEYVSASKoQNiQOGbQaBN4EBiG2RSQkBAQEBAQEBAQEtC?=
 =?us-ascii?q?gEBhEACgiE4EwIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgnoBBSMVUQsYAgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJjPwGCSgMJJQ+rYoEyhDQBgRSDUIE3BoEOKIwzeYEHgREnD?=
 =?us-ascii?q?4IoNT6CG4Iggx6CPCIEjUEKiHphRnqWWIJCgkmEc45rBhuabY5biFyULCKBW?=
 =?us-ascii?q?CsIAhgIIQ+DKE8YDVeHMwMXiGSFXSMDMQGNHwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Jan 2020 13:45:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00EDixvK140576;
        Tue, 14 Jan 2020 08:44:59 -0500
Subject: Re: [PATCH V4 0/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200114122804.321628-1-richard_c_haines@btinternet.com>
 <f483648a-7687-8388-917d-c2520b8f3bd6@tycho.nsa.gov>
 <5302118848ee1846e9c6010e93c163dd40547fd0.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <bdf3b824-341a-9b56-9cf6-fa256dd422ef@tycho.nsa.gov>
Date:   Tue, 14 Jan 2020 08:46:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <5302118848ee1846e9c6010e93c163dd40547fd0.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/14/20 8:39 AM, Richard Haines wrote:
> On Tue, 2020-01-14 at 08:30 -0500, Stephen Smalley wrote:
>> On 1/14/20 7:28 AM, Richard Haines wrote:
>>> These tests should cover all the areas in selinux/hooks.c that
>>> touch
>>> the 'filesystem' class. Each hooks.c function is listed in the
>>> 'test'
>>> script as there are some permissions that are checked in multiple
>>> places.
>>>
>>> Tested on Fedora 31 and Rawhide (5.5 for the new watch perm).
>>>
>>> V4 Changes:
>>> 1) Test non-name based type transition rule.
>>> 2) Test two different name-based type transition rules that only
>>> differ
>>>      in name.
>>
>> Sorry, I guess my wording was confusing.  What I meant was that the
>> inputs to the two name-based type transition rules were identical
>> except
>> for the name, but you would want them to have different
>> output/result
>> types so that you can tell whether it actually distinguished them.
> 
> So would this be ok as policy rules:
> 
> type_transition test_filesystem_t test_filesystem_t:file
> test_filesystem_filenametranscon1_t "name_trans_test_file1";
> type_transition test_filesystem_t test_filesystem_t:file
> test_filesystem_filenametranscon2_t "name_trans_test_file2";

Yes.  It looks a little odd in that usually the source context is a 
process context and the target context is a parent directory context so 
it is unusual that they'd be the same in any real-world policy 
(generally that would only happen for /proc/pid and you can't create 
files there).  But I guess that's a side effect of the way the other 
tests work / using context mounts?

> 
> 
>>
>>> 3) Creating ext4 filesystems with inodes > 128 bytes using -I 256.
>>> 4) Use kernel_setsched() macro.
>>>
>>> V3 Changes:
>>> 1) Lots of minor updates.
>>> 2) Add 'udevadm settle' as suggested by Ondrej to resolve udisks(8)
>>> issue.
>>> 3) Add stopping udisks(8) daemon as a '-d' option.
>>> 4) Add file quotaon test.
>>> 5) Add test for name type_transition rule.
>>> 6) Fix setfscreatecon(3) test to create a directory and check
>>> context.
>>> 7) Use kernel_dontaudit_setsched() as explained in [1].
>>>
>>> [1]
>>> https://lore.kernel.org/selinux/f863a91987c1926a4351f3edf968c9003197fead.camel@btinternet.com/
>>>
>>> V2 Changes:
>>> 1) If udisks(8) daemon is running, stop then restart after tests.
>>> The tests
>>>      run faster and stops the annoying habit of adding mounts to the
>>> 'files'
>>>      app on the desktop. Supports /usr/bin/systemctl or
>>> /usr/sbin/service
>>>      More importantly it stops interferance with the '*context='
>>> tests as it
>>>      can cause intermittent failures. Tested by running 'test' in a
>>> continuous
>>>      loop with udisks enabled, and then again disabled.
>>>      Loop 200 times, with udisks failed between 1 to 70 iterations,
>>> without
>>>      udisks, no failures.
>>> 2) Add "#define QFMT_VFS_V0 2" to quotas_test.c to fix a
>>> RHEL/CentOS 7 and
>>>      below build issue.
>>> 3) Build new file context based on the original in
>>>      create_file_change_context.c
>>> 4) Use "runcon `id -Z` quotacheck ..." to resolve RHEL-6 test run
>>> issue.
>>> 5) Fix free() contexts in create_file_change_context.c and
>>>      check_mount_context.c
>>>
>>> To test fanotify fs watch perm on 5.5+:
>>> 1) Build the testsuite policy first:
>>> make -C policy load
>>>
>>> 2) Add the following CIL statements to watch.cil and install:
>>> semodule -i watch.cil
>>>
>>> (common filesystem (watch))
>>> (classcommon filesystem filesystem)
>>> (allow test_filesystem_t self(filesystem (watch)))
>>> ; Until 'fs_watch_all_fs(test_filesystem_t)' in Policy use:
>>> (allow test_filesystem_t fs_t (filesystem (watch)))
>>> ; Required if notify policy enabled
>>> ;(allow test_filesystem_t self (dir (watch_sb)))
>>>
>>> 3) Edit /usr/share/selinux/devel/include/support/all_perms.spt
>>>      and insert the 'watch' permission at:
>>>
>>> define(`all_filesystem_perms',`{ mount remount ..... watch }')
>>>
>>> Richard Haines (1):
>>>     selinux-testsuite: Add filesystem tests
>>>
>>>    defconfig                                     |   6 +
>>>    policy/Makefile                               |   4 +
>>>    policy/test_filesystem.te                     | 356 +++++++
>>>    tests/Makefile                                |   7 +
>>>    tests/filesystem/.gitignore                   |  11 +
>>>    tests/filesystem/Makefile                     |  16 +
>>>    tests/filesystem/check_file_context.c         |  75 ++
>>>    tests/filesystem/check_mount_context.c        | 127 +++
>>>    tests/filesystem/create_file.c                | 117 +++
>>>    tests/filesystem/create_file_change_context.c | 146 +++
>>>    tests/filesystem/fanotify_fs.c                |  79 ++
>>>    tests/filesystem/fs_relabel.c                 | 138 +++
>>>    tests/filesystem/grim_reaper.c                |  89 ++
>>>    tests/filesystem/mount.c                      | 130 +++
>>>    tests/filesystem/quotas_test.c                | 143 +++
>>>    tests/filesystem/statfs_test.c                |  65 ++
>>>    tests/filesystem/test                         | 941
>>> ++++++++++++++++++
>>>    tests/filesystem/umount.c                     |  84 ++
>>>    18 files changed, 2534 insertions(+)
>>>    create mode 100644 policy/test_filesystem.te
>>>    create mode 100644 tests/filesystem/.gitignore
>>>    create mode 100644 tests/filesystem/Makefile
>>>    create mode 100644 tests/filesystem/check_file_context.c
>>>    create mode 100644 tests/filesystem/check_mount_context.c
>>>    create mode 100644 tests/filesystem/create_file.c
>>>    create mode 100644 tests/filesystem/create_file_change_context.c
>>>    create mode 100644 tests/filesystem/fanotify_fs.c
>>>    create mode 100644 tests/filesystem/fs_relabel.c
>>>    create mode 100644 tests/filesystem/grim_reaper.c
>>>    create mode 100644 tests/filesystem/mount.c
>>>    create mode 100644 tests/filesystem/quotas_test.c
>>>    create mode 100644 tests/filesystem/statfs_test.c
>>>    create mode 100755 tests/filesystem/test
>>>    create mode 100644 tests/filesystem/umount.c
>>>
> 

