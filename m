Message-ID: <52CF0129.5070904@tycho.nsa.gov>
Date: Thu, 09 Jan 2014 15:06:01 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Victor Porton <porton@narod.ru>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Restrict to a fixed Internet domain in a sandbox
References: <23731389285461@web11j.yandex.ru> <52CEF794.3030501@tycho.nsa.gov>
 <39121389295897@web13m.yandex.ru> <52CEF9C2.1080903@tycho.nsa.gov>
 <47571389297500@web28h.yandex.ru>
In-Reply-To: <47571389297500@web28h.yandex.ru>
Content-Type: text/plain; charset=KOI8-R
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/09/2014 02:58 PM, Victor Porton wrote:
> 09.01.2014, 21:35, "Stephen Smalley" <sds@tycho.nsa.gov>:
>> On 01/09/2014 02:31 PM, Victor Porton wrote:
>>
>>>  09.01.2014, 21:25, "Stephen Smalley" <sds@tycho.nsa.gov>:
>>>>  On 01/09/2014 11:37 AM, Victor Porton wrote:
>>>>>   I remind that sandbox is implemented in Fedora using SELinux.
>>>>>
>>>>>   It would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).
>>>>>
>>>>>   It seems it is impossible with current SELinux.
>>>>>
>>>>>   Could you add necessary features? Please!
>>>>  I'm not aware of any missing kernel features required to support your
>>>>  functionality.  I think all you are missing is two userspace components:
>>>  AFAIK, there are no support for this in Linux kernel.
>>>
>>>  It is why I advise to add a new syscall (see my previous message).
>>>>   a library that provides whatever interface you design, and a daemon
>>>>  that receives the specification in whatever form you design and turns it
>>>>  into a set of SELinux and iptables SECMARK/CONNSECMARK rules to label
>>>>  the packets so that SELinux can mediate them accordingly, and loads that
>>>>  into the kernel for enforcement.
>>>  I've already explained some reasons why iptables solution would be wrong. One of the reasons is that this would confuse a system administrator by appearance of new unexpected rules, the automatically added rules would also disappear when iptables script is reloaded, what could make errors for regular users. To use iptables this way seems a really bad idea.
>>
>> For SECMARK/CONNSECMARK, there is a separate dedicated security table to
>> avoid such conflicts.
> 
> Also I think, implementing it my way would be much more efficient than your way.

You are certainly free to implement it any way you like; it is open
source software after all.  But implementing a new kernel mechanism +
system call when it can already be achieved using existing mechanism is
generally discouraged.  You haven't even tried...
