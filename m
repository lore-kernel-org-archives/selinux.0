Message-ID: <40B6242E.30801@treblig.org>
Date: Thu, 27 May 2004 18:23:58 +0100
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: hint for patching debian shadow tools/useradd
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just a hint for those patching the debian shadow tools ;
I got the patch from the Fedora tools and applied the same
stuff - no success.
The thing to watch out for is that you need to patch the
Makefile.in's on Debian not/as well as the Makefile.am's

With that and a few policy tweaks I think it might just
work and let you create users without screwing the contexts
up.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
