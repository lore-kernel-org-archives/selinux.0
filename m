Message-ID: <4900315A.80208@ak.jp.nec.com>
Date: Thu, 23 Oct 2008 17:10:02 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: subrata@linux.vnet.ibm.com
CC: James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        paul.moore@hp.com, jbrindle@tresys.com, selinux@tycho.nsa.gov,
        ltp-list <ltp-list@lists.sf.net>
Subject: Re: [LTP][PATCH 2/2]  Add a new test case for bounds types
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com>	 <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>	 <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>	 <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com>	 <4897EB5A.1040404@ak.jp.nec.com>	 <1217940793.2994.52.camel@moss-spartans.epoch.ncsc.mil>	 <48997937.8050105@ak.jp.nec.com>  <48A3E0E8.4000902@ak.jp.nec.com>	 <1218824000.29535.315.camel@moss-spartans.epoch.ncsc.mil>	 <48B2A669.7040800@ak.jp.nec.com>	 <alpine.LRH.1.10.0808262015360.6838@tundra.namei.org>	 <alpine.LRH.1.10.0808262046000.6838@tundra.namei.org>	 <48B50AB5.4030502@ak.jp.nec.com> <1224680431.9160.69.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1224680431.9160.69.camel@subratamodak.linux.ibm.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Subrata Modak wrote:
> Kaigai,
> 
> Are these tests ready to be added to LTP ?

I agree to the patch to be added to LTP, if it is acceptable. :)

Please note that the type bounds feature now got merged into Linus's tree,
but it is not released officially.
(I guess the v2.6.28 will be released about three months later.)

I'm not good at the policy in LTP' community, so I will support their decision.

Thanks,

