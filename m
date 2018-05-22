Message-ID: <8fb536312e34a7d2e2027e89600be5216890b699.camel@btinternet.com>
From: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Date: Tue, 22 May 2018 15:07:56 +0100
In-Reply-To: <f3944f21-88fe-5fbc-f468-752751f96d23@tycho.nsa.gov>
References: <20180522113702.11882-1-richard_c_haines@btinternet.com>
 <53e70d53-1f17-da94-8a83-6b51e702ebed@tycho.nsa.gov>
 <69070991-05f9-d6a0-3934-b859ee6a4853@tycho.nsa.gov>
 <f3944f21-88fe-5fbc-f468-752751f96d23@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC V4 PATCH 0/1] selinux-testsuite: Add binder tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2018-05-22 at 09:53 -0400, Stephen Smalley wrote:
> On 05/22/2018 09:11 AM, Stephen Smalley wrote:
> > On 05/22/2018 09:01 AM, Stephen Smalley wrote:
> > > On 05/22/2018 07:37 AM, Richard Haines wrote:
> > > > Could you try this version where I've packed the transaction
> > > > structures.
> > > > I could not get the tests to fail on my two systems (but then
> > > > V3 didn't).
> > > 
> > > Hmmm...I saw one instance of a failure in test 6 when running
> > > ./test by
> > > hand but am now having problems replicating it.
> > > 
> > > dmesg output during all 6 tests was:
> > > 
> > > [  263.831513] binder: release 2025:2025 transaction 2 out, still
> > > active
> > > [  263.831519] binder: 2024:2024 transaction failed 29189/0, size
> > > 24-8 line 2788
> > > [  263.831522] binder: send failed reply for transaction 2,
> > > target dead
> > > [  263.846321] binder: 2026:2026 transaction failed 29201/-1,
> > > size 24-8 line 2864
> > > [  263.858613] binder: 2024:2027 transaction failed 29201/-1,
> > > size 0-0 line 2864
> > > [  263.872764] binder: 2028:2028 transaction failed 29201/-1,
> > > size 24-8 line 3050
> > > [  263.883684] binder: 2029:2029 ioctl 40046207 0 returned -13
> > > [  263.895261] binder: 2030 RLIMIT_NICE not set
> > > [  264.151699] binder: 2030 RLIMIT_NICE not set
> > > [  264.151879] binder: 2030 RLIMIT_NICE not set
> > > [  264.152212] binder: undelivered transaction 19, process died.
> > > [  264.152219] binder: 2030 RLIMIT_NICE not set
> > > [  264.153438] binder: 2030 RLIMIT_NICE not set
> > > 
> > > Are all of those expected?

Almost. These are my journal outputs for each test. The line numbers
will not match yours as I've added a bit of debug. I think I've
interpreted the results correctly for each one.

TEST 1:
binder: release 13663:13663 transaction 386 out, still active
binder: 13662:13662 transaction failed 29189/0, size 24-8 line 2800
(this is BR_DEAD_REPLY)
binder: send failed reply for transaction 386, target dead
Dead target because I kill off (guess I could close down cleanly but
just wanted to get something to at least BR_TRANSACTION_COMPLETE)

TEST 2:
binder: 13674:13674 transaction failed 29201/-1, size 24-8 line 2876
This is BR_FAILED_REPLY as the call perm was denied.

TEST 3:
binder: 13699:13700 transaction failed 29201/-1, size 0-0 line 2876
This is BR_FAILED_REPLY as impersonate perm was denied.

TEST 4:
binder: 13730:13730 transaction failed 29201/-1, size 24-8 line 3062
This is BR_FAILED_REPLY as transfer perm was denied.

TEST 5:
binder: 13754:13754 ioctl 40046207 0 returned -13
This is because set_context_mgr perm was denied.

TEST 6:
binder: 13780 RLIMIT_NICE not set (capability sys_nice denied - could
add this) 
binder: 13780 RLIMIT_NICE not set
binder: 13780 RLIMIT_NICE not set
binder: 13780:13780 transaction failed 29201/-1, size 24-8 line 3088
binder: send failed reply for transaction 402 to 13781:13781
binder: 13780 RLIMIT_NICE not set
This is BR_FAILED_REPLY as the fd:use permission is denied
(BINDER_TYPE_FD)


> > 
> > Now it is repeating upon a fresh reboot and running ./test by hand
> > repeatedly.
> > Also seeing these errors:
> > [  176.467915] binder_alloc: 1998: binder_alloc_buf, no vma
> > [  176.468046] binder: undelivered TRANSACTION_ERROR: 29189
> > 
> > Running it via make test passes though, oddly enough.
> > 
> > This is with completely stock 4.17-rc5 on F28.
> 
> ./test -v reports the following for test 6:
> Manager PID: 1949 Process context:
> 	unconfined_u:unconfined_r:test_binder_mgr_no_fd_t:s0-
> s0:c0.c1023
> Service Provider PID: 1950 Process context:
> 	unconfined_u:unconfined_r:test_binder_provider_t:s0-s0:c0.c1023
> Service Provider sending transaction to Manager - ADD_TEST_SERVICE
> Service Provider read_consumed: 48
> Service Provider command: BR_NOOP
> Service Provider command: BR_INCREFS
> Service Provider command: BR_ACQUIRE
> Service Provider command: BR_TRANSACTION_COMPLETE
> Manager read_consumed: 72
> Manager command: BR_NOOP
> Manager command: BR_TRANSACTION
> Manager BR_TRANSACTION data:
> 	handle: 0
> 	cookie: 0
> 	code: 100
> 	flag: TF_ACCEPT_FDS
> 	sender pid: 1950
> 	sender euid: 0
> 	data_size: 24
> 	offsets_size: 8
> 	hdr: BINDER_TYPE_HANDLE
> 	handle: 1
> 	flags: priority: 0x7f accept FDS: YES
> 	cookie: 0
> Manager has BINDER_TYPE_HANDLE obj->handle: 1
> Manager acquired handle: 1 for Service Provider
> Manager sending BC_REPLY to obtain its FD
> Manager handle: 0 and its FD: 3
> Manager read_consumed: 8
> Manager command: BR_NOOP
> Manager command: BR_TRANSACTION_COMPLETE
> Service Provider read_consumed: 72
> Service Provider command: BR_NOOP
> Service Provider command: BR_REPLY
> Service Provider BR_REPLY data:
> 	handle: 0
> 	cookie: 0
> 	code: 100
> 	flag: TF_ACCEPT_FDS
> 	sender pid: 0
> 	sender euid: 0
> 	data_size: 24
> 	offsets_size: 8
> 	hdr: BINDER_TYPE_FD
> 	fd: 5
> 	flags: priority: 0x7f accept FDS: YES
> 	cookie: 0
> Service Provider retrieved Managers fd: 5 st_dev: 6
> Service Provider read_consumed: 8
> Service Provider command: BR_NOOP
> Service Provider command: BR_TRANSACTION_COMPLETE
> Service Provider using Managers FD
> Manager read_consumed: 4
> Manager command: BR_NOOP
> not ok 6
> #   Failed test at ./test line 84.
> # Looks like you failed 1 test of 6.
> 

Looks like I'll need to go back to the drawing board !!!!
I may be some time.
Thanks for the feedback.
