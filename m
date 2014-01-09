Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09H3qDY004253
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 12:03:52 -0500
Received: by mail-wg0-f41.google.com with SMTP id y10so6181670wgg.4
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 09:03:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <160241389286775@web6m.yandex.ru>
References: <23731389285461@web11j.yandex.ru> <160241389286775@web6m.yandex.ru>
Date: Thu, 9 Jan 2014 09:03:50 -0800
Message-ID: <CAFftDdp_crpiVmPZhwkDyRQqX4NhKOuxeP4=_P2KShXVv_aJtQ@mail.gmail.com>
Subject: Re: Restrict to a fixed Internet domain in a sandbox
From: William Roberts <bill.c.roberts@gmail.com>
To: Victor Porton <porton@narod.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Could you just do this with normal iptables rules? Optionally using
labeled networking to label packets coming in.

On Thu, Jan 9, 2014 at 8:59 AM, Victor Porton <porton@narod.ru> wrote:
> 09.01.2014, 18:39, "Victor Porton" <porton@narod.ru>:
>> I remind that sandbox is implemented in Fedora using SELinux.
>>
>> It would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).
>>
>> It seems it is impossible with current SELinux.
>>
>> Could you add necessary features? Please!
>
> You could add a syscall like:
>
> int selinux_restrict_domain(const char *domain);
>
> (We could modify this interface to restrict to a finite list of domains instead of one domain, but personally I don't need this.)
>
> --
> Victor Porton - http://portonvictor.org
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Respectfully,

William C Roberts
