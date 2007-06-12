Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5CJuLCA015020
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 15:56:21 -0400
Received: from web36603.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5CJuJ8g018541
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 19:56:20 GMT
Date: Tue, 12 Jun 2007 12:56:04 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
To: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <Line.LNX.4.64.0706121342320.4489@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <741703.17747.qm@web36603.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- James Morris <jmorris@namei.org> wrote:

> On Tue, 12 Jun 2007, Casey Schaufler wrote:
> 
> > 
> > --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > 
> > > On Tue, 2007-06-12 at 08:08 -0700, Casey Schaufler wrote:
> > > ...
> > > > 
> > > > The file capabilty mechanism has been through two CC evaluations
> > > > for which I have the certificates, so I think that you may have
> > > > trouble substantiating your claim that it lacks an analyzable policy.
> > > 
> > > I'll clarify:  The file capability mechanism encodes policy in the
> > > filesystem state on a per-file basis,
> > 
> > Uh, yeah. They are stored in extended attributes. This provides
> > superior locality of reference. Extended attributes are a good
> > thing for security mechanisms, just have a read through the threads
> > about AA on the LSM list.
> 
> The important thing to differentiate here is that filesystem capabilities 
> stores _policy_ in the filesystem, as opposed to security attributes of 
> filesystem objects.

What, it's bad to tightly associate the policy with the executable?
That's crazy talk. The capability vector of a program belongs attached
to the program. How many other components of the security policy (e.g.
DAC bits, MLS labels, owner, owning group, setuid bit) are attached to
the program? And don't go saying that the setuid bits has nothing to
do with policy, I'll hit you over the head with an evaluation report.

Please remember (or learn) that the SELinux way of doing things is
the exception rather than the rule for associating "policy" with
program behavior. Systems have been associating "policy" directly
with executables for decades. The notion of an external policy
definition still gives some of us old farts the heebeejeebees.

 

Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
