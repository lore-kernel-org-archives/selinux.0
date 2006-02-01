From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: labeling of compilers etc
Date: Wed, 1 Feb 2006 19:22:12 +1100
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux-dev@tresys.com,
   SELinux List <selinux@tycho.nsa.gov>
References: <200601291156.13076.russell@coker.com.au> <200601311847.56015.russell@coker.com.au> <43E01E31.2060400@redhat.com>
In-Reply-To: <43E01E31.2060400@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200602011922.23667.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 01 February 2006 13:34, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > I executed code on a block device.  Incidentally the device I used for
> > testing was a USB flash device.  It seems to me that we want such devices
> > to be removable_device_t not fixed_disk_device_t (as is currently the
> > case).  Using removable_device_t will fix some usability cases but also
> > make it more of an issue to control executing code from it.
>
> Most of the applications that were named in this discussion would be
> blocked by a properly locked down domain anyways, by the name_connect
> check.

What do you mean?  How does name_connect relate to executing code on a USB 
device?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
