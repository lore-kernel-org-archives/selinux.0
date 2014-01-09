Message-ID: <52CF04B9.7010007@tycho.nsa.gov>
Date: Thu, 09 Jan 2014 15:21:13 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Victor Porton <porton@narod.ru>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Restrict to a fixed Internet domain in a sandbox
References: <23731389285461@web11j.yandex.ru> <52CEF794.3030501@tycho.nsa.gov>
 <39121389295897@web13m.yandex.ru> <52CEF9C2.1080903@tycho.nsa.gov>
 <47571389297500@web28h.yandex.ru> <52CF0129.5070904@tycho.nsa.gov>
 <97521389298485@web1m.yandex.ru>
In-Reply-To: <97521389298485@web1m.yandex.ru>
Content-Type: text/plain; charset=KOI8-R
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/09/2014 03:14 PM, Victor Porton wrote:
> 09.01.2014, 22:06, "Stephen Smalley" <sds@tycho.nsa.gov>:
>> On 01/09/2014 02:58 PM, Victor Porton wrote:
>>
>>>  09.01.2014, 21:35, "Stephen Smalley" <sds@tycho.nsa.gov>:
>>>>  On 01/09/2014 02:31 PM, Victor Porton wrote:
>>>>>   09.01.2014, 21:25, "Stephen Smalley" <sds@tycho.nsa.gov>:
>>>>>>   On 01/09/2014 11:37 AM, Victor Porton wrote:
>>>>>>>    I remind that sandbox is implemented in Fedora using SELinux.
>>>>>>>
>>>>>>>    It would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).
>>>>>>>
>>>>>>>    It seems it is impossible with current SELinux.
>>>>>>>
>>>>>>>    Could you add necessary features? Please!
>>>>>>   I'm not aware of any missing kernel features required to support your
>>>>>>   functionality.  I think all you are missing is two userspace components:
>>>>>   AFAIK, there are no support for this in Linux kernel.
>>>>>
>>>>>   It is why I advise to add a new syscall (see my previous message).
>>>>>>    a library that provides whatever interface you design, and a daemon
>>>>>>   that receives the specification in whatever form you design and turns it
>>>>>>   into a set of SELinux and iptables SECMARK/CONNSECMARK rules to label
>>>>>>   the packets so that SELinux can mediate them accordingly, and loads that
>>>>>>   into the kernel for enforcement.
>>>>>   I've already explained some reasons why iptables solution would be wrong. One of the reasons is that this would confuse a system administrator by appearance of new unexpected rules, the automatically added rules would also disappear when iptables script is reloaded, what could make errors for regular users. To use iptables this way seems a really bad idea.
>>>>  For SECMARK/CONNSECMARK, there is a separate dedicated security table to
>>>>  avoid such conflicts.
>>>  Also I think, implementing it my way would be much more efficient than your way.
>>
>> You are certainly free to implement it any way you like; it is open
>> source software after all.  But implementing a new kernel mechanism +
>> system call when it can already be achieved using existing mechanism is
>> generally discouraged.  You haven't even tried...
> 
> I've looked into iptables. It has 32 bit marks.
> 
> The first idea is to set the mark to the label of the sandbox process.
> 
> But it is wrong, other packages may use the same 32 bit numbers.
> 
> The same applies to SECMARK which are also 32 bit wide.
> 
> So, to implement it, we would need to introduce a new standard, which marks are used by which packages. A very bad idea.
> 
> It's better to implement it in kernel. I prophecy that sandboxes will become more and more important, and this feature will be very useful.

You misunderstand SECMARK.  It is a handle to a security context, which
is assigned to the sk_buff and then used in SELinux packet send/recv
checks that can be used to control packet flow.

http://selinuxproject.org/page/NB_Networking
http://james-morris.livejournal.com/11010.html
http://www.linux.com/learn/tutorials/421152-using-selinux-and-iptables-together
http://paulmoore.livejournal.com/4281.html

Note that most if not all of those articles were written before a
separate security table was introduced, so these days you would use -t
security and make sure your kernel enables CONFIG_IP_NF_SECURITY=y as
well as the SECMARK/CONNSECMARK options.

But again, you are free to do as you like.
