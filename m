Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5CHnsE3006222
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 13:49:54 -0400
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5CHnq19014638
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 17:49:53 GMT
Date: Tue, 12 Jun 2007 13:49:49 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
In-Reply-To: <616061.57558.qm@web36609.mail.mud.yahoo.com>
Message-ID: <Line.LNX.4.64.0706121342320.4489@localhost.localdomain>
References: <616061.57558.qm@web36609.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 12 Jun 2007, Casey Schaufler wrote:

> 
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > On Tue, 2007-06-12 at 08:08 -0700, Casey Schaufler wrote:
> > ...
> > > 
> > > The file capabilty mechanism has been through two CC evaluations
> > > for which I have the certificates, so I think that you may have
> > > trouble substantiating your claim that it lacks an analyzable policy.
> > 
> > I'll clarify:  The file capability mechanism encodes policy in the
> > filesystem state on a per-file basis,
> 
> Uh, yeah. They are stored in extended attributes. This provides
> superior locality of reference. Extended attributes are a good
> thing for security mechanisms, just have a read through the threads
> about AA on the LSM list.

The important thing to differentiate here is that filesystem capabilities 
stores _policy_ in the filesystem, as opposed to security attributes of 
filesystem objects.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
