Message-ID: <36282A1733C57546BE392885C06185924D91E3@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>,
   Chad Hanson
	 <chanson@TrustedCS.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   James Morris
	 <jmorris@redhat.com>
Subject: RE: [PATCH] checkpolicy - nodecon ordering
Date: Mon, 1 Nov 2004 16:58:06 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen Smalley wrote:
> 
> Good idea, but I don't think that the patch is correct.  Should be
> sorting based on the number of bits set in each mask, not 
> their integer
> value, as the simple value may not reflect the actual 
> specificity.  Code
> could also be simplified a bit, e.g. setting of newc->next 
> doesn't need
> to be conditional.

I could be missing something here, but I can't think of a valid case where
your statement above is true. A mask with more bits always has a greater
integer value than a mask with less bits.

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
