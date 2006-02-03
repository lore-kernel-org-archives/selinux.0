From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Morris <jmorris@namei.org>
Subject: Re: MCS policy patch
Date: Sat, 4 Feb 2006 10:10:22 +1100
Cc: SELinux List <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
References: <200602040118.10784.russell@coker.com.au> <Pine.LNX.4.64.0602031422070.4965@excalibur.intercode>
In-Reply-To: <Pine.LNX.4.64.0602031422070.4965@excalibur.intercode>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602041010.36001.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 04 February 2006 06:31, James Morris <jmorris@namei.org> wrote:
> Also, do we need dynamic transitions at all in MCS?

We aren't using them yet in any other policy, but it seemed correct to add the 
constraint as I did.  Of course we could just force the dynamic transition to 
stay at the same level.

> > Also the same restriction is placed on creation and relabelto for files,
> > directories etc.
>
> I thought we already had this.

For relabelto yes, but not for creation.  Therefore it was possible to create 
objects that you could not relabel.

> > It still doesn't place any MCS restrictions on read/write for file system
> > objects other than files, but allowing for example a process to create a
> > directory in a context that it could not relabel a directory to or from
> > is bogus.
>
> I'm still not sure what the best model is for directories.  I've had a
> couple of people email and say they want files created under an MCS
> labeled directory to inherit the label.

Is it even possible to do that without kernel code changes?  Currently it 
seems that the limit in this regard is the low level of the process.

Also I think we want to go slowly on this and preserve the "targeted" design 
goal of breaking as few things as possible.  We can (and will) add further 
constraints at later times.

> I like the idea of keeping things as absolutely as simple as possible, and
> leaving MCS as a user-oriented discretionary tool, where the end user (and
> not the admin) is responsible for labeling all of their own files
> indivdually.

I agree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
