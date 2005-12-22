Date: Thu, 22 Dec 2005 16:45:07 -0500
From: "schaufler-ca.com - Casey Schaufler" <casey@schaufler-ca.com>
Message-Id: <200512222145.jBMLj7H0008704@luminouswebdesign.com>
To: SELinux@tycho.nsa.gov
Subject: Re: [RFC] SELinux file_ioctl hook permission checks changes 
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- abreeves <abreeves@maxinter.net> wrote:


> Alles

> ... we have not investigated the full history of
> distinguished op. systems of the past as to what
> they could tell us.
> ...  TOPS-20 ...
> ...
> I wonder
> if any of you gurus had ever tho't about this

Oh my, yes indeedy. Have a look at the P1003.1e/2c
DRAFT document. It's chuck full of revealing insights
about what and why TOPS-20, Multics, VMS, and
System370 have contributed to the security
architecture of open (was system, now source)
kernels. None of it's done out in so many words,
mind you, but the rationale section for ACLs by
itself will probably leave you wondering how the
bureaucracy of the Holy Roman Empire manages
to have such influence in modern OS design.

> ... Think about it.

To answer the TOPS-20 4-way model question
more directly, the ogw 3-way model is good enough
for anything that doesn't need to be fully general,
and the 4-way just doesn't add that much value.
ACLs are (intended to be) completely general,
and when it came down to making changes
consensus was clearly on the side of going all
the way to generality.

> Allen B. Reeves, former NSAer.

------------------------
Casey Schaufler
casey@schaufler-ca.com
650.906.1780








--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
