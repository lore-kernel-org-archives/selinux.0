Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2602405E1
	for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937394; cv=none; b=PQAf9XzYA/nuN45xPq0ooL/zjinweBRpmQiYbgRbmyZpVhGG0GoUh114G0CuHeFWUS2/P2HJQWV4wdvQ2nMrD5yL5Dkx77re1LQChg2WMuYm5/GaiVumTKfJil1y06P2nWNQ17gmRCoLciO2zASo7hWbt7Pg1+IFRtfjCbkWoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937394; c=relaxed/simple;
	bh=Xcg/6PR/0fMkYGw7hi8SCOEv435962yuIENNUMGUci0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvzw02ruD2WtU1FWWAVjGahe+0AP/39x2h3PYEHAUOc4gvzeEWrCvaqCOjxfseZHRXZuIt05xisd4fQp/L52G/pxm1Y5zbORpe0zHK4b+cn4J19Srmws2AsHYZ9WEJYtSk1tBajx9KMTbtHnHcYReBAn9NG3uDtYJOGTP/aOHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tOWHo+vk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tOWHo+vk"
Received: from [10.137.198.68] (unknown [131.107.8.68])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1FBA82117679;
	Mon, 11 Aug 2025 11:36:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FBA82117679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754937392;
	bh=iOPVvGshGUgn0yv4+7Q3rQDNCosT07pIMtEZp9cDNm4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tOWHo+vkcOmgoeXbJeI7j8L6KOZoISH2Qmu7eB7BcE91o10gTIJJ04Eu8F3FPjcpF
	 8UshBASy7L1cQiz0cXgc+j4RJixpHtbiJthEg62VsJ9YBRCZ9MDZfHT/hiSOgN0awT
	 +RTI9w7sNpyTZCaHRI6nOoiOHDafrML/k+kYyqCw=
Message-ID: <8cd1865a-6220-471d-826d-e4908b39f229@linux.microsoft.com>
Date: Mon, 11 Aug 2025 11:36:30 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH testsuite] tests/bpf: Add tests for SELinux BPF token
 access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 danieldurning.work@gmail.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
References: <20250808184711.291-1-ericsu@linux.microsoft.com>
 <CAEjxPJ6SBAy8yi8XhASR5pVFnYfvJhFujzGfBQuS9o2TziOSFw@mail.gmail.com>
Content-Language: en-US
From: Eric Suen <ericsu@linux.microsoft.com>
In-Reply-To: <CAEjxPJ6SBAy8yi8XhASR5pVFnYfvJhFujzGfBQuS9o2TziOSFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/8/2025 12:59 PM, Stephen Smalley wrote:
> On Fri, Aug 8, 2025 at 2:47 PM Eric Suen <ericsu@linux.microsoft.com> wrote:
>> This patch adds new tests to verify the SELinux support for BPF token
>> access control, as introduced in the corresponding kernel patch:
>>    https://lore.kernel.org/selinux/20250806180149.1995-1-ericsu@linux.microsoft.com/
>>
>> Four new tests are added to cover both positive and negative scenarios,
>> ensuring that the SELinux policy enforcement on BPF token usage behaves
>> as expected.
>>    - Successful map_create and prog_load when SELinux permissions are
>>      granted.
>>    - Enforcement of SELinux policy restrictions when access is denied.
>>
>> These tests are located under the tests/bpf directory and can be run
>> using the standard SELinux testsuite workflow.
> (added Daniel to cc since he also posted a testsuite patch and thus
> should be included)
>
> As I mentioned on the other thread, you should include instructions in
> your commit message for how to temporarily define the requisite policy
> capability and new permissions to run these tests; an example is
> linked from the SELinux kernel wiki Getting Started page and my other
> email.
> That alone isn't worth re-submitting this patch but see below for more.
Stephen - I followed instructions in this example to enable new 
permissions and capability: 
https://github.com/SELinuxProject/selinux-testsuite/commit/023b79b8319e5fe222fb5af892c579593e1cbc50 


