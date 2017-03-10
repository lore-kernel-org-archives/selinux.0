Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2A0563s013481
 for <selinux@tycho.nsa.gov>; Thu, 9 Mar 2017 19:05:06 -0500
Received: by mail-ua0-f174.google.com with SMTP id u30so99578006uau.0
 for <selinux@tycho.nsa.gov>; Thu, 09 Mar 2017 16:05:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87innidvko.fsf@xmission.com>
References: <58732BCF.4090908@huawei.com> <58734284.1060504@huawei.com>
 <b7f75f65-592a-5102-0ac5-4d3aa43f0b55@huawei.com> <58736B2E.90201@huawei.com>
 <58C11A6C.7000408@huawei.com>
 <347f63b5-c274-c7bc-55f7-f6304d31418a@schaufler-ca.com>
 <87innidvko.fsf@xmission.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 Mar 2017 19:05:04 -0500
Message-ID: <CAHC9VhQOno3O32QRX9wYwAXzjaxMR7pBNK3bsdQ8Xqq_9SmBzA@mail.gmail.com>
Subject: Re: isolate selinux_enforcing
To: Casey Schaufler <casey@schaufler-ca.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Cc: yangshukui <yangshukui@huawei.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, Lizefan <lizefan@huawei.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, oleg@redhat.com,
 serge.hallyn@ubuntu.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Mar 9, 2017 at 3:49 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Casey Schaufler <casey@schaufler-ca.com> writes:
>
>> On 3/9/2017 1:03 AM, yangshukui wrote:
>>> I want to use SELinux in system container and only concern the function in the container.
>>> this system container run in vm and every vm has only one system container.
>>>
>>> How do I use now?
>>> docker run ... system-contaier /sbin/init
>>> after init is running ,the following service is also running:
>>>
>>> #this is the part of service file which will run in container after starting the container.
>>> ..
>>> semodule -R     #use the policy in container.
>>> restorecon /     #if needed
>>> ..
>>>
>>> this method seem to work if host os and the docker images use the same content for rootfs, but if host use
>>> redhat7 and docker images use centos7, it will deny many normal operations , and this let some host service not work.
>>>
>>> If SELinux is permissive in host and enforcing in container ,it will resolve my problem. Unfortunately,
>>> there is no namespace for SELinux.
>
> This is mostly a SELinux problem.
>
>> The LSM infrastructure is essentially a set of lists.
>> These lists are rooted globally, but there's no reason*
>> they couldn't be rooted in a namespace. That would give
>> each namespace the option of using whatever security
>> scheme was deemed appropriate. There are a number of
>> issues, such as namespacing policy, that would have to
>> be addressed, but the mechanism could work fine. I would
>> look at patches.
>
>>
>> ---
>> * Other than the sheer insanity of making security
>>   claims about such a system. I would not expect that
>>   minor issue to slow demand or deployment any more
>>   than it has in the past.
>
> I would tend to insist that the container local policy stacks inside the
> global policy.  So that at the least the global security claims would
> not be reduced.

My current thinking is that namespacing is best left to the individual
LSMs, as it is unlikely we will all want to solve it the same way.
With SELinux we already have some basic support for what Eric
describes via bounded domains, but that alone isn't likely to solve
SELinux inside containers in a sense that most would expect; for that
you will need what Stephen already described.

-- 
paul moore
www.paul-moore.com
