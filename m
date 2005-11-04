Subject: changes in ~2.6.13 break postfix policy?
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 04 Nov 2005 13:09:05 +0100
Message-Id: <1131106145.28236.7.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I'm running the same policy on a couple of similar systems.
All of them run postfix, and logcheck (so they frequently do send
emails)

On the systems running 2.6.13 or 2.6.14 I get errors similar to the
following:
avc:  denied  { read } for  pid=3247 comm="pickup" name="[197650]"
dev=sockfs ino=197650 scontext=system_u:system_r:postfix_pickup_t
tcontext=system_u:system_r:postfix_pickup_t tclass=sock_file
avc:  denied  { write } for  pid=3247 comm="pickup" name="[197650]"
dev=sockfs ino=197650 scontext=system_u:system_r:postfix_pickup_t
tcontext=system_u:system_r:postfix_pickup_t tclass=sock_file
avc:  denied  { getattr } for  pid=14416 comm="qmgr" name="[197661]"
dev=sockfs ino=197661 scontext=system_u:system_r:postfix_qmgr_t
tcontext=system_u:system_r:postfix_qmgr_t tclass=sock_file
for just about every socket postfix uses.

The socket "files" all have system_u:object_r:postfix_private_t, though.

I don't see the same errors on machines with an older selinux kernel.
Any idea whats wrong?

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
   To understand recursion you first need to understand recursion.   //\
   Nur der ist weise, der weiﬂ, dass er es nicht ist. --- Sokrates   V_/_



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
