Subject: more genhomedircon badness...
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
In-Reply-To: <1136133436.27906.56.camel@wintermute.xmldesign.de>
References: <1136133436.27906.56.camel@wintermute.xmldesign.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 01 Jan 2006 21:19:48 +0100
Message-Id: <1136146788.27906.65.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've now created /etc/selinux/modules/active/modules
and /etc/selinux/modules/active/seusers...

genhomedircon:  Warning!  No support yet for expanding ROLE macros in
the /etc/selinux/./contexts/files/homedir_template file when using
libsemanage.
genhomedircon:  You must manually update file_contexts.homedirs for any
non-user_r users (including root).
zsh: 19705 segmentation fault  genhomedircon

Ouch, a segfault!

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
          There are only 10 types of people in the world:           //\
          Those who understand binary and those who don't           V_/_
     Mathematik ist die Kunst, verschiedene Dinge mit demselben
                Namen zu belegen. --- Henri Poincaré



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
