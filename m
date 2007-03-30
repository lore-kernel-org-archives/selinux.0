Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UG3YOO022584
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 12:03:34 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UG3Wnf023544
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 16:03:33 GMT
To: russell@coker.com.au
Cc: bug-coreutils@gnu.org, selinux@tycho.nsa.gov
Subject: Re: SELinux for upstream coreutils, finally (RFC: does mkdir need -Z?)
From: Jim Meyering <jim@meyering.net>
In-Reply-To: <200703310016.13634.russell@coker.com.au> (Russell Coker's message of "Sat\, 31 Mar 2007 01\:16\:07 +1100")
References: <87tzw3x9mo.fsf@rho.meyering.net>
	<200703302237.35950.russell@coker.com.au>
	<87odmayiw0.fsf@rho.meyering.net>
	<200703310016.13634.russell@coker.com.au>
Date: Fri, 30 Mar 2007 17:39:01 +0200
Message-ID: <871wj6yc4q.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker <russell@coker.com.au> wrote:
> On Friday 30 March 2007 23:13, Jim Meyering <jim@meyering.net> wrote:
>> What did you think of the proposal (in the link above) for
>>
>>     fscon CTX mkdir /new/directory
>>
>> IMHO, it's not so much less "user friendly" than this equivalent:
>>
>>     mkdir -C CTX /new/directory
>
> How about:
> umask whatever ; mkdir /new/directory
>
> Instead of mkdir -m whatever /new/directory?

I agree that having to use umask like that would be a pain,
but largely because you generally want to use it in a sub-shell
so it doesn't affect other commands.  But fscon wouldn't have
that problem.

However, your example raises a good point: with mode-setting, we *do*
have the option of selecting a default mode via the "umask" command.
Currently, there is no analog to set the default SELinux file system
context, and that is part of why I'm arguing for the ability to write
"fscon".

>> > I think that all programs which set the uid and gid of a file should also
>> > be able to set the SE Linux context.
>> >
>> > It also seems reasonable that a program which can create a file with
>> > particular permissions should also be permitted to create it with a
>> > particular context.
>>
>> I was hoping for feedback on whether the proposed alternative (using
>> fscon and maybe runcon proxies) looked viable from a usability standpoint.
>
> Firstly there is the issue that fscon needs kernel changes to implement, then
> there is the issue that inheriting fscon can potentially give undesired
> results if privileged programs such as /bin/passwd forget to unset it, so
> therefore we need a policy method to control whether such inheriting of the
> fscon is permitted.

True, getting to the point at which we can write a usable "fscon" is
not trivial.  But neither is adding a -Z option to so many programs that
create files.  From a software engineering standpoint, I much prefer
the one-tool approach, even if we end up ceding to usability demands
and adding -Z to the more commonly used programs: mkdir and install.

> Adding an option to utilities is by far the easiest option.

In some sense (especially in the short term), it does look easier simply
to add the option to each program that needs it.  And I wouldn't have to
write so much, explaining my position :-)  However, as upstream maintainer,
I have to try to find the right (long term) solution.  I'm reluctant
to lock coreutils in to the short-term-easy solution if with a little
perseverance and patience we can get to a better one.

As I understood the outcome of our discussions on the selinux list back in
July, it would be feasible to make fscon work, but not trivial.  The main
objection appeared to be that fscon would not be easy for regular users
to find/understand/use, and that's why I ended up posting to fedora-list:
trying to get feedback from people not already up to their elbows in
the guts of SELinux.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
