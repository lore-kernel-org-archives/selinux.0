Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09LFotP021489
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 16:15:50 -0500
Received: by mail-we0-f177.google.com with SMTP id x55so1030483wes.22
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 13:15:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFftDdoV=7u78pWD1VM8hnDA4qJoZT2yFHk0PvsSXRThZcZQ1g@mail.gmail.com>
References: <47061389296301@web13m.yandex.ru>
 <CAFftDdoV=7u78pWD1VM8hnDA4qJoZT2yFHk0PvsSXRThZcZQ1g@mail.gmail.com>
Date: Thu, 9 Jan 2014 13:15:48 -0800
Message-ID: <CAFftDdovOGiPX5_1hikwKcEG0VnmZaEdFiWXZg_oyt2fELyjoA@mail.gmail.com>
Subject: Re: My proposal for a new feature in Linux kernel
From: William Roberts <bill.c.roberts@gmail.com>
To: Victor Porton <porton@narod.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Some links:
http://superuser.com/questions/463649/linux-routing-and-hma
http://lwn.net/Articles/531114/
http://serverfault.com/questions/218707/iptables-rules-to-allow-http-traffic-to-one-domain-only
http://www.linux.com/learn/tutorials/421152-using-selinux-and-iptables-together


On Thu, Jan 9, 2014 at 1:12 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> Just so you know. Syscall means the interface between userspace and
> the kernel changing modes. What your describing doesn't really need a
> syscall.
>
> Solutions to your problem exist via iptables and SELinux network
> labeling rules. Obviously, you will need to research or possible do
> some additional work in this
> area to solve your problem.
>
> You also might want to look into using namespaces. Bu unsharing the
> networking namespace, you can provide a virtual network stack to each
> process, and
> use veth devices to connect to a real device. Then you can use
> iptables rules in that namespace without impacting the rest of your
> system.
>
> You might want to look at LXC as well.
>
>
> On Thu, Jan 9, 2014 at 11:38 AM, Victor Porton <porton@narod.ru> wrote:
>> So my final proposal:
>>
>> struct full_sockaddr_t {
>>   struct sockaddr *ADDR;
>>   socklen_t LENGTH;
>> };
>>
>> // Syscall
>> int selinux_restrict_domains(struct full_sockaddr_t *socks, unsigned int num_socks);
>>
>> This call would restrict the sockets accessed by a process (and its childs) to the specified array of socket addresses.
>>
>> For security reasons it should be impossible to add more hosts to this list. (We may allow to further restrict.)
>>
>> Please implement it in Linux kernel.
>>
>> --
>> Victor Porton - http://portonvictor.org
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
>
> --
> Respectfully,
>
> William C Roberts



-- 
Respectfully,

William C Roberts
