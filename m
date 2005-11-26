Subject: Bug (?) in cvs selinux policy
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sat, 26 Nov 2005 02:27:28 +0100
Message-Id: <1132968448.701.1.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
while merging the current policy CVS in my local policy, I noticed this:
---
tail -1 domains/program/unused/dhcpc.te
allow dhcpc_t locale_t:file write;
---

Why? If this is some locale caching or so, it probably should be
use_locale(dhcpc_t) or something like that. But this single write here
is really odd...

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
       The best things in life are free: Friendship and Love.        //\
  Wer keine Zeit mehr mit echten Freunden verbringt, der wird bald   V_/_
          sein Gleichgewicht verlieren. --- Michael Levine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
