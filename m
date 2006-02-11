Message-ID: <36282A1733C57546BE392885C061859205735A@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "'Ivan Gyurdiev '" <ivg2@cornell.edu>,
   "'SELinux List '"
	 <SELinux@tycho.nsa.gov>
Cc: "'Stephen Smalley '" <sds@tycho.nsa.gov>,
   "'Joshua Brindle '"
	 <jbrindle@tresys.com>,
   Chad Hanson <chanson@TrustedCS.com>
Subject: RE: [SEPOL][SEMANAGE] Nodecon Support: Try 1
Date: Fri, 10 Feb 2006 20:55:27 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



>> Attached is a resync of the same patch to current CVS.
>Ok, this patch needs more work, I guess.

>According to Chad Hanson (on IRC) the kernel reorders by netmask, which 
>will not work with this patch.

I guess I need to correct myself, that checkpolicy, not the kernel orders
the nodecon rules.

http://marc.theaimsgroup.com/?l=selinux&m=109906728301734&w=2
http://marc.theaimsgroup.com/?l=selinux&m=109968743026327&w=2
http://cvs.sourceforge.net/viewcvs.py/selinux/nsa/selinux-usr/checkpolicy/po
licy_parse.y?r1=1.24&r2=1.25

>If this is the case, then this problem is equivalent to the issue with 
>ports - namely, the strategy to replace exact key match, and prepend 
>everything else in front does not work, and creates problems. The code 
>needs to be smarter on updates - needs to edit port ranges and nodecon 
>entries that are overridden locally, and make the appropriate changes.
>

The ordering by checkpolicy allows the nodecon rules to be unordered, even
though it may be confusing to an administrator. A network rule prepended to
a list won't have precendence to a exact host rule.

>Other comments by Chad:
>- no preference on byte order  - should probably follow policy 
>convention (network byte order?)
>- byte arrays are better than integer ones

Correct

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
