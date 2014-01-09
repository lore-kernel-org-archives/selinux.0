Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09JMuW7014145
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 14:22:56 -0500
Received: from web15j.yandex.ru (web15j.yandex.ru [5.45.198.56])
 by forward14.mail.yandex.net (Yandex) with ESMTP id EA37A1982273
 for <selinux@tycho.nsa.gov>; Thu,  9 Jan 2014 23:22:51 +0400 (MSK)
From: Victor Porton <porton@narod.ru>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <16931389295100@web15j.yandex.ru>
References: <23731389285461@web11j.yandex.ru>
 <160241389286775@web6m.yandex.ru> <31411389293953@web8h.yandex.ru>
 <16931389295100@web15j.yandex.ru>
Subject: Re: Restrict to a fixed Internet domain in a sandbox
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Message-Id: <21561389295369@web15j.yandex.ru>
Date: Thu, 09 Jan 2014 21:22:49 +0200
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



09.01.2014, 21:21, "Victor Porton" <porton@narod.ru>:
> I've realized that this would not work in the case of DNS round-robin load balancing, because the IP used by a sandboxed program may differ from the IP set by my application (which calls the sandbox).
>
> So now I propose the following alternative
>
> struct full_host_desc_t {
> ššstruct sockaddr *ADDR, socklen_t LENGTH;
> };

// a little error:  '.' instead of ';'
struct full_host_desc_t {
  struct sockaddr *ADDR;
  socklen_t LENGTH;
};

> int selinux_restrict_domains(struct full_host_desc_t *hosts, unsigned int num_hosts);
>
> Maybe there can be constructed a more efficient API.
>
> 09.01.2014, 21:02, "Victor Porton" <porton@narod.ru>:
>
>> šSorry, it should restrict not only domain but also port and protocol.
>>
>> šSo I propose this new syscall to restrict an application by "same-origin" policy:
>>
>> šint selinux_restrict_domain(struct sockaddr *ADDR, socklen_t LENGTH);
>>
>> šI am not sure that it is the best API specification. Please comment.
>>
>> šNote that probably all connections we need are TCP (not UDP), but we can support all protocols for completeness.
>>
>> š09.01.2014, 18:59, "Victor Porton" <porton@narod.ru>:
>>> šš09.01.2014, 18:39, "Victor Porton" <porton@narod.ru>:
>>>> šššI remind that sandbox is implemented in Fedora using SELinux.
>>>>
>>>> šššIt would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).
>>>>
>>>> šššIt seems it is impossible with current SELinux.
>>>>
>>>> šššCould you add necessary features? Please!
>>> ššYou could add a syscall like:
>>>
>>> ššint selinux_restrict_domain(const char *domain);
>>>
>>> šš(We could modify this interface to restrict to a finite list of domains instead of one domain, but personally I don't need this.)
>>>
>>> šš--
>>> ššVictor Porton - http://portonvictor.org
>> š--
>> šVictor Porton - http://portonvictor.org
>>
>> š_______________________________________________
>> šSelinux mailing list
>> šSelinux@tycho.nsa.gov
>> šTo unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> šTo get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
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
