Message-ID: <72222DC86846D411ABD300A0C9EB08A1015241B8@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Conan Callen '" <ccallen@windowpane.com>
Cc: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: RE: Partial TOC for Comment]
Date: Sat, 18 Aug 2001 08:01:32 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Conan Callen Wrote:
> Does SELinux help to make it tougher for the crackers to
>gain access like this? Know of any good webpages / books on how to get
>started (steps) on locking down a system, and creating scripts to
>monitor
>the system?

With a resound yes it does help. I had a Redhat box that used for
DNS. I was being lazy and did not update the box. Someone broke into
The DNS server and installed rootkit. I reloaded the server since I was
on his target list I got hit again (same as you.. Same day) I then reload
the box (offline) with selinux and created a named domain. Then the machine
was placed online. I did not update named to see if the named security
domain would work. Yes it works great. For the next week he kept tying, I
noticed in the logs where he was using buffer overflow to attacked the
named. He performed buffered overflow on the named server but was not able
to do any thing else to the system.

Mark Westerman
I very satisfied customer of SeLinux




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
