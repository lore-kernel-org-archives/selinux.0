Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97Fi4Wt012351
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 11:44:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h97Fi20p009182
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 15:44:02 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h97Fi0r7009173
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 15:44:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: login messages
Date: Wed, 8 Oct 2003 01:43:48 +1000
Cc: "James R. Kratzer" <JamesK@xetron.com>, selinux@tycho.nsa.gov
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A45@s3cin> <200310071533.00017.russell@coker.com.au> <1065534718.3919.211.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1065534718.3919.211.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310080143.48828.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 7 Oct 2003 23:51, Stephen Smalley wrote:
> I don't think that this helps, unless you are carefully limiting the
> types that can be read by user_loadkeys_t, since the user can still
> specify a font and umap as arguments to unicode_start and thus specify
> an arbitrary map.  Even if you use the policy to limit it to certain
> system types, it isn't clear that it is safe to allow the user to select
> any system-installed mapping.  The safest approach would be to have
> getty or login perform the loading, and to load authorized mappings that
> aren't subject to configuration by ordinary users.

Currently the consensus of opinion within Red Hat is to have the system 
installed mappings be audited to avoid any problems regarding the loading of 
bad mappings.  Then we just allow loading any system mappings by the user at 
any time.  Having a mapping be bad enough to cause problems seems to require 
a fairly gross error in the mapping.  Allowing the user to choose between 
different system mappings seems to be a big enough benefit to outweigh the 
tiny risk of immense gross errors in mappings.

Also I think I'll just make it loadkeys_t instead of having a number of 
user_loadkeys_t domains.


PS  Before someone asks, yes this is important.  Having console access does 
NOT mean that you can break the security of the machine in any trivial way.  
Think about "Internet terminal" devices that are physically secured as well 
as a Coke vending machine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
