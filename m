From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: svirt on MLS has strange AVC.
Date: Fri, 26 Mar 2010 15:54:23 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>
References: <4BA7E4BF.1040002@redhat.com> <201003251806.13943.paul.moore@hp.com> <1269612002.2980.69.camel@dhcp231-113.rdu.redhat.com>
In-Reply-To: <1269612002.2980.69.camel@dhcp231-113.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201003261554.23667.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 26 March 2010 10:00:02 am Eric Paris wrote:
> On Thu, 2010-03-25 at 18:06 -0400, Paul Moore wrote:
> > I thought QEMU/KVM was creating the socket and libvirtd was trying to
> > connect to it?  If this is the case wouldn't it be a random virtual
> > machine ...
> > 
> > 	svirt_t:s3:c156
> > 
> > ... and a not-so-random libvirtd ...
> > 
> > 	libvirtd_t:s0-s15:c0-c1023
> > 
> > ... trying to talk over a UNIX socket which is labeled svirt_t:s0 (on the
> > QEMU/KVM side) and libvirtd_t:s0-s15:c0-c1023 (on the libvirtd side)?  I
> > agree, that could be a little wierd on the QEMU/KVM side, but if we use
> > the full MLS range for the child socket we end up with
> > svirt:s0-s15:c0-c1023 on the QEMU/KVM side and
> > libvirtd_t:s0-s15:c0-c1023 on the libvirtd side; you'll probably still
> > need some MLS overrides on the QEMU/KVM side but you could at least do
> > something using the range.
> 
> Yes, that is exactly what is happening.  I find the label
> svirt:s0-s15:c0-c1023 abhorrent, but that's neither here nor there.  MLS
> as an 'other' class citizen in the label makes me .... unhappy.

Me too.  I work hard to deal in "labels" whenever possible, sadly (or 
unhappily) this isn't always possible.

> So today we have:
> 
> QEMU/KVM process: svirt_t:s3:c156
> QEMU/KVM socket:  svirt_t:s0-s15:c0-c1023

Well, if it is working correctly, I think we established that there were some 
bugs ... but honestly at this point I've forgotten, I need to re-read what we 
wrote ...

> sds suggested we only copy the low part of the MLS context to the server
> label, which gives us:
> 
> QEMU/KVM process: svirt_t:s3:c156
> QEMU/KVM socket:  svirt_t:s0:c0
> 
> which I don't think is any better as we still have to needlessly use MLS
> overrides which pretty much destroys the whole usefulness of vm
> isolation here.

Well, either way you are going to need to use some MLS override attributes, 
but one of the nice things about SELinux is you can restrict those overrides 
to specific object classes and permissions, e.g. you can create MLS overrides 
which only target specific UNIX domain socket operations.  It really isn't as 
bleak as it sounds; vm isolation is not lost.

> This is why I suggested an mls_copy_subset function so things could
> 'work' if you have ranged objects on either the client or server side.
> It only 'works' today if the ranged object is on the server side.....

Look at the MLS constraints, yes I know they are scary, but they are quite 
flexible and I believe they will allow you to do what you want.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
