Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7FGUi2r021461
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 12:30:44 -0400
Received: from web36611.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7FGUheN016384
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 16:30:43 GMT
Date: Wed, 15 Aug 2007 09:30:42 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 00/16] Permit filesystem local caching [try #3]
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
        steved@redhat.com, trond.myklebust@fys.uio.no,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>
In-Reply-To: <1187113368.26008.226.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <18318.47287.qm@web36611.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2007-08-14 at 08:53 -0700, Casey Schaufler wrote:
> > --- David Howells <dhowells@redhat.com> wrote:
> > 
> > > Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > 
> > > > With Smack you can leave the label alone, raise CAP_MAC_OVERRIDE,
> > > > do your business of setting the label correctly, and then drop
> > > > the capability. No new hooks required.
> > > 
> > > That sounds like a contradiction.  How can you both leave it alone and
> set
> > > it?
> > 
> > Whoops, sorry. You leave the process label alone and explicitly
> > set the file label using the xattr interfaces.
> 
> xattr interfaces don't help with the initial labeling of the file when
> it is created.

That's true. The deamon needs to run with an appropriate label.
I don't believe that this is situation with a really simple solution
because the activity being performed is unusual. 
 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
> 


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
