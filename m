Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
To: Casey Schaufler <casey@schaufler-ca.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, =?UTF-8?Q?Jos=c3=a9_Bollo?=
 <jobol@nonadev.net>, selinux@tycho.nsa.gov
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <1482140693.2178.1.camel@nonadev.net>
 <1482250452.28169.28.camel@tycho.nsa.gov>
 <1482251949.25787.1.camel@nonadev.net>
 <1482252636.28169.34.camel@tycho.nsa.gov>
 <b8fd94ca-4bd8-6340-0199-e51587d32ce8@schaufler-ca.com>
 <1482258482.28169.40.camel@tycho.nsa.gov>
 <e1d6f6d6-7bbb-85bd-7070-70406e5546d7@schaufler-ca.com>
 <1482262534.28169.67.camel@tycho.nsa.gov>
 <34661049-44ab-5eb1-0c25-b71a2cec90e3@schaufler-ca.com>
Cc: paul@paul-moore.com, james.l.morris@oracle.com,
 linux-security-module@vger.kernel.org
From: John Johansen <john.johansen@canonical.com>
Message-ID: <c83a7281-367f-2459-3bcd-f15b64d950a6@canonical.com>
Date: Tue, 20 Dec 2016 13:38:09 -0800
MIME-Version: 1.0
In-Reply-To: <34661049-44ab-5eb1-0c25-b71a2cec90e3@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/20/2016 12:03 PM, Casey Schaufler wrote:
> On 12/20/2016 11:35 AM, Stephen Smalley wrote:
>> On Tue, 2016-12-20 at 11:07 -0800, Casey Schaufler wrote:
>>> On 12/20/2016 10:28 AM, Stephen Smalley wrote:
>>>> On Tue, 2016-12-20 at 10:17 -0800, Casey Schaufler wrote:
>>>>> On 12/20/2016 8:50 AM, Stephen Smalley wrote:
>>>>>> On Tue, 2016-12-20 at 17:39 +0100, José Bollo wrote:
>>>>>>> Le mardi 20 décembre 2016 à 11:14 -0500, Stephen Smalley a
>>>>>>> écrit
>>>>>>> :
>>>>>>>>
>>>>>>>> Looking at your PTAGS implementation, I feel it is only
>>>>>>>> fair to
>>>>>>>> warn
>>>>>>>> you that your usage of /proc/pid/attr is insecure,
>>>>>>>> regardless
>>>>>>>> of
>>>>>>>> whether you use task security blobs or cred security blobs.
>>>>>>> Fair?!
>>>>>>>
>>>>>>>> Getting the attributes of another process via /proc/pid
>>>>>>>> files
>>>>>>>> is
>>>>>>>> inherently racy, as the process may exit and another
>>>>>>>> process
>>>>>>>> with
>>>>>>>> different attributes may be created with the same pid (and
>>>>>>>> no,
>>>>>>>> this
>>>>>>>> is not theoretical; it has been demonstrated).
>>>>>>> I know. And I'm surprized that you dont do anything to change
>>>>>>> that.
>>>>>> There is a reason why SO_PEERSEC and SCM_SECURITY
>>>>>> exist.  Again,
>>>>>> learn
>>>>>> from the upstream security modules rather than re-inventing
>>>>>> them,
>>>>>> badly.
>>>>> SO_PEERSEC and SCM_SECURITY are spiffy for processes that are
>>>>> sending each other messages, but they identify the attributes
>>>>> associated with the message, not the process. Neither SELinux
>>>>> nor Smack get the information to send off of the process, it
>>>>> comes from the socket structure.
>>>> Yes, but in the SELinux case at least, the socket is labeled with
>>>> the
>>>> label of the creating process (except in the rare case of using
>>>> setsockcreatecon(3), which can only be used by suitably authorized
>>>> processes).
>>> Yes, it's the same with Smack. When it's not the label
>>> of the process it's the label the system wants the peer
>>> to think it is.
>>>
>>>>   So in general it serves quite well as a means of obtaining
>>>> the peer label, which can then be used in access control (and this
>>>> is
>>>> in fact being used in a variety of applications in Linux and
>>>> Android).
>>> But only between processes that are in direct, explicit
>>> communication.
>>> There is no denying that these mechanisms work. They just aren't
>>> applicable to Jose's use.
>> If you say so (although it is unclear to me why or what exactly his use
>> case is), but regardless, there is also no denying that getting and
>> setting another process' attributes via /proc/pid files is inherently
>> racy.  
> 
> You're right. How can we fix that? I have seen a gazillion cases
> where system security would be much simpler and easier to enforce
> and develop if we could (safely) ensure that the process under
> /proc/pid wouldn't change on you without you knowing.
> 
locking. In this case it would have to be user acquired file lock that
would hold the entire set of pid files in place so you could do a read
for some of its info and write to it. I haven't dug into it all so
I have no idea how likely getting such a change in would be, but I
have a feeling it will meet with a fair bit of resistance.

The other way pid based interfaces have been handled is using a tuple
of pid + creation timestamp or some other monotonically increasing value,
that way you can be sure that the referenced pid is the correct one.
I'm not a fan of the creation timestamp because time isn't always
monotonically increasing but Jose could easily use a monotonic value.
This would require Jose to track the monotonic value per task and make
the expected monotonic value part of the write spec so that his module
could validate it before applying the written tags.

The monotonic value doesn't need to increase with each task, just each
reuse, but the it would probably be easiest just to use a value that
increases once per task created.

I'm sure there are probably a few other techniques that could be found
to make PTAGS safe. Whether /proc/pid/attr/ is the best interface
is a separate question.

>> He even acknowledged as much.  So we are left with a "security"
>> module whose only purpose is to support getting and setting process
>> tags for security enforcement purposes, and yet does so in a known-
>> insecure manner.  Again, this is why I keep suggesting that he needs to
>> reconsider his approach, not merely figure out how to implement per-
>> task security blobs.
> 
> Whether or not Jose moves forward with PTAGS we have identified
> an issue with the current cred based hooks for AppArmor, TOMOYO
> and at least one other proposed module. Regardless of the issues
> of /proc/pid there is work to be done.
> 
I can take a stab at it in a few weeks. While not critical for apparmor
it would certainly cleanup apparmor's cred handling.
