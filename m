From: "Ed Street" <edstreet@street-tek.com>
To: <Valdis.Kletnieks@vt.edu>, "'Park Lee'" <parklee_sel@yahoo.com>
Cc: <SELinux@tycho.nsa.gov>
Subject: RE: issue on binary & source compatibility 
Date: Wed, 2 Jun 2004 21:19:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <200406021856.i52IuNV8000745@turing-police.cc.vt.edu>
Message-Id: <20040603011919.E32353A404E@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Not so true anymore, look at the selinux-pax patch and policy files.  You
can now control pax via selinux policy.

Ed

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of Valdis.Kletnieks@vt.edu
Sent: Wednesday, June 02, 2004 2:56 PM
To: Park Lee
Cc: SELinux@tycho.nsa.gov
Subject: Re: issue on binary & source compatibility 

On Tue, 01 Jun 2004 06:34:57 PDT, Park Lee <parklee_sel@yahoo.com>  said:

extensions to GCC which require a recompile, or the PaX stuff that doesn't
add any protection to binaries that weren't linked with a modified binutils
to add the PaX-defined elf header....


---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.692 / Virus Database: 453 - Release Date: 5/28/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
