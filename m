Subject: Re: [Labeled-nfs] [PATCH 6/7] NFSv4: Client implementation of MAC
	Labeling
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
In-Reply-To: <15920.22389.qm@web36614.mail.mud.yahoo.com>
References: <15920.22389.qm@web36614.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 01 Aug 2007 17:34:20 -0400
Message-Id: <1186004060.15215.406.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 14:29 -0700, Casey Schaufler wrote:
> --- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:
> 
> > From: David P. Quigley <dpquigl@tycho.nsa.gov>
> > 
> > There are several places where recommended attributes are implemented in the
> > NFSv4 client code. This patch adds two functions to encode and decode the
> > secid
> > recommended attribute which makes use of the LSM hooks added earlier. It also
> > adds code to grab the label from the file attribute structures and encode the
> > label to be sent back to the server. Even though the code is there to encode
> > a
> > label to be sent back to the server there does not appear to be an interface
> > to
> > use it yet.
> 
> My usual comments regarding configuration names being SELINUX instead
> of MAC if you stick with u32 labels.
> 
> Now I'm confused. Are you sending the context string on the wire,
> or a sid? 

The context string.  But it is then mapped to a local SID when it is
received.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
