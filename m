Subject: Re: Debian SELinux backports project
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
In-Reply-To: <1132232710.16126.6.camel@wintermute.xmldesign.de>
References: <1132232710.16126.6.camel@wintermute.xmldesign.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 18 Nov 2005 03:46:10 +0100
Message-Id: <1132281971.10036.10.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi folks,
http://selinux.alioth.debian.org/ is up with a tiny bit of information,
as well as a dozen of (yet untested) packages, as well as an extensive
backporting howto
at http://selinux.alioth.debian.org/sesarge/HOWTO-Backport.txt

I currently don't have a box at hand to test the backports... maybe I'll
be able to organize one the next days, but I cannot promise. Basically I
just redid my earlier work on backports (but which I didn't upload to a
public location) a bit more formally and documented every step in above
HOWTO.
The changes I did to the packges are so tiny, the only thing that might
be broken are the cronjob changes in cron.daily/standard - I didn't test
them "literally" yet. So there might still be a typo in there. But
nothing serious, it will probably just give you some more SELinux audits
to care about.

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     Which is worse: ignorance or apathy? Who knows? Who cares?     //\
               Für jedes Problem gibt es eine Lösung,               V_/_
                 die einfach, klar und falsch ist.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
