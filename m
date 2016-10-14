MIME-Version: 1.0
In-Reply-To: <03c59bb9-e57f-9768-3aa0-c0e9f01f742a@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC561CD17F73@ORSMSX103.amr.corp.intel.com>
 <191f635c-992e-c7bb-e74d-afb5966b4f89@tycho.nsa.gov>
 <CAFftDdqg=A5CDin0YjYHWzhsVM2Bu-0qR_hhAG+jna0C862d_Q@mail.gmail.com>
 <03c59bb9-e57f-9768-3aa0-c0e9f01f742a@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 14 Oct 2016 09:07:20 -0400
Message-ID: <CAFftDdrS33y4LRvjPec3UV3sVq4+D+VKUS2X-40FQJrAp=EViw@mail.gmail.com>
Subject: Re: speeding up nodups_specs, need large fc file.
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Roberts, William C" <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Likely not, I see it compiling version 29 and I am on ubuntu which is
way out of date with this stuff... should I just use the checkpolicy
from my AOSP tree?

Or should I just install with some particular set of options from
selinux master repo?

On Fri, Oct 14, 2016 at 9:06 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/14/2016 09:02 AM, William Roberts wrote:
>> Looks like make MONOLITHIC=y policy to get the binary policy file....
>>
>> Is it normal for checkpolicy to take 5 minutes?
>
> No, at least not with a modern checkpolicy.  Are you using a current
> version?
>
> $ time make MONOLITHIC=y policy
> Compiling refpolicy policy.30
> /usr/bin/checkpolicy -U deny policy.conf -o policy.30
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> /usr/bin/checkpolicy:  policy configuration loaded
> /usr/bin/checkpolicy:  writing binary representation (version 30) to
> policy.30
>
> real    0m3.341s
> user    0m3.280s
> sys     0m0.061s
>
>>
>>>From TOP:
>> 31178 wcrobert  20   0  812552 751940   1628 R 100.0  4.6   4:47.36
>> checkpolicy
>>
>> On Thu, Oct 13, 2016 at 4:37 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On 10/13/2016 03:28 PM, Roberts, William C wrote:
>>>> I was looking back at my speedup patch for nodups specs…
>>>>
>>>> http://marc.info/?l=selinux&m=147249024230263&w=2
>>>>
>>>>
>>>>
>>>> I was testing before with a large, generated file_context file. I was
>>>> wondering what would be a good source for
>>>>
>>>> A desktop version of a file_contexts (textual preference as I can run
>>>> sefcontext_compile on it) file as well as a binary
>>>>
>>>> policy file….
>>>>
>>>>
>>>>
>>>> Should I just use refpolicy?
>>>
>>> That's probably fine, unless you happen to have Fedora installed and can
>>> just use its file_contexts file.
>>>
>>> $ cd refpolicy
>>> $ make MONOLITHIC=y conf
>>> $ make MONOLITHIC=y file_contexts
>>> $ wc -l file_contexts
>>> 4908 file_contexts
>>> $ wc -l /etc/selinux/targeted/contexts/files/file_contexts
>>> 6075 /etc/selinux/targeted/contexts/files/file_contexts
>>>
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
>>
>>
>



-- 
Respectfully,

William C Roberts
