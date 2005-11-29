Subject: Re: Bug (?) in cvs selinux policy
From: Erich Schubert <erich@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux@tycho.nsa.gov, Jason Vas Dias <jvdias@redhat.com>
In-Reply-To: <438C8A3C.5070904@redhat.com>
References: <1132968448.701.1.camel@wintermute.xmldesign.de>
	 <438C8A3C.5070904@redhat.com>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 00:11:58 +0100
Message-Id: <1133305918.20990.5.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
> I think this allows it to cp the locale file into the chroot environment.

For example with postfix, running stuff in a chroot is "deprecated" with
SELinux, since the security implicatons of setting up the chroot are
higher than not running a chroot but only SELinux. ;-)
Also, the setup should probably done by the init script, not by the
daemon.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
       To be trusted is a greater complement than to be loved.       //\
  Wer nicht zuweilen zuviel empfindet, der empfindet immer zuwenig.  V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
