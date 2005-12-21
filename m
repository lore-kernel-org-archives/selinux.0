Subject: Re: diffs + additions to NSA cvs policy
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
In-Reply-To: <1135132579.5408.33.camel@wintermute.xmldesign.de>
References: <1135132579.5408.33.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 04:42:51 +0100
Message-Id: <1135136571.5408.34.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> - munin (successor of LRRD, load graphing)

This also needs
---
# Munin
portcon tcp 4949  system_u:object_r:munin_port_t
---
at least if you do remote statistics.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
     This one's tricky. You have to use imaginary numbers, like     //\
                      eleventeen... --- Hobbes                      V_/_
   Wirklich gute Freunde machen sich erst aus dem Staub, wenn man
           sie braucht. --- Charles Maurice de Tayllerand


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
