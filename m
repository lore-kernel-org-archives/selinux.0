Date: Fri, 8 Feb 2002 21:16:47 +0200 (EET)
From: Hacko <toltec@karai.net>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: SELinux@tycho.nsa.gov
Subject: RE: shell history task
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A1015242C8@csoc-mail-box.csoconline.com>
Message-ID: <Pine.LNX.4.44.0202082059250.2758-100000@karai.karai.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

> I may be totally off base here, but the best you could do
> is to create a append_only_file_t. This may be useful  for
> some log files too. The real problem is unset SOMEENVIRONMNET.
> The environment variables are residing in the bash program
> itself. The unset command is part of the bash program,
> I am not sure of any way the create SELinux
> rules that would effect the way a programs behave to itself without
> making system calls. The unset command I believe does
> not make any system calls( I could be wrong, I have not
> look at the source )  but only effects the bash program.

yes, i have done some weird bash patch 5-6 years ago, and it do all
these, just today remember it and think it from the selinux point, like an
idea rather than practically used. thanks for the append_only ;)

> It looks like you are try to audit what programs are being
> executed, (i.e. seeing what a hacker is doing). A better method
> would be to use the snare audit modules from  Intersecalliance
> http://www.intersectalliance.com/projects/Snare/Documentation/index.html#SNA
> RE_Installation
> I am currently using that product on top of SELlinux. The government
> requires audit data and it is the best for right now.
>

yes, the same is here, i'm using snare almost from the beginning, but
seems that sometimes snare do some high load over machine, and for sure i'm
not that crazy to rely on .bash_hitory for audits ;).

best regards,

Hacko




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
