Date: Mon, 18 May 2009 13:53:24 +0500
From: selinux@udmvt.ru
To: Joshua Brindle <method@manicmethod.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Dropping SELinux privileges
Message-ID: <20090518085324.GB10816@ruber.office.udmvt.ru>
References: <3453b4110905151046s27022fb4jf9975fa4523572fa@mail.gmail.com> <3453b4110905151100n5afb13c8q56b75bd25eac571f@mail.gmail.com> <4A0DB579.9080807@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A0DB579.9080807@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 15, 2009 at 02:33:29PM -0400, Joshua Brindle wrote:
> Sebastien Raveau wrote:
>> Hi everybody!
>>
>>
>> As a personal challenge I am trying to reach "state of the art"
>> security on my home router... and for that I'm using SELinux of course
>> ;-)
>>
>> I have everything setup and working, but what intrigues me is: isn't
>> there a way to drop SELinux privileges?
>>
>> I mean, many programs require privileges only during their startup
>> phase, and restricting their rights from the outside proves
>> impossible; that's why volontary chroot(), setgid() and setuid() are
>> so useful: the program decides when to relinquish its privileges.
>>
>> For example, a program like OpenVPN should only be allowed network
>> I/O, but because its initialization invokes shell commands, we have to
>> give it many more rights than it actually needs. Granted, in the case
>> of OpenVPN the combination with setuid and chroot solves the shell
>> commands problem, but this still makes policy files too complex...
>>
>> Maximum (theoretical) security could be reached if a program could be
>> allowed to switch from some policy to an even more restrictive policy,
>> and very simple policy files could be written if a program could be
>> allowed to start unconfined and when ready apply a policy to itself,
>> which is basically the same.
>>
>>
>> I couldn't find such a thing in the SELinux API: have I misread? Or it
>> does not exist and perhaps I could contribute it? :-)
>>
>> Best regards,
>>
>
> SELinux has a concept of type transitions to change the type (or domain) 
> of a process over an exec(). So the openvpn example would type transition 
> when it runs the shell commands and the shell commands would run in a 
> less privileged domain.
>
> There is also a way to change the domain of a process at runtime called 
> setcon() though we prefer transitions over exec() because they can be 
> enforced and less state is passed over exec than available in a running 
> process.
By the way, why there is no type transition on fork? It would help a lot
on confining traditional unix services with minimum effort, don't you think?
Everybody knows that there is some common model - parent is listener, children
are workers, but all code resides in one binary. Splitting it into separate
programs requires some effort, you know. One extra file in /proc will easily
help to "convert" such applications to SELinux.
You will have to just change the starup script: after parent is started you just write
to /proc file the required children's context (assuming it is the same across all forks),
and that's it, no extra patches to application is needed, no recompilation.
Isn't it easy and robust solution? Am I wrong or what?
Or maybe such thing already present somewhere?

>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
