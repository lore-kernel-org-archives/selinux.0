From: Victor Porton <porton@narod.ru>
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <52CF0129.5070904@tycho.nsa.gov>
References: <23731389285461@web11j.yandex.ru> <52CEF794.3030501@tycho.nsa.gov>
 <39121389295897@web13m.yandex.ru> <52CEF9C2.1080903@tycho.nsa.gov>
 <47571389297500@web28h.yandex.ru> <52CF0129.5070904@tycho.nsa.gov>
Subject: Re: Restrict to a fixed Internet domain in a sandbox
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Message-Id: <97521389298485@web1m.yandex.ru>
Date: Thu, 09 Jan 2014 22:14:45 +0200
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

09.01.2014, 22:06, "Stephen Smalley" <sds@tycho.nsa.gov>:
> On 01/09/2014 02:58 PM, Victor Porton wrote:
>
>> š09.01.2014, 21:35, "Stephen Smalley" <sds@tycho.nsa.gov>:
>>> šOn 01/09/2014 02:31 PM, Victor Porton wrote:
>>>> šš09.01.2014, 21:25, "Stephen Smalley" <sds@tycho.nsa.gov>:
>>>>> ššOn 01/09/2014 11:37 AM, Victor Porton wrote:
>>>>>> šššI remind that sandbox is implemented in Fedora using SELinux.
>>>>>>
>>>>>> šššIt would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).
>>>>>>
>>>>>> šššIt seems it is impossible with current SELinux.
>>>>>>
>>>>>> šššCould you add necessary features? Please!
>>>>> ššI'm not aware of any missing kernel features required to support your
>>>>> ššfunctionality. šI think all you are missing is two userspace components:
>>>> ššAFAIK, there are no support for this in Linux kernel.
>>>>
>>>> ššIt is why I advise to add a new syscall (see my previous message).
>>>>> ššša library that provides whatever interface you design, and a daemon
>>>>> ššthat receives the specification in whatever form you design and turns it
>>>>> ššinto a set of SELinux and iptables SECMARK/CONNSECMARK rules to label
>>>>> ššthe packets so that SELinux can mediate them accordingly, and loads that
>>>>> ššinto the kernel for enforcement.
>>>> ššI've already explained some reasons why iptables solution would be wrong. One of the reasons is that this would confuse a system administrator by appearance of new unexpected rules, the automatically added rules would also disappear when iptables script is reloaded, what could make errors for regular users. To use iptables this way seems a really bad idea.
>>> šFor SECMARK/CONNSECMARK, there is a separate dedicated security table to
>>> šavoid such conflicts.
>> šAlso I think, implementing it my way would be much more efficient than your way.
>
> You are certainly free to implement it any way you like; it is open
> source software after all. šBut implementing a new kernel mechanism +
> system call when it can already be achieved using existing mechanism is
> generally discouraged. šYou haven't even tried...

I've looked into iptables. It has 32 bit marks.

The first idea is to set the mark to the label of the sandbox process.

But it is wrong, other packages may use the same 32 bit numbers.

The same applies to SECMARK which are also 32 bit wide.

So, to implement it, we would need to introduce a new standard, which marks are used by which packages. A very bad idea.

It's better to implement it in kernel. I prophecy that sandboxes will become more and more important, and this feature will be very useful.

-- 
Victor Porton - http://portonvictor.org
