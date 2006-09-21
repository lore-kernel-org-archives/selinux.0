Subject: Re: SSH pubkey authentication & MLS policy
From: Erich Schubert <erich@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Michael C Thompson <thompsmc@us.ibm.com>,
        "Serge E. Hallyn" <serue@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45129698.5080503@redhat.com>
References: <4511AAF2.8090809@us.ibm.com>  <45129698.5080503@redhat.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 21 Sep 2006 17:28:48 +0200
Message-Id: <1158852528.14117.48.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
This is not MLS related.
Here's the Debian diff used to allow public key logins.
http://svn.debian.org/wsvn/selinux/refpolicy/branches/debian/policy/modules/services/ssh.te?op=diff&rev=0&sc=0

I believe that sshd verifies the home directory to be not
world-writeable.
The patch above adds "search", although "getattr" probably is
sufficient. But I didn't want to add another interface... yeah, I'm a
bit lazy sometimes.

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
 A man doesn't know what he knows until he knows what he doesn't know. //\
     Während das Glück dir lacht, wirst Freunde du zählen in Menge;    V_/_
       wenn sich der Himmel bewölkt, findest du dich bald allein.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
