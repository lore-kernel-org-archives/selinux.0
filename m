Subject: Re: mv and cp behavior.
From: Erich Schubert <erich@debian.org>
To: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1098121436.6101.56.camel@decepticon.boston.redhat.com>
References: <41712EEF.9090402@redhat.com>
	 <1098105487.27895.40.camel@moss-spartans.epoch.ncsc.mil>
	 <1098115678.6101.30.camel@decepticon.boston.redhat.com>
	 <1098119648.27895.150.camel@moss-spartans.epoch.ncsc.mil>
	 <1098121436.6101.56.camel@decepticon.boston.redhat.com>
Content-Type: text/plain
Date: Mon, 18 Oct 2004 20:22:09 +0200
Message-Id: <1098123729.10216.6.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
btw: an easy way of doing a "cp" without changing destination file
properties (unix and selinux) is using "cat sourcefile > destfile"

Sure, this is not the most efficient, but for example on text files it
really doesn't matter.

Greetings,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
 A man doesn't know what he knows until he knows what he doesn't know. //\
         Es gibt kein idiotensicheres Programm, weil Idioten so        V_/_
                       genial sind. -- E. Murphy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
