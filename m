Message-Id: <200208120811.IAA28558@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>, Brian May <bam@snoopy.apana.org.au>
Subject: Re: security context for temporalily mounted filesystems
Date: Mon, 12 Aug 2002 10:12:27 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200208091352.NAA00864@jazzband.ncsc.mil> <20020811215228.CE1DDFA95@ivanova.coker.com.au> <20020811220151.0F45A8682@lyta.coker.com.au>
In-Reply-To: <20020811220151.0F45A8682@lyta.coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Montag, 12. August 2002 00:01 schrieb Russell Coker:
> On Sun, 11 Aug 2002 23:51, Carsten Grohmann wrote:
> > Who is an new type: usermountpoint_t and a new domain usermount_t like
> > mount_t to allow the users in user_r to allow mount removeable disk
> > devices?
>
> I'm not sure I understand this.
>
> However are you using Brian May's policy for multiple mount domains or my
> policy that is a derivative of his policy?  I think that some variation

I don't 

> of the policy that Brian and I are working on for mount has a chance of
> getting into the CVS and it might be best for you to use it.
>
> > I will post the changed rules tomorrow. Now I only test it and it works
> > fine I guess.
> >
> > Carsten

Hi Russel, Hi Brain and all Others

I am sorry, that I don't write clearly, what I want.

This time I look the mount_t domain (from Brain) in your policy. I missing 
that the user_r is not able to mount some not all devices.
I suggest:
 1. To define a new type usermountpoint_t. With this type we 
     could labelling the mountpoints for /floppy /cdrom and 
     similar.
 2.  To define a new domain usermount_t based on the 
      mount_t domain, but only with rigths to mount the new
      type and removeable_device_t.
  3  Get user_r access to the new domain.
After this normal users could mount floppy disks and cdroms.

The file_type_auto_trans macro is called twice one time in mount.te and the 
other time in mount_domain. You could remove it from mount.te I think.

Carsten


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
