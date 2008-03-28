From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: policy package names for Debian
Date: Fri, 28 Mar 2008 23:41:01 +1100
Cc: Manoj Srivastava <srivasta@debian.org>,
        "SE-Linux," <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
References: <200803281340.01991.russell@coker.com.au> <1206707218.3302.393.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1206707218.3302.393.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803282341.05475.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 28 March 2008 23:26, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> If you are seeking consistency with Fedora, then note that it calls the
> packages selinux-policy-targeted and selinux-policy-mls. The
> selinux-policy-strict package is gone as of Fedora 8 and later,
> obsoleted by the merge of strict and targeted policies (now one just
> maps users to confined roles via semanage login and if one truly doesn't
> want to leave anything unconfined at all, one can semodule -r
> unconfined).
>
> If on the other hand you want to track the names used by upstream
> refpolicy these days, then those would be standard, mcs, and mls.  The

Tracking upstream seems more sensible.  So that would be selinux-pol-mcs and 
selinux-pol-mls (I don't think it makes sense to support "standard" in 
Debian).  Or maybe just "selinux-pol" and "selinux-pol-mls" (to make it more 
obvious that the "mls" one is the odd one out.

> BTW, recently noticed that semanage user -a is broken under standard
> (non-mcs/mls) policy as there is a hardcoded :s0 in seobject.py on a
> prefix context check - so that needs to be resolved.  Or we just need to
> give up on non-mcs/mls policies altogether (that would simplify life for
> applications and users - a single format for all contexts).

I think it's best to give up on policy which lacks the MLS field in the 
context for everything but embedded systems.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
