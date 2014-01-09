From: Victor Porton <porton@narod.ru>
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <52CEF794.3030501@tycho.nsa.gov>
References: <23731389285461@web11j.yandex.ru> <52CEF794.3030501@tycho.nsa.gov>
Subject: Re: Restrict to a fixed Internet domain in a sandbox
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Message-Id: <39121389295897@web13m.yandex.ru>
Date: Thu, 09 Jan 2014 21:31:37 +0200
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

09.01.2014, 21:25, "Stephen Smalley" <sds@tycho.nsa.gov>:
> On 01/09/2014 11:37 AM, Victor Porton wrote:
>
>> šI remind that sandbox is implemented in Fedora using SELinux.
>>
>> šIt would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).
>>
>> šIt seems it is impossible with current SELinux.
>>
>> šCould you add necessary features? Please!
>
> I'm not aware of any missing kernel features required to support your
> functionality. šI think all you are missing is two userspace components:

AFAIK, there are no support for this in Linux kernel.

It is why I advise to add a new syscall (see my previous message).

> ša library that provides whatever interface you design, and a daemon
> that receives the specification in whatever form you design and turns it
> into a set of SELinux and iptables SECMARK/CONNSECMARK rules to label
> the packets so that SELinux can mediate them accordingly, and loads that
> into the kernel for enforcement.

I've already explained some reasons why iptables solution would be wrong. One of the reasons is that this would confuse a system administrator by appearance of new unexpected rules, the automatically added rules would also disappear when iptables script is reloaded, what could make errors for regular users. To use iptables this way seems a really bad idea.

-- 
Victor Porton - http://portonvictor.org
