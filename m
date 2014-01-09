Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09HY6ec006279
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 12:34:06 -0500
Received: by mail-we0-f170.google.com with SMTP id u57so2885118wes.15
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 09:34:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <43611389287982@web25g.yandex.ru>
References: <23731389285461@web11j.yandex.ru> <160241389286775@web6m.yandex.ru>
 <CAFftDdp_crpiVmPZhwkDyRQqX4NhKOuxeP4=_P2KShXVv_aJtQ@mail.gmail.com>
 <43611389287982@web25g.yandex.ru>
Date: Thu, 9 Jan 2014 09:34:03 -0800
Message-ID: <CAFftDdrHOnNgKaYO2HhN=fTawk6yKDXY_8X4hBmd-7pALzx_bQ@mail.gmail.com>
Subject: Re: Restrict to a fixed Internet domain in a sandbox
From: William Roberts <bill.c.roberts@gmail.com>
To: Victor Porton <porton@narod.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

You wouldn't want your application to set up the security... that
would be like asking the fox to guard the hen house. You would want to
establish all these things before your application is running.
However, you would need to administer this policy somehow, which is
going to be specific on the environment you are running.

What Java and JavaScript are doing doesn't really relate to SELinux
directly IMO. SELinux is controlling the interactions to resources of
the Linux Kernel (assuming no userspace object managers).

Im not really a desktop SELinux guy, more on Android. So I cant tell
you the specifics of how to do it, but I know it can be done.

Bill


On Thu, Jan 9, 2014 at 9:19 AM, Victor Porton <porton@narod.ru> wrote:
> 09.01.2014, 19:03, "William Roberts" <bill.c.roberts@gmail.com>:
>> Could you just do this with normal iptables rules? Optionally using
>> labeled networking to label packets coming in.
>
> It could be done with iptables, but:
>
> 1. My application would need root access to manipulate netfilter. It is not acceptable.
>
> 2. Even if my application has permissions enough to manipulate iptables, rules automatically created by it would interfere with customary way system administrators manually edit iptables script. It is very bad (and possibly may even impose a security treat).
>
> I am about a quite particular application I am going to write, and I now am writing its algorithm specification. Not to turn my application into spam mail bomber or something similar, I really need to restrict to a fixed domain as a security measure. It is important. It is done in JavaScript and Java, obviously SELinux should not be behind JavaScript and Java in security.
>
>> On Thu, Jan 9, 2014 at 8:59 AM, Victor Porton <porton@narod.ru> wrote:
>>
>>>  09.01.2014, 18:39, "Victor Porton" <porton@narod.ru>:
>>>>  I remind that sandbox is implemented in Fedora using SELinux.
>>>>
>>>>  It would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).
>>>>
>>>>  It seems it is impossible with current SELinux.
>>>>
>>>>  Could you add necessary features? Please!
>>>  You could add a syscall like:
>>>
>>>  int selinux_restrict_domain(const char *domain);
>>>
>>>  (We could modify this interface to restrict to a finite list of domains instead of one domain, but personally I don't need this.)
>
> --
> Victor Porton - http://portonvictor.org



-- 
Respectfully,

William C Roberts