I experimented with those commands, and 'sudo semodule -i 
netlink_xperm.cil' failed with following errors. I am in the process of 
figuring this out. In the meantime, if you know where the problem is, 
could you please let me know?
Invalid policycap (netlink_xperm) at 
/var/lib/selinux/targeted/tmp/modules/400/netlink_xperm/cil:1
Failed to verify cil database
Failed to verify cil database
Post process failed
semodule:  Failed!


>> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
>> ---
>>   policy/test_bpf.te     | 48 ++++++++++++++++++++++++++++++++++
>>   tests/bpf/Makefile     |  5 ++--
>>   tests/bpf/bpf_common.h | 10 +++++++
>>   tests/bpf/bpf_test.c   | 59 ++++++++++++++++++++++++++++++------------
>>   tests/bpf/test         | 21 ++++++++++++++-
>>   5 files changed, 124 insertions(+), 19 deletions(-)
>>
>> diff --git a/policy/test_bpf.te b/policy/test_bpf.te
>> index 5eab0bd..ef226a8 100644
>> --- a/policy/test_bpf.te
>> +++ b/policy/test_bpf.te
>> @@ -57,3 +57,51 @@ typeattribute test_bpf_deny_prog_run_t bpfdomain;
>>   allow test_bpf_deny_prog_run_t self:process { setrlimit };
>>   allow test_bpf_deny_prog_run_t self:capability { sys_resource sys_admin };
>>   allow test_bpf_deny_prog_run_t self:bpf { map_create map_read map_write prog_load };
>> +
>> +################### Allow map_create_as and prog_load_as ###################
>> +fs_list_bpf_dirs(test_bpf_t);
> Technically we shouldn't put semicolons at the end of a macro call; it
> will turn into an empty statement in the macro-expanded policy.
> Semicolons are only for actual policy language statements. You might
> just have copied this from elsewhere but it would be better to avoid
> it.
I see. Will fix in next iteration. Thank you.
>> +allow kernel_t test_bpf_t:bpf map_create;
>> +allow test_bpf_t bpf_t:dir { ioctl open read search };
>> +allow test_bpf_t bpf_t:filesystem mount;
>> +allow test_bpf_t root_t:dir mounton;
>> +allow test_bpf_t self:bpf { map_create_as prog_load_as };
>> +allow test_bpf_t self:cap2_userns { bpf perfmon };
>> +allow test_bpf_t self:cap_userns { net_admin setgid setuid sys_admin };
>> +allow test_bpf_t self:user_namespace create;
>> +allow test_bpf_t unlabeled_t:dir search;
> Here and below, the fact that you are allowing kernel_t (i.e. the
> domain/type of kernel threads and the first process prior to switching
> to init_t) permissions suggests a bug/defect in your kernel patch,
> because that just shouldn't be required for a userspace program to
> create a BPF map.
> Similarly allowing permission to unlabeled_t:dir suggests a bug/defect
> in your kernel patch or your test policy, because unlabeled_t is a
> type for files that do not have a SELinux label/context assigned to
> them. This can occur for example if there are no SELinux policy rules
> for labeling a given filesystem type in the base policy, but in that
> case you should add a genfscon or similar policy statement either as
> part of your test policy or note the need to add such a rule in the
> commit message. Daniel's testsuite patch didn't appear to require
> either a kernel_t or unlabeled_t allow rule.
I will clean up this te file in next iteration. Thanks.
>> diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
>> index 1ae8ce9..cacefbe 100644
>> --- a/tests/bpf/Makefile
>> +++ b/tests/bpf/Makefile
>> @@ -1,5 +1,5 @@
>>   TARGETS = bpf_test
>> -DEPS = bpf_common.c bpf_common.h
>> +SRCS = bpf_test.c bpf_common.c token_test.c
>>   LDLIBS += -lselinux -lbpf
>>
>>   # export so that BPF_ENABLED entries get built correctly on local build
>> @@ -14,4 +14,5 @@ clean:
>>          rm -f $(TARGETS) test_sock flag *_flag
>>          @set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i clean ; done
>>
>> -$(TARGETS): $(DEPS)
>> +$(TARGETS): $(SRCS)
>> +       $(CC) $(CFLAGS) -o $@ $^ $(LDLIBS)
>> \ No newline at end of file
> Please fix the terminating newline issue here.
> Also, make doesn't work after this patch is applied:
> make: *** No rule to make target 'token_test.c', needed by 'bpf_test'.  Stop.
>
>> diff --git a/tests/bpf/bpf_common.h b/tests/bpf/bpf_common.h
>> index 44ac28f..adba522 100644
>> --- a/tests/bpf/bpf_common.h
>> +++ b/tests/bpf/bpf_common.h
>> @@ -12,6 +12,8 @@
>>   extern int create_bpf_map(void);
>>   extern int create_bpf_prog(void);
>>   extern void bpf_setrlimit(void);
>> +extern int test_bpf_map_create(void);
>> +extern int test_bpf_prog_load(void);
>>
>>   /* edited eBPF instruction library */
>>   /* Short form of mov, dst_reg = imm32 */
>> @@ -32,3 +34,11 @@ extern void bpf_setrlimit(void);
>>                                                 .off   = 0,                      \
>>                                                          .imm   = 0 })
>>
>> +/* Raw code statement block */
>> +#define BPF_RAW_INSN(CODE, DST, SRC, OFF, IMM)                 \
>> +       ((struct bpf_insn) {                                    \
>> +               .code  = CODE,                                  \
>> +                       .dst_reg = DST,                                 \
>> +                               .src_reg = SRC,                                 \
>> +                                       .off   = OFF,                                   \
>> +                                               .imm   = IMM })
> I don't see any usage of this macro nor definition of these functions
> in your patch?
> Did you forget to "git add" a file?
You are right, I missed 'git add token_test.c'. Sorry.
>> diff --git a/tests/bpf/test b/tests/bpf/test
>> index a3fd856..aefc70c 100755
>> --- a/tests/bpf/test
>> +++ b/tests/bpf/test
>> @@ -9,8 +9,10 @@ BEGIN {
>>
>>       $test_bpf_count       = 7;
>>       $test_fdreceive_count = 4;
>> +    $test_bpf_token_count = 4;
>>
>> -    $test_count = $test_bpf_count + $test_fdreceive_count;
>> +    $test_count = $test_bpf_count + $test_fdreceive_count +
>> +                  $test_bpf_token_count;
>>
>>       # allow info to be shown during tests
>>       $v = $ARGV[0];
>> @@ -67,6 +69,13 @@ ok( $result eq 0 );
>>   $result = system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
>>   ok( $result eq 0 );
>>
>> +# BPF token - BPF_MAP_CREATE_AS, BPF_PROG_LOAD_AS
>> +$result = system "runcon -t test_bpf_t $basedir/bpf_test -c $v";
>> +ok ( $result eq 0 );
>> +
>> +$result = system "runcon -t test_bpf_t $basedir/bpf_test -l $v";
>> +ok ( $result eq 0 );
>> +
>>   # Deny map_create permission
>>   $result =
>>     system "runcon -t test_bpf_deny_map_create_t $basedir/bpf_test -m $v 2>&1";
>> @@ -92,6 +101,16 @@ $result =
>>     system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v 2>&1";
>>   ok($result);
>>
>> +# BPF token - deny BPF_MAP_CREATE_AS
>> +$result =
>> +  system "runcon -t test_bpf_deny_map_create_as_t $basedir/bpf_test -c $v 2>&1";
>> +ok($result);
>> +
>> +# BPF token - deny BPF_PROG_LOAD_AS
>> +$result =
>> +  system "runcon -t test_bpf_deny_prog_load_as_t $basedir/bpf_test -l $v 2>&1";
>> +ok($result);
>> +
>>   #
>>   ################ BPF Tests for fdreceive #######################
>>   #
> At least on my system, perl tidy complained about some lines in this
> file; be sure to re-run it and amend.
I did run 'checkpatch.pl'. Maybe there are warnings I missed. I will 
take a look again.


