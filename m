Return-Path: <SRS0=Wrvk=XF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD881C3A5A2
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 12:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F72920872
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 12:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Wy+muVl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfIJM1D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:27:03 -0400
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:44228 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfIJM1C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Sep 2019 08:27:02 -0400
X-EEMSG-check-017: 23513304|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,489,1559520000"; 
   d="scan'208";a="23513304"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Sep 2019 12:27:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568118420; x=1599654420;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yQxx+f8g0kwk6fgPpyldry5c/RdsTcyTE5szNn9eQVo=;
  b=Wy+muVl4aqgis4p/4S7Vbbc0nGJHIYNILxQnmJdp6gCYuMGYoULuplPQ
   zLEtDmqOtSKlh3c29K/xC2IFlWciL23Xm7tfoz3jwfhYywO7AtNa+7ey6
   6TO80HUrdP+iHaPjiQvaZeTn1MgqB+GTGmVtZvkmgKQGZfeiBCa4hiQnX
   ytMESn4g/mnK3AfNsM6ngpIkSl01Xg4CO+nxbQbsQLpQyQru7r3urQrxa
   bV5qdQowqAGA+yyTtfbjrIlnL8iH67ayEPM+1cf7Hxl7t/682DHoA7ZEI
   Lf6W5HSLzvdBVQAaeQ/rAsWARgIzBRGw0A+hVEgwGZpPHMqNqk6dDV3b3
   A==;
X-IronPort-AV: E=Sophos;i="5.64,489,1559520000"; 
   d="scan'208";a="27718602"
IronPort-PHdr: =?us-ascii?q?9a23=3A2pqUbh18mIv3FoM7smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWLvvxwZ3uMQTl6Ol3ixeRBMOHsqkC07Kd6fGoGTRZp8rY6jZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8cbjZF+JqotxR?=
 =?us-ascii?q?fFvH9FcPlSyW90OF6fhRnx6tqu8JJ57yhcp/ct/NNcXKvneKg1UaZWByk8PW?=
 =?us-ascii?q?Av483ruxjDTQ+R6XYZT24bjBlGDRXb4R/jRpv+vTf0ueR72CmBIM35Vqs0Vi?=
 =?us-ascii?q?i476dqUxDnliEKPCMk/W7Ni8xwiKVboA+9pxF63oXZbp2ZOOZ4c6jAZt4RW3?=
 =?us-ascii?q?ZPUdhNWCxAGoO8bpUAD+wdPeZDsoLxo0ICoQaiCQWwAe/izDFHhmXy3aYnze?=
 =?us-ascii?q?ovFw/I1xEkE94XvnnZqND5OaEPWu630abI1y3OYe5I1zfz6IbGcR4vrv+DUr?=
 =?us-ascii?q?1ybcXfxlIiFx/Hg1iKtYDpIz2Y2+YLvmOG7+RgT+Wvi2s/pg9svjig2N8sio?=
 =?us-ascii?q?nXiYIT11vK6CB5z5wxJd28VkF6YcOvHZxLty6HLIt7Wd8iQmF0tyY6zb0Ko5?=
 =?us-ascii?q?i7fDMQx5g9yB7fbOKHfpGO7xn+WuiRJjJ4i2hkeLK5nxu97Favxfb9Vsau1l?=
 =?us-ascii?q?ZGtC1FksPDtn0Lyhfd6dCHR+Ng8kqu1juDzQDe5vxeLUwqmqfXNYQtzqM2m5?=
 =?us-ascii?q?EOq0rMBDX2l1/zjKKOc0Uk/fWn5Pr/b7X9o5+cK5d0igbjMqQygsC/Afo3Mg?=
 =?us-ascii?q?wJX2WD5eSzzqfj/UzkQLVRlPE2jqnYv4zaJcQcvKK5BRNa0p0/5BqlCjem0d?=
 =?us-ascii?q?AYkWEGLFJDZh2Hk5DkN0zBLf33F/uyg0mgnC11y/3JILHtGIjBImDGkLj7fL?=
 =?us-ascii?q?Z970BcyBA0zdBa/59UEawOIOnoV0/ttN3XEh85Mwuuz+bhE9VyzJkSWW2IAq?=
 =?us-ascii?q?+HKK/Sq0OH5vozI+mQY48YoCvyK/8g5/7vi385mEMSfaqz0ZsYcnC4H/pmI1?=
 =?us-ascii?q?mCbHXxnNgBH3kFvgwlTOP0lFKOSzhTZ3KqVaIm+j47EJ6mDZvERo21mLyOxj?=
 =?us-ascii?q?q7HplNa2BeEF+MDHPoe5yBW/cLbyKSONFuniYYWrimTo8rzQuuuxPiy7p7Mu?=
 =?us-ascii?q?rU/TUVtYn929hx5u3Tkwwy9DNvAsSD3GGCUXt0knkLRzAoxqB/p1JyylOZ3a?=
 =?us-ascii?q?h/mfxYGo8b2/QcfgA/NJjdxO8yJMrzVB6JKtuOTVegQ96lRz4rT9wt69MDbU?=
 =?us-ascii?q?t7ANipyBbHiW7iKrYPkLrDK5s1/q/Ylyz4LMl6ynrL/LUwhFkhBM1UPCupgb?=
 =?us-ascii?q?AppCbJAIucqFmUj6anc+wn2SfJ8GqShT6VsFpwTB97UaKDW2sWIETRs4KqtQ?=
 =?us-ascii?q?v5U7ayBOF/YUN6wsmYJ/4PM4a4gA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ANAAAvlXdd/wHyM5BlGgEBAQEBAgEBAQEHAgEBAQGBV?=
 =?us-ascii?q?AQBAQEBCwGBbSptUgEyKoQhj18BAwaBESWJc48rgXsJAQEBAQEBAQEBKwkBA?=
 =?us-ascii?q?gEBhD8CgkgjNQgOAgwBAQEEAQEBAQEGAwEBbIUuDII6KQGCZwEFIxVBEAsYA?=
 =?us-ascii?q?gImAgJXBgEMBgIBAYJTDD8BgXYUD6Z6gTKFS4MugUmBDCgBi3cYeIEHgREnD?=
 =?us-ascii?q?IJfPoJIGQQYgQFGgwuCWASMOA8RiQeBMZU3giuCLIRVjXAGG4I0gi6JM4ZVh?=
 =?us-ascii?q?CCNf4E4hkySZQE2gVgrCAIYCCEPgycJgkUXhFOEEIVbJAMwAYEFAQGMW4JFA?=
 =?us-ascii?q?QE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Sep 2019 12:26:59 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8ACQv9F014627;
        Tue, 10 Sep 2019 08:26:57 -0400
