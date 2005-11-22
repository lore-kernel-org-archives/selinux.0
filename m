Subject: Re: Threaded applications and "execmem" privilege
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
In-Reply-To: <1132504528.12651.21.camel@wintermute.xmldesign.de>
References: <1132504528.12651.21.camel@wintermute.xmldesign.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 22 Nov 2005 16:17:33 +0100
Message-Id: <1132672653.28079.10.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
I've built debian stable libc6 package which do not use PROT_EXEC for
the stack, meaning they do not require the execmem privilege. executable
stacks are a bad idea anyway, aren't they?
This is not heavily tested... I've just installed it on one machine, and
can now run "dig" in enforcing mode. ;-)
I'm trying to upload them to alioth right now.

Here's the patch I used:
--- nptl/allocatestack.c.orig   2005-11-21 01:18:07.000000000 +0100
+++ nptl/allocatestack.c        2005-11-21 01:18:17.000000000 +0100
@@ -392,7 +392,7 @@
            size += pagesize_m1 + 1;
 #endif

-         mem = mmap (NULL, size, PROT_READ | PROT_WRITE | PROT_EXEC,
+         mem = mmap (NULL, size, PROT_READ | PROT_WRITE,
                      MAP_PRIVATE | MAP_ANONYMOUS | ARCH_MAP_FLAGS, -1,
0);

          if (__builtin_expect (mem == MAP_FAILED, 0))

>From a quick scan of the "Debian unstable" source I'd expect a similar
patch is needed there, too... but maybe one of the debian-patches
already does a similar change.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
                 Friends are those who reach out for                 //\
                   your hand but touch your heart.                   V_/_
   Wo befreundete Wege zusammenlaufen, da sieht die ganze Welt für
         eine Stunde wie eine Heimat aus. --- Herrmann Hesse



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
