Subject: Re: Threaded applications and "execmem" privilege
From: Erich Schubert <erich@debian.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
In-Reply-To: <1133188277.348.47.camel@moss-spartans.epoch.ncsc.mil>
References: <1132504528.12651.21.camel@wintermute.xmldesign.de>
	 <1132672653.28079.10.camel@wintermute.xmldesign.de>
	 <1133188277.348.47.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 16:18:30 +0100
Message-Id: <1133191110.5276.17.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen,
> That alters the mmap call to only apply PROT_EXEC when the binary is
> marked as requiring an executable stack or the binary lacks marking (I
> assume that execstack -q `which host` shows - /usr/bin/host). That

Okay, that probably means that most apps (maybe not java and x.org, but
I don't have these on my selinux boxes anyway) should work just fine.
And others probably too, since IIRC i386 doesn't enforce that anyway...
But I'll switch to the patch you posted.

> change is dated Sep 24 2003, and further changes have occurred since
> that time.  How old is the Debian libc?

Debian *stable* libc is version 2.3.2 with tons of patches. Unstable has
2.3.5 with apparently a different thread library?

I don't have this "execstack -q" application. Seems to be
Redhat-specific.

Debian includes a lintian check for executeable stack since october, but
that means rather few packages have been tested yet...

Some more information on the issue:
http://wiki.debian-hardened.org/SSP/ProPolice_Implementations

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
    Go away or i'll replace you with a very small shell script.     //\
    Der Anfang aller Erkenntnis ist das Staunen. --- Aristoteles    V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
