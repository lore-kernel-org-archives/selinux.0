Subject: Re: Documentation, anyone?
From: Erich Schubert <erich@debian.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
   Ivan Gyurdiev <ivg2@cornell.edu>,
   Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
In-Reply-To: <1136306860.27632.102.camel@moss-spartans.epoch.ncsc.mil>
References: <1136133436.27906.56.camel@wintermute.xmldesign.de>
	 <1136306860.27632.102.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 23:31:11 +0100
Message-Id: <1136327471.1340.8.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen,
Thanks for your replies.

genhomedircon doesn't fall back on the "old" behaviour as I had it on
Debian up to now. When libsemanage fails (I guess when the "modular" dir
doesn't exist), it tries to load /etc/selinux/seusers instead; the old
genhomedircon I had was apparently parsing the local.users and users
files directly;
the current fallback is to load seusers and then parse these files for
any user found in this seusers file (which also must have three
components per line).
So I managed to get sufficient fallback now by writing an appropriate
seusers file; I think I got an example from one of the fedora packages.

For debian users, I've created two new mailing lists; as noted on
http://blog.drinsama.de/erich/en/linux/selinux/2006010201-debian-selinux-lists.html
The first mail on the selinux-users debian list gives details on the
seusers workaround to get a working genhomedircon again.

Thanks for your udev feedback; I'm not entirely happy with the
restorecon approach (e.g. what will happen on a syslog restart, which
might recreate the /dev/log device with incorrect permissions?) but it
will do for now.

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
  There is no branch of mathematics, however abstract, which may not  //\
 some day be applied to phenomena of the real world. --- Lobatchevsky V_/_
      Die Mathematik muss man schon deswegen studieren, weil sie
      die Gedanken ordnet. --- Michail Wassiljewitsch Lomonossow


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
