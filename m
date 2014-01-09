Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09IxIT7012088
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 13:59:18 -0500
Received: from web8h.yandex.ru (web8h.yandex.ru [84.201.186.37])
 by forward3h.mail.yandex.net (Yandex) with ESMTP id 2B5641362C90
 for <selinux@tycho.nsa.gov>; Thu,  9 Jan 2014 22:59:14 +0400 (MSK)
From: Victor Porton <porton@narod.ru>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <160241389286775@web6m.yandex.ru>
References: <23731389285461@web11j.yandex.ru> <160241389286775@web6m.yandex.ru>
Subject: Re: Restrict to a fixed Internet domain in a sandbox
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Message-Id: <31411389293953@web8h.yandex.ru>
Date: Thu, 09 Jan 2014 20:59:13 +0200
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Sorry, it should restrict not only domain but also port and protocol.

So I propose this new syscall to restrict an application by "same-origin" policy:

int selinux_restrict_domain(struct sockaddr *ADDR, socklen_t LENGTH);

I am not sure that it is the best API specification. Please comment.

Note that probably all connections we need are TCP (not UDP), but we can support all protocols for completeness.

09.01.2014, 18:59, "Victor Porton" <porton@narod.ru>:
> 09.01.2014, 18:39, "Victor Porton" <porton@narod.ru>:
>
>> šI remind that sandbox is implemented in Fedora using SELinux.
>>
>> šIt would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).
>>
>> šIt seems it is impossible with current SELinux.
>>
>> šCould you add necessary features? Please!
>
> You could add a syscall like:
>
> int selinux_restrict_domain(const char *domain);
>
> (We could modify this interface to restrict to a finite list of domains instead of one domain, but personally I don't need this.)
>
> --
> Victor Porton - http://portonvictor.org

-- 
Victor Porton - http://portonvictor.org