> Regards--
> Subrata
> 
> On Wed, 2008-08-27 at 17:05 +0900, KaiGai Kohei wrote:
>> James Morris wrote:
>>> Could you also please add tests for this (at least one which should
>> fail 
>>> and one which should succeed) to the Linux Test Project?
>>>
>>>
>>> - James
>> The attached patch adds a new test case to check correctness of
>> boundary
>> feature. It contains four sub tests, as follows:
>>
>> test01: It tries to invoke setcon() with bounded domain in a
>> multi-threaded
>>          process. The expected result is success.
>> test02: It tries to invoke setcon() with unrelated domain in a
>> multi-threaded
>>          process. The expected result is fail.
>> test03: It makes a bounded domain try to read a file, when its bounds
>> domain
>>          can read the file. The expected result is success.
>> test04: It makes a bounded domain try to write a file, when its bounds
>> domain
>>          cannot write the file. The expected result is fail, even if
>> the bounded
>>          domain is allowed to write the file.
>>
>> ---- The result of execution
>> [root@saba tests]# ./runtest.sh bounds
>> /home/kaigai/develop/ltp/testcases/kernel/security/selinux-testsuite/tests
>> Running with security
>> context=unconfined_u:unconfined_r:unconfined_t:SystemLow-SystemHigh
>> 1+0 records in
>> 1+0 records out
>> 1024 bytes (1.0 kB) copied, 8.6321e-05 s, 11.9 MB/s
>> All systems go
>> test01   PASS : thread dyntrans passed.
>> setcon() on multithread process failed: Operation not permitted
>> All systems go
>> test02   PASS : thread dyntrans to unbound domain failed.
>> 2+0 records in
>> 2+0 records out
>> 1024 bytes (1.0 kB) copied, 4.2932e-05 s, 23.9 MB/s
>> test03   PASS : unbounded action to be allowed.
>> dd: opening `/tmp/selinux/test_file': Permission denied
>> test04   PASS : bounded action to be denied.
>> Done.
>> [root@saba tests]#
>>
>> (*) I added a bit ad-hoc policy to invoke the script from the shell.
>>
>> -- 
>> OSS Platform Development Division, NEC
>> KaiGai Kohei <kaigai@ak.jp.nec.com>
>>
>>
>>
>>
>>
>>
>>
>> differences
>> between files
>> attachment
>> (ltp-selinux-bounds-tests.patch)
>>
>> Index: ltp/testcases/kernel/security/selinux-testsuite/tests/Makefile
>> ===================================================================
>> ---
>> ltp/testcases/kernel/security/selinux-testsuite/tests/Makefile      (revision 2)
>> +++
>> ltp/testcases/kernel/security/selinux-testsuite/tests/Makefile      (revision 3)
>> @@ -3,7 +3,7 @@
>>  ifeq (redhat-release-4, $(findstring redhat-release-4,
>> $(REDHAT_RELEASE)))
>>      SUBDIRS=domain_trans entrypoint execshare exectrace
>> execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink
>> relabel rename rxdir sem setattr setnice shm sigkill stat sysctl
>> task_create task_setnice task_setscheduler task_getscheduler
>> task_getsid task_getpgid task_setpgid wait file ioctl capable_file
>> capable_net capable_sys
>>  else
>> -    SUBDIRS=domain_trans entrypoint execshare exectrace
>> execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink
>> relabel rename rxdir sem setattr setnice shm sigkill stat sysctl
>> task_create task_setnice task_setscheduler task_getscheduler
>> task_getsid task_getpgid task_setpgid wait file ioctl capable_file
>> capable_net capable_sys dyntrace dyntrans
>> +    SUBDIRS=domain_trans entrypoint execshare exectrace
>> execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink
>> relabel rename rxdir sem setattr setnice shm sigkill stat sysctl
>> task_create task_setnice task_setscheduler task_getscheduler
>> task_getsid task_getpgid task_setpgid wait file ioctl capable_file
>> capable_net capable_sys dyntrace dyntrans bounds
>>  endif
>>
>>  all: 
>> Index:
>> ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds_thread.c
>> ===================================================================
>> ---
>> ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds_thread.c        (revision 0)
>> +++
>> ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds_thread.c        (revision 3)
>> @@ -0,0 +1,82 @@
>> +/*
>> + * Copyright (c) 2008 NEC Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or
>> modify it
>> + * under the terms of the GNU General Public License as published by
>> the Free
>> + * Software Foundation; either version 2 of the License, or (at your
>> option)
>> + * any later version.
>> + */
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <pthread.h>
>> +#include <selinux/selinux.h>
>> +#include <selinux/context.h>
>> +
>> +static int thread_status = 0;
>> +
>> +static void *worker(void *datap)
>> +{
>> +       security_context_t security_context = datap;
>> +       int rc;
>> +
>> +       rc = setcon(security_context);
>> +       if (rc < 0) {
>> +               perror("setcon() on multithread process failed");
>> +               thread_status = 1;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +       security_context_t security_context;
>> +       context_t context;
>> +       pthread_t thread;
>> +       int rc;
>> +
>> +       if (argc != 2) {
>> +               fprintf(stderr, "usage: %s <new domain>\n", argv[0]);
>> +               return 1;
>> +       }
>> +
>> +       rc = getcon(&security_context);
>> +       if (rc < 0) {
>> +               fprintf(stderr, "%s: unable to get my context\n",
>> argv[0]);
>> +               return 1;
>> +       }
>> +
>> +       context = context_new(security_context);
>> +       if (!context) {
>> +               fprintf(stderr, "%s: unable to create context
>> structure\n", argv[0]);
>> +               return 1;
>> +       }
>> +
>> +       if (context_type_set(context, argv[1])) {
>> +               fprintf(stderr, "%s: unable to set new type\n",
>> argv[0]);
>> +               return 1;
>> +        }
>> +
>> +       freecon(security_context);
>> +       security_context = context_str(context);
>> +       if (!security_context) {
>> +               fprintf(stderr, "%s: unable to obtain new context
>> string\n", argv[0]);
>> +               return 1;
>> +       }
>> +
>> +       rc = pthread_create(&thread, NULL, worker, security_context);
>> +       if (rc) {
>> +               fprintf(stderr, "%s: unable to kick a new thread\n",
>> argv[0]);
>> +               return 1;
>> +       }
>> +
>> +       rc = pthread_join(thread, NULL);
>> +       if (rc) {
>> +               fprintf(stderr, "%s: unable to join its thread\n",
>> argv[0]);
>> +               return 1;
>> +       }
>> +
>> +       printf("All systems go\n");
>> +       return thread_status;
>> +}
>> Index:
>> ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds.sh
>> ===================================================================
>> ---
>> ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds.sh      (revision 0)
>> +++
>> ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds.sh      (revision 3)
>> @@ -0,0 +1,123 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2008 NEC Corporation
>> +#
>> +# This program is free software; you can redistribute it and/or
>> modify it
>> +# under the terms of the GNU General Public License as published by
>> the Free
>> +# Software Foundation; either version 2 of the License, or (at your
>> option)
>> +# any later version.
>> +#
>> +
>> +setup()
>> +{
>> +       export TCID="setup"
>> +       export TST_COUNT=0
>> +       export TST_TOTAL=4
>> +
>> +       # Remove any leftover test directories from prior failed runs.
>> +       rm -rf $SELINUXTMPDIR/test_file
>> +
>> +       # Create a test files
>> +       dd if=/dev/zero of=$SELINUXTMPDIR/test_file count=1 bs=1024
>> +       chcon -t test_bounds_file_t $SELINUXTMPDIR/test_file
>> +}
>> +
>> +test01()
>> +{
>> +       TCID="test01"
>> +       TST_COUNT=1
>> +       RC=0
>> +
>> +       runcon -t test_bounds_parent_t \
>> +              -- selinux_bounds_thread test_bounds_child_t 2>&1
>> +       RC=$?
>> +       if [ $RC -eq 0 ];
>> +       then
>> +               echo "$TCID   PASS : thread dyntrans passed."
>> +       else
>> +               echo "$TCID   FAIL : thread dynstrans failed."
>> +       fi
>> +       return $RC
>> +}
>> +
>> +test02()
>> +{
>> +       TCID="test02"
>> +       TST_COUND=2
>> +       RC=0
>> +
>> +       runcon -t test_bounds_parent_t \
>> +              -- selinux_bounds_thread test_bounds_unbound_t 2>&1
>> +       RC=$?
>> +       if [ $RC -ne 0 ];       # we expect this to fail
>> +       then
>> +               echo "$TCID   PASS : thread dyntrans to unbound domain
>> failed."
>> +               RC=0
>> +       else
>> +               echo "$TCID   FAIL : thread dyntrans to unbound domain
>> succeeded."
>> +               RC=1
>> +       fi
>> +       return $RC
>> +}
>> +
>> +test03()
>> +{
>> +       TCID="test03"
>> +       TST_COUND=3
>> +       RC=0
>> +
>> +       runcon -t test_bounds_child_t \
>> +              -- dd if=$SELINUXTMPDIR/test_file of=/dev/null
>> +       RC=$?
>> +       if [ $RC -eq 0 ];
>> +       then
>> +               echo "$TCID   PASS : unbounded action to be allowed."
>> +       else
>> +               echo "$TCID   FAIL : unbounded action to be allowed."
>> +       fi
>> +       return $RC
>> +}
>> +
>> +test04()
>> +{
>> +       TCID="test04"
>> +       TST_COUNT=4
>> +       RC=0
>> +
>> +       runcon -t test_bounds_child_t \
>> +               -- dd if=/dev/zero of=$SELINUXTMPDIR/test_file count=1
>> bs=1024
>> +       RC=$?
>> +       if [ $RC -ne 0 ];       # we expect this to fail
>> +       then
>> +               echo "$TCID   PASS : bounded action to be denied."
>> +               RC=0
>> +       else
>> +               echo "$TCID   FAIL : bounded action to be denied."
>> +               RC=1
>> +       fi
>> +       return $RC
>> +}
>> +
>> +cleanup()
>> +{
>> +       # Cleanup
>> +       rm -rf $SELINUXTMPDIR/test_file
>> +}
>> +
>> +# Function:    main
>> +#
>> +# Description: - Execute all tests, exit with test status.
>> +#
>> +# Exit:                - zero on success
>> +#              - non-zero on failure.
>> +#
>> +RC=0   # Return value from setup, and test functions.
>> +EXIT_VAL=0
>> +
>> +setup
>> +test01 || EXIT_VAL=$RC
>> +test02 || EXIT_VAL=$RC
>> +test03 || EXIT_VAL=$RC
>> +test04 || EXIT_VAL=$RC
>> +cleanup
>> +exit $EXIT_VAL
>>
>> Property changes on:
>> ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/selinux_bounds.sh
>> ___________________________________________________________________
>> Added: svn:executable
>>    + *
>>
>> Index:
>> ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/Makefile
>> ===================================================================
>> ---
>> ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/Makefile       (revision 0)
>> +++
>> ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/Makefile       (revision 3)
>> @@ -0,0 +1,11 @@
>> +TARGETS=$(patsubst %.c,%,$(wildcard *.c))
>> +LDLIBS += -lselinux -lpthread
>> +
>> +all: $(TARGETS)
>> +
>> +install:
>> +       @set -e; for i in $(TARGETS); do ln -f
>> $$i ../../../../../bin/$$i; done
>> +       ln -f selinux_bounds.sh ../../../../../bin/
>> +
>> +clean:
>> +       rm -f $(TARGETS)
>> \ No newline at end of file
>> Index:
>> ltp/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile
>> ===================================================================
>> ---
>> ltp/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile  (revision 2)
>> +++
>> ltp/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile  (revision 3)
>> @@ -1,7 +1,7 @@
>>  POLICYDEVEL = /usr/share/selinux/devel
>>  SEMODULE = /usr/sbin/semodule
>>
>> -TARGETS=test_global.te test_capable_file.te test_capable_net.te \
>> +TARGETS=test_global.te test_bounds.te test_capable_file.te
>> test_capable_net.te \
>>  test_capable_sys.te test_dyntrace.te test_dyntrans.te
>> test_entrypoint.te \
>>  test_execshare.te test_exectrace.te test_execute_no_trans.te \
>>  test_fdreceive.te test_file.te test_inherit.te test_ioctl.te
>> test_ipc.te \
>> Index:
>> ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_bounds.te
>> ===================================================================
>> ---
>> ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_bounds.te    (revision 0)
>> +++
>> ltp/testcases/kernel/security/selinux-testsuite/refpolicy/test_bounds.te    (revision 3)
>> @@ -0,0 +1,65 @@
>> +#################################
>> +#
>> +# Policy for testing boundary features
>> +#
>> +
>> +attribute test_bounds_domain;
>> +
>> +# Domain for process that allows to other domains
>> +type test_bounds_parent_t;
>> +domain_type(test_bounds_parent_t)
>> +typeattribute test_bounds_parent_t test_bounds_domain;
>> +typeattribute test_bounds_parent_t testdomain;
>> +
>> +# Domain for process that has a bounds type
>> +type test_bounds_child_t;
>> +domain_type(test_bounds_child_t)
>> +typeattribute test_bounds_child_t test_bounds_domain;
>> +typeattribute test_bounds_child_t testdomain;
>> +
>> +# Domain for process that does not have any bounds type
>> +type test_bounds_unbound_t;
>> +domain_type(test_bounds_unbound_t)
>> +typeattribute test_bounds_unbound_t test_bounds_domain;
>> +typeattribute test_bounds_unbound_t testdomain;
>> +
>> +# Types for test files
>> +type test_bounds_file_t;
>> +files_type(test_bounds_file_t)
>> +
>> +# Definition of boundary relationship
>> +typebounds test_bounds_parent_t test_bounds_child_t;
>> +
>> +# Allow the test_bounds_parent_t to dyntrans
>> +allow test_bounds_parent_t test_bounds_child_t   : process
>> { dyntransition };
>> +allow test_bounds_parent_t test_bounds_unbound_t : process
>> { dyntransition };
>> +
>> +# Allow domains to access test_bounds_file_t
>> +allow test_bounds_parent_t  test_bounds_file_t : file
>> { read_file_perms };
>> +allow test_bounds_child_t   test_bounds_file_t : file
>> { rw_file_perms };
>> +allow test_bounds_unbound_t test_bounds_file_t : file
>> { rw_file_perms };
>> +
>> +# Allow execution of helper programs.
>> +corecmd_exec_bin(test_bounds_domain)
>> +allow test_bounds_domain bin_t : file { entrypoint };
>> +libs_use_ld_so(test_bounds_domain)
>> +libs_use_shared_libs(test_bounds_domain)
>> +libs_exec_ld_so(test_bounds_domain)
>> +libs_exec_lib_files(test_bounds_domain)
>> +
>> +# Allow all of these domains to be entered from sysadm domain
>> +miscfiles_domain_entry_test_files(test_bounds_domain)
>> +sysadm_entry_spec_domtrans(test_bounds_domain)
>> +
>> +# Allow to invoke script on targeted policy
>> +optional_policy(`
>> +       gen_require(`
>> +               role unconfined_r;
>> +               type unconfined_t;
>> +       ')
>> +
>> +       role unconfined_r types test_bounds_domain;
>> +       allow unconfined_t test_bounds_domain : process
>> { transition };
>> +
>> +       userdom_use_user_terminals(unconfined, test_bounds_domain)
>> +')
>>
> 
> 
> 


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
