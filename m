Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3AJOvhf015713
	for <selinux@tycho.nsa.gov>; Wed, 10 Apr 2013 15:24:57 -0400
Received: from iad-wprd-xchw02.corp.verio.net (iad-wprd-xchw02.corp.verio.net [198.87.7.165])
	by relay1-bcrtfl2.verio.net (Postfix) with ESMTP id 1F9DBB0382C1
	for <selinux@tycho.nsa.gov>; Wed, 10 Apr 2013 15:24:56 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: appending to an existing policy
Date: Wed, 10 Apr 2013 15:24:48 -0400
Message-ID: <0971982CF6B9AB418FFD5FEF7F50CB9F05E098D7@IAD-WPRD-XCHB03.corp.verio.net>
In-Reply-To: <5165B3FE.3060001@redhat.com>
References: <0971982CF6B9AB418FFD5FEF7F50CB9F05D71CDA@IAD-WPRD-XCHB03.corp.verio.net> <5165B3FE.3060001@redhat.com>
From: "Rodney Simioni" <rodney.simioni@verio.net>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is this something fixable, thank you.

[root@narf audit]# make -f /usr/share/selinux/devel/Makefile
Compiling targeted lsh64 module
/usr/bin/checkmodule:  loading policy configuration from tmp/lsh64.tmp
lsh64.te":187:ERROR 'unknown type semanage_t' at token ';' on line 1213:
allow semanage_t setfiles_t:process { siginh noatsecure rlimitinh };
#============= semanage_t ==============
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make: *** [tmp/lsh64.mod] Error 1

-----Original Message-----
From: Daniel J Walsh [mailto:dwalsh@redhat.com] 
Sent: Wednesday, April 10, 2013 2:49 PM
To: Rodney Simioni
Cc: selinux@tycho.nsa.gov
Subject: Re: appending to an existing policy

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/10/2013 02:24 PM, Rodney Simioni wrote:
> I just created a custom policy and did the semodule -i test.te.
> 
> 
> 
> I reran all my tests after a few days and I noticed there were 
> additional AVC denials in the audit.log.
> 
> 
> 
> I want to add the new stuff to my existing test.te file so that I 
> won't have multiple policies. I just want to have one policy and just 
> keep adding to it, is that possible and how? Thanks in advance.
> 
> 
> This email message is intended for the use of the person to whom it 
> has been sent, and may contain information that is confidential or 
> legally protected. If you are not the intended recipient or have 
> received this message in error, you are not authorized to copy, 
> distribute, or otherwise use this message or its attachments. Please 
> notify the sender immediately by return e-mail and permanently delete
this message and any attachments.
> Verio Inc. makes no warranty that this email is error or virus free. 
> Thank you.
> 
Yes just recreate the te file with the additions or do a

audit2allow -la >> test.te
vi test.te # To make sure the rules added are what you want.
make -f /usr/share/selinux/devel/Makefile semodule -i test.pp

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFls/0ACgkQrlYvE4MpobNktgCeMSmaNBPgPObxA+a3VoIkUsQM
eCMAnikWXxVHVvR5wR6Gs5ssYiV2PX7q
=UHgP
-----END PGP SIGNATURE-----


This email message is intended for the use of the person to whom it has been sent, and may contain information that is confidential or legally protected. If you are not the intended recipient or have received this message in error, you are not authorized to copy, distribute, or otherwise use this message or its attachments. Please notify the sender immediately by return e-mail and permanently delete this message and any attachments. Verio Inc. makes no warranty that this email is error or virus free.  Thank you.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
