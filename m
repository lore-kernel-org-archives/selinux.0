Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59443341AB7
	for <selinux@vger.kernel.org>; Mon, 18 Aug 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534386; cv=none; b=WX1oJ70upU1WYTMiV+6v4SeJ7R9F38W0CR5/aEbLwhcJfa12g20NL4HMHZYoBvPFJ7FshNxyKayPBiTchuC+56aTSMIywY04SBPsi+74Q/YjA9rSSVFYw98Q9OgjUeVaVeAoxXzIXw8Awkbh45rcSRykELy70MyodY9NAZWRxtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534386; c=relaxed/simple;
	bh=ic52K+YbTdp+UUJYKMCaeiKMqOR5prQ994K5OMSC7GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5U7tRikGDd7lzx0YGykWhC1AxQxEkoqTfdiRSSQXDL3/J6r1ox8ieaGB8Olid0JbToyAm57jQlSo5plnTIZxXPANzZuPLXiXk7aBHrwB0PGt0lk7MYxbRUalOIyR/IQ52sJUNgGcgy3W24zu7mOmJxn+oXk1gR5HupTu9mhSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LOjGTGmQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LOjGTGmQ"
Received: from [10.137.198.68] (unknown [131.107.8.68])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A89B201C745;
	Mon, 18 Aug 2025 09:26:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A89B201C745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755534379;
	bh=dzHebWMoUW1+kKeWtbAPKOZ35iK/lYBhIjQEcwmhZ8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LOjGTGmQx4xz6vm5o63mthz2pzF7oh5Q/kF4QjkGyXWphfBoRMsoTfP8bu/dKFq3Y
	 Y1qE8sga0VYsJt0osS9sDOkR88iZEkqG/ykED9GALEnu7IM8Q6gYIGk8N46ydkHVjA
	 /BobLCXdEqqjlqFydCbfe/alTRZX2kcVvro6gFlA=
Message-ID: <595c0f7c-2d44-403f-8ae7-31d72eef7513@linux.microsoft.com>
Date: Mon, 18 Aug 2025 09:26:17 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH testsuite v2] tests/bpf: Add tests for SELinux BPF token
 access control
To: Daniel Durning <danieldurning.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com,
 stephen.smalley.work@gmail.com, omosnace@redhat.com
References: <20250817191031.1150-1-ericsu@linux.microsoft.com>
 <CAKrb_fGsWid=-muzOorRR6gQ8onf3EZ6z93ocQaM4SZ8-9Pxaw@mail.gmail.com>
