Subject: Re: [PATCH] Add seuser and user_extra to package format
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Chad Hanson <chanson@TrustedCS.com>, Daniel J Walsh <dwalsh@redhat.com>,
   Joshua Brindle <jbrindle@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <43E80E52.6090503@cornell.edu>
References: <43E7D03D.4090909@tresys.com>  <43E80E52.6090503@cornell.edu>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 09:34:26 -0500
Message-Id: <1139322866.2872.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-02-06 at 22:04 -0500, Ivan Gyurdiev wrote:
> Please try with the following patch on top:
> 
> - removes system databases, which are unnecessary, write directly to the 
> final file
> - fix 64-bit bugs Joshua's introducing :)

Merged both patches.

> I will resync my nodecon patch tomorrow - let me know if anything's 
> wrong with it, otherwise will submit as is (ordering pending in a later 
> patch).

I still wasn't clear on the disposition of the pylist patch.

For the nodecon patch, I wasn't sure if we were sufficiently confident
in the ABI/API stability to include it for FC5 or if it should wait on
FC6 devel.  It would likely help to have feedback from potential users
of the nodecon API.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
