Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71MEkES003118
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 18:14:46 -0400
Received: from web36601.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l71MEjxj007393
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 22:14:45 GMT
Date: Wed, 1 Aug 2007 15:14:45 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 4/7] Security: Add secctx_to_secid LSM hooks and security helper functions
To: Paul Moore <paul.moore@hp.com>, casey@schaufler-ca.com
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
In-Reply-To: <200708011741.19107.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <101642.143.qm@web36601.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Paul Moore <paul.moore@hp.com> wrote:

> On Wednesday, August 1 2007 5:11:27 pm Casey Schaufler wrote:
> > --- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:
> > > From: David P. Quigley <dpquigl@tycho.nsa.gov>
> > >
> > > The existing LSM interface provides a hook for converting a security
> > > identifier
> > > to a security context. This patch introduces a complementary hook to
> > > provide the conversion from the security context to corresponding
> > > security identifier.
> >
> > This is strictly SELinux behavior. I don't suppose it hurts
> > anything, but a general framework won't need this.
> 
> I'm not so sure about that ... having a mechanism which maps an arbitrarily 
> large label into a easily manipulated token (and back again) seems like 
> something that could be of use to other security mechanisms besides 
> SELinux/TE.

Yes, if you wanted to port the SecureWare CMW to Linux it would be
quite valuable. If on the other hand you have a small, directly
used label a mapping mechanism is unnecessary and being required
to do mappings is a pain in the bum. But, that's just me.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
