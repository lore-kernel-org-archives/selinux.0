Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71FnFrT007502
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 11:49:15 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i71FnE0x022517
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 15:49:14 GMT
Date: Sun, 1 Aug 2004 17:00:19 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-hotplug-devel@lists.sourceforge.net,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: hotplug 0.030 not setting selinux permissions on /dev/tty*
Message-ID: <20040801160019.GC15949@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi there,

i've got udev up-and-running, with an selinux kernel 2.6.7.

i've added se-linux temporary attributes to tmpfs in order for
the tmpfs /dev to "remember" the selinux settings that udev would
make (without the patch, it's guaranteed to fail).

[see http://hands.com/~lkcl/selinux/2.6.6]

the issue is that i am not seeing any execution of
/etc/dev.d/default/selinux.dev on /dev/tty[absolutelyanything].

so as a temporary hack i am going to have to do a manual restorecon
or a setfiles /etc/selinux/src/file_contexts/file_contexts /dev.

which defeats the object of having the /etc/dev.d/default/selinux.dev
stuff in the first place.

i really don't know enough about the operation of udev to say where
the creation of /dev/tty1, /dev/tty2 etc etc etc are coming from,
or why /etc/dev.d/default/selinux.dev would not be called.

does anyone know why?

what is going on: /dev/tty1...N are all in /dev/.udev.tdb, and
they are all created in /dev, so... why wouldn't they have the
permissions set?

could it be because.... they are copied from somewhere else?

e.g. the initrd scripts?

i am at a loss.

l.

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
