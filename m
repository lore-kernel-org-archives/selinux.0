Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBAEC43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 17:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9052077B
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 17:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YlAvDF0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfLJRBL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:01:11 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:28030 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfLJRBK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 12:01:10 -0500
X-EEMSG-check-017: 34232782|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="scan'208";a="34232782"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Dec 2019 17:01:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575997267; x=1607533267;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=npTOExzzfYUmyAmtKWroDaYdj7mF6tNrAzKGiMZT26Q=;
  b=YlAvDF0xCLKHRyjlnilkighMWu9XH0np0zKZADBFh7iQ1l+MKAVWtudT
   RcAk0H5DKzCC7vdvXto+LsfwR63wGn3bJsnHcuqWki6YEWz8ywPCx6JO8
   9lLgddwgHt+LnMci/oh5UViFXFtcos3CAS/fWtJ6AbjGtWO4N8Z673RTK
   ZdwHP83qr249z1I5dxLCUdCnzcCAChYcQn3Pb9gFRDRs+u4JtVtj5Gyyn
   VLi5NjUEVkpqOKOWECJx+x48ld9XS7xdrkLpU2zxUaaykKUJGsIGr6Co4
   tdxwxMUQcYySKT5e5Klm5i2f8SQCLVqFLE7xjqRSW5ZIn/AyLIkpe9nmi
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="scan'208";a="30950847"
IronPort-PHdr: =?us-ascii?q?9a23=3ApQqCtRPPoI6AuSBjgTAl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/j7rarrMEGX3/hxlliBBdydt6sfzbOH6OuxAyQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngi6oAHfu8UZhYZuNLs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1YAqRayAA+hD/7txDBVnH/7xbA03e?=
 =?us-ascii?q?Q/HwHI3wIuEdwBv3vWo9rpO6kfSvy1warSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0hW2FloDs2x7IJtJ?=
 =?us-ascii?q?KhfCUG1Y4rywDQZvCZaYSE/xTuX/uLLzhinnJqYre/ig638Uin1+LzSNG50E?=
 =?us-ascii?q?1PripZitnMsW0N1wDL5siHVPR9+kCh1C6T1w/J8OFEIF00lbHBJ54gxL4wmJ?=
 =?us-ascii?q?0TsV/dESDqgkn2kK+XeVkk+uiv8ejnZKnppoSAOINujwH+M6AultS+AeQ+LA?=
 =?us-ascii?q?cOQ3CW9fmz2bDs50H0QKhGguconqTWrpzWP9kXqra8AwBP04Yj7xi/Dy2h0N?=
 =?us-ascii?q?QdhXQHN09KeAmcgoj1O1DBPPD4DfClj1Sqizdk3erKPrLmApXTNnTDiqvufa?=
 =?us-ascii?q?5h605Azwo+1cpf55NIBbEBOv3zQFL+u8TEARAhMwy72efnCNNj2YMFQm+AGb?=
 =?us-ascii?q?OZMKLUsV+U+O0vOe+Ma5EJuDrnN/cl4Pvuh2cjmVABZampwYcXaHegE/R9PU?=
 =?us-ascii?q?qZZXvsgtEcEWYFpQc+UuPqh0OYUTJJZHa9Qbg85jclB4KiF4vDQZqtgLPSlB?=
 =?us-ascii?q?u8S6dXbWBPEFzEMX7pcYifE6MWaSmSK9VtpTczVbGgTYI6/RuytQnmxqBhI/?=
 =?us-ascii?q?aS8Sod49arz9Vx5uvOhTks+jFuSceQyWeASydzhGxbaSUx2fVEvUFlylqFmZ?=
 =?us-ascii?q?N9ivhcGM0bs+hFSS8mJJXcyKp8ENm0VQXfKITaAG26S8mrVGliBuk6xMUDNg?=
 =?us-ascii?q?MkQISv?=
