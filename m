Subject: Threaded applications and "execmem" privilege
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 20 Nov 2005 17:35:28 +0100
Message-Id: <1132504528.12651.21.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I've been trying to find out how to avoid the "execmem" errors you e.g.
get in "host" (from the bind package, using the resolver library from
bind...), "dig" and "bind" itself.

Apaprently this is due to using threads - as far as I can tell, any
application using threads on Linux will do a mmap with "PROT_READ |
PROT_WRITE | PROT_EXEC",
which will trigger the execmem hook of SELinux.

Now that is really annyoing: either I need to enable "execmem" for most
domains, or write new domains for stuff like "host" and "dig" and add
appropriate execute transitions to tons of domains. :-(

It would probably be possible to remove PROT_EXEC from the mmap in the
threads library, but I bet there are some applications relying on
it... :-(
Another option would be to modify the threads library to try with
PROT_EXEC first, then retry without. Then a "dontaudit" rule for some
applications should be fine as well...

Anyone here deep enough in the thread libraries to know whether
PROT_EXEC is actually needed and/or what it's going to break?

Can some people try to run "dig" or the "host" command from bind (NOT
the dnsutils version, which probably doesn't use libpthread) and check
wheter they need the execmem permission for it, too?
And otherwise maybe find out how their thread library avoids using both
PROT_WRITE and PROT_EXEC on the same mmap...

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
   There was never a good war or a bad peace. - Benjamin Franklin   //\
               Für jedes Problem gibt es eine Lösung,               V_/_
                  die einfach, klar und falsch ist.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
