Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7T4SNQm011580
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2012 00:28:23 -0400
Message-ID: <503D9A5D.9090307@itechfrontiers.com>
Date: Wed, 29 Aug 2012 00:28:13 -0400
From: "Patrick K., ITF" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: proof selinux
References: <CAE_4iW8xF5NLvjrXKpSExgstbFx8JKfx38F5PBN0YP3VaPFz4Q@mail.gmail.com> <503D8F58.3010207@itechfrontiers.com> <CAFftDdo1286WZaKfgeJK8xe=N4DE6F3HyQe-X5FM2kpUQD3rxA@mail.gmail.com>
In-Reply-To: <CAFftDdo1286WZaKfgeJK8xe=N4DE6F3HyQe-X5FM2kpUQD3rxA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Bill,

The demonstration for SEAndroid you referred to is not to prevent the 
overflow, SELinux is not a tool such as StackGuard or ProPolice;

Such prevention is in gaining access and elevation of privileges, 
SELinux is there to compartmentalize things if correctly used, So 
technically it is not for preventing from buffer overflow or even 
preventing exploits, it is to confine, isolate, restrict and limit the 
damage (in GingerBreak case preventing Elevation of access -Root access-)

I believe you referred to this page:

http://selinuxproject.org/~jmorris/lss2011_slides/caseforseandroid.pdf

Best Regards,

Patrick K.

On 8/29/2012 12:10 AM, William Roberts wrote:
> As far as demo at preventing attacks based on overflow stephen smalley
> does a nice job showing how SEAndroid prevented ginger break. Look at
> the SEAndroid web page(Google it)
>
> On Aug 28, 2012 8:45 PM, "Patrick K., ITF" <cto@itechfrontiers.com
> <mailto:cto@itechfrontiers.com>> wrote:
>
>     Hi Raul,
>
>     I'm not sure if we are on the same page about SELinux.
>
>     SELinux is not there to prevent from buffer overflow or such exploits,
>
>     If you run a process in some kind of Role or Context, you confine it
>     to the limitations you defined in that context (using SELinux Policies),
>
>     How effective SELinux would be, depends on your policies actually.
>
>     The effectiveness of SELinux has nothing to do with exploits, unless
>     of course you meant attacking SELinux code or kernel LSM or Kernel
>     itself.
>
>
>     Testing SELinux is easy, simply assign whatever role or policy you
>     want to a process and user or group,  the ultimate exploit of a
>     process gives total control of that role or policy to that user. So
>     the attackers become as privileged as the role or user or context of
>     the policy.
>
>
>     Sincerely,
>
>     Patrick K.
>
>     On 8/28/2012 10:50 PM, Raul da Silva {Sp4wn} wrote:
>
>         hi guys,
>
>         I know that we have a lot of ways to prove how effective is
>         SELinux as
>         cgi, perl, shell scripts and I know that is effective but I'd
>         like to
>         know if someone already tested some kind of exploit of buffer
>         overflow
>         attack as demo to show how effective could be SELinux.
>         Any information I really appreciate
>
>         Thanks
>
>
>
>         Raul Leite
>         sp4wn.root@gmail.com <mailto:sp4wn.root@gmail.com>
>         <mailto:sp4wn.root@gmail.com <mailto:sp4wn.root@gmail.com>>
>
>
>
>     --
>     This message was distributed to subscribers of the selinux mailing list.
>     If you no longer wish to subscribe, send mail to
>     majordomo@tycho.nsa.gov <mailto:majordomo@tycho.nsa.gov> with
>     the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
