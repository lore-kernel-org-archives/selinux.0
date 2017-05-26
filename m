Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4Q23AXQ006442
 for <selinux@tycho.nsa.gov>; Thu, 25 May 2017 22:03:14 -0400
Received: by mail-lf0-f67.google.com with SMTP id m18so14696944lfj.0
 for <selinux@tycho.nsa.gov>; Thu, 25 May 2017 19:03:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1495742895.22368.11.camel@tycho.nsa.gov>
References: <1495635523-84017-1-git-send-email-danielj@mellanox.com>
 <1495635523-84017-3-git-send-email-danielj@mellanox.com>
 <1495742895.22368.11.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 May 2017 22:03:06 -0400
Message-ID: <CAHC9VhSNMQ5FVCqyBsH0e2JJ+9And++1gQc6GMVrMsDac=N3_A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] selinux-testsuite: Infiniband endport tests
To: Stephen Smalley <sds@tycho.nsa.gov>, Dan Jurgens <danielj@mellanox.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 25, 2017 at 4:08 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2017-05-24 at 17:18 +0300, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> New tests for Infiniband endports. Most users do not have infiniband
>> hardware, and if they do the device names can vary.  There is a
>> configuration file for enabling the tests and setting environment
>> specific configurations.  If the tests are disabled they always show
>> as
>> passed.
>>
>> A special test application was unnecessary, a standard diagnostic
>> application is used instead.  This required a change to the make file
>> to avoid trying to build an application in the new subdir.
>>
>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>

...

>> +
>> +# Allow all of these domains to be entered from the sysadm domain.
>> +miscfiles_domain_entry_test_files(ibendportdomain)
>> +userdom_sysadm_entry_spec_domtrans_to(ibendportdomain)
>> diff --git a/tests/Makefile b/tests/Makefile
>> index 7dfe2a8..63e6f57 100644
>> --- a/tests/Makefile
>> +++ b/tests/Makefile
>> @@ -12,6 +12,8 @@ SUBDIRS:= domain_trans entrypoint execshare
>> exectrace execute_no_trans \
>>       capable_sys dyntrans dyntrace bounds nnp mmap unix_socket
>> inet_socket \
>>       overlay checkreqprot mqueue mac_admin infiniband_pkey
>>
>> +SUBDIRS_NO_MAKE:= infiniband_endport
>> +
>>  ifeq ($(shell grep -q cap_userns
>> $(POLDEV)/include/support/all_perms.spt && echo true),true)
>>  ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
>>  SUBDIRS += cap_userns
>> @@ -56,7 +58,7 @@ all:
>>
>>  test: all
>>       chcon -R -t test_file_t .
>> -     @SUBDIRS="$(SUBDIRS)" PATH=/usr/bin:/bin:/usr/sbin:/sbin
>> ./runtests.pl
>> +     @SUBDIRS="$(SUBDIRS) $(SUBDIRS_NO_MAKE)"
>> PATH=/usr/bin:/bin:/usr/sbin:/sbin ./runtests.pl
>
> This works, but elsewhere we've always just put a trivial Makefile with
> empty all: and clean: targets in it, e.g. entrypoint/Makefile.  No big
> deal either way.

Since it looks like this needs a respin anyway to fix other issues,
I'd probably prefer the entrypoint/Makefile approach for the sake of
consistency.

-- 
paul moore
www.paul-moore.com
