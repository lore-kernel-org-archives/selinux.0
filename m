Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TM0grT023072
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 18:00:42 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TM0eCb023656
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 22:00:41 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 29 Jul 2004 22:00:41 -0000
Date: Thu, 29 Jul 2004 23:11:46 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: James Morris <jmorris@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: temporary hack to use udev in selinux
Message-ID: <20040729221146.GO9950@lkcl.net>
References: <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com> <200407292059.i6TKxGFL019918@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200407292059.i6TKxGFL019918@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

usb-mount does this by using sudo.

it's a very clever program, but from a security perspective i ain't
entirely enamoured with the number of additions i've had to make
to fsadm.te, the number of extra permissions to mount_t and user_t
and i'm sure i've got something wrong, here.

however, that aside, usb-mount is at present only set up to
do usb hotplug devices.

perhaps it could be adapted to do scsi and ide drives, and consequently
cdroms too?

does hotplug "do" cdrom drives?

l.

p.s. anyone interested in the rather drastic hacks i've done for
usb-mount, let me know.

p.p.s. neither sg_map nor disktype are catered for in fsadm.te,
so i've had to add stuff for those.

On Thu, Jul 29, 2004 at 04:59:16PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 29 Jul 2004 13:06:15 EDT, James Morris said:
>  
> > This could be done by simply allowing context= to override any other 
> > behavior, right?
> 
> Well, with proper control over what roles/etc can use that mount option.
> (Think "/dev/cdrom auto-mounted as 'user' by a system daemon"...)



-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
