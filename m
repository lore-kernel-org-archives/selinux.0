Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9EK7TWt021217
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 16:07:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9EK7SmR027801
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 20:07:28 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
        by jazzband.ncsc.mil  with ESMTP id h9EK7Rjp027798 for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 20:07:27 GMT
Subject: [Fwd: Re: trusted vs untrusted packages]
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1066162046.27911.47.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Tue, 14 Oct 2003 15:07:26 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(resend)
-----Forwarded Message-----
> Subject: Re: trusted vs untrusted packages
> Date: Mon, 13 Oct 2003 21:36:13 -0500
> 
> On Mon, 2003-10-13 at 20:07, Russell Coker wrote:
> > One idea is to have signed packages be installed by rpm running as rpm_t and 
> > unsigned packages be installed by rpm running as rpm_unsigned_t [1].  So for 
> > example we could allow rpm_unsigned_t to install files in /sbin as 
> > sbin_unsigned_t and in /bin as bin_unsigned_t [2].  Then a program installed 
> 
> I would think that some sort of trusted-path execution setup would be
> better.  I don't know much about TPE, but this sounds like one situation
> that it would be good for.  Then you could set it to not do domain
> transitions on untrusted stuff, and also require that sysadm_t only
> execute trusted stuff.  The status as trusted or untrusted could be
> handled by another xattr.  Then it also would not get overridden by a
> relabel.  But I'm getting ahead of myself, since there is no TPE in
> SELinux. </brainstorm>
> 
> Might there one day be TPE in SELinux, or is that beyond its scope?
-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
