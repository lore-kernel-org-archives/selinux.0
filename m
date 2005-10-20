Subject: Re: [ SEMANAGE ] Fix and make consistent interface naming
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4356ABA8.2080207@cornell.edu>
References: <4356ABA8.2080207@cornell.edu>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 11:04:21 -0400
Message-Id: <1129820661.2375.393.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-19 at 16:25 -0400, Ivan Gyurdiev wrote:
> This is the next rename patch...
> I'm sorry, but things will have to be renamed until they're correct, and 
> easy to understand.
> As plans change, names become obsolete.
> 
> Patch does the following:
> - adds (_local) suffix to all functions, and structures that work with 
> local users, and puts the code in (_local) files
> - changes incorrect (_base) suffix in some cases, which I hadn't noticed 
> to (_policy), which is correct
> - exposes query APIs for policy objects to libsemanage clients (but not 
> modify APIs). Basically I wrote a public header. Note that this header 
> is still not included in semanage.h, and the functions are not in the 
> map file - I'll change that when I've tested things, and they work.
> - removes (_policy) suffix from those APIs - the suffix is kept 
> everywhere internally, to make the code clearer, but is removed for the 
> function names in the interface, to indicate to the user that the 
> objects that he/she is working with _include_ the local ones.
> - adds stub implementation and interfaces for in-policy interfaces and 
> booleans
> - adds stddef.h in a few places where it was missing.
> ============
> This is much better...
> 
> I don't like how in some places I use short-hand notation ("bool", 
> "iface"), and in others I use the full word ("interface", "boolean"). 
> The interfaces are fully consistent, but for example, I can't just feed 
> the user relay code through sed to generate the port/iface relay code - 
> needs manual editing. Anyway, that's not important right now - I don't 
> want to rename more files for no good reason.

Ok, merged.  libsemanage 1.3.28.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
