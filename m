MIME-Version: 1.0
In-Reply-To: <3453b4110905151046s27022fb4jf9975fa4523572fa@mail.gmail.com>
References: <3453b4110905151046s27022fb4jf9975fa4523572fa@mail.gmail.com>
Date: Fri, 15 May 2009 20:00:36 +0200
Message-ID: <3453b4110905151100n5afb13c8q56b75bd25eac571f@mail.gmail.com>
Subject: Dropping SELinux privileges
From: Sebastien Raveau <sebastien.raveau@epita.fr>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi everybody!


As a personal challenge I am trying to reach "state of the art"
security on my home router... and for that I'm using SELinux of course
;-)

I have everything setup and working, but what intrigues me is: isn't
there a way to drop SELinux privileges?

I mean, many programs require privileges only during their startup
phase, and restricting their rights from the outside proves
impossible; that's why volontary chroot(), setgid() and setuid() are
so useful: the program decides when to relinquish its privileges.

For example, a program like OpenVPN should only be allowed network
I/O, but because its initialization invokes shell commands, we have to
give it many more rights than it actually needs. Granted, in the case
of OpenVPN the combination with setuid and chroot solves the shell
commands problem, but this still makes policy files too complex...

Maximum (theoretical) security could be reached if a program could be
allowed to switch from some policy to an even more restrictive policy,
and very simple policy files could be written if a program could be
allowed to start unconfined and when ready apply a policy to itself,
which is basically the same.


I couldn't find such a thing in the SELinux API: have I misread? Or it
does not exist and perhaps I could contribute it? :-)

Best regards,

-- 
Sebastien Raveau

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
