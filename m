Message-Id: <200209110907.JAA05058@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>
Subject: Re: redhat.te and suse.te (was Re: pppd with ipppd)
Date: Wed, 11 Sep 2002 11:07:03 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200209082234.38885.russell@coker.com.au> <200209101310.NAA02014@jazzswing.ncsc.mil> <200209101826.30237.russell@coker.com.au>
In-Reply-To: <200209101826.30237.russell@coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Dienstag, 10. September 2002 18:26 schrieb Russell Coker:
>
> Now that we have shown that the .fc file per application scheme works
> well I doubt that there is a real need to use M4 for the .fc files (it's
> adding extra complexity for little benefit that I can see).

> > And it will by possible to remove unused single rules (like dhcpd_t)
> > without get an error ( Unkown type ...).
>
> What do you mean?

I am sorry about my bad english. 
Without the m4 macros specially ifdef, I would not create a single suse 
rule. Because with an monolithic suse.fc file it isn't possible to strip 
down the policy. But the possiblity to remove unused rules is ( in my eyes 
) good feature of selinux. Because of that I don't see a disadvantage in 
the use of ifdef's also in the fc files. 

Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
