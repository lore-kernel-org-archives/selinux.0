Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4NKDcRb006662
	for <selinux@tycho.nsa.gov>; Sun, 23 May 2004 16:13:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4NKDZAR010661
	for <selinux@tycho.nsa.gov>; Sun, 23 May 2004 20:13:35 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4NKDNHn010645 for <selinux@tycho.nsa.gov>; Sun, 23 May 2004 20:13:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH][RFC] Allow administrator control over per-user default_contexts
Date: Mon, 24 May 2004 06:12:15 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov,
   Daniel J Walsh <dwalsh@redhat.com>, selinux-dev@tresys.com
References: <1085155374.2789.131.camel@moss-spartans.epoch.ncsc.mil> <200405212213.i4LMDLZM005446@turing-police.cc.vt.edu>
In-Reply-To: <200405212213.i4LMDLZM005446@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405240612.15645.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 22 May 2004 08:13, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 21 May 2004 12:02:55 EDT, Stephen Smalley said:
> > - Does this change seem reasonable?
>
> Yes.

I agree.

However I am not certain that the existence of the directory should preclude 
any use of ~/.default_contexts.  Maybe only the existence of 
a /etc/security/selinux/default_contexts.user/username should be used to 
indicate that ~/.default_contexts should be ignored.

> > - Should the policy include support for the $HOME/.default_contexts
> > files for ordinary users?
>
> I'm ambivalent on this one.  I *will* firmly commit to the idea that *if*
> we have a $HOME/.default_contexts file at all, that we need
> $1_default_context_t and all the other policy rules/domains to do it
> *right*.

I agree.  Also we would have to write a utility to generate/modify the 
~/.default_contexts file.  Having users correctly label files under their 
home directory is painful.  It would be easy to write a script to make the 
current context the default and then set the type of the file correctly.

> A related question - has anybody done scaling tests for this sort of thing
> for large numbers of different values of $1?  I'm thinking about situations
> like webhosting, where dozens/hundreds of logins might need this - it's
> unclear (at least to me) at what point it becomes a Bad Idea to create
> per-user policies and just dump all of them in "customer_t".

The most I've used is ~36 user roles.  That didn't cause a problem so dozens 
seems OK to me.

> > - Should Fedora transition to using
> > /etc/security/default_contexts.user/root instead of
> > /root/.default_contexts, thus prohibiting use of $HOME/.default_contexts
> > by default?  Administrators who want to allow $HOME/.default_contexts
> > would then need to copy the root entry to /root/.default_contexts and
> > remove the directory to enable such support.
>
> That seems eminently sane as far as changing the default on new
> installs.

Makes sense to me.

> It would be easy enough to add an RPM 'postinstall' scriptlet to
> auto-populate /etc/security/default_contexts.user based on all $HOME
> values:

[...]

> but somehow that seems to violate the Principle of Least Surprise - it's
> the sort of thing like 'pwconv' was - a good thing for the sysadmin to do,
> but the sort of thing that I'd hate done to my system just because I ran an
> 'rpm -Fvh'..

I agree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
