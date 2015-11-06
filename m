Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA6L2M2k010960
 for <selinux@tycho.nsa.gov>; Fri, 6 Nov 2015 16:02:22 -0500
From: "Roberts, William C" <william.c.roberts@intel.com>
To: Jeffrey Vander Stoep <jeffv@google.com>, Paul Moore <pmoore@redhat.com>,
 SELinux <selinux@tycho.nsa.gov>
Subject: RE: New SELinux userspace release supporting extended ioctl
 permissions?
Date: Fri, 6 Nov 2015 21:02:08 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC56010C3800@ORSMSX103.amr.corp.intel.com>
References: <1852496.Nbh2u1K4Uk@sifl>	<20151106162635.GA10239@x250>
 <CABXk95Ae+pBH0LaQ+93N5mD7GDfPaAJNEQR4qo3VxX+SnFC07g@mail.gmail.com>
In-Reply-To: <CABXk95Ae+pBH0LaQ+93N5mD7GDfPaAJNEQR4qo3VxX+SnFC07g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of Jeffrey
> Vander Stoep
> Sent: Friday, November 6, 2015 9:51 AM
> To: Paul Moore <pmoore@redhat.com>; SELinux <selinux@tycho.nsa.gov>
> Subject: Re: New SELinux userspace release supporting extended ioctl
> permissions?
> 
> > Applying ioctl whitelisting on GNU/Linux systems looks to me pretty
> > hard to do though. Many drivers, and their ioctls to support.
> 
> Agreed.
> 
> On Android we use ioctl whitelisting only in a targeted manner. I think the same
> approach could (should) be applied to GNU/Linux.
> 
> The example that went out in the M release focused on restricting the leakage of
> privacy sensitive information from socket ioctls. Apps are blocked from using
> socket ioctls to access the wifi MAC address, wifi SSID and layer 2 encryption
> protocol. I could see a similar policy applied to the GNU/Linux browser. Ioctl
> policies on GPU access also seem practical albeit device specific.
> 
> Constructing a comprehensive list of ioctls and the source/target/class sets that
> require access does not strike me as practical. In many cases these ioctls are
> already properly restricted via the ioctl permission.

I think a good example of what could be targeted are perhaps video devices implementing
The Video 4 Linux and V4L2 api's. Since those ioctl's are well documented, hopefully things
adhere to them. However, based on my experience, there is the standard and then what
people do, and they are not one in the same.


> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
