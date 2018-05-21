From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <20180521163337.15043-1-richard_c_haines@btinternet.com>
 <74e0c011-aebc-6973-8843-58d640853850@tycho.nsa.gov>
Message-ID: <57d7f228-33c4-5251-3a3c-b4d32d51f0d7@tycho.nsa.gov>
Date: Mon, 21 May 2018 13:06:39 -0400
MIME-Version: 1.0
In-Reply-To: <74e0c011-aebc-6973-8843-58d640853850@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC V3 PATCH 1/1] selinux-testsuite: Add binder tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/21/2018 01:02 PM, Stephen Smalley wrote:
> On 05/21/2018 12:33 PM, Richard Haines wrote:
>> Add binder tests. See tests/binder/test_binder.c for details on
>> message flows to test security_binder*() functions.
> 
> Breaks the build on RHEL7 since /usr/include/linux/android/binder.h does not exist and is not
> provided by any package.  On F28 with v4.17-rc5, 2 tests fail at runtime:
> # ./test -v
> 1..6
> Manager PID: 5610 Process context:
> 	unconfined_u:unconfined_r:test_binder_mgr_t:s0-s0:c0.c1023
> Service Provider PID: 5611 Process context:
> 	unconfined_u:unconfined_r:test_binder_provider_t:s0-s0:c0.c1023
> Service Provider sending transaction to Manager - ADD_TEST_SERVICE
> Service Provider read_consumed: 8
> Service Provider command: BR_NOOP
> Service Provider command: BR_FAILED_REPLY
> not ok 1
> #   Failed test at ./test line 46.
> Service Provider PID: 5612 Process context:
> 	unconfined_u:unconfined_r:test_binder_provider_no_call_t:s0-s0:c0.c1023
> Service Provider sending transaction to Manager - ADD_TEST_SERVICE
> Service Provider read_consumed: 8
> Service Provider command: BR_NOOP
> Service Provider command: BR_FAILED_REPLY
> ok 2
> Service Provider PID: 5613 Process context:
> 	unconfined_u:unconfined_r:test_binder_provider_no_im_t:s0-s0:c0.c1023
> Service Provider sending transaction to Manager - ADD_TEST_SERVICE
> Service Provider read_consumed: 8
> Service Provider command: BR_NOOP
> Service Provider command: BR_FAILED_REPLY
> not ok 3
> #   Failed test at ./test line 56.
> Service Provider PID: 5614 Process context:
> 	unconfined_u:unconfined_r:test_binder_provider_no_transfer_t:s0-s0:c0.c1023
> Service Provider sending transaction to Manager - ADD_TEST_SERVICE
> Service Provider read_consumed: 8
> Service Provider command: BR_NOOP
> Service Provider command: BR_FAILED_REPLY
> ok 4
> Manager PID: 5615 Process context:
> 	unconfined_u:unconfined_r:test_binder_provider_t:s0-s0:c0.c1023
> Failed to become context manager: Permission denied
> ok 5
> Manager PID: 5616 Process context:
> 	unconfined_u:unconfined_r:test_binder_mgr_no_fd_t:s0-s0:c0.c1023
> Service Provider PID: 5617 Process context:
> 	unconfined_u:unconfined_r:test_binder_provider_t:s0-s0:c0.c1023
> Service Provider sending transaction to Manager - ADD_TEST_SERVICE
> Service Provider read_consumed: 8
> Service Provider command: BR_NOOP
> Service Provider command: BR_FAILED_REPLY
> ok 6
> # Looks like you failed 2 tests of 6.

dmesg output during the tests:
<6>[ 2769.139332] binder: 5827:5827 got transaction with invalid offset (4096, min 0 max 24) or object.
<6>[ 2769.139377] binder: 5827:5827 transaction failed 29201/-22, size 24-8 line 3034
<6>[ 2769.159674] binder: 5828:5828 transaction failed 29201/-1, size 24-8 line 2864
<6>[ 2769.170922] binder: 5829:5829 got transaction with invalid offset (4096, min 0 max 24) or object.
<6>[ 2769.170933] binder: 5829:5829 transaction failed 29201/-22, size 24-8 line 3034
<6>[ 2769.182644] binder: 5830:5830 got transaction with invalid offset (4096, min 0 max 24) or object.
<6>[ 2769.182655] binder: 5830:5830 transaction failed 29201/-22, size 24-8 line 3034
<6>[ 2769.199232] binder: 5831:5831 ioctl 40046207 0 returned -13
<6>[ 2769.209828] binder: 5832 RLIMIT_NICE not set
<6>[ 2769.495722] binder: 5833:5833 got transaction with invalid offset (4096, min 0 max 24) or object.
<6>[ 2769.495740] binder: 5833:5833 transaction failed 29201/-22, size 24-8 line 3034
