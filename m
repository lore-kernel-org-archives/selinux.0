Message-Id: <200508081641.j78GfSss016318@gotham.columbia.tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>
Cc: <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
Subject: RE: Attributes in new binary format
Date: Mon, 8 Aug 2005 12:41:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1123518614.13654.244.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
> I don't see why any of this would mean that we should put this
> information into the kernel's binary format, particularly given that
> the kernel is just going to discard it at read time (and it would
> need the isattr flag to be written into the kernel binary format to
> know what to discard at that point, I assume).  Including attributes
> in analysis can be done by performing the analysis on policy source
> or the policy module format.  

It all comes down to trade-offs. In our experience there are times you need
to or are forced to use the binary format for analysis. We can with some
effort do the expansion in lipabol and put the binary format into the
current format without attributes. However, we always wished the binary
format had attributes. Now it does (almost). 

If it required extensive kernel resources to maintain the symbols in the
binary file format, we wouldn't suggest it. But it seems like the effort is
fairly small (skip over entries on read) and the gain, IMO, is great. Hence
the suggestion. Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
