Message-ID: <36282A1733C57546BE392885C0618592E1C330@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Daniel J Walsh <dwalsh@redhat.com>, Jonathan Kim <jkim@TrustedCS.com>
Cc: SELinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>
Subject: RE: [PATCH] MLS Policy
Date: Wed, 9 Nov 2005 12:56:40 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I concur....

> -----Original Message-----
> From: Daniel J Walsh [mailto:dwalsh@redhat.com]
> Sent: Wednesday, November 09, 2005 10:20 AM
> To: Jonathan Kim
> Cc: SELinux@tycho.nsa.gov; Chad Hanson
> Subject: Re: [PATCH] MLS Policy
> 
> 
> Jonathan Kim wrote:
> > The attached patch corrects an apparent typo in the 
> base_can_network 
> > macro.
> > With the patch applied, it will be possible to do "ssh or ping 
> > localhost", for example.
> No this is not a bug in the patch.  the idea was to only force all 
> policies to specify a non standard device type.
> So that you can start to specify, apache can listen on eth0 
> but not eth1.
> 
> Adding the following is probably what MLS needs
> +allow $1 netif_lo_t:netif { $2_recv $2_send rawip_send rawip_recv };
> 
> >  
> > Also, the NSA policy already contains the correct comments 
> for all of 
> > the MLS attributes in the file attrib.te, but the 
> > 'policy-20051021.patch' is patching over these comments with older 
> > comments.
> > The fix is to not patch that portion of the attrib.te file
> >  
> > Thank you
> >
> > -----------------------------------
> > *Jonghoon Jonathan*
> > Secure Systems Engineer
> >
> > *Trusted Computer Solutions*
> > 121 W Goose Alley
> > Urbana, IL  61801
> >
> > http://www.TrustedCS.com <http://www.trustedcs.com/>
> >
> > *V:*  217.384.0028  ext.16
> > *F: * 217.384.0288
> >
> >  
> 
> 
> -- 
> 
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
