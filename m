Subject: Re: [RFC][PATCH] collect security labels on user
	processes	generating audit messages
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
   James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <1140021440.14253.411.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <1140018578.11792.23.camel@localhost> <43F35354.2090108@hp.com>
	 <200602151122.37945.sgrubb@redhat.com>
	 <1140021440.14253.411.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 12:33:06 -0600
Message-Id: <1140028386.12579.23.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-15 at 11:37 -0500, Stephen Smalley wrote:
> On Wed, 2006-02-15 at 11:22 -0500, Steve Grubb wrote:
> > This should be a separate thread since the topic is different.
> > 
> > On Wednesday 15 February 2006 11:14, Linda Knippers wrote:
> > > Amy submitted a patch a while back to eliminate the "name=" field
> > > to avoid "name=(null)" from the audit records if there was no name
> > > but I don't think the patch went anywhere.
> > 
> > Right. I want all audit fields to have name=value. If we have %s in the 
> > message and pass NULL to it, snprintf is already going to put "(null)" so 
> > what's wrong with just using this precedent?
> 
> In that case, Tim doesn't need a special check for !ctx in his code at
> all.

FYI, if I just pass NULL to audit_log_format(), then <NULL> is printed
to the log, not (null).  I just tried this.

-tim


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
