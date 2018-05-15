From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <20180515082553.30310-1-richard_c_haines@btinternet.com>
 <0c5025b1-b90e-3e8f-b6f9-7ff080f5f772@tycho.nsa.gov>
 <0193e640-4792-57b1-2408-a6944731baf4@tycho.nsa.gov>
Message-ID: <f662a095-582f-3e00-1e53-e4c3ba1f6ed3@tycho.nsa.gov>
Date: Tue, 15 May 2018 12:38:36 -0400
MIME-Version: 1.0
In-Reply-To: <0193e640-4792-57b1-2408-a6944731baf4@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC PATCH 1/1] selinux-testsuite: Add binder tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/15/2018 09:43 AM, Stephen Smalley wrote:
> On 05/15/2018 09:36 AM, Stephen Smalley wrote:
>> This test is failing for me (with or without -v):
>> # ./test -v
>> 1..6
>> Manager PID: 5608 Process context:
>> 	unconfined_u:unconfined_r:test_binder_mgr_t:s0-s0:c0.c1023
>> Client PID: 5609 Process context:
>> 	unconfined_u:unconfined_r:test_binder_client_t:s0-s0:c0.c1023
>> Client read_consumed: 28
>> Manager read_consumed: 72
>> Client command: BR_NOOP
>> Manager command: BR_NOOP
>> Client command: BR_INCREFS
>> Manager command: BR_TRANSACTION
>> Client command: BR_TRANSACTION_COMPLETE
>> BR_TRANSACTION data:
>> 	handle: 0
>> 	cookie: 0
>> 	code: 0
>> 	flag: TF_ACCEPT_FDS
>> 	sender pid: 5609
>> 	sender euid: 0
>> 	data_size: 24
>> 	offsets_size: 8
>> Sending BC_REPLY
>> Manager read_consumed: 8
>> Manager command: BR_NOOP
>> Manager command: BR_TRANSACTION_COMPLETE
>> Client read_consumed: 72
>> Client command: BR_NOOP
>> Client command: BR_REPLY
>> BR_REPLY data:
>> 	handle: 0
>> 	cookie: 0
>> 	code: 0
>> 	flag: TF_ACCEPT_FDS
>> 	sender pid: 0
>> 	sender euid: 0
>> 	data_size: 24
>> 	offsets_size: 8
>> Retrieved Managers fd: 4 st_dev: 6
>> Client read_consumed: 8
>> Client using Managers FD command: BR_NOOP
>> Client using Managers FD command: BR_FAILED_REPLY
>> Client using Managers received FD failed response
>> Manager read_consumed: 4
>> Manager command: BR_NOOP
>> not ok 1
>> #   Failed test at ./test line 36.
> 
> Just realized that I was testing with a kernel that still had Casey's stacking support enabled.
> Will re-try without that.

Still fails for me on F28 with stock/linus 4.17.0-rc5.  No AVC messages from the failing test itself,
just the other ones.