Subject: Re: [PATCH] selinux-testsuite: add tests for fsnotify
To:     Dominick Grift <dominick.grift@defensec.nl>,
        Aaron Goidel <acgoide@tycho.nsa.gov>
Cc:     paul@paul-moore.com, selinux@vger.kernel.org
References: <20190710133917.1188-1-acgoide@tycho.nsa.gov>
 <20190910055926.GA963995@brutus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3e584347-f97f-eb00-3291-2ce666e50918@tycho.nsa.gov>
Date:   Tue, 10 Sep 2019 08:26:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910055926.GA963995@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/10/19 1:59 AM, Dominick Grift wrote:
> On Wed, Jul 10, 2019 at 09:39:17AM -0400, Aaron Goidel wrote:
>> Added a suite to test permissions for setting inotify and fanotify watches
>> on filesystem objects. Tests watch, watch_with_perm, and watch_reads permissions.
> 
> Ive also "tested" the fsnotify patch. And my tests indicate that this might cause issues:
> 
> I added the access vectors to my policy, but on older systems (debian 10) cron fails to start
> cron needs the "entrypoint" permission on /etc/crontab but it looks like appending the "watch" access vectors to common-file disrupted the ordering
> The result is that now i have to allow cron to "watch_read" /etc/crontab even though the neither kernel nor selinux user space are aware of the fsnotify access vectors
> It seems the cron selinux code got confused and now thinks watch_read is entrypoint (its using selinux code to determine whether it can manually transition to cronjob domains on crontabs)
> 
> I am hoping this issue with resolve itself on systems with kernels and user spaces that suppose fsnotify.
> However unless i am overlooking something this is still likely to disrupt compatibility

