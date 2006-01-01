Subject: Debian users: don't upgrade for now
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
In-Reply-To: <1136133436.27906.56.camel@wintermute.xmldesign.de>
References: <1136133436.27906.56.camel@wintermute.xmldesign.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 01 Jan 2006 17:41:24 +0100
Message-Id: <1136133684.27906.59.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello again:
to all Debian users of SELinux:
Avoid upgrading to either unstable or my backports.

This is not good:
system_u:object_r:default_t      root

But I don't know how to get genhomedircon working properly any more.

Oh, and does anyone have a hint for me how to get /dev/log
and /dev/initctl labeled properly with udev? Udev with SELinux is
serious pain...

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     Which is worse: ignorance or apathy? Who knows? Who cares?     //\
      Alles verändert sich, sobald man sich selber verändert.       V_/_



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
