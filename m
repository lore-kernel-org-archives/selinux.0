From: Joseph A Nagy Jr <joseph_a_nagy_jr@charter.net>
To: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: Re: Linux Wipe Disk Utility
Date: Wed, 13 Aug 2003 17:57:15 -0500
References: <E2462F68A99DB74D8AEDF13B261B1BDD02A69594@Larry.widevine.com>
In-Reply-To: <E2462F68A99DB74D8AEDF13B261B1BDD02A69594@Larry.widevine.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200308131757.18235.joseph_a_nagy_jr@charter.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 13 August 2003 17:07, Tomás Palmer wrote this in an attempt 
to be witty and informative:
> Well for windows there are a lot of U.S. DOD 5220.22 compliant HDD
> scrubbers. Do a quick search for Linux data scubbers but here is
> something I found and there are very pricey versions available
> http://wipe.sourceforge.net/
<snip>

Unless I'm mistaken, files on ext3 have their inodes automatically 
zeroed out upon file deletion. If this is the case, the above solutions 
are entirely unneccessary (at least the linux ones).
- -- 
Wielder of the mighty +1 LARTsaber of Unsubscribe Instructions At End of
Message, the +3 Clue-by-Four of No Attachments to a Mailing List, and
the -4 Shield of No Spell Checker. http://jan-jr-ent.homelinux.org
http://joseph-a-nagy-jr.homelinux.org http://mc-luug.homelinux.org/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/OsJMnjt9jEvKYeARAoQ6AJ9EvomcF1iZaFz9hr5tmJFKoQa54ACfYVjG
QYZfTIji9J478zBBy/fPqwo=
=/fXY
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