X-IPAS-Result: =?us-ascii?q?A2AIAAAmzu9d/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYFsAwEBAQELAYFzgW0gEiqEA4kDhmcBAQEBAQEGgTeJaY9LgXsJA?=
 =?us-ascii?q?QEBAQEBAQEBNwEBhEACgic2Bw4CEAEBAQQBAQEBAQUDAQFshUOCOykBgnoBB?=
 =?us-ascii?q?SMECwEFUQkCGAICJgICVwYBDAYCAQGCUww/gkcDCSWSZpt0fzOJD4FIgQ4oA?=
 =?us-ascii?q?YwxeYEHgREnD4JdPoIbgi6DEIJeBI0sihZ2liyCOYI7ky8GG4JCjDeLPy2OH?=
 =?us-ascii?q?ZwyDiSBWCsIAhgIIQ+DJ1ARFIxyF45BIwMwjysBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Dec 2019 17:01:06 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBAH0pIu060383;
        Tue, 10 Dec 2019 12:00:51 -0500
Subject: Re: [V4 PATCH 1/1] selinux-testsuite: Add perf_event tests
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191208170646.75714-1-richard_c_haines@btinternet.com>
 <a9460e84-b96c-3704-6b64-72d08d6d619b@tycho.nsa.gov>
Message-ID: <da993614-e6ce-62ec-965b-b3b0294f980a@tycho.nsa.gov>
Date:   Tue, 10 Dec 2019 12:01:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a9460e84-b96c-3704-6b64-72d08d6d619b@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/10/19 10:31 AM, Stephen Smalley wrote:
> On 12/8/19 12:06 PM, Richard Haines wrote:
>> Test perf_event permissions.
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> 
> I'll fix the merge conflict.

Thanks, merged.

