Subject: Re: Documentation, anyone?
From: Erich Schubert <erich@debian.org>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 01 Jan 2006 21:33:41 +0100
Message-Id: <1136147621.27906.74.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Ivan,
[sorry for not having the in-reply-to header, I'm not subscribed to the
list]
I'm not running Fedora.
The reason why I'd like to find out more on the seusers file is because
the latest genhomedircon "depends" on this file. But I couldn't find one
anywhere.
Obviously, I don't have your <type>/modules/active directory either...
And none of this was included with the semanage source I have, nor is it
explained in the manpages or a "doc" subdir in the source...

Yes, I'm running a "plain old" strict policy...

Oh, and in genhomedircon, the third component is not entirely optional:
probably line 201, "if len(user) < 3:" should be < 2 then... ;-)
(in the non-semanaged case)

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
           There are only 10 types of people in the world:           //\
           Those who understand binary and those who don't           V_/_
   Die kürzeste Verbindung zwischen zwei Menschen ist ein Lächeln.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
