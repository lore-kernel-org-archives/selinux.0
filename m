Subject: Re: libselinux CVS doesn't honor DESTDIR
From: Erich Schubert <erich@debian.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1140701707.21179.25.camel@moss-spartans.epoch.ncsc.mil>
References: <1140700506.10547.6.camel@wintermute.xmldesign.de>
	 <1140701707.21179.25.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 14:52:30 +0100
Message-Id: <1140702750.10547.13.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen,
Sorry, my bad. I just verified that it was somehow in the Debian diff,
albeit I couldn't build the debian package with that change... I thought
the Debian diffs here only consisted of a debian/ dir, but apparently
libselinux was an exception. Seems like this was introduced when adding
support for the pkgconfig file requested by some debian packagers (to
aid the building of statically linked support utilities for
bootstrapping I think)

But - yay - I finally have:
# semanage user -l
                MLS/       MLS/
SELinux User    MCS Level  MCS Range                      SELinux Roles

root            s0         s0-s0:c0.c255                  system_r
sysadm_r staff_r
staff_u         s0         s0-s0:c0.c255                  sysadm_r
staff_r
sysadm_u        s0         s0-s0:c0.c255                  sysadm_r
system_u        s0         s0-s0:c0.c255                  system_r
user_u          s0         s0                             user_r

On Debian stable! ;-)

Now I only need to write and fix tons of policy...
E.g. amavis, courier, drac, tor

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
  A polar bear is a rectangular bear after a coordinate transform.   //\
             Es lohnt sich nicht, die Augen aufzumachen,             V_/_
                    wenn der Kopf im Sand steckt.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
