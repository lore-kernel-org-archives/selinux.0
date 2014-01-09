Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09JIPOG013668
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 14:18:25 -0500
Received: from web15j.yandex.ru (web15j.yandex.ru [5.45.198.56])
 by forward12.mail.yandex.net (Yandex) with ESMTP id 960FBC21A91
 for <selinux@tycho.nsa.gov>; Thu,  9 Jan 2014 23:18:20 +0400 (MSK)
From: Victor Porton <porton@narod.ru>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <31411389293953@web8h.yandex.ru>
References: <23731389285461@web11j.yandex.ru>
 <160241389286775@web6m.yandex.ru> <31411389293953@web8h.yandex.ru>
Subject: Re: Restrict to a fixed Internet domain in a sandbox
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Message-Id: <16931389295100@web15j.yandex.ru>
Date: Thu, 09 Jan 2014 21:18:20 +0200
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I've realized that this would not work in the case of DNS round-robin load balancing, because the IP used by a sandboxed program may differ from the IP set by my application (which calls the sandbox).

So now I propose the following alternative

struct full_host_desc_t {
  struct sockaddr *ADDR, socklen_t LENGTH;
};

int selinux_restrict_domains(struct full_host_desc_t *hosts, unsigned int num_hosts);

Maybe there can be constructed a more efficient API.

09.01.2014, 21:02, "Victor Porton" <porton@narod.ru>:
> Sorry, it should restrict not only domain but also port and protocol.
>
> So I propose this new syscall to restrict an application by "same-origin" policy:
>
> int selinux_restrict_domain(struct sockaddr *ADDR, socklen_t LENGTH);
>
> I am not sure that it is the best API specification. Please comment.
>
> Note that probably all connections we need are TCP (not UDP), but we can support all protocols for completeness.
>
> 09.01.2014, 18:59, "Victor Porton" <porton@narod.ru>:
>
>> š09.01.2014, 18:39, "Victor Porton" <porton@narod.ru>:
>>> ššI remind that sandbox is implemented in Fedora using SELinux.
>>>
>>> ššIt would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).
>>>
>>> ššIt seems it is impossible with current SELinux.
>>>
>>> ššCould you add necessary features? Please!
>> šYou could add a syscall like:
>>
>> šint selinux_restrict_domain(const char *domain);
>>
>> š(We could modify this interface to restrict to a finite list of domains instead of one domain, but personally I don't need this.)
>>
>> š--
>> šVictor Porton - http://portonvictor.org
>
> --
> Victor Porton - http://portonvictor.org
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

-- 
Victor Porton - http://portonvictor.org
