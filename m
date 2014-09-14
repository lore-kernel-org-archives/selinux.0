MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <54008C93.5060300@tresys.com>
References: <53FCA845.1030001@tresys.com> <20140827150608.GA6701@siphos.be>
 <53FE02E5.6080506@tresys.com>
 <CAPzO=NyyP-m8jPBujd-vnG9XHo2FymskgQBH3fKPt448NznZdA@mail.gmail.com>
 <53FF8DE9.6070302@tycho.nsa.gov>
 <CAPzO=Nwwbn8ihZmuj-JGKPUonZwjS69Zjg=1ix1EDbR=QQ56oQ@mail.gmail.com>
 <54006DD4.6040706@tycho.nsa.gov> <54007889.90706@tresys.com>
 <CAPzO=Nwppvd+Q=J4SXk5Q38FVAUpqCeb8vjXhxfMBkbFRYpjsw@mail.gmail.com>
 <54008AC4.6080600@tycho.nsa.gov> <54008C93.5060300@tresys.com>
Date: Sun, 14 Sep 2014 11:31:57 +0200
Message-ID: <CAPzO=NzfSr6zk+AhZUSnwF-aB8o225m_6VX5mTjLV=L1m_iimw@mail.gmail.com>
Subject: Re: SELinux Userspace Release: 20140826-rc1
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Steve Lawrence <slawrence@tresys.com>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Steve & co

Will you be pushing out an rc3 release? If not, can I get the fix for
this particular situation so I can continue testing?

Wkr,
  Sven Vermeulen

On Fri, Aug 29, 2014 at 4:22 PM, Steve Lawrence <slawrence@tresys.com> wrote:
> On 08/29/2014 10:14 AM, Stephen Smalley wrote:
>> On 08/29/2014 10:00 AM, Sven Vermeulen wrote:
>>> On Fri, Aug 29, 2014 at 2:56 PM, Steve Lawrence <slawrence@tresys.com> wrote:
>>>>>>>> Segmentation fault
>>>>>> [...]
>>>>>>> Can you provide a copy of your original policy prior to conversion?
>>>>>>
>>>>>> If you mean the policy.29 file, certainly. You can wget it from
>>>>>> http://dev.gentoo.org/~swift/tmp/20140828-policy.29
>>>>>
>>>>> No, the contents of /etc/selinux/mcs.  The migration script converts the
>>>>> old policy module store, not the final kernel policy file.
>>>>>
>>>>
>>>> Hmm, I'm unable to reproduce this. I think the policy store that Stephen
>>>> mentions will be help to reproduce it.
>>>>
>>>
>>> Certainly.
>>>
>>> The policy store can be found at
>>> http://dev.gentoo.org/~swift/tmp/20140829-etc-selinux-mcs.tar.gz
>>
>> Hmm...semanage_migrate_store worked for me on that policy store.
>>
>> Can you reproduce the fault?  If so, can you get debug info?
>> Build with debug flags and run semanage_migrate_store under valgrind,
>> perhaps?
>>
>
> We are able to get the segfault and have gotten a backtrace. It looks
> like it has to do with how optionals are handled and how we reset state
> when an optional is disabled. The fix in this particular case is pretty
> simple, but I think we need to go through the rest of the reset state
> code and ensure we aren't making similar mistakes. Might take a little
> bit of time.
>
