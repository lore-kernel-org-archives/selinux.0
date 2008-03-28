Subject: Re: file(1)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <200803272349.32854.russell@coker.com.au>
References: <200803272349.32854.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 28 Mar 2008 09:33:34 -0400
Message-Id: <1206711214.3302.442.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-03-27 at 23:49 +1100, Russell Coker wrote:
> # SE Linux policy modules *.pp
> 0       lelong  0xf97cff8f      SE Linux modular policy
> >4      lelong  x       version %d,
> >8      lelong  x       %d sections,
> >>(12.l) lelong 0xf97cff8d
> >>>(12.l+27) lelong x           mod version %d,
> >>>(12.l+31) lelong 0           Not MLS,
> >>>(12.l+31) lelong 1           MLS,
> >>>(12.l+23) lelong 2
> >>>>(12.l+47) string >\0        module name %s
> >>>(12.l+23) lelong 1          base
> 
> The above /etc/magic entry allows file(1) to display some information about 
> policy modules.  Below is a sample of the result:
> 
> # file qmail.pp  base.pp  /tmp/loadkeys.pp
> qmail.pp:         SE Linux modular policy version 1, 2 sections, mod version 
> 7, Not MLS, module name qmail\005
> base.pp:          SE Linux modular policy version 1, 4 sections, mod version 
> 7, Not MLS, base
> /tmp/loadkeys.pp: SE Linux modular policy version 1, 2 sections, mod version 
> 6, MLS, module name loadkeys\005
> 
> Please let me know what you think of this, in terms of text formatting, 
> information displayed, and use of file(1) features.

"policy version 1" ought to be "policy type 1", or more simply, "base
module" (1) or "non-base module" (2).

Just for comparison with the existing support in file for kernel
policies, "file policy.21" displays:
policy.21: SE Linux policy v21 8 symbols 7 ocons

Not sure though that the symbols and ocons info is helpful there to
users, and it should always be implicit from the version.

Note btw that this format is expected to be obsoleted by the policyrep
work.

> The \005 after the module name is due to the fact that file(1) seems to 
> support only two types of string, a "C string" (terminated by \0) and 
> a "Pascal string" where a single byte is used to indicate the length.  Using 
> a 32bit little-endian word to indicate the length doesn't seem to work with 
> file(1) - but if anyone can figure out a way then please let me know.
> 
> It seems to me that it would be a good idea to write /etc/magic entries at the 
> same time as devising file formats.  Being able to quickly and easily 
> determine the contents of a file is a really handy feature.  Working with the 
> limitations of file(1) to support this to the greatest degree possible would 
> be a good thing.  If the module name was limited to 255 characters I doubt 
> that it would ever inconvenience anyone (in the past I've used compilers that 
> support symbol lengths of ~30 characters), but having a better display in 
> file(1) output would often help people.  Another option would be to have a 
> word indicating the string length while also having a 0 terminator (wasting 
> the occasional byte isn't really a problem).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