Content-Language: en-US
From: Eric Suen <ericsu@linux.microsoft.com>
In-Reply-To: <CAKrb_fGsWid=-muzOorRR6gQ8onf3EZ6z93ocQaM4SZ8-9Pxaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/18/2025 7:37 AM, Daniel Durning wrote:
> On Sun, Aug 17, 2025 at 3:10 PM Eric Suen <ericsu@linux.microsoft.com> wrote:
>> This patch adds new tests to verify the SELinux support for BPF token
>> access control, as introduced in the corresponding kernel patch:
>>    https://lore.kernel.org/selinux/20250816201420.197-1-ericsu@linux.microsoft.com/
>>
>> Four new tests are added to cover both positive and negative scenarios,
>> ensuring that the SELinux policy enforcement on BPF token usage behaves
>> as expected.
>>    - Successful map_create and prog_load when SELinux permissions are
>>      granted.
>>    - Enforcement of SELinux policy restrictions when access is denied.
>>
>> For testing purposes, you can update the base policy by manually
>> modifying your base module and tweaking /usr/share/selinux/devel as
>> follows:
>>    sudo semodule -c -E base
>>    sudo cp base.sil base.sil.orig
>>    sudo sed -i "s/map_create/map_create map_create_as/" base.cil
>>    sudo sed -i "s/prog_load/prog_load prog_load_as/" base.cil
>>    sudo semodule -i base.cil
>>    echo "(policycap bpf_token_perms)" > bpf_token_perms.cil
>>    sudo semodule -i bpf_token_perms.cil
>>    sudo cp /usr/share/selinux/devel/include/support/all_perms.spt \
>>        /usr/share/selinux/devel/include/support/all_perms.spt.orig
>>    sudo sed -i "s/"map_create/map_create map_create_as/" \
>>        /usr/share/selinux/devel/include/support/all_perms.spt
>>    sudo sed -i "s/prog_load/prog_load prog_load_as/" \
>>        /usr/share/selinux/devel/include/support/all_perms.spt
>>
>> When finished testing, you can semodule -r base bpf_token_perms to
>> undo the two module changes and restore your all_perms.spt file from
>> the saved .orig file.
>>
>> Changes in v2:
>> - Removed allow rule for 'kernel_t' in test_bpf.te which was added due
>>    to a bug in the kernel
>> - Cleaned up other unnecessary rules in test_bpf.te
>> - Added token_test.c which was missing from previous patch
>>
>> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
>> ---
>>   policy/test_bpf.te     |  39 +++
>>   tests/bpf/Makefile     |   5 +-
>>   tests/bpf/bpf_common.h |  10 +
>>   tests/bpf/bpf_test.c   |  59 +++--
>>   tests/bpf/test         |  21 +-
>>   tests/bpf/token_test.c | 538 +++++++++++++++++++++++++++++++++++++++++
>>   6 files changed, 653 insertions(+), 19 deletions(-)
>>   create mode 100644 tests/bpf/token_test.c
>>
>> diff --git a/policy/test_bpf.te b/policy/test_bpf.te
>> index 5eab0bd..45da852 100644
>> --- a/policy/test_bpf.te
>> +++ b/policy/test_bpf.te
>> @@ -57,3 +57,42 @@ typeattribute test_bpf_deny_prog_run_t bpfdomain;
>>   allow test_bpf_deny_prog_run_t self:process { setrlimit };
>>   allow test_bpf_deny_prog_run_t self:capability { sys_resource sys_admin };
>>   allow test_bpf_deny_prog_run_t self:bpf { map_create map_read map_write prog_load };
>> +
>> +################### Allow map_create_as and prog_load_as ###################
>> +fs_list_bpf_dirs(test_bpf_t)
>> +allow test_bpf_t bpf_t:filesystem mount;
>> +allow test_bpf_t root_t:dir mounton;
>> +allow test_bpf_t self:bpf { map_create_as prog_load_as };
>> +allow test_bpf_t self:cap2_userns { bpf perfmon };
>> +allow test_bpf_t self:cap_userns { net_admin setgid setuid sys_admin };
>> +allow test_bpf_t self:user_namespace create;
>> +
>> +############################ Deny map_create_as ############################
>> +type test_bpf_deny_map_create_as_t;
>> +testsuite_domain_type(test_bpf_deny_map_create_as_t)
>> +typeattribute test_bpf_deny_map_create_as_t bpfdomain;
>> +allow test_bpf_deny_map_create_as_t self:process { setrlimit };
>> +allow test_bpf_deny_map_create_as_t self:capability { sys_resource sys_admin };
>> +
>> +fs_list_bpf_dirs(test_bpf_deny_map_create_as_t)
>> +allow test_bpf_deny_map_create_as_t bpf_t:filesystem mount;
>> +allow test_bpf_deny_map_create_as_t root_t:dir mounton;
>> +allow test_bpf_deny_map_create_as_t self:bpf { map_create map_read map_write prog_load prog_load_as };
>> +allow test_bpf_deny_map_create_as_t self:cap2_userns { bpf };
>> +allow test_bpf_deny_map_create_as_t self:cap_userns { setgid setuid sys_admin };
>> +allow test_bpf_deny_map_create_as_t self:user_namespace create;
>> +
>> +############################ Deny prog_load_as #############################
>> +type test_bpf_deny_prog_load_as_t;
>> +testsuite_domain_type(test_bpf_deny_prog_load_as_t)
>> +typeattribute test_bpf_deny_prog_load_as_t bpfdomain;
>> +allow test_bpf_deny_prog_load_as_t self:process { setrlimit };
>> +allow test_bpf_deny_prog_load_as_t self:capability { sys_resource sys_admin };
>> +
>> +fs_list_bpf_dirs(test_bpf_deny_prog_load_as_t)
>> +allow test_bpf_deny_prog_load_as_t bpf_t:filesystem mount;
>> +allow test_bpf_deny_prog_load_as_t root_t:dir mounton;
>> +allow test_bpf_deny_prog_load_as_t self:bpf { map_create map_create_as map_read map_write prog_load };
>> +allow test_bpf_deny_prog_load_as_t self:cap2_userns { bpf perfmon };
>> +allow test_bpf_deny_prog_load_as_t self:cap_userns { net_admin setgid setuid sys_admin };
>> +allow test_bpf_deny_prog_load_as_t self:user_namespace create;
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
>> diff --git a/tests/bpf/bpf_test.c b/tests/bpf/bpf_test.c
>> index 3c6a29c..a8dc383 100644
>> --- a/tests/bpf/bpf_test.c
>> +++ b/tests/bpf/bpf_test.c
>> @@ -1,28 +1,38 @@
>>   #include "bpf_common.h"
>>
>> +#define write_verbose(verbose, fmt, ...) \
>> +       do { \
>> +               if (verbose) \
>> +                       printf(fmt "\n", ##__VA_ARGS__); \
>> +       } while (0)
>> +
>>   static void usage(char *progname)
>>   {
>>          fprintf(stderr,
>> -               "usage:  %s -m|-p [-v]\n"
>> +               "usage:  %s -m|-p|-c|-l [-v]\n"
>>                  "Where:\n\t"
>>                  "-m    Create BPF map fd\n\t"
>>                  "-p    Create BPF prog fd\n\t"
>> +               "-c    Test BPF token map create\n\t"
>> +               "-l    Test BPF token program load\n\t"
>>                  "-v Print information.\n", progname);
>>          exit(-1);
>>   }
>>
>>   int main(int argc, char *argv[])
>>   {
>> -       int opt, result, fd;
>> -       bool verbose = false;
>> +       int opt, result, ret;
>> +       bool verbose = false, is_fd = true;
>>          char *context;
>>
>>          enum {
>>                  MAP_FD = 1,
>> -               PROG_FD
>> +               PROG_FD,
>> +               MAP_CREATE,
>> +               PROG_LOAD,
>>          } bpf_fd_type;
>>
>> -       while ((opt = getopt(argc, argv, "mpv")) != -1) {
>> +       while ((opt = getopt(argc, argv, "mpclv")) != -1) {
>>                  switch (opt) {
>>                  case 'm':
>>                          bpf_fd_type = MAP_FD;
>> @@ -30,6 +40,12 @@ int main(int argc, char *argv[])
>>                  case 'p':
>>                          bpf_fd_type = PROG_FD;
>>                          break;
>> +               case 'c':
>> +                       bpf_fd_type = MAP_CREATE;
>> +                       break;
>> +               case 'l':
>> +                       bpf_fd_type = PROG_LOAD;
>> +                       break;
>>                  case 'v':
>>                          verbose = true;
>>                          break;
>> @@ -44,8 +60,7 @@ int main(int argc, char *argv[])
>>                  exit(-1);
>>          }
>>
>> -       if (verbose)
>> -               printf("Process context:\n\t%s\n", context);
>> +       write_verbose(verbose, "Process context:\n\n%s", context);
>>
>>          free(context);
>>
>> @@ -54,24 +69,36 @@ int main(int argc, char *argv[])
>>
>>          switch (bpf_fd_type) {
>>          case MAP_FD:
>> -               if (verbose)
>> -                       printf("Creating BPF map\n");
>> +               write_verbose(verbose, "Creating BPF map");
>>
>> -               fd = create_bpf_map();
>> +               ret = create_bpf_map();
>>                  break;
>>          case PROG_FD:
>> -               if (verbose)
>> -                       printf("Creating BPF prog\n");
>> +               write_verbose(verbose, "Creating BPF prog");
>> +
>> +               ret = create_bpf_prog();
>> +               break;
>> +       case MAP_CREATE:
>> +               is_fd = false;
>> +               write_verbose(verbose, "Testing BPF map create");
>> +
>> +               ret = test_bpf_map_create();
>> +               break;
>> +       case PROG_LOAD:
>> +               is_fd = false;
>> +               write_verbose(verbose, "Testing BPF prog load");
>>
>> -               fd = create_bpf_prog();
>> +               ret = test_bpf_prog_load();
>>                  break;
>>          default:
>>                  usage(argv[0]);
>>          }
>>
>> -       if (fd < 0)
>> -               return fd;
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       if (is_fd)
>> +               close(ret);
>>
>> -       close(fd);
>>          return 0;
>>   }
>> diff --git a/tests/bpf/test b/tests/bpf/test
>> index a3fd856..14bda32 100755
>> --- a/tests/bpf/test
>> +++ b/tests/bpf/test
>> @@ -9,8 +9,10 @@ BEGIN {
>>
>>       $test_bpf_count       = 7;
>>       $test_fdreceive_count = 4;
>> +    $test_bpf_token_count = 4;
>>
>> -    $test_count = $test_bpf_count + $test_fdreceive_count;
>> +    $test_count =
>> +      $test_bpf_count + $test_fdreceive_count + $test_bpf_token_count;
>>
>>       # allow info to be shown during tests
>>       $v = $ARGV[0];
>> @@ -67,6 +69,13 @@ ok( $result eq 0 );
>>   $result = system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
>>   ok( $result eq 0 );
>>
>> +# BPF token - BPF_MAP_CREATE_AS, BPF_PROG_LOAD_AS
>> +$result = system "runcon -t test_bpf_t $basedir/bpf_test -c $v";
>> +ok( $result eq 0 );
>> +
>> +$result = system "runcon -t test_bpf_t $basedir/bpf_test -l $v";
>> +ok( $result eq 0 );
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
>> diff --git a/tests/bpf/token_test.c b/tests/bpf/token_test.c
>> new file mode 100644
>> index 0000000..eb1e3da
>> --- /dev/null
>> +++ b/tests/bpf/token_test.c
>> @@ -0,0 +1,538 @@
>> +#include "bpf_common.h"
>> +#include "signal.h"
>> +#include "linux/mount.h"
>> +#include <linux/unistd.h>
>> +#include "sys/wait.h"
>> +#include "sys/socket.h"
>> +#include "fcntl.h"
>> +#include "sched.h"
>> +#include <bpf/btf.h>
>> +
>> +#define bit(n) (1ULL << (n))
>> +
>> +#define zclose(fd) do { if (fd >= 0) close(fd); fd = -1; } while (0)
>> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>> +
>> +#define _CHECK(condition, format...) ({    \
>> +       int __ret = !!(condition); \
>> +       int __save_errno = errno;   \
>> +       if (__ret) {    \
>> +               fprintf(stderr, ##format);   \
>> +       }   \
>> +       errno = __save_errno;   \
>> +       __ret;  \
>> +})
>> +
>> +#define ASSERT_OK(res, name) ({     \
>> +       long long ___res = (res);       \
>> +       bool ___ok = ___res == 0;       \
>> +       _CHECK(!___ok, \
>> +                       "%s failed. unexpected error: %lld (errno %d)\n",  \
>> +                        name, ___res, errno);  \
>> +       ___ok;                          \
>> +})
>> +
>> +#define ASSERT_GT(actual, expected, name) ({    \
>> +       typeof(actual) ___act = (actual);   \
>> +       typeof(expected) ___exp = (expected);   \
>> +       bool ___ok = ___act > ___exp;       \
>> +       _CHECK(!___ok,  \
>> +                       "unexpected %s: actual %lld <= expected %lld (errno %d)\n",   \
>> +                       (name), (long long)(___act), (long long)(___exp), errno);  \
>> +       ___ok;  \
>> +})
>> +
>> +#define ASSERT_GE(actual, expected, name) ({    \
>> +       typeof(actual) ___act = (actual);       \
>> +       typeof(expected) ___exp = (expected);   \
>> +       bool ___ok = ___act >= ___exp;          \
>> +       _CHECK(!___ok,  \
>> +                       "unexpected %s: actual %lld < expected %lld (errno %d)\n",   \
>> +                       (name), (long long)(___act), (long long)(___exp), errno);          \
>> +       ___ok;  \
>> +})
>> +
>> +#define ASSERT_EQ(actual, expected, name) ({    \
>> +       typeof(actual) ___act = (actual);           \
>> +       typeof(expected) ___exp = (expected);       \
>> +       bool ___ok = ___act == ___exp;              \
>> +       _CHECK(!___ok,   \
>> +                       "unexpected %s: actual %lld != expected %lld (errno %d)\n",   \
>> +                       (name), (long long)(___act), (long long)(___exp), errno);          \
>> +       ___ok;  \
>> +})
>> +
>> +#define ASSERT_OK_PTR(ptr, name) ({     \
>> +       const void *___res = (ptr);         \
>> +       int ___err = libbpf_get_error(___res);  \
>> +       bool ___ok = ___err == 0;           \
>> +       _CHECK(!___ok,  \
>> +                       "%s unexpected error: %d\n", name, ___err);  \
>> +       ___ok;      \
>> +})
>> +
>> +struct bpffs_opts {
>> +       __u64 cmds;
>> +       __u64 maps;
>> +       __u64 progs;
>> +       __u64 attachs;
>> +       const char *cmds_str;
>> +       const char *maps_str;
>> +       const char *progs_str;
>> +       const char *attachs_str;
>> +};
>> +
>> +typedef int (*child_callback_fn)(int bpffs_fd);
>> +
>> +static inline int sys_mount(const char *dev_name, const char *dir_name,
>> +                           const char *type, unsigned long flags,
>> +                           const void *data)
>> +{
>> +       return syscall(__NR_mount, dev_name, dir_name, type, flags, data);
>> +}
>> +
>> +static inline int sys_fsopen(const char *fsname, unsigned int flags)
>> +{
>> +       return syscall(__NR_fsopen, fsname, flags);
>> +}
>> +
>> +static inline int sys_fsconfig(int fs_fd, unsigned int cmd, const char *key,
>> +                              const void *val, int aux)
>> +{
>> +       return syscall(__NR_fsconfig, fs_fd, cmd, key, val, aux);
>> +}
>> +
>> +static inline int sys_fsmount(int fs_fd, unsigned int flags,
>> +                             unsigned int ms_flags)
>> +{
>> +       return syscall(__NR_fsmount, fs_fd, flags, ms_flags);
>> +}
> It looks like you are using code heavily derived from elsewhere in the
> kernel (tools/testing/selftests/bpf/prog_tests/token.c). It is
> probably worth adding a note and including the original license at the
> top of your file. I did this in my own token test suite patch if you
> want an example.

Oh Really? I had no idea about original license. Let me take a look. 
Thank you for letting me know, Daniel.

