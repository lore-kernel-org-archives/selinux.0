Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5EDsLCg003664
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 09:54:21 -0400
Received: from web36612.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5EDsJKe010228
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 13:54:19 GMT
Date: Thu, 14 Jun 2007 06:54:04 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
To: russell@coker.com.au, Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200706141944.35457.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <558323.22266.qm@web36612.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Russell Coker <russell@coker.com.au> wrote:

> On Wednesday 13 June 2007 22:31, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Wed, 2007-06-13 at 21:16 +1000, Russell Coker wrote:
> > > On Wednesday 13 June 2007 01:57, Stephen Smalley <sds@tycho.nsa.gov> 
> wrote:
> > > > Well, first, no script should be allowed a capability that is not given
> > > > to its caller directly ;)
> > >
> > > Why not?  Isn't that the entire point of this authoritative granting of
> > > capabilities patch?
> >
> > _script_, not program.
> 
> OK, that's a bit of a topic change.
> 
> I've been thinking about the script issue.  It seems to me that a problem we 
> face is the replacement of executables by scripts (which often happens in 
> distributions and sometimes happens with programs that are relevant to system
> 
> integrity).

That should only be a problem on a name based system, right?

OK, sorry for the dig. Anyhow, it seems that the program that
sets the policy (labels the file system?) ought to be checking
the "type" of the file if it matters. You also might consider
that as 21st century programming (special purpose scripting)
replaces 20th century programming (general purpose binaries)
fewer people are going to be tolerent of a distintion between
a "program" and a "script" and look seriously at how you might
avoid having to treat them differently.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
