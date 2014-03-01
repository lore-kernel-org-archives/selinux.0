Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s21Dw41N025404
 for <selinux@tycho.nsa.gov>; Sat, 1 Mar 2014 08:58:05 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so1949428pbb.36
 for <selinux@tycho.nsa.gov>; Sat, 01 Mar 2014 05:58:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOFt0CSfGU3Df2nyyt-LvApuA=sYVuDy_FKPHsNE4Pp61Goh6A@mail.gmail.com>
References: <CAOFt0CQYn+Sku39NOHn4ggX1_8O3y6uvZLtfS1_TQJhirANfNQ@mail.gmail.com>
 <98847C58-0B26-40AC-A59D-837794A6C957@me.com>
 <CAOFt0CSfGU3Df2nyyt-LvApuA=sYVuDy_FKPHsNE4Pp61Goh6A@mail.gmail.com>
Date: Sat, 1 Mar 2014 08:58:02 -0500
Message-ID: <CAN4BvJ-dwQCSveLzWv5CHGiVUhOh_rU72UFguVrBMd9opCDXLg@mail.gmail.com>
Subject: Re: What is Type Enforcement Model in SELinux?
From: Brandon Whalen <brandon@quarksecurity.com>
To: Kernel freak <kernelfreak@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Mar 1, 2014 at 8:26 AM, Kernel freak <kernelfreak@gmail.com> wrote:
>
>
>
> On Sat, Mar 1, 2014 at 2:14 PM, Bryan Harris <bryanlharris@me.com> wrote:
>>
>> I am also new to selinux but I believe what you're looking for is MAC
>> mandatory access control.
>>
>> http://en.m.wikipedia.org/wiki/SELinux
>>
>> Hope this helps and doesn't make things worse for you. (-:
>
>
> Sorry, but I don't believe it is.
>>
>>
>> Bryan
>>
>> > On Mar 1, 2014, at 6:23 AM, Kernel freak <kernelfreak@gmail.com> wrote:
>> >
>> > Hello Friends,
>> >                      I am writing a report and I need to write about TE
>> > model in SELinux. I searched around the net, but all the articles I read
>> > beat around the bush and never say like ok, this is TE model for SELinux.
>> > Can anyone be so kind and please point me out to some links which say
>> > about TE model in SELinux and if possible an appropriate model. Thank you
>> > for your time and patience.

SELinux doesn't just implement TE. It can implement RBAC, UBAC, TE,
and can also do MLS. To understand the threat SELinux and TE are
trying to mitigate read
http://www.nsa.gov/research/_files/publications/inevitability.pdf and
then you can read
https://lwn.net/2001/features/OLS/pdf/pdf/selinux.pdf to see how the
design of SELinux is meant to deal with those threats.


>> > _______________________________________________
>> > Selinux mailing list
>> > Selinux@tycho.nsa.gov
>> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> > To get help, send an email containing "help" to
>> > Selinux-request@tycho.nsa.gov.
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>
