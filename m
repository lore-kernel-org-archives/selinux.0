Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAGGRC4H024525
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 11:27:12 -0500
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAGGRAfY016716
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 16:27:10 GMT
Subject: Re: [DSE-Dev] [martin@martinorr.name:  /selinux getattr messages]
From: Erich Schubert <erich@debian.org>
To: Litwiniec Robert <linio@wonder.pl>
Cc: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>,
        selinux@tycho.nsa.gov, Martin Orr <martin@martinorr.name>,
        selinux-devel@lists.alioth.debian.org
In-Reply-To: <20071116150103.GA31130@asterix.wonder.pl>
References: <20071116125923.GA25905@bobek.pm.i.cz>
	 <1195224049.22415.42.camel@hepcat.vitavonni.de>
	 <20071116150103.GA31130@asterix.wonder.pl>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 17:27:06 +0100
Message-Id: <1195230426.22415.52.camel@hepcat.vitavonni.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Robert,
> I testing selinux on my etch/lenny machine, and i prepared patch for
> refpolicy trunk:
> http://wonder.pl/pub/debian/deby/debian-selinux-patches/refpolicy/refpolicy-debian-20071116.patch

Just some notes:
- don't include build.conf in the patch
- try to split the patch into small changes, and send them individually.
That makes review easier, and they go into upstream quicker.

I don't have the time to completely review your patch, so just a few
notes:

refpolicy/policy/modules/admin/alsa.fc:
/var/lib/alsa/asound\.state	gen_context(system_u:object_r:alsa_etc_rw_t,s0)

Make a new context such as alsa_state_t, using *_etc_* outside of /etc
is a misnamer, and you unnecessarily give write access to files in /etc
when you only want to give write access to /var/lib/alsa.
Also you should relabel the directory /var/lib/alsa, this helps getting
the file labeled correctly upon creation already.

refpolicy/policy/modules/apps/mozilla.fc:
/usr/bin/epiphany
shouldn't be labeled mozilla_exec_t, because it's just a wrapper shell
script. The correct binaries to relabel are
  /usr/bin/epiphany-gecko
  /usr/bin/epiphany-webkit
  /usr/bin/epiphany
(for version where there was just the gecko branch)

/etc/gdm - you messed something up there. avoid bin_t there.

refpolicy/policy/modules/services/hal.fc:
also relabel the directory, so the pidfile gets labeled correctly upon
creation.

Again, I didn't go through the whole diff. But on overall, I think
you've been doing a quite good job. You've understood how to fix audit
errors properly and how to use interfaces and macros. I hope that
someone of the active SELinux users will have time to look at your diff
in detail and include some of the changes into the upstream branch.

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
 Why waste time learning, when ignorance is instantaneous? --- Calvin //\
     Die eigentliche Aufgabe eines Freundes ist, dir beizustehen,     V_/_
     wenn du im Unrecht bist. Jedermann ist auf deiner Seite, wenn
                   du im Recht bist. --- Mark Twain


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
