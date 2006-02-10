Message-ID: <43ED1FF5.2050802@cornell.edu>
Date: Fri, 10 Feb 2006 18:21:25 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
   Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [SEPOL][SEMANAGE] Nodecon Support: Try 1
References: <43E667C2.6050001@cornell.edu> <43E6A154.5010608@cornell.edu> <43E9AA00.3010803@cornell.edu>
In-Reply-To: <43E9AA00.3010803@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Attached is a resync of the same patch to current CVS.
Ok, this patch needs more work, I guess.

According to Chad Hanson (on IRC) the kernel reorders by netmask, which 
will not work with this patch.
If this is the case, then this problem is equivalent to the issue with 
ports - namely, the strategy to replace exact key match, and prepend 
everything else in front does not work, and creates problems. The code 
needs to be smarter on updates - needs to edit port ranges and nodecon 
entries that are overridden locally, and make the appropriate changes.

Other comments by Chad:
- no preference on byte order  - should probably follow policy 
convention (network byte order?)
- byte arrays are better than integer ones


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
