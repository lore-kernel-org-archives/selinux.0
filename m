Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: privfd attribute
Date: Thu, 19 Sep 2002 12:40:10 +0200
References: <200209171901.TAA20518@jazzband.ncsc.mil> <200209181950.01338.russell@coker.com.au> <20020919102602.EB660FA8D@ivanova.coker.com.au>
In-Reply-To: <20020919102602.EB660FA8D@ivanova.coker.com.au>
MIME-Version: 1.0
Message-Id: <200209191240.10726.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 19 Sep 2002 12:24, Carsten Grohmann wrote:
> Am Mittwoch, 18. September 2002 19:50 schrieb Russell Coker:
> > privlog is an attribute specifying that a process gets certain access (IE
> > to /dev/log - but later it might be to some other form of logging).
> >
> > privfd is an attribute used to grant access to a process.  Any domain
> > that opens a file handle that lots of other domains need to access
> > (example crond_t, login_t, sshd_t, newrole_t) gets it.
> >
> > privlog and privfd are totally different types of attribute used for
> > totally different things (at a conceptual level at least).
>
> I am not sure, if I understand the usage of the attributes right.
> After I declared an attribute, I can use it in a type declaration.
> And then I can use it in two ways:
> 1. I can write a allow rule like this
>     allow myattribute exampledomain_conf_t:file r_file_perms;
>    and all other domains which have this attribute in the domain
>    declaration have grant access to this file without an specific
>    rule.
>    An Example of this this the privlog attribute.

That is correct.

> 2. I could it uses as an set of type and through this I can write simple
>    rules
>     allow mydomain_t myattribute:fd use;
>    instead of
>      allow mydomain_t { login_t sshd_t, newrole_t }:fd use;
>    and it will by easier to add or remove new types.
>    The privfd attribute is an Example of this.

These two examples are not fundamentally different.  In both cases you are 
using the attribute as a set of domains.  Whenever you see an attribute you 
can just replace it with { list of all types that have the attribute } and 
get exactly the same result.


-- 
There is no point PGP/GPG signing an email unless the signature can be
verified.  If you post to a list then don't sign the message unless your
key is available on public key servers and has been signed by someone
who is in the web of trust, otherwise you just waste bandwidth and CPU.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
