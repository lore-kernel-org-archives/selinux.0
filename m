Subject: Re: Attributes in new binary format
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: <42F7805B.3040607@tresys.com>
References: <42F7805B.3040607@tresys.com>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 12:30:14 -0400
Message-Id: <1123518614.13654.244.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-08 at 11:55 -0400, Joshua Brindle wrote:
> In the new binary format the attribute values are preserved in the avtab 
> but the attribute entries in the type symbol table are destroyed.
> 
> This makes analysis on the binary format difficult for a number of reasons.
> 
> Tools like apol will have to expand the type bitmaps and will lose 
> attibutes on types. This is the same as analysing the current (v19) 
> binary format but including attributes will be beneficial to analysis.
> 
> Further, the hierarchal constraint checking is currently broken with the 
> new format. The reason is that we must be able to expand attributes at 
> check time to ensure that types weren't given permissions via attributes 
> that violate the constraints. This can be done with the new format but 
> it's very time consuming.
> 
> I'd like to suggest that we preserve the attibute entries in the type 
> table in the binary format and modify the kernel read function to not 
> allocate space for them as it reads them in. This makes the binary 
> format much more usable in terms of analysis at no cost to the kernel 
> memory.
> 
> Let me know what you think.

I don't see why any of this would mean that we should put this
information into the kernel's binary format, particularly given that the
kernel is just going to discard it at read time (and it would need the
isattr flag to be written into the kernel binary format to know what to
discard at that point, I assume).  Including attributes in analysis can
be done by performing the analysis on policy source or the policy module
format.  As far as the hierarchical constraint checking code is
concerned, can't it just use expand_avtab like the assertion checking
code now does?  Running time on checkpolicy actually shows a nontrivial
speed up from the original upstream checkpolicy to the latest patched
one with the inline ebitmap operators.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
