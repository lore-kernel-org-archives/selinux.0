Message-ID: <43ED5B3C.9090406@cornell.edu>
Date: Fri, 10 Feb 2006 22:34:20 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Chad Hanson <chanson@TrustedCS.com>
CC: "'SELinux List '" <SELinux@tycho.nsa.gov>,
   "'Stephen Smalley '" <sds@tycho.nsa.gov>,
   "'Joshua Brindle '" <jbrindle@tresys.com>
Subject: Re: [SEPOL][SEMANAGE] Nodecon Support: Try 1
References: <36282A1733C57546BE392885C061859205735A@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C061859205735A@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I guess I need to correct myself, that checkpolicy, not the kernel orders
> the nodecon rules.
>
> http://marc.theaimsgroup.com/?l=selinux&m=109906728301734&w=2
> http://marc.theaimsgroup.com/?l=selinux&m=109968743026327&w=2
> http://cvs.sourceforge.net/viewcvs.py/selinux/nsa/selinux-usr/checkpolicy/po
> licy_parse.y?r1=1.24&r2=1.25
>   
Ah, this makes all the difference... then the original plan makes sense, 
and the patch should work, once ordering is added in the local case. I 
should be able to make a nodecon spec take precedence by placing it in 
front of the ocontext_t list, correct?

The ports issue I described stands anyway, list() and iterate() show 
overlapping ranges, and that will be an issue for nodes as well.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
