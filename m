Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5I15vcm004339
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2010 21:05:57 -0400
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5I157x6016293
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 01:05:07 GMT
Received: by vws8 with SMTP id 8so2168354vws.12
        for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2010 18:05:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTik72PznqNvcz_2mp9kwTjdGA2NiTLo7v0yv2i47@mail.gmail.com>
References: <AANLkTik72PznqNvcz_2mp9kwTjdGA2NiTLo7v0yv2i47@mail.gmail.com>
From: Jason Axelson <bostonvaulter@gmail.com>
Date: Thu, 17 Jun 2010 15:05:35 -1000
Message-ID: <AANLkTil6dElngZYLNXbcvA0TsefQDL8DaCG8C01jOeur@mail.gmail.com>
Subject: Re: Benchmarking
To: Paul Otheim <coriolis220@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Paul,

I can't answer your question about using only MAC and no DAC. But if
you really want to get some performance you can do modify your
policies. For an interesting example of this look at this presentation
by Hitachi about porting SELinux to Android.

https://docs.google.com/viewer?url=http://www.celinux.org/elc08_presentations/ELC2008_nakamura.pdf

Jason Axelson

On Thu, Jun 17, 2010 at 2:49 PM, Paul Otheim <coriolis220@gmail.com> wrote:
> Most of the benchmarking figures I have seen or heard of consistently say
> that, depending on what your doing, the average performance hit when running
> SELinux is about 5 to 7 percent. My question is if anyone has benchmarked
> with no DAC and SELinux only for permissions checks. What, if any, is the
> performance gain? Can I get that seven percent back? I know its not a strict
> SELinux question but I don't know of any other place to ask such a thing.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