So, IIUC, the issue is that:
a) older cron was directly using the fixed FILE__ENTRYPOINT definition 
from libselinux in a security_compute_av() call rather than dynamically 
looking up entrypoint permission,
b) the value of the file entrypoint permission in policy has changed 
because you updated your policy and chose to place the watch* 
permissions in the common file definition to match the kernel.

Note that you could have instead sprinkled copies of the watch* 
permissions across all of the individual file/dir/*_file classes and 
placed them at the end of the classes if you wanted to avoid this 
compatibility issue.  The policy and kernel definitions no longer need 
to be identical; the kernel will dynamically map between them for its 
own permission checks.

Also, this should have already been broken for you when map permission 
was added, which would have shown up as execute_no_trans being checked 
instead of entrypoint.  This was already filed as a bug on cron in 
debian here:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=924716

So, wrt compatibility, IIUC:
- the kernel change does not break compatibility for old policy + old 
userspace,
- new policy can choose to add the new permissions in a 
backward-compatible manner if desired, although refpolicy has already 
chosen not to do this for map permission,
- the offending code in cron produces build warnings that were 
introduced in 2014 in libselinux to update their code to use the dynamic 
class/perm mapping support, which would resolve the issue.

> 
>>
>> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
>> ---
>>   policy/Makefile              |   4 ++
>>   policy/test_notify.te        |  74 ++++++++++++++++++++++++
>>   tests/Makefile               |   4 ++
>>   tests/notify/Makefile        |   5 ++
>>   tests/notify/test            | 101 +++++++++++++++++++++++++++++++++
>>   tests/notify/test_fanotify.c | 105 +++++++++++++++++++++++++++++++++++
>>   tests/notify/test_inotify.c  |  43 ++++++++++++++
>>   7 files changed, 336 insertions(+)
>>   create mode 100644 policy/test_notify.te
>>   create mode 100644 tests/notify/Makefile
>>   create mode 100755 tests/notify/test
>>   create mode 100644 tests/notify/test_fanotify.c
>>   create mode 100644 tests/notify/test_inotify.c
>>
>> diff --git a/policy/Makefile b/policy/Makefile
>> index 305b572..65f88c5 100644
>> --- a/policy/Makefile
>> +++ b/policy/Makefile
>> @@ -71,6 +71,10 @@ ifeq ($(shell grep -q corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/coren
>>   TARGETS += test_sctp.te
>>   endif
>>   
>> +ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/include/support/all_perms.spt && echo true),true)
>> +TARGETS+=test_notify.te
>> +endif
>> +
>>   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>>   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
>>   endif
>> diff --git a/policy/test_notify.te b/policy/test_notify.te
>> new file mode 100644
>> index 0000000..8ba6f1a
>> --- /dev/null
>> +++ b/policy/test_notify.te
>> @@ -0,0 +1,74 @@
>> +####################################################
>> +# Policy for testing inoftify and fanotify watches #
>> +####################################################
>> +
>> +attribute test_notify_domain;
>> +
>> +# Type for the file on which we want to set a watch
>> +type test_notify_file_t;
>> +files_type(test_notify_file_t);
>> +
>> +# Domain for the process which CAN set a non-permission watch
>> +type test_watch_t;
>> +domain_type(test_watch_t);
>> +unconfined_runs_test(test_watch_t);
>> +
>> +typeattribute test_watch_t test_notify_domain;
>> +typeattribute test_watch_t testdomain;
>> +
>> +allow test_notify_domain self:capability sys_admin;
>> +
>> +allow test_watch_t test_notify_file_t:file { read write open watch };
>> +
>> +# Domain for the process which CAN set a NON-access watch on a file
>> +type test_perm_watch_t;
>> +domain_type(test_perm_watch_t);
>> +unconfined_runs_test(test_perm_watch_t);
>> +
>> +typeattribute test_perm_watch_t test_notify_domain;
>> +typeattribute test_perm_watch_t testdomain;
>> +
>> +allow test_perm_watch_t test_notify_file_t:file { read write open watch watch_with_perm };
>> +
>> +# Domain which CAN set a NON-perm watch which MAY read accesses
>> +type test_read_watch_t;
>> +domain_type(test_read_watch_t);
>> +unconfined_runs_test(test_read_watch_t);
>> +
>> +typeattribute test_read_watch_t test_notify_domain;
>> +typeattribute test_read_watch_t testdomain;
>> +
>> +allow test_read_watch_t test_notify_file_t:file { read write open watch watch_reads };
>> +
>> +# Domain which CAN set any watch which CAN read accesses
>> +type test_perm_read_watch_t;
>> +domain_type(test_perm_read_watch_t);
>> +unconfined_runs_test(test_perm_read_watch_t);
>> +
>> +typeattribute test_perm_read_watch_t test_notify_domain;
>> +typeattribute test_perm_read_watch_t testdomain;
>> +
>> +allow test_perm_read_watch_t test_notify_file_t:file { read write open watch watch_with_perm watch_reads };
>> +
>> +# Domain which CANNOT set any watches
>> +type test_no_watch_t;
>> +domain_type(test_no_watch_t);
>> +unconfined_runs_test(test_no_watch_t);
>> +
>> +typeattribute test_no_watch_t test_notify_domain;
>> +typeattribute test_no_watch_t testdomain;
>> +
>> +allow test_no_watch_t test_notify_file_t:file { read write open };
>> +
>> +# Domain which has no write access but can watch
>> +type test_rdonly_t;
>> +domain_type(test_rdonly_t);
>> +unconfined_runs_test(test_rdonly_t);
>> +
>> +typeattribute test_rdonly_t test_notify_domain;
>> +typeattribute test_rdonly_t testdomain;
>> +
>> +allow test_rdonly_t test_notify_file_t:file { read open watch };
>> +
>> +miscfiles_domain_entry_test_files(test_notify_domain);
>> +userdom_sysadm_entry_spec_domtrans_to(test_notify_domain);
>> diff --git a/tests/Makefile b/tests/Makefile
>> index 63aa325..b99c96e 100644
>> --- a/tests/Makefile
>> +++ b/tests/Makefile
>> @@ -50,6 +50,10 @@ ifeq ($(shell grep "^SELINUX_INFINIBAND_PKEY_TEST=" infiniband_pkey/ibpkey_test.
>>   SUBDIRS += infiniband_pkey
>>   endif
>>   
>> +ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/include/support/all_perms.spt && echo true),true)
>> +SUBDIRS+=notify
>> +endif
>> +
>>   ifeq ($(DISTRO),RHEL4)
>>       SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
>>   endif
>> diff --git a/tests/notify/Makefile b/tests/notify/Makefile
>> new file mode 100644
>> index 0000000..78c4b3b
>> --- /dev/null
>> +++ b/tests/notify/Makefile
>> @@ -0,0 +1,5 @@
>> +TARGETS=test_inotify test_fanotify
>> +
>> +all: $(TARGETS)
>> +clean:
>> +	rm -f $(TARGETS)
>> diff --git a/tests/notify/test b/tests/notify/test
>> new file mode 100755
>> index 0000000..21f03de
>> --- /dev/null
>> +++ b/tests/notify/test
>> @@ -0,0 +1,101 @@
>> +#!/usr/bin/perl
>> +
>> +use Test;
>> +BEGIN { plan tests => 14 }    # number of tests to run
>> +
>> +# help the test script locate itself
>> +$basedir = $0;
>> +$basedir =~ s|(.*)/[^/]*|$1|;
>> +
>> +# Get rid of a testfile from last run if it's there (just in case)
>> +system("rm -f $basedir/watch_me");
>> +
>> +# Create a new test file
>> +system("touch $basedir/watch_me");
>> +system("chcon -t test_notify_file_t $basedir/watch_me");
>> +
>> +## TESTS
>> +
>> +## TEST BASIC WATCH PERMISSION
>> +# Should be able to set inotify watch
>> +$exit_val =
>> +  system("runcon -t test_watch_t $basedir/test_inotify $basedir/watch_me 2>&1");
>> +ok( $exit_val, 0 );
>> +
>> +# Should be able to set non-permissions based fanotify watch
>> +$exit_val = system(
>> +    "runcon -t test_watch_t $basedir/test_fanotify $basedir/watch_me 2>&1");
>> +ok( $exit_val, 0 );
>> +
>> +# Should NOT be able to set permission based fanotify watch
>> +$exit_val = system(
>> +    "runcon -t test_watch_t $basedir/test_fanotify -p $basedir/watch_me 2>&1");
>> +ok($exit_val);    # this should fail
>> +
>> +# Should NOT be able to set read based fanotify watch
>> +$exit_val = system(
>> +    "runcon -t test_watch_t $basedir/test_fanotify -r $basedir/watch_me 2>&1");
>> +ok($exit_val);    # this should fail
>> +
>> +# Should NOT be able to set read based inotify watch
>> +$exit_val = system(
>> +    "runcon -t test_watch_t $basedir/test_inotify -r $basedir/watch_me 2>&1");
>> +ok($exit_val);    # this should fail
>> +
>> +## TEST PERM WATCH
>> +# Should be able to set permission based fanotify watch
>> +$exit_val = system(
>> +"runcon -t test_perm_watch_t $basedir/test_fanotify -p $basedir/watch_me 2>&1"
>> +);
>> +ok( $exit_val, 0 );
>> +
>> +# Should NOT be able to set watch of accesses
>> +$exit_val = system(
>> +"runcon -t test_perm_watch_t $basedir/test_fanotify -r $basedir/watch_me 2>&1"
>> +);
>> +ok($exit_val);    # this should fail
>> +
>> +## TEST READ NO PERM WATCH PERMSISSIONS
>> +# Should NOT be able to set read and perm watch
>> +$exit_val = system(
>> +"runcon -t test_read_watch_t $basedir/test_fanotify -p -r $basedir/watch_me 2>&1"
>> +);
>> +ok($exit_val);    # should fail
>> +
>> +# Should be able to set read inotify watch
>> +$exit_val = system(
>> +"runcon -t test_read_watch_t $basedir/test_inotify -r $basedir/watch_me 2>&1"
>> +);
>> +ok( $exit_val, 0 );
>> +
>> +## TEST READ WITH PERM WATCH PERMSISSIONS
>> +# Should be able to set read and perm watch
>> +$exit_val = system(
>> +"runcon -t test_perm_read_watch_t $basedir/test_fanotify -p -r $basedir/watch_me 2>&1"
>> +);
>> +ok( $exit_val, 0 );
>> +
>> +## TEST NO WATCH PERMSISSIONS
>> +# Should NOT be able to set inotify watch
>> +$exit_val = system(
>> +    "runcon -t test_no_watch_t $basedir/test_inotify $basedir/watch_me 2>&1");
>> +ok($exit_val);    # this should fail
>> +
>> +# Should NOT be able to set any fanotify watch
>> +$exit_val = system(
>> +    "runcon -t test_no_watch_t $basedir/test_fanotify $basedir/watch_me 2>&1");
>> +ok($exit_val);    # this should fail
>> +
>> +## TEST READ ONLY
>> +# Should NOT be able to get read-write descriptor
>> +$exit_val = system(
>> +    "runcon -t test_rdonly_t $basedir/test_fanotify -l $basedir/watch_me 2>&1");
>> +ok($exit_val);    # this should fail
>> +
>> +# Should be able to get read-write descriptor
>> +$exit_val = system(
>> +    "runcon -t test_watch_t $basedir/test_fanotify -l $basedir/watch_me 2>&1");
>> +ok( $exit_val, 0 );
>> +
>> +# Clean up test file
>> +system("rm -f $basedir/watch_me");
>> diff --git a/tests/notify/test_fanotify.c b/tests/notify/test_fanotify.c
>> new file mode 100644
>> index 0000000..fff773f
>> --- /dev/null
>> +++ b/tests/notify/test_fanotify.c
>> @@ -0,0 +1,105 @@
>> +#define _GNU_SOURCE 1
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +
>> +#include <getopt.h>
>> +
>> +#include <fcntl.h>
>> +#include <poll.h>
>> +#include <sys/fanotify.h>
>> +#include <unistd.h>
>> +
>> +void printUsage()
>> +{
>> +	fprintf(stderr, "Usage: test_fanotify [-p] [-r] [-l] file_name\n");
>> +	exit(1);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	if (argc < 2) {
>> +		printUsage();
>> +	}
>> +
>> +	int fd, ret, arg;
>> +	int mask = FAN_OPEN;  // default mask
>> +	int listening = 0;
>> +
>> +	// the -p flag will test for watch_with_perm
>> +	// the mask used at mark will contain FAN_OPEN_PERM
>> +	//
>> +	// the -r flag will test for watching accesses to files for reads
>> +	// the mask will contain FAN_ACCESS
>> +	while ((arg = getopt(argc, argv, "prl")) != -1) {
>> +		switch (arg) {
>> +		case 'p':
>> +			mask |= FAN_OPEN_PERM;
>> +			break;
>> +		case 'r':
>> +			mask |= FAN_ACCESS;
>> +			break;
>> +		case 'l':
>> +			listening = 1;
>> +			break;
>> +		default:
>> +			printUsage();
>> +		}
>> +	}
>> +
>> +	// get file descriptor for new fanotify event queue
>> +	fd = fanotify_init(FAN_CLASS_CONTENT, O_RDWR);
>> +	if (fd < 0) {
>> +		perror("fanotify_init:bad file descriptor");
>> +		exit(1);
>> +	}
>> +
>> +	// mark a filesystem object and add mark to event queue
>> +	// get notifications on file opens, accesses, and closes
>> +	// use current working directory as base dir
>> +	ret = fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, argv[optind]);
>> +
>> +	if (ret < 0) {
>> +		perror("test_fanotify:watch denied");
>> +		exit(1);
>> +	}
>> +
>> +	// logic to actually listen for an event if the -l flag is passed
>> +	// this is used to test if an app with read-only access can get a read/write
>> +	// handle to the watched file
>> +	if (listening) {
>> +		if (fork() == 0) {  // fork a child process to cause an event on the file
>> +			FILE *f;
>> +
>> +			f = fopen(argv[optind], "r");  // open file for reading
>> +			fgetc(f);                      // read char from file
>> +
>> +			fclose(f);
>> +		} else {  // logic to watch for events and try to access file read/write
>> +			struct pollfd fds;
>> +			fds.fd = fd;
>> +			fds.events = POLLIN;
>> +
>> +			while (listening) {
>> +				int polled = poll(&fds, 1, 1);
>> +				if (polled > 0) {
>> +					if (fds.revents & POLLIN) {
>> +						struct fanotify_event_metadata buff[200];
>> +
>> +						size_t len = read(fd, (void *)&buff, sizeof(buff));
>> +						if (len == -1) {
>> +							perror("test_fanotify:can't open file");
>> +							exit(1);
>> +						} else {
>> +							listening = 0;
>> +							break;
>> +						}
>> +					}
>> +				} else if (polled == -1) {
>> +					listening = 0;
>> +				}
>> +			}
>> +		}
>> +	}
>> +	exit(0);
>> +}
>> diff --git a/tests/notify/test_inotify.c b/tests/notify/test_inotify.c
>> new file mode 100644
>> index 0000000..17c3565
>> --- /dev/null
>> +++ b/tests/notify/test_inotify.c
>> @@ -0,0 +1,43 @@
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <sys/inotify.h>
>> +#include <getopt.h>
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	if (argc < 2) {
>> +		fprintf(stderr, "Usage: test_inotify [-r] file_name\n");
>> +		exit(1);
>> +	}
>> +
>> +	int fd, wd, arg;
>> +	int mask = IN_MODIFY;
>> +
>> +	while ((arg = getopt(argc, argv, "pr")) != -1) {
>> +		switch (arg) {
>> +		case 'r':
>> +			mask |= IN_ACCESS;
>> +			break;
>> +		default:
>> +			fprintf(stderr, "Usage: test_inotify [-r] file_name\n");
>> +			exit(1);
>> +		}
>> +	}
>> +
>> +	// get new file descriptor for inotify access
>> +	fd = inotify_init();
>> +	if (fd < 0) {
>> +		perror("inotify_init:bad file descriptor");
>> +		exit(1);
>> +	}
>> +
>> +	// set watch on file and get watch descriptor for accessing events on it
>> +	wd = inotify_add_watch(fd, argv[optind], mask);
>> +
>> +	if (wd < 0) {
>> +		perror("test_inotify:watch denied");
>> +		exit(1);
>> +	}
>> +
>> +	exit(0);
>> +}
>> -- 
>> 2.21.0
>>
> 

