Subject: Re: svirt on MLS has strange AVC.
From: Eric Paris <eparis@redhat.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh
 <dwalsh@redhat.com>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux
 <selinux@tycho.nsa.gov>
In-Reply-To: <201003251806.13943.paul.moore@hp.com>
References: <4BA7E4BF.1040002@redhat.com>
	 <1269541078.1031.45.camel@moss-pluto.epoch.ncsc.mil>
	 <1269543730.2980.17.camel@dhcp231-113.rdu.redhat.com>
	 <201003251806.13943.paul.moore@hp.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Mar 2010 13:06:42 -0400
Message-ID: <1269882402.2980.152.camel@dhcp231-113.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[resending as tycho.nsa.gov bounced it the first time.  Paul already
responded so this is just for the archives]

On Thu, 2010-03-25 at 18:06 -0400, Paul Moore wrote:
> I thought QEMU/KVM was creating the socket and libvirtd was trying to connect 
> to it?  If this is the case wouldn't it be a random virtual machine ...
> 
> 	svirt_t:s3:c156
> 
> ... and a not-so-random libvirtd ...
> 
> 	libvirtd_t:s0-s15:c0-c1023
> 
> ... trying to talk over a UNIX socket which is labeled svirt_t:s0 (on the 
> QEMU/KVM side) and libvirtd_t:s0-s15:c0-c1023 (on the libvirtd side)?  I 
> agree, that could be a little wierd on the QEMU/KVM side, but if we use the 
> full MLS range for the child socket we end up with svirt:s0-s15:c0-c1023 on 
> the QEMU/KVM side and libvirtd_t:s0-s15:c0-c1023 on the libvirtd side; you'll 
> probably still need some MLS overrides on the QEMU/KVM side but you could at 
> least do something using the range.

Yes, that is exactly what is happening.  I find the label
svirt:s0-s15:c0-c1023 abhorrent, but that's neither here nor there.  MLS
as an 'other' class citizen in the label makes me .... unhappy.  So
today we have:

QEMU/KVM process: svirt_t:s3:c156
QEMU/KVM socket:  svirt_t:s0-s15:c0-c1023

sds suggested we only copy the low part of the MLS context to the server
label, which gives us:

QEMU/KVM process: svirt_t:s3:c156
QEMU/KVM socket:  svirt_t:s0:c0

which I don't think is any better as we still have to needlessly use MLS
overrides which pretty much destroys the whole usefulness of vm
isolation here.

This is why I suggested an mls_copy_subset function so things could
'work' if you have ranged objects on either the client or server side.
It only 'works' today if the ranged object is on the server side.....

-Eric



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
