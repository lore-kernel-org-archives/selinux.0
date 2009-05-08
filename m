Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n48NEvT3005046
	for <selinux@tycho.nsa.gov>; Fri, 8 May 2009 19:14:57 -0400
Message-ID: <4A04BCDC.2020106@tycho.nsa.gov>
Date: Fri, 08 May 2009 19:14:36 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>, Chad Sellers <csellers@tresys.com>
Subject: EOF missing newline bug in squid.fc / toolchain
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The file squid.fc in refpolicy has no newline at the end.

The toolchain doesn't correct for this, and squid.pp retains the missing
newline, all the way to the finished file_contexts where I'm ending up with
/var/squidGuard(/.*)?   system_u:object_r:squid_cache_t:s0#

(an empty comment line got mashed on), and setfiles verification fails
with invalid MLS field.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
