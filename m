Message-Id: <200208110935.JAA23009@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: security context for temporalily mounted filesystems
Date: Sun, 11 Aug 2002 11:36:11 +0200
References: <200208091352.NAA00864@jazzband.ncsc.mil> <20020810235352.GC13384@snoopy.apana.org.au>
In-Reply-To: <20020810235352.GC13384@snoopy.apana.org.au>
Cc: SELinux <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Sonntag, 11. August 2002 01:53 schrieb Brian May:
> On Fri, Aug 09, 2002 at 03:51:34PM +0200, Carsten Grohmann wrote:
> > last days I labelling the mount point (/floppy, /cdrom, ..) and the
> > correspond links as root_t.
> > I think, it is good to add this to the standard distribution.
>
> What is the justification in doing this?
>
> That is, what benefit do you get?

I discussed with Russel, about my SuSE rules. He wrote in this discussion 
the file_t is only unkown entries. Draw the consequence we should not label 
this entries not as file_t.

> Also, when you say /floppy, I assume you mean the directory on / called
> "floppy", and not the root directory on the mounted floppy disk drive?

I mean both mount point and the link to it. On SuSE /floppy is an link to 
/mnt/floppy or /media/floppy. So I labeled both the link and the link 
target ( the mount point ) as root_t. During a mount genfs relabelling the 
mountpoint to the right type. So I think there will be no problem with the 
root_t.

Carsten




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
