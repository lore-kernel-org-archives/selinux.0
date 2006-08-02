Message-ID: <36282A1733C57546BE392885C061859201466C0E@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: James Morris <jmorris@namei.org>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>
Subject: RE: [RFC 1/3] secid reconciliation on inbound
Date: Wed, 2 Aug 2006 08:57:55 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Tue, 1 Aug 2006, James Morris wrote:
> 
> > On Tue, 1 Aug 2006, Venkat Yekkirala wrote:
> > 
> > > +#define PACKET__COME_THRU                         0x00000008UL
> > > +#define PACKET__GO_THRU                           0x00000010UL
> > 
> > These names seem awkward, and do we really need a separate 
> perm for each 
> > direction?
> 
> Ok, I see we need separate permissions.  The naming, still...

You are probably seeing something I haven't :), because I did
consider using just one perm such as flow_thru for both directions
but then thought separate perms would make things easier to understand.

As for naming, how about "enter" and "leave"? Or "flow_in" and "flow_out".
Any other suggestions out there?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
