Date: Fri, 25 Jan 2002 10:22:50 -0800
From: Paul Krumviede <pwk@acm.org>
To: Stephen Smalley <sds@tislabs.com>, Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: network and module problems
Message-ID: <90286525.1011954170@localhost>
In-Reply-To: <Pine.GSO.4.33.0201251146080.7127-100000@raven>
References: <Pine.GSO.4.33.0201251146080.7127-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--On Friday, 25 January, 2002 12:47 -0500 Stephen Smalley <sds@tislabs.com> 
wrote:

>
> On 25 Jan 2002, Timothy Wood wrote:
>
>> never raise.  What I still don't see is how the lo interface never loads
>> because as far as I know the lo interface doesn't have a module.  I'm
>> sifting through dmesg once again, a little more closely this time, and
>> I"m seeing a lot of wierd things.  Someone tell me if all this looks
>> right.
>
> I've seen the error that you are seeing before, but it was due to not
> enabling the Netlink and Routing message options in the kernel config for
> RH7.2 systems.

is this true for both 2.4.16 and 2.4.17 kernels? i just looked at my RH7.2
system, and the kernel config file for the 2.4.16 build has CONFIG_NETLINK,
CONFIG_RTNETLINK and CONFIG_NETLINK_DEV, while the 2.4.17
kernel only has CONFIG_NETLINK_DEV (and Documentation/Configure.help
implies that the other 2 are only for 2.5 kernels)...

so maybe going to the new release would have avoided this confusion
after all.

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
