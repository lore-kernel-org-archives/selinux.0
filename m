Message-ID: <72222DC86846D411ABD300A0C9EB08A101524433@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>
Cc: SELinux@tycho.nsa.gov
Subject: RE: initrd kernel panic
Date: Wed, 16 Oct 2002 09:33:49 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

That should have been cvs check out on friday.

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tislabs.com]
> Sent: Wednesday, October 16, 2002 9:27 AM
> To: Westerman, Mark
> Cc: SELinux@tycho.nsa.gov
> Subject: Re: initrd kernel panic
> 
> 
> 
> On Wed, 16 Oct 2002, Westerman, Mark wrote:
> 
> > When trying to use the initrd
> > policy with an selinux kernel I am
> > getting the following panic
> >
> > ss: loading policy configuration from <NULL>
> 
> This was discussed earlier on the list (see
> http://marc.theaimsgroup.com/?l=selinux&m=103289179925418&w=2), and
> patches were posted and committed to the sourceforge CVS 
> tree.  It is no
> longer necessary to place a policy on an initrd at all.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
