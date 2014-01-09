Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09HJm76005288
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 12:19:48 -0500
From: Victor Porton <porton@narod.ru>
To: William Roberts <bill.c.roberts@gmail.com>
In-Reply-To: <CAFftDdp_crpiVmPZhwkDyRQqX4NhKOuxeP4=_P2KShXVv_aJtQ@mail.gmail.com>
References: <23731389285461@web11j.yandex.ru> <160241389286775@web6m.yandex.ru>
 <CAFftDdp_crpiVmPZhwkDyRQqX4NhKOuxeP4=_P2KShXVv_aJtQ@mail.gmail.com>
Subject: Re: Restrict to a fixed Internet domain in a sandbox
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Message-Id: <43611389287982@web25g.yandex.ru>
Date: Thu, 09 Jan 2014 19:19:42 +0200
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

09.01.2014, 19:03, "William Roberts" <bill.c.roberts@gmail.com>:
> Could you just do this with normal iptables rules? Optionally using
> labeled networking to label packets coming in.

It could be done with iptables, but:

1. My application would need root access to manipulate netfilter. It is not acceptable.

2. Even if my application has permissions enough to manipulate iptables, rules automatically created by it would interfere with customary way system administrators manually edit iptables script. It is very bad (and possibly may even impose a security treat).

I am about a quite particular application I am going to write, and I now am writing its algorithm specification. Not to turn my application into spam mail bomber or something similar, I really need to restrict to a fixed domain as a security measure. It is important. It is done in JavaScript and Java, obviously SELinux should not be behind JavaScript and Java in security.

> On Thu, Jan 9, 2014 at 8:59 AM, Victor Porton <porton@narod.ru> wrote:
>
>> š09.01.2014, 18:39, "Victor Porton" <porton@narod.ru>:
>>> šI remind that sandbox is implemented in Fedora using SELinux.
>>>
>>> šIt would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).
>>>
>>> šIt seems it is impossible with current SELinux.
>>>
>>> šCould you add necessary features? Please!
>> šYou could add a syscall like:
>>
>> šint selinux_restrict_domain(const char *domain);
>>
>> š(We could modify this interface to restrict to a finite list of domains instead of one domain, but personally I don't need this.)

-- 
Victor Porton - http://portonvictor.org