> 
>> ---
>> V2 Changes:
>> Remove neverallows from policy
>> Check /proc/sys/kernel/perf_event_paranoid, if < 2 then bypass the
>> capability { sys_admin } test.
>> V3 Changes:
>> Remove allow_map() and device_t:chr_file rules as not required.
>> V4 Change:
>> Correct policy module comment header.
>>
>>   defconfig                     |   6 ++
>>   policy/Makefile               |   4 +
>>   policy/test_perf_event.te     |  89 +++++++++++++++++
>>   tests/Makefile                |   4 +
>>   tests/perf_event/.gitignore   |   1 +
>>   tests/perf_event/Makefile     |   7 ++
>>   tests/perf_event/perf_event.c | 178 ++++++++++++++++++++++++++++++++++
>>   tests/perf_event/test         |  93 ++++++++++++++++++
>>   8 files changed, 382 insertions(+)
>>   create mode 100644 policy/test_perf_event.te
>>   create mode 100644 tests/perf_event/.gitignore
>>   create mode 100644 tests/perf_event/Makefile
>>   create mode 100644 tests/perf_event/perf_event.c
>>   create mode 100755 tests/perf_event/test
>>
>> diff --git a/defconfig b/defconfig
>> index 0574f1d..2d9c092 100644
>> --- a/defconfig
>> +++ b/defconfig
>> @@ -78,3 +78,9 @@ CONFIG_KEY_DH_OPERATIONS=y
>>   # Test key management socket.
>>   # This is not required for SELinux operation itself.
>>   CONFIG_NET_KEY=m
>> +
>> +# Test perf events.
>> +# This is not required for SELinux operation itself.
>> +CONFIG_HAVE_PERF_EVENTS=y
>> +CONFIG_PERF_EVENTS=y
>> +CONFIG_TRACEPOINTS=y
>> diff --git a/policy/Makefile b/policy/Makefile
>> index dda2e16..3f60991 100644
>> --- a/policy/Makefile
>> +++ b/policy/Makefile
>> @@ -101,6 +101,10 @@ ifeq ($(shell grep -q module_load 
>> $(POLDEV)/include/support/all_perms.spt && ech
>>   TARGETS+=test_module_load.te
>>   endif
>> +ifeq ($(shell grep -q perf_event 
>> $(POLDEV)/include/support/all_perms.spt && echo true),true)
>> +TARGETS += test_perf_event.te
>> +endif
>> +
>>   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>>   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te 
>> test_ibpkey.te, $(TARGETS))
>>   endif
>> diff --git a/policy/test_perf_event.te b/policy/test_perf_event.te
>> new file mode 100644
>> index 0000000..67250a4
>> --- /dev/null
>> +++ b/policy/test_perf_event.te
>> @@ -0,0 +1,89 @@
>> +#
>> +######### perf_event policy module ##########
>> +#
>> +attribute perfdomain;
>> +
>> +################# Allow perf_event { * } ##########################
>> +type test_perf_t;
>> +domain_type(test_perf_t)
>> +unconfined_runs_test(test_perf_t)
>> +typeattribute test_perf_t testdomain;
>> +typeattribute test_perf_t perfdomain;
>> +
>> +allow test_perf_t self:capability { sys_admin };
>> +allow test_perf_t self:perf_event { open cpu kernel tracepoint read 
>> write };
>> +
>> +################# Deny capability { sys_admin } 
>> ##########################
>> +type test_perf_no_admin_t;
>> +domain_type(test_perf_no_admin_t)
>> +unconfined_runs_test(test_perf_no_admin_t)
>> +typeattribute test_perf_no_admin_t testdomain;
>> +typeattribute test_perf_no_admin_t perfdomain;
>> +
>> +allow test_perf_no_admin_t self:perf_event { open cpu kernel 
>> tracepoint read write };
>> +
>> +################# Deny perf_event { open } ##########################
>> +type test_perf_no_open_t;
>> +domain_type(test_perf_no_open_t)
>> +unconfined_runs_test(test_perf_no_open_t)
>> +typeattribute test_perf_no_open_t testdomain;
>> +typeattribute test_perf_no_open_t perfdomain;
>> +
>> +allow test_perf_no_open_t self:capability { sys_admin };
>> +allow test_perf_no_open_t self:perf_event { cpu kernel tracepoint 
>> read write };
>> +
>> +################# Deny perf_event { cpu } ##########################
>> +type test_perf_no_cpu_t;
>> +domain_type(test_perf_no_cpu_t)
>> +unconfined_runs_test(test_perf_no_cpu_t)
>> +typeattribute test_perf_no_cpu_t testdomain;
>> +typeattribute test_perf_no_cpu_t perfdomain;
>> +
>> +allow test_perf_no_cpu_t self:capability { sys_admin };
>> +allow test_perf_no_cpu_t self:perf_event { open kernel tracepoint 
>> read write };
>> +
>> +################# Deny perf_event { kernel } ##########################
>> +type test_perf_no_kernel_t;
>> +domain_type(test_perf_no_kernel_t)
>> +unconfined_runs_test(test_perf_no_kernel_t)
>> +typeattribute test_perf_no_kernel_t testdomain;
>> +typeattribute test_perf_no_kernel_t perfdomain;
>> +
>> +allow test_perf_no_kernel_t self:capability { sys_admin };
>> +allow test_perf_no_kernel_t self:perf_event { open cpu tracepoint 
>> read write };
>> +
>> +################# Deny perf_event { tracepoint } 
>> ##########################
>> +type test_perf_no_tracepoint_t;
>> +domain_type(test_perf_no_tracepoint_t)
>> +unconfined_runs_test(test_perf_no_tracepoint_t)
>> +typeattribute test_perf_no_tracepoint_t testdomain;
>> +typeattribute test_perf_no_tracepoint_t perfdomain;
>> +
>> +allow test_perf_no_tracepoint_t self:capability { sys_admin };
>> +allow test_perf_no_tracepoint_t self:perf_event { open cpu kernel 
>> read write };
>> +
>> +################# Deny perf_event { read } ##########################
>> +type test_perf_no_read_t;
>> +domain_type(test_perf_no_read_t)
>> +unconfined_runs_test(test_perf_no_read_t)
>> +typeattribute test_perf_no_read_t testdomain;
>> +typeattribute test_perf_no_read_t perfdomain;
>> +
>> +allow test_perf_no_read_t self:capability { sys_admin };
>> +allow test_perf_no_read_t self:perf_event { open cpu kernel 
>> tracepoint write };
>> +
>> +################# Deny perf_event { write } ##########################
>> +type test_perf_no_write_t;
>> +domain_type(test_perf_no_write_t)
>> +unconfined_runs_test(test_perf_no_write_t)
>> +typeattribute test_perf_no_write_t testdomain;
>> +typeattribute test_perf_no_write_t perfdomain;
>> +
>> +allow test_perf_no_write_t self:capability { sys_admin };
>> +allow test_perf_no_write_t self:perf_event { open cpu kernel 
>> tracepoint read };
>> +
>> +#
>> +########### Allow these domains to be entered from sysadm domain 
>> ############
>> +#
>> +miscfiles_domain_entry_test_files(perfdomain)
>> +userdom_sysadm_entry_spec_domtrans_to(perfdomain)
>> diff --git a/tests/Makefile b/tests/Makefile
>> index 0d33fbf..8f66996 100644
>> --- a/tests/Makefile
>> +++ b/tests/Makefile
>> @@ -79,6 +79,10 @@ SUBDIRS+=module_load
>>   endif
>>   endif
>> +ifeq ($(shell grep -q perf_event 
>> $(POLDEV)/include/support/all_perms.spt && echo true),true)
>> +SUBDIRS += perf_event
>> +endif
>> +
>>   ifeq ($(DISTRO),RHEL4)
>>       SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap 
>> nnp_nosuid overlay unix_socket, $(SUBDIRS))
>>   endif
>> diff --git a/tests/perf_event/.gitignore b/tests/perf_event/.gitignore
>> new file mode 100644
>> index 0000000..8c2f931
>> --- /dev/null
>> +++ b/tests/perf_event/.gitignore
>> @@ -0,0 +1 @@
>> +perf_event
>> diff --git a/tests/perf_event/Makefile b/tests/perf_event/Makefile
>> new file mode 100644
>> index 0000000..988424c
>> --- /dev/null
>> +++ b/tests/perf_event/Makefile
>> @@ -0,0 +1,7 @@
>> +TARGETS = perf_event
>> +LDLIBS += -lselinux
>> +
>> +all: $(TARGETS)
>> +
>> +clean:
>> +    rm -f $(TARGETS)
>> diff --git a/tests/perf_event/perf_event.c 
>> b/tests/perf_event/perf_event.c
>> new file mode 100644
>> index 0000000..8983f02
>> --- /dev/null
>> +++ b/tests/perf_event/perf_event.c
>> @@ -0,0 +1,178 @@
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <errno.h>
>> +#include <stdbool.h>
>> +#include <asm/unistd.h>
>> +#include <sys/mman.h>
>> +#include <sys/ioctl.h>
>> +#include <linux/perf_event.h>
>> +#include <selinux/selinux.h>
>> +
>> +enum {
>> +    PERF_FILE_MMAP,
>> +    PERF_FILE,
>> +    PERF_MMAP
>> +} read_type;
>> +
>> +static void print_usage(char *progname)
>> +{
>> +    fprintf(stderr,
>> +        "usage:  %s [-f|-m] [-v]\n"
>> +        "Where:\n\t"
>> +        "-f  Read perf_event info using read(2)\n\t"
>> +        "-m  Read perf_event info using mmap(2)\n\t"
>> +        "    Default is to use read(2) and mmap(2)\n\t"
>> +        "-v  Print information\n", progname);
>> +    exit(-1);
>> +}
>> +
>> +static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
>> +                int cpu, int group_fd, unsigned long flags)
>> +{
>> +    return syscall(__NR_perf_event_open, hw_event, pid, cpu,
>> +               group_fd, flags);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    int opt, result, page_size, mmap_size, fd;
>> +    long long count;
>> +    bool verbose = false;
>> +    char *context;
>> +    void *base;
>> +    struct perf_event_attr pe_attr;
>> +    struct perf_event_mmap_page *pe_page;
>> +
>> +    read_type = PERF_FILE_MMAP;
>> +
>> +    while ((opt = getopt(argc, argv, "fmv")) != -1) {
>> +        switch (opt) {
>> +        case 'f':
>> +            read_type = PERF_FILE;
>> +            break;
>> +        case 'm':
>> +            read_type = PERF_MMAP;
>> +            break;
>> +        case 'v':
>> +            verbose = true;
>> +            break;
>> +        default:
>> +            print_usage(argv[0]);
>> +        }
>> +    }
>> +
>> +    if (verbose) {
>> +        result = getcon(&context);
>> +        if (result < 0) {
>> +            fprintf(stderr, "Failed to obtain process context\n");
>> +            exit(-1);
>> +        }
>> +        printf("Process context:\n\t%s\n", context);
>> +        free(context);
>> +    }
>> +
>> +    /* Test perf_event { open cpu kernel tracepoint } */
>> +    memset(&pe_attr, 0, sizeof(struct perf_event_attr));
>> +    pe_attr.type = PERF_TYPE_HARDWARE | PERF_TYPE_TRACEPOINT;
>> +    pe_attr.size = sizeof(struct perf_event_attr);
>> +    pe_attr.config = PERF_COUNT_HW_INSTRUCTIONS;
>> +    pe_attr.disabled = 1;
>> +    pe_attr.exclude_hv = 1;
>> +
>> +    fd = perf_event_open(&pe_attr, -1, 1, -1, 0);
>> +    if (fd < 0) {
>> +        fprintf(stderr, "Failed perf_event_open(): %s\n",
>> +            strerror(errno));
>> +        if (errno == EACCES)
>> +            exit(1);
>> +        else
>> +            exit(-1);
>> +    }
>> +
>> +    /* Test perf_event { write }; */
>> +    result = ioctl(fd, PERF_EVENT_IOC_RESET, 0);
>> +    if (result < 0) {
>> +        fprintf(stderr, "Failed ioctl(PERF_EVENT_IOC_RESET): %s\n",
>> +            strerror(errno));
>> +        if (errno == EACCES)
>> +            result = 2;
>> +        goto err;
>> +    }
>> +
>> +    result = ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
>> +    if (result < 0) {
>> +        fprintf(stderr, "Failed ioctl(PERF_EVENT_IOC_ENABLE): %s\n",
>> +            strerror(errno));
>> +        if (errno == EACCES)
>> +            result = 3;
>> +        goto err;
>> +    }
>> +
>> +    result = ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
>> +    if (result < 0) {
>> +        fprintf(stderr, "Failed ioctl(PERF_EVENT_IOC_DISABLE): %s\n",
>> +            strerror(errno));
>> +        if (errno == EACCES)
>> +            result = 4;
>> +        goto err;
>> +    }
>> +
>> +    /* Test mmap(2) perf_event { read } */
>> +    if (read_type == PERF_MMAP || read_type == PERF_FILE_MMAP) {
>> +        page_size = sysconf(_SC_PAGESIZE);
>> +        if (page_size < 0) {
>> +            fprintf(stderr, "Failed sysconf(_SC_PAGESIZE): %s\n",
>> +                strerror(errno));
>> +            if (errno == EACCES)
>> +                result = 5;
>> +            else
>> +                result = -1;
>> +            goto err;
>> +        }
>> +        mmap_size = page_size * 2;
>> +
>> +        base = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
>> +                MAP_SHARED, fd, 0);
>> +        if (base == MAP_FAILED) {
>> +            fprintf(stderr, "Failed mmap(): %s\n", strerror(errno));
>> +            if (errno == EACCES)
>> +                result = 6;
>> +            else
>> +                result = -1;
>> +            goto err;
>> +        }
>> +
>> +        if (verbose) {
>> +            pe_page = base;
>> +            printf("perf mmap(2) return value: %lld\n",
>> +                   pe_page->offset);
>> +        }
>> +
>> +        munmap(base, mmap_size);
>> +    }
>> +
>> +    /* Test read(2) perf_event { read } */
>> +    if (read_type == PERF_FILE || read_type == PERF_FILE_MMAP) {
>> +        result = read(fd, &count, sizeof(long long));
>> +        if (result < 0) {
>> +            fprintf(stderr, "Failed read(): %s\n", strerror(errno));
>> +            if (errno == EACCES)
>> +                result = 7;
>> +            goto err;
>> +        }
>> +
>> +        if (verbose)
>> +            printf("perf read(2) return value: %lld\n", count);
>> +
>> +        close(fd);
>> +    }
>> +
>> +    return 0;
>> +
>> +err:
>> +    close(fd);
>> +    return result;
>> +}
>> diff --git a/tests/perf_event/test b/tests/perf_event/test
>> new file mode 100755
>> index 0000000..1c2e4a9
>> --- /dev/null
>> +++ b/tests/perf_event/test
>> @@ -0,0 +1,93 @@
>> +#!/usr/bin/perl
>> +use Test::More;
>> +
>> +BEGIN {
>> +    $basedir = $0;
>> +    $basedir =~ s|(.*)/[^/]*|$1|;
>> +
>> +    $test_count = 8;
>> +    $sys_admin  = 0;
>> +
>> +    # allow info to be shown during tests
>> +    $v = $ARGV[0];
>> +    if ($v) {
>> +        if ( $v ne "-v" ) {
>> +            plan skip_all => "Invalid option (use -v)";
>> +        }
>> +    }
>> +    else {
>> +        $v = " ";
>> +    }
>> +
>> +    $level = `cat /proc/sys/kernel/perf_event_paranoid`;
>> +    chomp($level);
>> +    if ( $level >= 2 ) {    # These tests require CAP_SYS_ADMIN
>> +        $test_count += 1;
>> +        $sys_admin = 1;
>> +    }
>> +
>> +    if ( $v eq "-v" ) {
>> +        print "Paranoid level: $level\n";
>> +        if ( $level < 0 ) {
>> +            print "\tNot paranoid\n";
>> +        }
>> +        elsif ( $level eq 0 ) {
>> +            print "\tDisallow raw tracepoint/ftrace without 
>> CAP_SYS_ADMIN\n";
>> +        }
>> +        elsif ( $level eq 1 ) {
>> +            print "\tDisallow CPU event access without CAP_SYS_ADMIN\n";
>> +        }
>> +        elsif ( $level eq 2 ) {
>> +            print "\tDisallow kernel profiling without CAP_SYS_ADMIN\n";
>> +        }
>> +        else {
>> +            print "\tUndefined level\n";
>> +        }
>> +    }
>> +
>> +    plan tests => $test_count;
>> +}
>> +
>> +# perf_event { open cpu kernel tracepoint read write };
>> +print "Test perf_event\n";
>> +$result = system "runcon -t test_perf_t $basedir/perf_event $v";
>> +ok( $result eq 0 );
>> +
>> +if ($sys_admin) {
>> +
>> +    # Deny capability { sys_admin } - EACCES perf_event_open(2)
>> +    $result =
>> +      system "runcon -t test_perf_no_admin_t $basedir/perf_event $v 
>> 2>&1";
>> +    ok( $result >> 8 eq 1 );
>> +}
>> +
>> +# Deny perf_event { open } - EACCES perf_event_open(2)
>> +$result = system "runcon -t test_perf_no_open_t $basedir/perf_event 
>> $v 2>&1";
>> +ok( $result >> 8 eq 1 );
>> +
>> +# Deny perf_event { cpu } - EACCES perf_event_open(2)
>> +$result = system "runcon -t test_perf_no_cpu_t $basedir/perf_event $v 
>> 2>&1";
>> +ok( $result >> 8 eq 1 );
>> +
>> +# Deny perf_event { kernel } - EACCES perf_event_open(2)
>> +$result = system "runcon -t test_perf_no_kernel_t $basedir/perf_event 
>> $v 2>&1";
>> +ok( $result >> 8 eq 1 );
>> +
>> +# Deny perf_event { tracepoint } - EACCES perf_event_open(2)
>> +$result =
>> +  system "runcon -t test_perf_no_tracepoint_t $basedir/perf_event $v 
>> 2>&1";
>> +ok( $result >> 8 eq 1 );
>> +
>> +# Deny perf_event { read } - EACCES mmap(2)
>> +$result = system "runcon -t test_perf_no_read_t $basedir/perf_event 
>> -m $v 2>&1";
>> +ok( $result >> 8 eq 6 );
>> +
>> +# Deny perf_event { read } - EACCES read(2)
>> +$result = system "runcon -t test_perf_no_read_t $basedir/perf_event 
>> -f $v 2>&1";
>> +ok( $result >> 8 eq 7 );
>> +
>> +# Deny perf_event { write } - EACCES ioctl(2) write
>> +$result = system "runcon -t test_perf_no_write_t $basedir/perf_event 
>> $v 2>&1";
>> +ok( $result >> 8 eq 2 );
>> +
>> +exit;
>>
> 

