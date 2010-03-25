Date: Thu, 25 Mar 2010 22:09:38 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: svirt on MLS has strange AVC.
Message-ID: <20100325220938.GB30421@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <4BA7E4BF.1040002@redhat.com> <1269541078.1031.45.camel@moss-pluto.epoch.ncsc.mil> <1269543730.2980.17.camel@dhcp231-113.rdu.redhat.com> <201003251806.13943.paul.moore@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201003251806.13943.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Mar 25, 2010 at 06:06:13PM -0400, Paul Moore wrote:
> On Thursday 25 March 2010 03:02:10 pm Eric Paris wrote:
> > On Thu, 2010-03-25 at 14:17 -0400, Stephen Smalley wrote:
> > > It seems to me that it really should only get the low/current level of
> > > the peer, not the full range, e.g. mls_context_cpy_low(), so that we
> > > don't turn a connection from a ranged subject into a fully ranged
> > > socket?
> 
> This is an interesting question, and you could ask the same of INET 
> connections where you have a ranged client peer label available.  I guess my 
> question is considering that the UNIX socket MLS constraints seem to follow 
> the rest of the MLS constraint conventions (the low half of the range is used 
> as the effective sensitivity label and the high half of the range is used as 
> the cleared sensitivity label) what do you loose with the current 
> implementation?  I haven't thought about it enough to have an opinion yet ...
> 
> > Is that even the best, by itself?  We would still be in the same
> > situation except now we would have a random virtual machine
> > 
> > svirt_t:s3:c156
> > 
> > trying to read/write to a socket with the label:
> > 
> > svirt_t:s0:c0
> > 
> > since libvirtd_t is going to pretty much always be running:
> > 
> > libvirtd_t:s0-s15:c0-1023
> 
> I thought QEMU/KVM was creating the socket and libvirtd was trying to connect 
> to it?  If this is the case wouldn't it be a random virtual machine ...

That is correct, this is the monitor socket created by QEMU, which
libvirtd then connects to

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

Regards,
Daniel
-- 
|: Red Hat, Engineering, London    -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org -o- http://virt-manager.org -o- http://deltacloud.org :|
|: http://autobuild.org        -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-   F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
