Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iADJwtIi016950
	for <selinux@tycho.nsa.gov>; Sat, 13 Nov 2004 14:58:55 -0500 (EST)
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id iADJvTvm011597
	for <selinux@tycho.nsa.gov>; Sat, 13 Nov 2004 19:57:30 GMT
Received: from debby (shorty@debby [127.0.0.1])
	by localhost.localdomain (8.13.1/8.13.1/Debian-16) with ESMTP id iADJwmGt021627
	for <selinux@tycho.nsa.gov>; Sat, 13 Nov 2004 20:58:49 +0100
Subject: Re: Linux Journal Article
From: Wolfgang Pfeiffer <roto@gmx.net>
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0411122147260.7482-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0411122147260.7482-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Date: Sat, 13 Nov 2004 20:58:48 +0100
Message-Id: <1100375928.1691.17.camel@debby>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-12 at 21:48 -0500, James Morris wrote:
> What's New in Fedora Core 3 SE Linux
> By Faye Coker
> 
> http://www.linuxjournal.com/node/7887

Excerpt from this page:

"Work also is being done on Security Enhanced X, where the aim is to
have control over the X sessions so that, for instance, a hostile X
program can't interfere with other X programs on the display."

Does this mean that SElinux currently can't have an impact on X-related
processes (gdm, Gnome, FVWM etc., and on Debian/unstable)?

I'm asking because one reason to install SElinux is the problems I had
with Gnome at times (on a non-SElinux system), such that one X-related
process, when crashing, seemed to pull all the rest of the X-session
into hell ... thus rendering the whole X-session unusable ..

Thanks in anticipation.

Best Regards
Wolfgang
-- 
Wolfgang Pfeiffer                           gpg ID: 0AA7E825
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
