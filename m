Return-Path: <SRS0=Wrvk=XF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C317C49ED7
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 14:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C400021670
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 14:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="TE5CzAwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfIJO4i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:56:38 -0400
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:18433 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730707AbfIJO4i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Sep 2019 10:56:38 -0400
X-EEMSG-check-017: 26233810|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,489,1559520000"; 
   d="scan'208";a="26233810"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Sep 2019 14:54:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568127269; x=1599663269;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EdwCCpoqafLAyV3KlAsNSApl5IVaCnHx82wVGgG4/KE=;
  b=TE5CzAwV3LGVfzMV8linBsw15QqIlmy4i1zQNmAQ90qq89zOwaziT2Uo
   b+qxn7iOgVy4s/Pw9ebsT31OQ3WhRJdNIIGFcM1t+lldljxsfUmpB83IL
   Fg6j97c/VqHT7hj6X+V0PEM+3nUwvyla/IUwTYXRims8ZvQnfkBATlq10
   hKBN7b009JTmQkmC8WgRPwiGG7iipXUOfeeGjEOGCA4fYPsyGuHYL94R5
   JnoFLEaUfPwm5xEsso7HI5dA3OakZ5cZxByK/sDgpQRDBRP2Pv0dAVsMY
   APFk1oizqv7g4M0+LmFU9gPmFfaxg/Z6PWxv8G6H0BzHZTiAHqSAhlSqT
   w==;
X-IronPort-AV: E=Sophos;i="5.64,489,1559520000"; 
   d="scan'208";a="27730157"
