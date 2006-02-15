Subject: Re: [RFC][PATCH] collect security labels on user
	processes	generating audit messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-audit@redhat.com, James Morris <jmorris@namei.org>,
   selinux@tycho.nsa.gov
In-Reply-To: <200602151122.37945.sgrubb@redhat.com>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <1140018578.11792.23.camel@localhost> <43F35354.2090108@hp.com>
	 <200602151122.37945.sgrubb@redhat.com>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 11:37:20 -0500
Message-Id: <1140021440.14253.411.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-15 at 11:22 -0500, Steve Grubb wrote:
> This should be a separate thread since the topic is different.
> 
> On Wednesday 15 February 2006 11:14, Linda Knippers wrote:
> > Amy submitted a patch a while back to eliminate the "name=" field
> > to avoid "name=(null)" from the audit records if there was no name
> > but I don't think the patch went anywhere.
> 
> Right. I want all audit fields to have name=value. If we have %s in the 
> message and pass NULL to it, snprintf is already going to put "(null)" so 
> what's wrong with just using this precedent?

In that case, Tim doesn't need a special check for !ctx in his code at
all.  But see below.

> It creates parsing problems without a value. If I saw "tty="  and that's all, 
> I'd think the audit system malfunctioned and file a bugzilla. I don't want 
> that.

OTOH, if I see (null), I tend to assume a bug in the code.  Isn't it
saner to just omit the name=value pair altogether if the value is NULL?
Otherwise, you are adding extra processing on the generation and parsing
side for no benefit, along with wasting space in the audit message.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
