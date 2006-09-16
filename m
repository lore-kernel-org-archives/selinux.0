Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8GC8Bnn024708
	for <selinux@tycho.nsa.gov>; Sat, 16 Sep 2006 08:08:11 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8GC7CSA012208
	for <selinux@tycho.nsa.gov>; Sat, 16 Sep 2006 12:07:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: awk, isatty(), libc and ioctl()
Date: Sat, 16 Sep 2006 22:08:08 +1000
Cc: selinux@tycho.nsa.gov
References: <1158185710.1594.94.camel@wintermute.xmldesign.de>
In-Reply-To: <1158185710.1594.94.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200609162208.13198.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 14 September 2006 08:15, Erich Schubert <erich@debian.org> wrote:
> one of the few audit errors remaining on my test box is
>   initrc_t postfix_etc_t:file ioctl;
>
> Which sounds like an odd behaviour to me. I've tracked it down to the
> init script using an awk-one-liner to determine if it needs to sync the
> chroot.
> Awk however calls isatty() on any file it processes. Which is
> implemented in the libc apparently using an ioctl TCGETS; this will fail
> for regular files.

One thing to note is that Perl has the same issue in regard to ioctl() on all 
files.

The isatty() code could stat the file first, anything that's not a character 
device is not a tty.  But I doubt that we are going to get a change to glibc 
for this.

It's easiest to just allow or dontaudit the ioctl.  It's what we've been doing 
for the past 5 years...

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