IronPort-PHdr: =?us-ascii?q?9a23=3A2NyEnRatbnQ0MsMIc9vi0dL/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsy5Zx7h7PlgxGXEQZ/co6odzbaP6Oa4ASddsd7B6ClELMUWEU?=
 =?us-ascii?q?ddyI0/pE8JOIa9E0r1LfrnPWQRPf9pcxtbxUy9KlVfA83kZlff8TWY5D8WHQ?=
 =?us-ascii?q?jjZ0IufrymUoHdgN6q2O+s5pbdfxtHhCanYbN1MR66sRjdutMZjId/JKs90A?=
 =?us-ascii?q?fFrmdHd+lWxm5jOFafkwrh6suq85Nv7jpct+g9+8JcVKnxYrg1Q6FfADk6KW?=
 =?us-ascii?q?4++dfltQPETQuB53scVnsZnx9VCAXb7x/0Q4n8vDLiuuVyxCeVM8v2TaspWT?=
 =?us-ascii?q?u59KdkVAXoiCYcODEn9mzcl9F9g7haoBKloBx/3pLUbYSIP/dwYq/RYdUXTn?=
 =?us-ascii?q?daU81PSyJOHJ+zb4oXD+oAI+lYqZX9p0ATphe6HAWgGf/jxiNNinLw06I6ye?=
 =?us-ascii?q?AhGhzY0gImEdwFrXDYoMzrOKoWVOy4yrTDwzfeYPNMwTrz9YjGfA4vof+PU7?=
 =?us-ascii?q?x/f8XexkszGA3KlViQtY/oMimJ2ugRvWWW7extXv+vhW49rAFxpyCiyNowio?=
 =?us-ascii?q?bXnoIVyk7L9SNky4goIN23Ukp7Ydq6H5pQqiqXMJB2Td45Q2xzpCY7yqEJuZ?=
 =?us-ascii?q?68fCQQzpQn3ATQZ+aIc4iP/BLuTeCcKip2inJifbKwnRey8U64x+LhSMa03k?=
 =?us-ascii?q?hFrixektbSqn8BzRrT6syfRvRg4EiuwjeP2BrV6u1eJkA0j6XbJpg8ybAzjp?=
 =?us-ascii?q?oeqVnPEyD5lUnsjKKaa18o9van5uj5eLnqu5mRPJJuhA7kKKQhgMm/DPw9Mg?=
 =?us-ascii?q?gJQmeU5/yx1Kbm/U3lWLVKieA2krXBvJDaO8sboqm5DhdJ0ok58Ra/Diqm0M?=
 =?us-ascii?q?8CkXkbLFNKZBKHj4/zN1HIPP/4Fuuwj06pkDdqw/DKJrzhApPTIXjfiLrtYL?=
 =?us-ascii?q?lw5kFGxAcz0NxT/YxYB74fLP7pR0P9rNnYAQU4MwywzebnEtJ91oYGVGKUH6?=
 =?us-ascii?q?CZK7jfsUOI5+0zI+mMY5UZuDDmK/c//fLugng5mUEFcamzwZQXcGy4HuhhI0?=
 =?us-ascii?q?iBfHXshdIBEWYMvgo/UOPqi0eOUTFJZ3azUaI8+io2B5+4AofNWI+thqeB0z?=
 =?us-ascii?q?mnEZFMYGBGDkiGEW30eIWcR/cMdCWSL9d5kjMeSLihT5Qs1Qm0uw/nz7prN+?=
 =?us-ascii?q?/U+ioftZL5ytd5/fHclRY39TZsFcSSz3mNT31onmMPXzI2x75woUh8yleFzK?=
 =?us-ascii?q?h5jOdVFcJc5/xXSAc2L53cwPJgC9D0RA3Bes2FSFG8QtWpUnkNSYcdxNoPZU?=
 =?us-ascii?q?d2GJ2NlBHNw2L+D7gQlrqKD59y/bjd0WTZK8tzxnDd2aJniV1wEeVVMmjzvb?=
 =?us-ascii?q?Jy7wjeAcbylkydk6u7PfAH0DXl6HaIzW3IulpRFgF3T/OWDjgkekLKoIGhtQ?=
 =?us-ascii?q?v5RLi0BOFia1EQxA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ATAACTt3dd/wHyM5BkGwEBAQEDAQEBBwMBAQGBUwYBA?=
 =?us-ascii?q?QELAYFtKm1SATIqhCGIHIdFAQMGgTaJc48rgXsJAQEBAQEBAQEBLQcBAgEBh?=
 =?us-ascii?q?D8CgkkjNAkOAgwBAQEEAQEBAQEGAwEBbIUuDII6KQGCZgEBAQECARoJDwEFQ?=
 =?us-ascii?q?RAJAhgCAiYCAlcGDQYCAQGCUww/AYF2BQ8Piz2bb4EyhDYBhEKBSYEMKAGLd?=
 =?us-ascii?q?xh4gQeBESeCaz6CSBkEGIEBRoMLglgEjDgPCwaKOJU3giuCLIRVjXAGG4I0g?=
 =?us-ascii?q?i6JM4ZVhCCPN4ZMkmQ4gVgrCAIYCCEPgycJgkUXhFODbCSFWyQDMAEJfAEBj?=
 =?us-ascii?q?FuCRQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Sep 2019 14:54:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8AEsSMP026469;
        Tue, 10 Sep 2019 10:54:28 -0400
Subject: Re: [PATCH] selinux-testsuite: add tests for fsnotify
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com,
        selinux@vger.kernel.org
References: <20190710133917.1188-1-acgoide@tycho.nsa.gov>
 <20190910055926.GA963995@brutus.lan>
 <3e584347-f97f-eb00-3291-2ce666e50918@tycho.nsa.gov>
 <20190910141517.GA1058184@brutus.lan>
 <d6636549-d91c-d4d2-4478-9aa3c8e023df@tycho.nsa.gov>
