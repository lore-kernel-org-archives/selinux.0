Subject: Re: Strange AVC with latest rawhide kernel.
To: James Carter <jwcart2@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
 Paul Moore <paul@paul-moore.com>
References: <1456423369.3702.42.camel@redhat.com>
 <56CF4574.3030709@tycho.nsa.gov> <1456426779.3702.52.camel@redhat.com>
 <56CF523A.7000503@tycho.nsa.gov> <1456429021.31341.34.camel@redhat.com>
 <56CF5A54.7020600@tycho.nsa.gov> <1456432101.3702.67.camel@redhat.com>
 <56CF6A08.6010305@tycho.nsa.gov> <1456491264.3481.2.camel@redhat.com>
 <CAHC9VhQwrmbH7UONJET6XOwfqJvn46fe9WXgkFOP-JDd4ss1uw@mail.gmail.com>
 <56D07421.3090301@tycho.nsa.gov> <1456504426.3481.44.camel@redhat.com>
 <56D0AC79.8040600@tycho.nsa.gov> <1456518652.3481.51.camel@redhat.com>
 <56D47178.3010006@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <56D47F89.5040506@redhat.com>
Date: Mon, 29 Feb 2016 12:27:37 -0500
MIME-Version: 1.0
In-Reply-To: <56D47178.3010006@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 02/29/2016 11:27 AM, James Carter wrote:
> On 02/26/2016 03:30 PM, Daniel J Walsh wrote:
>> On Fri, 2016-02-26 at 14:50 -0500, James Carter wrote:
>>> On 02/26/2016 11:33 AM, Daniel J Walsh wrote:
>>>>
>>>>
>>>> BTW I turned on the expand-check=1 in semanage.conf and semodule -B
>>>> went nuts and crashed.
>>>>
>>>> On this policy.
>>>>
>>>> policy_module(mypol, 1.0)
>>>>
>>>> require {
>>>>     type svirt_lxc_net_t;
>>>>     type docker_t;
>>>>     type svirt_sandbox_file_t;
>>>>     type unconfined_t;
>>>> }
>>>> allow unconfined_t svirt_sandbox_file_t:file entrypoint;
>>>> allow docker_t svirt_sandbox_file_t:file entrypoint;
>>>> typebounds unconfined_t docker_t;
>>>> typebounds docker_t svirt_lxc_net_t;
>>>>
>>>>
>>> I thought that maybe the toolchain couldn't handle an A bounds B
>>> bounds C
>>> relationship, but current versions handle that just fine and even
>>> versions back
>>> in June before I refactored the bounds checking could handle it. I
>>> only checked
>>> with checkpolicy and secilc, so there is a chance that something
>>> particular with
>>> modules caused this.
>>>
>>> I tried your module on Fedora 23 and the first bounds check fails.
>>> Nothing crazy
>>> happened though. I don't currently have a rawhide machine to try it
>>> on.
>>>
>>
>> I guess unconfined_t also needs docker_exec_t as an entrypoint.
>>
>> Still crashes.  Here is the output and strace.
>> # strace -o /tmp/strace semodule -B 2> /tmp/out
>>
>
> Is your policy available somewhere, so I can try to reproduce this?
>
> Jim
>
>
It is just the rawhide policy, along with the rawhide docker-selinux 
package.

Then add the policy module above.
