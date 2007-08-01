Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71M6kEx002700
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 18:06:46 -0400
Received: from web36608.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l71M6ixj006248
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 22:06:45 GMT
Date: Wed, 1 Aug 2007 15:06:43 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [Labeled-nfs] [PATCH 6/7] NFSv4: Client implementation of MAC Labeling
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
In-Reply-To: <1186004060.15215.406.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <222173.8862.qm@web36608.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2007-08-01 at 14:29 -0700, Casey Schaufler wrote:
> > --- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:
> > 
> > > From: David P. Quigley <dpquigl@tycho.nsa.gov>
> > > 
> > > There are several places where recommended attributes are implemented in
> the
> > > NFSv4 client code. This patch adds two functions to encode and decode the
> > > secid
> > > recommended attribute which makes use of the LSM hooks added earlier. It
> also
> > > adds code to grab the label from the file attribute structures and encode
> the
> > > label to be sent back to the server. Even though the code is there to
> encode
> > > a
> > > label to be sent back to the server there does not appear to be an
> interface
> > > to
> > > use it yet.
> > 
> > My usual comments regarding configuration names being SELINUX instead
> > of MAC if you stick with u32 labels.
> > 
> > Now I'm confused. Are you sending the context string on the wire,
> > or a sid? 
> 
> The context string.  But it is then mapped to a local SID when it is
> received.

For Smack I would want to pass the label (a short character string)
and then use the string unaltered. I don't need to map it to a SID.
If the interface translates the label to a SID I then have to
translate it right back to a label. I need to invoke the translation
infrastructure twice just to get back what I had originally.

My conculsion* is that the interface needs to be LSM clean, and
leave the representation and processing of the data up to the
LSM module and not make assumptions about how it should be represented.

----
* In support of my goal, of course.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
