Message-Id: <200208112150.VAA11102@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>, Brian May <bam@snoopy.apana.org.au>
Subject: Re: security context for temporalily mounted filesystems
Date: Sun, 11 Aug 2002 23:51:42 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200208091352.NAA00864@jazzband.ncsc.mil> <200208110935.JAA23009@jazzband.ncsc.mil> <20020811145503.0E4C68654@lyta.coker.com.au>
In-Reply-To: <20020811145503.0E4C68654@lyta.coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Sonntag, 11. August 2002 16:55 schrieb Russell Coker:
> On Sun, 11 Aug 2002 11:36, Carsten Grohmann wrote:
> > Am Sonntag, 11. August 2002 01:53 schrieb Brian May:
> > > On Fri, Aug 09, 2002 at 03:51:34PM +0200, Carsten Grohmann wrote:
> > > > last days I labelling the mount point (/floppy, /cdrom, ..) and the
> > > > correspond links as root_t.
> > > > I think, it is good to add this to the standard distribution.
> > >
> > > What is the justification in doing this?
> > >
> > > That is, what benefit do you get?
> >
> > I discussed with Russel, about my SuSE rules. He wrote in this
> > discussion the file_t is only unkown entries. Draw the consequence we
> > should not label this entries not as file_t.
>
> True.
>
> > > Also, when you say /floppy, I assume you mean the directory on /
> > > called "floppy", and not the root directory on the mounted floppy
> > > disk drive?
> >
> > I mean both mount point and the link to it. On SuSE /floppy is an link
> > to /mnt/floppy or /media/floppy. So I labeled both the link and the
> > link target ( the mount point ) as root_t. During a mount genfs
> > relabelling the mountpoint to the right type. So I think there will be
> > no problem with the root_t.
>
> I am not recommending root_t for everything, and I am not certain that
> it's the best thing to do.  However as I haven't had a better idea and
> it's a lot better than file_t I can't suggest anything else.

Who is an new type: usermountpoint_t and a new domain usermount_t like 
mount_t to allow the users in user_r to allow mount removeable disk devices?

I will post the changed rules tomorrow. Now I only test it and it works 
fine I guess.

Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
