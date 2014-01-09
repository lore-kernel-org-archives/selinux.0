Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09ISgD7010181
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 13:28:42 -0500
From: Victor Porton <porton@narod.ru>
To: William Roberts <bill.c.roberts@gmail.com>
In-Reply-To: <CAFftDdrHOnNgKaYO2HhN=fTawk6yKDXY_8X4hBmd-7pALzx_bQ@mail.gmail.com>
References: <23731389285461@web11j.yandex.ru> <160241389286775@web6m.yandex.ru>
 <CAFftDdp_crpiVmPZhwkDyRQqX4NhKOuxeP4=_P2KShXVv_aJtQ@mail.gmail.com>
 <43611389287982@web25g.yandex.ru>
 <CAFftDdrHOnNgKaYO2HhN=fTawk6yKDXY_8X4hBmd-7pALzx_bQ@mail.gmail.com>
Subject: Re: Restrict to a fixed Internet domain in a sandbox
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Message-Id: <202091389292115@web8h.yandex.ru>
Date: Thu, 09 Jan 2014 20:28:35 +0200
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

09.01.2014, 19:34, "William Roberts" <bill.c.roberts@gmail.com>:
> You wouldn't want your application to set up the security... that
> would be like asking the fox to guard the hen house. You would want to
> establish all these things before your application is running.
> However, you would need to administer this policy somehow, which is
> going to be specific on the environment you are running.

The security cannot be set in advance, because before my application starts, which domains should be allowed is not known. It can be setup only from the inside of my application.

My application is not the fox to guard the hen house, because I am going my application "safe" (in the same sense as "ls" and "cp" Linux commands are safe, they don't do anything without user's approval).

But by design my application may run programs downloaded from the Web without user's interaction. This is why I need a sandbox and restrict networking to a certain domain (which domain is calculated by my application based on its input data).

> What Java and JavaScript are doing doesn't really relate to SELinux
> directly IMO. SELinux is controlling the interactions to resources of
> the Linux Kernel (assuming no userspace object managers).

Despite of the real (implemented) security behind Java is too bad, basic Java security ideas were designed by wise guys. We should follow their wisdom and implement these ideas in SELinux.

> Im not really a desktop SELinux guy, more on Android. So I cant tell
> you the specifics of how to do it, but I know it can be done.
>
> Bill
>
> On Thu, Jan 9, 2014 at 9:19 AM, Victor Porton <porton@narod.ru> wrote:
>
>> š09.01.2014, 19:03, "William Roberts" <bill.c.roberts@gmail.com>:
>>> šCould you just do this with normal iptables rules? Optionally using
>>> šlabeled networking to label packets coming in.
>> šIt could be done with iptables, but:
>>
>> š1. My application would need root access to manipulate netfilter. It is not acceptable.
>>
>> š2. Even if my application has permissions enough to manipulate iptables, rules automatically created by it would interfere with customary way system administrators manually edit iptables script. It is very bad (and possibly may even impose a security treat).
>>
>> šI am about a quite particular application I am going to write, and I now am writing its algorithm specification. Not to turn my application into spam mail bomber or something similar, I really need to restrict to a fixed domain as a security measure. It is important. It is done in JavaScript and Java, obviously SELinux should not be behind JavaScript and Java in security.
>>> šOn Thu, Jan 9, 2014 at 8:59 AM, Victor Porton <porton@narod.ru> wrote:
>>>> šš09.01.2014, 18:39, "Victor Porton" <porton@narod.ru>:
>>>>> ššI remind that sandbox is implemented in Fedora using SELinux.
>>>>>
>>>>> ššIt would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).
>>>>>
>>>>> ššIt seems it is impossible with current SELinux.
>>>>>
>>>>> ššCould you add necessary features? Please!
>>>> ššYou could add a syscall like:
>>>>
>>>> ššint selinux_restrict_domain(const char *domain);
>>>>
>>>> šš(We could modify this interface to restrict to a finite list of domains instead of one domain, but personally I don't need this.)
>> š--
>> šVictor Porton - http://portonvictor.org
>
> --
> Respectfully,
>
> William C Roberts

-- 
Victor Porton - http://portonvictor.org
