Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LErOgA026439
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 10:53:24 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LEm1Ba000578
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:48:01 GMT
Subject: Re: ainit
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   fedora-selinux-list@redhat.com
In-Reply-To: <200507212142.28830.russell@coker.com.au>
References: <200507212142.28830.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 10:50:24 -0400
Message-Id: <1121957424.13068.53.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-21 at 21:42 +1000, Russell Coker wrote:
> Is this really what we want?  Having a system process allocate shared memory 
> that can be used by any user processes?  Also it seems likely that other 
> sound programs will need to access the shared memory in question.
> 
> There are three possible assumptions that we could make:
> 
> 1)  Anyone who is serious about security doesn't use ALSA so such
> access doesn't matter that much.

This isn't the case.  ALSA isn't any different then OSS from a SELinux
viewpoint.  I don't have ainit on any of my Gentoo machines; after a few
minutes on Google, it seems that this is a Redhat/Fedora specific
program.

> 2)  Sound devices are a channel for communication anyway so it doesn't
> really grant any new access.

I don't see any SysV IPC objects on my machines that use ALSA, so it
seems that ALSA has an optional feature that uses IPC, but it is not
required for playing or recording sound.

> Does ALSA require that a shared memory segment be available to all
> programs that are accessing the sound device?

This is the important question to ask of this feature.

> Can an application stuff some data into the sound hardware without
> using the user-space code from ALSA in such a way that another
> application can read it?

Adding in shared memory access between all user domains is a much easier
channel for communication then a sound device is; it doesn't need to go
through the hardware since all user domains can read and write the
segments.

> 3)  We need to have pam_console launch programs such as ainit in a context 
> determined by the user role.

Probably the right answer if the shared memory doesn't have to be shared
between all user domains.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
