Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6NK8XkH021145
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2013 16:08:33 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so8852038pbc.24
        for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2013 13:08:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130723195056.GA24395@siphos.be>
References: <20130723122207.GA21664@siphos.be>
	<51EE8B0F.4090103@tresys.com>
	<20130723195056.GA24395@siphos.be>
Date: Tue, 23 Jul 2013 16:08:32 -0400
Message-ID: <CADjGSjgdngPHP4YQHgCTXkJ5VDBoiELvm-9+93YdpkVoaK+q4w@mail.gmail.com>
Subject: Re: [refpolicy] Want to make typeattribute declarations possible in conditionals
From: Joshua Brindle <brindle@quarksecurity.com>
To: Sven Vermeulen <sven.vermeulen@siphos.be>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        refpolicy@oss1.tresys.com, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 23, 2013 at 3:50 PM, Sven Vermeulen
<sven.vermeulen@siphos.be> wrote:
> On Tue, Jul 23, 2013 at 09:54:23AM -0400, Christopher J. PeBenito wrote:
>> On 7/23/2013 8:22 AM, Sven Vermeulen wrote:
>> > I would like to be able to assign attributes to types in a conditional
>> > statement. Right now, this isn't allowed, and I don't know if it is feasible
>>
>> Definitely a question for main SELinux list.
>
> Ah ok, sorry about that.
>
>> > to look for a solution to this or not. Is this a real design constraint that
>> > will be hard to work around, or is this doable?
>>
>> It would require kernel changes.  Someone else can be more specific about the challenges for implementing it, but the one complication I can think of off the top of my head is that attributes are expanded in the base module during compile time.
>
> The base only? Because attributes are declared in (non-base) modules as
> well. Also, if they are expanded during policy (re)build, I was hoping we
> could do some implementation without impacting SELinux at the kernel.

He meant in constraints. E.g., if domain is used in a constraint, the
set of types is expanded in the kernel binary policy and thus
information about the domain attribute is lost. There is no chance
this could be implemented without impacting the kernel. I believe the
suggestion to use link-time tunables is the correct one, since the
vast majority of booleans are actually defined as tunables in
reference policy, and doing it at link-time could be done without
changing the kernel.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
