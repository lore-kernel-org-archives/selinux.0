Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA12469
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 15:23:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA01207
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 19:23:05 GMT
Received: from smtp5.andrew.cmu.edu (SMTP5.ANDREW.CMU.EDU [128.2.10.85])
	by jazzswing.ncsc.mil  with ESMTP id TAA01203
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 19:23:05 GMT
Date: Fri, 8 Jun 2001 15:23:26 -0400 (EDT)
From: Zachary Uram <zu22@andrew.cmu.edu>
To: Jonathan Day <jd9812@my-deja.com>
cc: selinux@tycho.nsa.gov
Subject: RE: hello?
In-Reply-To: <200106081503.IAA15302@mail22.bigmailbox.com>
Message-ID: <Pine.GSO.4.21L.0106081520000.5848-100000@unix7.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Jun 2001, Jonathan Day wrote:
> 
> Second, selinux and OpenBSD aim for security in two orthogonal ways. (ie: They don't interact at all.) SELinux aims for security through setting up quantifiable boundaries on resources. Nothing goes in or out, without explicit permission. Thus, if a program is compromised, the impact of that is going to be much smaller than it would be, otherwise.

Hi Jonathan,

Oh I see.

> OpenBSD is an exercise in phenominal auditing. I think they've found one, maybe two, potential security problems in the pasy year. It is also a hotbed of encryption. Their IPSec implementation is extremely good, for example, and OpenSSH is one of the best SSH clones going.

Auditing is software verification & validation testing? How do
they find the bugs in the code?


> As for which is better, it depends on which track suits your needs the best. Personally, I suspect that when the Stanford Checker is released onto the world, the wholesale auditing of Linux, the various extensions, and every package ever written for it, will become an industry of its own.

What is Stanford Checker? Can I download it for free? What is
website? Is it like the weblint of Linux security?

> The other thing you need to consider is that SELinux, as it stands, isn't designed to work with MOSIX, yet MOSIX seems (from the publicity) to be destined for the kernel. This means that SELinux is going to need some degree of extending and bashing to get it to work with a distributed environment.

MOSIX is to Linux as POSIX is to UNIX? Does MOSIX have website?

> I've never tried SELinux with Debian, but it should run just fine. It's not distribution-specific.

Cool.
Thanks.

I want to start installing different secure OSes on my machines
and then try break in and examine my logs to learn.

SDG,
Zach


uram@cmu.edu
"Blessed are those who have not seen and yet have faith." - John 20:29



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
