Return-Path: <SRS0=BxL9=6H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D21C54FD0
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 14:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA5B62074F
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 14:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgDWO6Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:58:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:54034 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDWO6Q (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 23 Apr 2020 10:58:16 -0400
IronPort-SDR: TEKpj8Vm3GcdTlT0Ct7Hpwiel12WK4J3IjN0aGxO93KctviRMPKbaMQhstuJw+0CFPFN6r8idh
 Y49om/m/fozQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 07:58:15 -0700
IronPort-SDR: FaswXvjqMFVLy46tV/4eP/rnfbowfboz9xwzgyGqApS0MEaPW2tUcyFil+wQjigRSNRWmYOJcI
 x2aC2oinduyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="456935239"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 23 Apr 2020 07:58:15 -0700
Received: from [10.249.228.14] (abudanko-mobl.ccr.corp.intel.com [10.249.228.14])
        by linux.intel.com (Postfix) with ESMTP id DD73B5802C9;
        Thu, 23 Apr 2020 07:58:12 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] perf tool: make Perf tool aware of SELinux access
 control
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <66f2975b-4a69-b428-7dc5-d9aa40b3c673@linux.intel.com>
 <7459371d-2ec8-4700-13b6-09b73998cc7c@linux.intel.com>
 <20200423132733.GC19437@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <12d614d9-e77f-d96b-7546-7b59f06edabf@linux.intel.com>
Date:   Thu, 23 Apr 2020 17:58:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423132733.GC19437@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 23.04.2020 16:27, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 22, 2020 at 05:45:34PM +0300, Alexey Budankov escreveu:
>>
>> Implement SELinux sysfs check to see if the system is in enforcing
>> mode and print warning message with pointers to check audit logs.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/util/cloexec.c |  4 ++--
>>  tools/perf/util/evsel.c   | 40 +++++++++++++++++++++++----------------
>>  2 files changed, 26 insertions(+), 18 deletions(-)
>>
>> diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
>> index a12872f2856a..9c8ec816261b 100644
>> --- a/tools/perf/util/cloexec.c
>> +++ b/tools/perf/util/cloexec.c
>> @@ -65,7 +65,7 @@ static int perf_flag_probe(void)
>>  		return 1;
>>  	}
>>  
>> -	WARN_ONCE(err != EINVAL && err != EBUSY,
>> +	WARN_ONCE(err != EINVAL && err != EBUSY && err != EACCES,
>>  		  "perf_event_open(..., PERF_FLAG_FD_CLOEXEC) failed with unexpected error %d (%s)\n",
>>  		  err, str_error_r(err, sbuf, sizeof(sbuf)));
>>  
>> @@ -83,7 +83,7 @@ static int perf_flag_probe(void)
>>  	if (fd >= 0)
>>  		close(fd);
>>  
>> -	if (WARN_ONCE(fd < 0 && err != EBUSY,
>> +	if (WARN_ONCE(fd < 0 && err != EBUSY && err != EACCES,
>>  		      "perf_event_open(..., 0) failed unexpectedly with error %d (%s)\n",
>>  		      err, str_error_r(err, sbuf, sizeof(sbuf))))
>>  		return -1;
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 9fa92649adb4..82492ca12405 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -2514,32 +2514,40 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
>>  			      int err, char *msg, size_t size)
>>  {
>>  	char sbuf[STRERR_BUFSIZE];
>> -	int printed = 0;
>> +	int printed = 0, enforced = 0;
>>  
>>  	switch (err) {
>>  	case EPERM:
>>  	case EACCES:
>> +		printed += scnprintf(msg + printed, size - printed,
>> +			"Access to performance monitoring and observability operations is limited.\n");
>> +
>> +		if (!sysfs__read_int("fs/selinux/enforce", &enforced)) {
>> +			if (enforced) {
>> +				printed += scnprintf(msg + printed, size - printed,
>> +					"Enforced MAC policy settings (SELinux) can limit access to performance\n"
>> +					"monitoring and observability operations. Inspect system audit records for\n"
>> +					"more perf_event access control information and adjusting the policy.\n");
>> +			}
>> +		}
>> +
>>  		if (err == EPERM)
>> -			printed = scnprintf(msg, size,
>> -				"No permission to enable %s event.\n\n",
>> +			printed += scnprintf(msg, size,
>> +				"No permission to enable %s event.\n",
>>  				perf_evsel__name(evsel));
> 
> This removal of a newline doesn't seem necessary to this patch.

There will be break in the middle of the message then, but ok.

>   
>>  		return scnprintf(msg + printed, size - printed,
>> -		 "You may not have permission to collect %sstats.\n\n"
>> -		 "Consider tweaking /proc/sys/kernel/perf_event_paranoid,\n"
>> -		 "which controls use of the performance events system by\n"
>> -		 "unprivileged users (without CAP_PERFMON or CAP_SYS_ADMIN).\n\n"
>> -		 "The current value is %d:\n\n"
>> +		 "Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open\n"
>> +		 "access to performance monitoring and observability operations for users\n"
>> +		 "without CAP_PERFMON capability. perf_event_paranoid setting is %d:\n"
> 
> Here we need as well to check if the kernel/libcap supports CAP_PERFMON
> to provide a better error message.

I will change change "CAP_PERFMON" to "CAP_PERFMON or CAP_SYS_ADMIN" in the new message.

> 
>>  		 "  -1: Allow use of (almost) all events by all users\n"
>>  		 "      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK\n"
>> -		 ">= 0: Disallow ftrace function tracepoint by users without CAP_PERFMON or CAP_SYS_ADMIN\n"
>> -		 "      Disallow raw tracepoint access by users without CAP_SYS_PERFMON or CAP_SYS_ADMIN\n"
>> -		 ">= 1: Disallow CPU event access by users without CAP_PERFMON or CAP_SYS_ADMIN\n"
>> -		 ">= 2: Disallow kernel profiling by users without CAP_PERFMON or CAP_SYS_ADMIN\n\n"
>> -		 "To make this setting permanent, edit /etc/sysctl.conf too, e.g.:\n\n"
>> -		 "	kernel.perf_event_paranoid = -1\n" ,
>> -				 target->system_wide ? "system-wide " : "",
>> -				 perf_event_paranoid());
>> +		 ">= 0: Disallow raw and ftrace function tracepoint access\n"
>> +		 ">= 1: Disallow CPU event access\n"
>> +		 ">= 2: Disallow kernel profiling\n"
>> +		 "To make the adjusted perf_event_paranoid setting permanent preserve it\n"
>> +		 "in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)",
>> +		 perf_event_paranoid());
>>  	case ENOENT:
>>  		return scnprintf(msg, size, "The %s event is not supported.",
>>  				 perf_evsel__name(evsel));

Thanks,
Alexey
