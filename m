Date: Tue, 9 Jul 2002 08:28:13 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: comparison between SELinux and chroot
In-Reply-To: <200207091109.LAA21173@jazzband.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0207090815120.27193-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 9 Jul 2002, Carsten Grohmann wrote:

> I am looking for a paper with an comparison between SELinux and chroot.
> Why should I install and use SELinux, if I could use a chroot call, who is
> possible simplier.

chroot merely limits a process to a subset of the filesystem.  Even for
that purpose, chroot is a weak mechanism, as a chroot jail can be easily
broken by a superuser process.  Setting up a chroot jail that is adequate
for the functioning of the process while remaining "safe" is nontrivial,
and consumes disk space unnecessarily for duplicated files.  And chroot
doesn't provide any protection for kernel services and objects other than
the filesystem.

You might want to read a recent thread on this topic from the linux-kernel
mailing list,
http://marc.theaimsgroup.com/?l=linux-kernel&m=102587714118914&w=2

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
