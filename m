Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5A2MPrT024428
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 22:22:25 -0400 (EDT)
Received: from abyss.simplyaquatics.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5A2MNQd023497
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 22:22:23 -0400 (EDT)
From: "Ed Street" <edstreet@street-tek.com>
To: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: RE: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Date: Wed, 9 Jun 2004 22:22:21 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <20040609233946.GI5727@lkcl.net>
Message-Id: <20040610022221.7796D3A4063@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Well why ANY app needs write access to /etc is beyond me.  Also are you
using run_init /etc/init.d/foo ?

Ed

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of Luke Kenneth Casson Leighton
Sent: Wednesday, June 09, 2004 7:40 PM
To: SE-Linux
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't
working.

On Wed, Jun 09, 2004 at 09:41:26PM +0000, Luke Kenneth Casson Leighton
wrote:
> hi,
> 
> debian's postfix init.d script does a whole stackload of
> things like copy over /etc/localtime, /etc/services.
 
 i should be more specific: in the creation of the chroot jail,
 in /var/spool/postfix, the permissions (contexts) are preserved
 and recreated (see file_contexts/programs/postfix.fc)

 i.e., in order for the /etc/init.d/postfix script to create the
 chroot jail, it is necessary to give initrd_t permissions
 sufficient to write to etc_t, amongst other things.

 the chroot jail needs a copy of /etc/localtime and /lib/libnss* and
 such-like.

 clearly from an selinux perspective, the /etc/init.d/postfix
 script cannot be an appropriate place to set up a chroot jail.

 can anyone think of a way in which this could be better achieved?

 bearing in mind that the solution must take into account that
 postfix can be run in a chroot jail or not, depending on
 an administrative decision.

 l.
 

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.698 / Virus Database: 455 - Release Date: 6/2/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
