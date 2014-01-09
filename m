From: Victor Porton <porton@narod.ru>
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <52CEF9C2.1080903@tycho.nsa.gov>
References: <23731389285461@web11j.yandex.ru> <52CEF794.3030501@tycho.nsa.gov>
 <39121389295897@web13m.yandex.ru> <52CEF9C2.1080903@tycho.nsa.gov>
Subject: Re: Restrict to a fixed Internet domain in a sandbox
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Message-Id: <54261389296650@web13m.yandex.ru>
Date: Thu, 09 Jan 2014 21:44:10 +0200
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

09.01.2014, 21:35, "Stephen Smalley" <sds@tycho.nsa.gov>:
> On 01/09/2014 02:31 PM, Victor Porton wrote:
>
>> š09.01.2014, 21:25, "Stephen Smalley" <sds@tycho.nsa.gov>:
>>> šOn 01/09/2014 11:37 AM, Victor Porton wrote:
>>>> ššI remind that sandbox is implemented in Fedora using SELinux.
>>>>
>>>> ššIt would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).
>>>>
>>>> ššIt seems it is impossible with current SELinux.
>>>>
>>>> ššCould you add necessary features? Please!
>>> šI'm not aware of any missing kernel features required to support your
>>> šfunctionality. šI think all you are missing is two userspace components:
>> šAFAIK, there are no support for this in Linux kernel.
>>
>> šIt is why I advise to add a new syscall (see my previous message).
>>> šša library that provides whatever interface you design, and a daemon
>>> šthat receives the specification in whatever form you design and turns it
>>> šinto a set of SELinux and iptables SECMARK/CONNSECMARK rules to label
>>> šthe packets so that SELinux can mediate them accordingly, and loads that
>>> šinto the kernel for enforcement.
>> šI've already explained some reasons why iptables solution would be wrong. One of the reasons is that this would confuse a system administrator by appearance of new unexpected rules, the automatically added rules would also disappear when iptables script is reloaded, what could make errors for regular users. To use iptables this way seems a really bad idea.
>
> For SECMARK/CONNSECMARK, there is a separate dedicated security table to
> avoid such conflicts.

You force me (user) to start some scripts under root. But I want my software to be installable by a regular user in his home directory. It is one reason why adding new syscall into the kernel (see my previous email) would be better than creating such a daemon.

Also, I continue to highly doubt that your usage of IP would not interfere with normal system administration.

It is also unclear how to implement your daemon. It should create a new kind of "mark" every time a new sandbox binary starts (for two different sandboxes not to interfere with each other). I am not quite sure that this can be implemented in iptables.

-- 
Victor Porton - http://portonvictor.org
