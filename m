From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Joshua Brindle" <jbrindle@tresys.com>
Subject: Re: file(1)
Date: Sat, 29 Mar 2008 12:19:10 +1100
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, "SE-Linux" <selinux@tycho.nsa.gov>
References: <200803272349.32854.russell@coker.com.au> <1206711214.3302.442.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B0158801CD1E16@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158801CD1E16@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803291219.12623.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 29 March 2008 02:10, "Joshua Brindle" <jbrindle@tresys.com> wrote:
> >> # file qmail.pp  base.pp  /tmp/loadkeys.pp
> >> qmail.pp:         SE Linux modular policy version 1, 2 sections, mod
> >> version 7, Not MLS, module name qmail\005
>
> Also I think SELinux policy package, this magic number is for packages,
> modules have their own magic number.

# file /etc/selinux/refpolicy-mls/policy/policy.22
/etc/selinux/refpolicy-mls/policy/policy.22: SE Linux policy v22 MLS 8 symbols 
7 ocons

Yes, I've got that.

> >> base.pp:          SE Linux modular policy version 1, 4 sections, mod
> >> version 7, Not MLS, base /tmp/loadkeys.pp: SE Linux modular policy
> >> version 1, 2 sections, mod version 6, MLS, module name loadkeys\005
> >>
> >> Please let me know what you think of this, in terms of text
> >> formatting, information displayed, and use of file(1) features.
> >
> > "policy version 1" ought to be "policy type 1", or more
> > simply, "base module" (1) or "non-base module" (2).

But non-base modules have a 1 in that field too!

> > Just for comparison with the existing support in file for
> > kernel policies, "file policy.21" displays:
> > policy.21: SE Linux policy v21 8 symbols 7 ocons
> >
> > Not sure though that the symbols and ocons info is helpful
> > there to users, and it should always be implicit from the version.

Probably not.  But that was a mistake I made long ago.  Hopefully this 
discussion will help avoid such things this time.

> > Note btw that this format is expected to be obsoleted by the
> > policyrep work.

Which format?  The module format or the policy binary format?

In either case we still need file(1) support.  When someone gives me a disk 
containing a Debian/Etch or Fedora Core 5 filesystem in 2012 which has most 
files in /lost+found and asks me to recover data then the presence of magic 
entries will really help.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