Message-ID: <76c7a2f2-ccc3-46bf-bf1c-ef11a039536e@tycho.nsa.gov>
Date:   Tue, 10 Sep 2019 10:54:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d6636549-d91c-d4d2-4478-9aa3c8e023df@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/10/19 10:40 AM, Stephen Smalley wrote:
> On 9/10/19 10:15 AM, Dominick Grift wrote:
>> On Tue, Sep 10, 2019 at 08:26:57AM -0400, Stephen Smalley wrote:
>>> On 9/10/19 1:59 AM, Dominick Grift wrote:
>>>> On Wed, Jul 10, 2019 at 09:39:17AM -0400, Aaron Goidel wrote:
>>>>> Added a suite to test permissions for setting inotify and fanotify 
>>>>> watches
>>>>> on filesystem objects. Tests watch, watch_with_perm, and 
>>>>> watch_reads permissions.
>>>>
>>>> Ive also "tested" the fsnotify patch. And my tests indicate that 
>>>> this might cause issues:
>>>>
>>>> I added the access vectors to my policy, but on older systems 
>>>> (debian 10) cron fails to start
>>>> cron needs the "entrypoint" permission on /etc/crontab but it looks 
>>>> like appending the "watch" access vectors to common-file disrupted 
>>>> the ordering
>>>> The result is that now i have to allow cron to "watch_read" 
>>>> /etc/crontab even though the neither kernel nor selinux user space 
>>>> are aware of the fsnotify access vectors
>>>> It seems the cron selinux code got confused and now thinks 
>>>> watch_read is entrypoint (its using selinux code to determine 
>>>> whether it can manually transition to cronjob domains on crontabs)
>>>>
>>>> I am hoping this issue with resolve itself on systems with kernels 
>>>> and user spaces that suppose fsnotify.
>>>> However unless i am overlooking something this is still likely to 
>>>> disrupt compatibility
>>>
>>> So, IIUC, the issue is that:
>>> a) older cron was directly using the fixed FILE__ENTRYPOINT 
>>> definition from
>>> libselinux in a security_compute_av() call rather than dynamically 
>>> looking
>>> up entrypoint permission,
>>> b) the value of the file entrypoint permission in policy has changed 
>>> because
>>> you updated your policy and chose to place the watch* permissions in the
>>> common file definition to match the kernel.
>>>
>>> Note that you could have instead sprinkled copies of the watch* 
>>> permissions
>>> across all of the individual file/dir/*_file classes and placed them 
>>> at the
>>> end of the classes if you wanted to avoid this compatibility issue.  The
>>> policy and kernel definitions no longer need to be identical; the kernel
>>> will dynamically map between them for its own permission checks.
>>>
>>> Also, this should have already been broken for you when map 
>>> permission was
>>> added, which would have shown up as execute_no_trans being checked 
>>> instead
>>> of entrypoint.  This was already filed as a bug on cron in debian here:
>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=924716
>>>
>>> So, wrt compatibility, IIUC:
>>> - the kernel change does not break compatibility for old policy + old
>>> userspace,
>>> - new policy can choose to add the new permissions in a 
>>> backward-compatible
>>> manner if desired, although refpolicy has already chosen not to do 
>>> this for
>>> map permission,
>>> - the offending code in cron produces build warnings that were 
>>> introduced in
>>> 2014 in libselinux to update their code to use the dynamic class/perm
>>> mapping support, which would resolve the issue.
>>
>> this does not work (cron[8934]: ((null)) ENTRYPOINT FAILED): 
>> https://defensec.nl/gitweb/dssp2.git/commitdiff/914b1d5366922f92435cba780519c5d2bb9f4f7d 
>>
>>
>> [kcinimod@brutus dssp2 (master=)]$ seinfo policy.31 -x --common 
>> common_file
>>
>> Commons: 1
>>     common common_file
>> {
>>          append
>>          lock
>>          mounton
>>          unlink
>>          read
>>          create
>>          quotaon
>>          execute
>>          setattr
>>          map
>>          relabelto
>>          rename
>>          link
>>          ioctl
>>          getattr
>>          relabelfrom
>> }
>> [kcinimod@brutus dssp2 (master=)]$ seinfo policy.31 -xcfile
>>
>> Classes: 1
>>     class file
>> inherits common_file
>> {
>>          execmod
>>          watch
>>          write
>>          watch_reads
>>          execute_no_trans
>>          watch_mount
>>          watch_with_perm
>>          open
>>          watch_sb
>>          audit_access
>>          entrypoint
>> }
> 
> If you want to preserve compatibility with userspace using fixed 
> definitions of FILE__ENTRYPOINT, then you have to insert any new file 
> permissions after the current entrypoint permission in the class file. 
> So watch and friends have to go after it, not before it.
> 
> Also, since the kernel always uses FILE__WATCH* in the check code rather 
> than distinguishing by class, the watch* permissions need to be at the 
> same offset in all of the file classes.  The same is true of the other 
> file permissions.  It looks like you may have other permissions out of 
> sync across the file classes e.g. execmod, open, audit_access, that need 
> to be aligned or the kernel could check the wrong permission.

Sorry, the last para isn't correct - it should get mapped correctly per 
class.  But you do need to add the permissions after entrypoint in the 
file class to avoid displacing its value.

> 
>>
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
>>>>> ---
>>>>>    policy/Makefile              |   4 ++
>>>>>    policy/test_notify.te        |  74 ++++++++++++++++++++++++
>>>>>    tests/Makefile               |   4 ++
>>>>>    tests/notify/Makefile        |   5 ++
>>>>>    tests/notify/test            | 101 
>>>>> +++++++++++++++++++++++++++++++++
>>>>>    tests/notify/test_fanotify.c | 105 
>>>>> +++++++++++++++++++++++++++++++++++
>>>>>    tests/notify/test_inotify.c  |  43 ++++++++++++++
>>>>>    7 files changed, 336 insertions(+)
>>>>>    create mode 100644 policy/test_notify.te
>>>>>    create mode 100644 tests/notify/Makefile
>>>>>    create mode 100755 tests/notify/test
>>>>>    create mode 100644 tests/notify/test_fanotify.c
>>>>>    create mode 100644 tests/notify/test_inotify.c
>>>>>
>>>>> diff --git a/policy/Makefile b/policy/Makefile
>>>>> index 305b572..65f88c5 100644
>>>>> --- a/policy/Makefile
>>>>> +++ b/policy/Makefile
>>>>> @@ -71,6 +71,10 @@ ifeq ($(shell grep -q 
>>>>> corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/coren
>>>>>    TARGETS += test_sctp.te
>>>>>    endif
>>>>> +ifeq ($(shell grep -q all_file_perms.*watch 
>>>>> $(POLDEV)/include/support/all_perms.spt && echo true),true)
>>>>> +TARGETS+=test_notify.te
>>>>> +endif
>>>>> +
>>>>>    ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>>>>>    TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
>>>>>    endif
>>>>> diff --git a/policy/test_notify.te b/policy/test_notify.te
>>>>> new file mode 100644
>>>>> index 0000000..8ba6f1a
>>>>> --- /dev/null
>>>>> +++ b/policy/test_notify.te
>>>>> @@ -0,0 +1,74 @@
>>>>> +####################################################
>>>>> +# Policy for testing inoftify and fanotify watches #
>>>>> +####################################################
>>>>> +
>>>>> +attribute test_notify_domain;
>>>>> +
>>>>> +# Type for the file on which we want to set a watch
>>>>> +type test_notify_file_t;
>>>>> +files_type(test_notify_file_t);
>>>>> +
>>>>> +# Domain for the process which CAN set a non-permission watch
>>>>> +type test_watch_t;
>>>>> +domain_type(test_watch_t);
>>>>> +unconfined_runs_test(test_watch_t);
>>>>> +
>>>>> +typeattribute test_watch_t test_notify_domain;
>>>>> +typeattribute test_watch_t testdomain;
>>>>> +
>>>>> +allow test_notify_domain self:capability sys_admin;
>>>>> +
>>>>> +allow test_watch_t test_notify_file_t:file { read write open watch };
>>>>> +
>>>>> +# Domain for the process which CAN set a NON-access watch on a file
>>>>> +type test_perm_watch_t;
>>>>> +domain_type(test_perm_watch_t);
>>>>> +unconfined_runs_test(test_perm_watch_t);
>>>>> +
>>>>> +typeattribute test_perm_watch_t test_notify_domain;
>>>>> +typeattribute test_perm_watch_t testdomain;
>>>>> +
>>>>> +allow test_perm_watch_t test_notify_file_t:file { read write open 
>>>>> watch watch_with_perm };
>>>>> +
>>>>> +# Domain which CAN set a NON-perm watch which MAY read accesses
>>>>> +type test_read_watch_t;
>>>>> +domain_type(test_read_watch_t);
>>>>> +unconfined_runs_test(test_read_watch_t);
>>>>> +
>>>>> +typeattribute test_read_watch_t test_notify_domain;
>>>>> +typeattribute test_read_watch_t testdomain;
>>>>> +
>>>>> +allow test_read_watch_t test_notify_file_t:file { read write open 
>>>>> watch watch_reads };
>>>>> +
>>>>> +# Domain which CAN set any watch which CAN read accesses
>>>>> +type test_perm_read_watch_t;
>>>>> +domain_type(test_perm_read_watch_t);
>>>>> +unconfined_runs_test(test_perm_read_watch_t);
>>>>> +
>>>>> +typeattribute test_perm_read_watch_t test_notify_domain;
>>>>> +typeattribute test_perm_read_watch_t testdomain;
>>>>> +
>>>>> +allow test_perm_read_watch_t test_notify_file_t:file { read write 
>>>>> open watch watch_with_perm watch_reads };
>>>>> +
>>>>> +# Domain which CANNOT set any watches
>>>>> +type test_no_watch_t;
>>>>> +domain_type(test_no_watch_t);
>>>>> +unconfined_runs_test(test_no_watch_t);
>>>>> +
>>>>> +typeattribute test_no_watch_t test_notify_domain;
>>>>> +typeattribute test_no_watch_t testdomain;
>>>>> +
>>>>> +allow test_no_watch_t test_notify_file_t:file { read write open };
>>>>> +
>>>>> +# Domain which has no write access but can watch
>>>>> +type test_rdonly_t;
>>>>> +domain_type(test_rdonly_t);
>>>>> +unconfined_runs_test(test_rdonly_t);
>>>>> +
>>>>> +typeattribute test_rdonly_t test_notify_domain;
>>>>> +typeattribute test_rdonly_t testdomain;
>>>>> +
>>>>> +allow test_rdonly_t test_notify_file_t:file { read open watch };
>>>>> +
>>>>> +miscfiles_domain_entry_test_files(test_notify_domain);
>>>>> +userdom_sysadm_entry_spec_domtrans_to(test_notify_domain);
>>>>> diff --git a/tests/Makefile b/tests/Makefile
>>>>> index 63aa325..b99c96e 100644
>>>>> --- a/tests/Makefile
>>>>> +++ b/tests/Makefile
>>>>> @@ -50,6 +50,10 @@ ifeq ($(shell grep 
>>>>> "^SELINUX_INFINIBAND_PKEY_TEST=" infiniband_pkey/ibpkey_test.
>>>>>    SUBDIRS += infiniband_pkey
>>>>>    endif
>>>>> +ifeq ($(shell grep -q all_file_perms.*watch 
>>>>> $(POLDEV)/include/support/all_perms.spt && echo true),true)
>>>>> +SUBDIRS+=notify
>>>>> +endif
>>>>> +
>>>>>    ifeq ($(DISTRO),RHEL4)
>>>>>        SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket 
>>>>> mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
>>>>>    endif
>>>>> diff --git a/tests/notify/Makefile b/tests/notify/Makefile
>>>>> new file mode 100644
>>>>> index 0000000..78c4b3b
>>>>> --- /dev/null
>>>>> +++ b/tests/notify/Makefile
>>>>> @@ -0,0 +1,5 @@
>>>>> +TARGETS=test_inotify test_fanotify
>>>>> +
>>>>> +all: $(TARGETS)
>>>>> +clean:
>>>>> +    rm -f $(TARGETS)
>>>>> diff --git a/tests/notify/test b/tests/notify/test
>>>>> new file mode 100755
>>>>> index 0000000..21f03de
>>>>> --- /dev/null
>>>>> +++ b/tests/notify/test
>>>>> @@ -0,0 +1,101 @@
>>>>> +#!/usr/bin/perl
>>>>> +
>>>>> +use Test;
>>>>> +BEGIN { plan tests => 14 }    # number of tests to run
>>>>> +
>>>>> +# help the test script locate itself
>>>>> +$basedir = $0;
>>>>> +$basedir =~ s|(.*)/[^/]*|$1|;
>>>>> +
>>>>> +# Get rid of a testfile from last run if it's there (just in case)
>>>>> +system("rm -f $basedir/watch_me");
>>>>> +
>>>>> +# Create a new test file
>>>>> +system("touch $basedir/watch_me");
>>>>> +system("chcon -t test_notify_file_t $basedir/watch_me");
>>>>> +
>>>>> +## TESTS
>>>>> +
>>>>> +## TEST BASIC WATCH PERMISSION
>>>>> +# Should be able to set inotify watch
>>>>> +$exit_val =
>>>>> +  system("runcon -t test_watch_t $basedir/test_inotify 
>>>>> $basedir/watch_me 2>&1");
>>>>> +ok( $exit_val, 0 );
>>>>> +
>>>>> +# Should be able to set non-permissions based fanotify watch
>>>>> +$exit_val = system(
>>>>> +    "runcon -t test_watch_t $basedir/test_fanotify 
>>>>> $basedir/watch_me 2>&1");
>>>>> +ok( $exit_val, 0 );
>>>>> +
>>>>> +# Should NOT be able to set permission based fanotify watch
>>>>> +$exit_val = system(
>>>>> +    "runcon -t test_watch_t $basedir/test_fanotify -p 
>>>>> $basedir/watch_me 2>&1");
>>>>> +ok($exit_val);    # this should fail
>>>>> +
>>>>> +# Should NOT be able to set read based fanotify watch
>>>>> +$exit_val = system(
>>>>> +    "runcon -t test_watch_t $basedir/test_fanotify -r 
>>>>> $basedir/watch_me 2>&1");
>>>>> +ok($exit_val);    # this should fail
>>>>> +
>>>>> +# Should NOT be able to set read based inotify watch
>>>>> +$exit_val = system(
>>>>> +    "runcon -t test_watch_t $basedir/test_inotify -r 
>>>>> $basedir/watch_me 2>&1");
>>>>> +ok($exit_val);    # this should fail
>>>>> +
>>>>> +## TEST PERM WATCH
>>>>> +# Should be able to set permission based fanotify watch
>>>>> +$exit_val = system(
>>>>> +"runcon -t test_perm_watch_t $basedir/test_fanotify -p 
>>>>> $basedir/watch_me 2>&1"
>>>>> +);
>>>>> +ok( $exit_val, 0 );
>>>>> +
>>>>> +# Should NOT be able to set watch of accesses
>>>>> +$exit_val = system(
>>>>> +"runcon -t test_perm_watch_t $basedir/test_fanotify -r 
>>>>> $basedir/watch_me 2>&1"
>>>>> +);
>>>>> +ok($exit_val);    # this should fail
>>>>> +
>>>>> +## TEST READ NO PERM WATCH PERMSISSIONS
>>>>> +# Should NOT be able to set read and perm watch
>>>>> +$exit_val = system(
>>>>> +"runcon -t test_read_watch_t $basedir/test_fanotify -p -r 
>>>>> $basedir/watch_me 2>&1"
>>>>> +);
>>>>> +ok($exit_val);    # should fail
>>>>> +
>>>>> +# Should be able to set read inotify watch
>>>>> +$exit_val = system(
>>>>> +"runcon -t test_read_watch_t $basedir/test_inotify -r 
>>>>> $basedir/watch_me 2>&1"
>>>>> +);
>>>>> +ok( $exit_val, 0 );
>>>>> +
>>>>> +## TEST READ WITH PERM WATCH PERMSISSIONS
>>>>> +# Should be able to set read and perm watch
>>>>> +$exit_val = system(
>>>>> +"runcon -t test_perm_read_watch_t $basedir/test_fanotify -p -r 
>>>>> $basedir/watch_me 2>&1"
>>>>> +);
>>>>> +ok( $exit_val, 0 );
>>>>> +
>>>>> +## TEST NO WATCH PERMSISSIONS
>>>>> +# Should NOT be able to set inotify watch
>>>>> +$exit_val = system(
>>>>> +    "runcon -t test_no_watch_t $basedir/test_inotify 
>>>>> $basedir/watch_me 2>&1");
>>>>> +ok($exit_val);    # this should fail
>>>>> +
>>>>> +# Should NOT be able to set any fanotify watch
>>>>> +$exit_val = system(
>>>>> +    "runcon -t test_no_watch_t $basedir/test_fanotify 
>>>>> $basedir/watch_me 2>&1");
>>>>> +ok($exit_val);    # this should fail
>>>>> +
>>>>> +## TEST READ ONLY
>>>>> +# Should NOT be able to get read-write descriptor
>>>>> +$exit_val = system(
>>>>> +    "runcon -t test_rdonly_t $basedir/test_fanotify -l 
>>>>> $basedir/watch_me 2>&1");
>>>>> +ok($exit_val);    # this should fail
>>>>> +
>>>>> +# Should be able to get read-write descriptor
>>>>> +$exit_val = system(
>>>>> +    "runcon -t test_watch_t $basedir/test_fanotify -l 
>>>>> $basedir/watch_me 2>&1");
>>>>> +ok( $exit_val, 0 );
>>>>> +
>>>>> +# Clean up test file
>>>>> +system("rm -f $basedir/watch_me");
>>>>> diff --git a/tests/notify/test_fanotify.c 
>>>>> b/tests/notify/test_fanotify.c
>>>>> new file mode 100644
>>>>> index 0000000..fff773f
>>>>> --- /dev/null
>>>>> +++ b/tests/notify/test_fanotify.c
>>>>> @@ -0,0 +1,105 @@
>>>>> +#define _GNU_SOURCE 1
>>>>> +
>>>>> +#include <stdio.h>
>>>>> +#include <stdlib.h>
>>>>> +
>>>>> +#include <getopt.h>
>>>>> +
>>>>> +#include <fcntl.h>
>>>>> +#include <poll.h>
>>>>> +#include <sys/fanotify.h>
>>>>> +#include <unistd.h>
>>>>> +
>>>>> +void printUsage()
>>>>> +{
>>>>> +    fprintf(stderr, "Usage: test_fanotify [-p] [-r] [-l] 
>>>>> file_name\n");
>>>>> +    exit(1);
>>>>> +}
>>>>> +
>>>>> +int main(int argc, char *argv[])
>>>>> +{
>>>>> +    if (argc < 2) {
>>>>> +        printUsage();
>>>>> +    }
>>>>> +
>>>>> +    int fd, ret, arg;
>>>>> +    int mask = FAN_OPEN;  // default mask
>>>>> +    int listening = 0;
>>>>> +
>>>>> +    // the -p flag will test for watch_with_perm
>>>>> +    // the mask used at mark will contain FAN_OPEN_PERM
>>>>> +    //
>>>>> +    // the -r flag will test for watching accesses to files for reads
>>>>> +    // the mask will contain FAN_ACCESS
>>>>> +    while ((arg = getopt(argc, argv, "prl")) != -1) {
>>>>> +        switch (arg) {
>>>>> +        case 'p':
>>>>> +            mask |= FAN_OPEN_PERM;
>>>>> +            break;
>>>>> +        case 'r':
>>>>> +            mask |= FAN_ACCESS;
>>>>> +            break;
>>>>> +        case 'l':
>>>>> +            listening = 1;
>>>>> +            break;
>>>>> +        default:
>>>>> +            printUsage();
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    // get file descriptor for new fanotify event queue
>>>>> +    fd = fanotify_init(FAN_CLASS_CONTENT, O_RDWR);
>>>>> +    if (fd < 0) {
>>>>> +        perror("fanotify_init:bad file descriptor");
>>>>> +        exit(1);
>>>>> +    }
>>>>> +
>>>>> +    // mark a filesystem object and add mark to event queue
>>>>> +    // get notifications on file opens, accesses, and closes
>>>>> +    // use current working directory as base dir
>>>>> +    ret = fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, 
>>>>> argv[optind]);
>>>>> +
>>>>> +    if (ret < 0) {
>>>>> +        perror("test_fanotify:watch denied");
>>>>> +        exit(1);
>>>>> +    }
>>>>> +
>>>>> +    // logic to actually listen for an event if the -l flag is passed
>>>>> +    // this is used to test if an app with read-only access can 
>>>>> get a read/write
>>>>> +    // handle to the watched file
>>>>> +    if (listening) {
>>>>> +        if (fork() == 0) {  // fork a child process to cause an 
>>>>> event on the file
>>>>> +            FILE *f;
>>>>> +
>>>>> +            f = fopen(argv[optind], "r");  // open file for reading
>>>>> +            fgetc(f);                      // read char from file
>>>>> +
>>>>> +            fclose(f);
>>>>> +        } else {  // logic to watch for events and try to access 
>>>>> file read/write
>>>>> +            struct pollfd fds;
>>>>> +            fds.fd = fd;
>>>>> +            fds.events = POLLIN;
>>>>> +
>>>>> +            while (listening) {
>>>>> +                int polled = poll(&fds, 1, 1);
>>>>> +                if (polled > 0) {
>>>>> +                    if (fds.revents & POLLIN) {
>>>>> +                        struct fanotify_event_metadata buff[200];
>>>>> +
>>>>> +                        size_t len = read(fd, (void *)&buff, 
>>>>> sizeof(buff));
>>>>> +                        if (len == -1) {
>>>>> +                            perror("test_fanotify:can't open file");
>>>>> +                            exit(1);
>>>>> +                        } else {
>>>>> +                            listening = 0;
>>>>> +                            break;
>>>>> +                        }
>>>>> +                    }
>>>>> +                } else if (polled == -1) {
>>>>> +                    listening = 0;
>>>>> +                }
>>>>> +            }
>>>>> +        }
>>>>> +    }
>>>>> +    exit(0);
>>>>> +}
>>>>> diff --git a/tests/notify/test_inotify.c b/tests/notify/test_inotify.c
>>>>> new file mode 100644
>>>>> index 0000000..17c3565
>>>>> --- /dev/null
>>>>> +++ b/tests/notify/test_inotify.c
>>>>> @@ -0,0 +1,43 @@
>>>>> +#include <stdio.h>
>>>>> +#include <stdlib.h>
>>>>> +#include <sys/inotify.h>
>>>>> +#include <getopt.h>
>>>>> +
>>>>> +int main(int argc, char *argv[])
>>>>> +{
>>>>> +    if (argc < 2) {
>>>>> +        fprintf(stderr, "Usage: test_inotify [-r] file_name\n");
>>>>> +        exit(1);
>>>>> +    }
>>>>> +
>>>>> +    int fd, wd, arg;
>>>>> +    int mask = IN_MODIFY;
>>>>> +
>>>>> +    while ((arg = getopt(argc, argv, "pr")) != -1) {
>>>>> +        switch (arg) {
>>>>> +        case 'r':
>>>>> +            mask |= IN_ACCESS;
>>>>> +            break;
>>>>> +        default:
>>>>> +            fprintf(stderr, "Usage: test_inotify [-r] file_name\n");
>>>>> +            exit(1);
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    // get new file descriptor for inotify access
>>>>> +    fd = inotify_init();
>>>>> +    if (fd < 0) {
>>>>> +        perror("inotify_init:bad file descriptor");
>>>>> +        exit(1);
>>>>> +    }
>>>>> +
>>>>> +    // set watch on file and get watch descriptor for accessing 
>>>>> events on it
>>>>> +    wd = inotify_add_watch(fd, argv[optind], mask);
>>>>> +
>>>>> +    if (wd < 0) {
>>>>> +        perror("test_inotify:watch denied");
>>>>> +        exit(1);
>>>>> +    }
>>>>> +
>>>>> +    exit(0);
>>>>> +}
>>>>> -- 
>>>>> 2.21.0
>>>>>
>>>>
>>>
>>
> 

