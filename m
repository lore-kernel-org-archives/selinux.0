Date: Mon, 8 Dec 2008 09:04:26 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/3] SELinux: Add new security mount option to indicate
 security label support.
In-Reply-To: <1228488915.15920.42.camel@moss-terrapins.epoch.ncsc.mil>
Message-ID: <alpine.LRH.1.10.0812080903520.22527@tundra.namei.org>
References: <1228421890-9467-1-git-send-email-dpquigl@tycho.nsa.gov>  <1228421890-9467-3-git-send-email-dpquigl@tycho.nsa.gov>  <alpine.LRH.1.10.0812051200380.11818@tundra.namei.org> <1228488915.15920.42.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 5 Dec 2008, David P. Quigley wrote:

> On Fri, 2008-12-05 at 12:01 +1100, James Morris wrote:
> > On Thu, 4 Dec 2008, David P. Quigley wrote:
> > 
> > > There is no easy way to tell if a file system supports SELinux security labeling.
> > > Because of this a new flag is being added to the super block security structure
> > > to indicate that the particular super block supports labeling. This flag is set
> > > for file systems using the xattr, task, and transition labeling methods unless
> > > that behavior is overridden by context mounts.
> > 
> > Looks ok to me (similar namespace issue with the flag).
> > 
> > 
> > - James
> 
> I'm assuming you mean change SBLABELSUPP to SE_SBLABELSUPP, correct?

Yes, although the Linux way would likely be SE_SB_LABEL_SUPP for 
readability.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
