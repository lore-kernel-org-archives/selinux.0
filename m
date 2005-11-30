Subject: Re: Bug (?) in cvs selinux policy
From: Erich Schubert <erich@debian.org>
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux@tycho.nsa.gov,
   Jason Vas Dias <jvdias@redhat.com>
In-Reply-To: <1133306986.13162.45.camel@localhost.localdomain>
References: <1132968448.701.1.camel@wintermute.xmldesign.de>
	 <438C8A3C.5070904@redhat.com>
	 <1133305918.20990.5.camel@wintermute.xmldesign.de>
	 <1133306986.13162.45.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 01:38:17 +0100
Message-Id: <1133311097.20990.21.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> I personally like to have the option of using both, for peace of mind.
> I am not good enough to run my systems in full enforcing mode constantly
> (there are still some maintenance tasks that I do which are much easier
> to handle by switching to permissive mode) and so I like to have the
> ability to cumulate the security measures.

This should then be handled by a central "setup_chroot" utility with
it's own domain and the ability to copy over files (with proper security
checking, of course)
It would be helpful for most applications anyway to have a central tool
for that, instead of each app writing it's own in its initscript.

The other issue remains, that the chroot most likely is setup by your
initscript, i.e. with initrc_t permissions, not dhcpc_t.
Btw, I never heard of dhcpC (= client) running chroot. Seems kind of
hard, since most likely you'll want it to update your real resolv.conf,
maybe reload your mail server etc.

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
  Nothing prevents happiness like the memory of happiness. --- A. Gide //\
 Mancher findet sein Herz nicht eher, als bis er seinen Kopf verliert. V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
