Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h99JdpWt028586
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 15:39:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h99JdjUb004510
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 19:39:45 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h99JdjhX004507 for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 19:39:45 GMT
Subject: Re: login messages
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: "James R. Kratzer" <JamesK@xetron.com>, selinux@tycho.nsa.gov
In-Reply-To: <200310080143.48828.russell@coker.com.au>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A45@s3cin>
	 <200310071533.00017.russell@coker.com.au>
	 <1065534718.3919.211.camel@moss-spartans.epoch.ncsc.mil>
	 <200310080143.48828.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1065728379.8181.386.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 09 Oct 2003 15:39:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-07 at 11:43, Russell Coker wrote:
> Currently the consensus of opinion within Red Hat is to have the system 
> installed mappings be audited to avoid any problems regarding the loading of 
> bad mappings.  Then we just allow loading any system mappings by the user at 
> any time.  Having a mapping be bad enough to cause problems seems to require 
> a fairly gross error in the mapping.  Allowing the user to choose between 
> different system mappings seems to be a big enough benefit to outweigh the 
> tiny risk of immense gross errors in mappings.
> 
> Also I think I'll just make it loadkeys_t instead of having a number of 
> user_loadkeys_t domains.

So, what's the resolution on the capable() check being performed by the
SELinux module?  Should it be reduced from a full capable() check (i.e.
Linux capability and SELinux permission check) to just a SELinux
capability permission check, to avoid changing the Linux permissions
model and the need for a setuid program?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
