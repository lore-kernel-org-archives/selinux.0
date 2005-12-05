Subject: slapd on debian stable
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 05 Dec 2005 18:46:03 +0100
Message-Id: <1133804764.15188.21.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
at least on debian stable (didn't check unstable), the debian slapd
binary is located in /usr/lib/slapd (and thus not
system_u:object_r:slapd_exec_t)
Should we add a conditional or an unconditional statement for this to
the ldap policy files?

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
      To be trusted is a greater complement than to be loved.       //\
   Unter Freunden ist guter Rat nicht teuer, aber wie alles, was    V_/_
       nichts kostet, nur wenig gefragt. --- Robert Muthmann


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
