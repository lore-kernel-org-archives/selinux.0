Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w58GfE1j031367
 for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2018 12:41:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 412Spc1X2Dz25sS6
 for <selinux@tycho.nsa.gov>; Fri,  8 Jun 2018 16:41:12 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 412Spb2qR9z25sRv
 for <selinux@tycho.nsa.gov>; Fri,  8 Jun 2018 16:41:11 +0000 (UTC)
Received: by mail-lf0-f47.google.com with SMTP id i15-v6so10699280lfc.2
 for <selinux@tycho.nsa.gov>; Fri, 08 Jun 2018 09:41:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQZzKmT1PXjT==3UstqEV47LyfWZwy0yrHJchJLN6kyQA@mail.gmail.com>
References: <CANjv_kN3XAjhJZbZ_uTh7aBJ2w3dhmeGrhrLtVvuKuDO_Y0g=A@mail.gmail.com>
 <CAHC9VhQZzKmT1PXjT==3UstqEV47LyfWZwy0yrHJchJLN6kyQA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Jun 2018 12:41:09 -0400
Message-ID: <CAHC9VhSTSvekvxv0gq5a1N-kxkd-mGL+SC71ia=2YPVN0R4jAQ@mail.gmail.com>
To: Sgeeta Dhundale <sgeeta.in@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: selinux-testsuite inet_socket test failure
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jun 8, 2018 at 12:35 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jun 8, 2018 at 9:17 AM, Sgeeta Dhundale <sgeeta.in@gmail.com> wrote:
>> Hi,
>>   While running selinux testsuits I am seeing some of the inet_socket tests
>> failure.
>> Googled alotbut couldnt see any similler issue reported as such.
>> It would be really helpful if you can give some pointer to  resolved this.
>>
>> Selinux rpms I am using =>
>> # rpm -qa | grep selinux
>> libselinux-devel-2.0.94-7.el6.x86_64
>> libselinux-utils-2.0.94-7.el6.x86_64
>> selinux-policy-targeted-3.7.19-312.0.1.el6.noarch
>> libselinux-2.0.94-7.el6.x86_64
>> selinux-policy-3.7.19-312.0.1.el6.noarch
>> libselinux-python-2.0.94-7.el6.x86_64
>> -------------------------------
>>
>> Output snippet of test run
>> chcon -R -t test_file_t .
>> Running as user root with context unconfined_u:unconfined_r:unconfined_t
>>
>> .....
>> ......
>> dyntrace/test ............ ok
>> bounds/test .............. ok
>> mmap/test ................ ok
>> unix_socket/test ......... ok
>> inet_socket/test .........
>> Dubious, test returned 2 (wstat 512, 0x200)
>> Failed 2/33 subtests
>> checkreqprot/test ........ ok
>> mqueue/test .............. skipped: mqueue fileystem not supported/mounted
>> mac_admin/test ........... ok
>> infiniband_pkey/test ..... ok
>> infiniband_endport/test .. ok
>>
>> Test Summary Report
>> -------------------
>> inet_socket/test       (Wstat: 512 Tests: 33 Failed: 2)
>>   Failed tests:  7, 9
>>   Non-zero exit status: 2
>> Files=46, Tests=325, 54 wallclock secs ( 0.27 usr  0.10 sys +  0.76 cusr
>> 1.46 csys =  2.59 CPU)
>> Result: FAIL
>> make: Leaving directory `/root/SELinux/selinux-testsuite-master/tests'
>> ASSERT:SELinux-Test run failed, pls check testrun.log file for details
>> expected:<0> but was:<1>
>> FAILED
>
> It looks like you are running RHEL-6.x or CentOS-6.x?
>
> I just ran the tests on my RHEL-6.x test system and saw similar
> results, it appears to be the result of the following commit to the
> selinux-testsuite:
>
>  commit c618ab669b0c580bb3fa000b168d7d4b5a00c5ee
>  Author: Stephen Smalley <sds@tycho.nsa.gov>
>  Date:   Thu Oct 26 09:29:37 2017 -0400
>
>    selinux-testsuite: inet_socket: tighten checking
>
>    As demonstrated by https://github.com/SELinuxProject/selinux-kernel/issues/3
>    the inet_socket tests can "pass" for the wrong reasons.  Change the
>    client program to use different exit codes for different failures,
>    and change the test script to check the expected exit code for all tests.
>    With this change, getting an unexpected peer label causes a test failure
>    rather than being treated identically to a permission denial.
>
>    NB This could make the tests more fragile, e.g. it appears that we encounter
>    permission denial failures at different points for different tests, so we
>    may need to relax the checking somewhat based on testing a wider range of
>    older kernels.
>
>    Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> ... I think we may need to take a closer look at what RHEL-6.x based
> kernels are currently doing to ensure they are "correct" (I'm going to
> assume yes, but that is an assumption), and perhaps update the test
> suite to reflect the RHEL-6.x behavior.

FYI, I created an issue on GH to track this:

* https://github.com/SELinuxProject/selinux-testsuite/issues/37

-- 
paul moore
www.paul-moore.com
