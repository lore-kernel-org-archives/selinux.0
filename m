From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <20180522113702.11882-1-richard_c_haines@btinternet.com>
 <53e70d53-1f17-da94-8a83-6b51e702ebed@tycho.nsa.gov>
Message-ID: <69070991-05f9-d6a0-3934-b859ee6a4853@tycho.nsa.gov>
Date: Tue, 22 May 2018 09:11:22 -0400
MIME-Version: 1.0
In-Reply-To: <53e70d53-1f17-da94-8a83-6b51e702ebed@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC V4 PATCH 0/1] selinux-testsuite: Add binder tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/22/2018 09:01 AM, Stephen Smalley wrote:
> On 05/22/2018 07:37 AM, Richard Haines wrote:
>> Could you try this version where I've packed the transaction structures.
>> I could not get the tests to fail on my two systems (but then V3 didn't).
> 
> Hmmm...I saw one instance of a failure in test 6 when running ./test by
> hand but am now having problems replicating it.
> 
> dmesg output during all 6 tests was:
> 
> [  263.831513] binder: release 2025:2025 transaction 2 out, still active
> [  263.831519] binder: 2024:2024 transaction failed 29189/0, size 24-8 line 2788
> [  263.831522] binder: send failed reply for transaction 2, target dead
> [  263.846321] binder: 2026:2026 transaction failed 29201/-1, size 24-8 line 2864
> [  263.858613] binder: 2024:2027 transaction failed 29201/-1, size 0-0 line 2864
> [  263.872764] binder: 2028:2028 transaction failed 29201/-1, size 24-8 line 3050
> [  263.883684] binder: 2029:2029 ioctl 40046207 0 returned -13
> [  263.895261] binder: 2030 RLIMIT_NICE not set
> [  264.151699] binder: 2030 RLIMIT_NICE not set
> [  264.151879] binder: 2030 RLIMIT_NICE not set
> [  264.152212] binder: undelivered transaction 19, process died.
> [  264.152219] binder: 2030 RLIMIT_NICE not set
> [  264.153438] binder: 2030 RLIMIT_NICE not set
> 
> Are all of those expected?

Now it is repeating upon a fresh reboot and running ./test by hand repeatedly.
Also seeing these errors:
[  176.467915] binder_alloc: 1998: binder_alloc_buf, no vma
[  176.468046] binder: undelivered TRANSACTION_ERROR: 29189

Running it via make test passes though, oddly enough.

This is with completely stock 4.17-rc5 on F28.

> 
> /sys/kernel/debug/binder/failed_transaction_log contained:
> 
> 5: reply from 2024:2024 to 0:0 context binder node 0 handle 0 size 24:8 ret 29189/0 l=2788
> 6: call  from 2026:2026 to 0:0 context binder node 1 handle 0 size 24:8 ret 29201/-1 l=2864
> 11: async from 2024:2027 to 0:0 context binder node 8 handle 2 size 0:0 ret 29201/-1 l=2864
> 12: call  from 2028:2028 to 2024:0 context binder node 1 handle 0 size 24:8 ret 29201/-1 l=3050
> 24: reply from 2039:2039 to 2040:2040 context binder node 0 handle 0 size 24:8 ret 29189/-3 l=2971
> 25: call  from 2041:2041 to 0:0 context binder node 20 handle 0 size 24:8 ret 29201/-1 l=2864
> 30: async from 2039:2042 to 0:0 context binder node 27 handle 2 size 0:0 ret 29201/-1 l=2864
> 31: call  from 2043:2043 to 2039:0 context binder node 20 handle 0 size 24:8 ret 29201/-1 l=3050
> 43: reply from 2050:2050 to 2051:2051 context binder node 0 handle 0 size 24:8 ret 29189/-3 l=2971
> 44: call  from 2052:2052 to 0:0 context binder node 39 handle 0 size 24:8 ret 29201/-1 l=2864
> 49: async from 2050:2053 to 0:0 context binder node 46 handle 2 size 0:0 ret 29201/-1 l=2864
> 50: call  from 2054:2054 to 2050:0 context binder node 39 handle 0 size 24:8 ret 29201/-1 l=3050
> 62: reply from 2062:2062 to 0:0 context binder node 0 handle 0 size 24:8 ret 29189/0 l=2788
> 63: call  from 2064:2064 to 0:0 context binder node 58 handle 0 size 24:8 ret 29201/-1 l=2864
> 68: async from 2062:2065 to 0:0 context binder node 65 handle 2 size 0:0 ret 29201/-1 l=2864
> 69: call  from 2066:2066 to 2062:0 context binder node 58 handle 0 size 24:8 ret 29201/-1 l=3050
> 
>>
>> Thanks
>>
>> I've updated this so it still tests all the binder permissions.
>>
>> I didn't bother with a Client as I found another way to achieve the
>> same result. Plenty of comments in test_binder.c to explain. Hopefully
>> it is sane, otherwise a Client will be required.
>>
>> I've tested on Fedora 28 with linux-4.17-rc5 so that it does not
>> suffer the same fate as V1 did. Also looked to see what other patches
>> were in the pipeline, none that should stop this version working.
>>
>> V2 Changes:
>> Fixed the policy and test Makefiles
>> Updated binder policy.
>> Updated the defconfig and now works to build linux-4.17-rc5
>> Updated the test to handle the -v option. Plenty of output
>> to see what is happening.
>>
>> V3 Changes:
>> Added missing policy for using shared memory.
>> Use the allow_map macro.
>>
>> V4 Changes:
>> Pack transaction structures.
>> Check if $(INCLUDEDIR)/linux/android/binder.h exists.
>>
>> Richard Haines (1):
>>   selinux-testsuite: Add binder tests
>>
>>  README.md                   |   8 +
>>  defconfig                   |   7 +
>>  policy/Makefile             |   4 +
>>  policy/test_binder.te       | 120 +++++++
>>  tests/Makefile              |   5 +
>>  tests/binder/Makefile       |   7 +
>>  tests/binder/check_binder.c |  80 +++++
>>  tests/binder/test           |  89 +++++
>>  tests/binder/test_binder.c  | 684 ++++++++++++++++++++++++++++++++++++
>>  9 files changed, 1004 insertions(+)
>>  create mode 100644 policy/test_binder.te
>>  create mode 100644 tests/binder/Makefile
>>  create mode 100644 tests/binder/check_binder.c
>>  create mode 100644 tests/binder/test
>>  create mode 100644 tests/binder/test_binder.c
>>
> 
