Message-Id: <200208282118.VAA19350@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: kernel daemons runs in init_t
Date: Wed, 28 Aug 2002 23:19:23 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0208281607050.25057-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0208281607050.25057-100000@raven>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Mittwoch, 28. August 2002 22:08 schrieb Stephen Smalley:
> On Wed, 28 Aug 2002, Carsten Grohmann wrote:
> > with the new release, all kernel daemons runs in the init_t domain.
> > Is this a new feature or my mistake?
> > But I don't found any anormaly.
>
> As I explained previously, it depends on the parent of the kernel thread.
> If the kernel thread's PPID is 1 (init), it should also be labeled with
> init_t.  If the kernel thread's PPID is 0 (kernel), then it should also
> be labeled with kernel_t.

Only I don't understand why changes the domain of some kernel threads 
between the to releases. During I use the July release, I have different 
domains for the kernel threads and now with the August release all kernel 
threads labelling as init_t. If you think all is correct, then I don't have 
a problem with this different domains.

The general README writes we should use "IP Networking Support" in the 
kernel. But I don't found this option. It is removed from the kernel? Then 
we could change the README too.

Thanks 

  Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
