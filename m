Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9UCZlYi012007
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 08:35:47 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9UCYFhH027518
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 12:34:15 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.2/8.14.2) with ESMTP id m9UCZjut021179
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 08:35:45 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.2/8.14.2/Submit) id m9UCZjIB021178
	for selinux@tycho.nsa.gov; Thu, 30 Oct 2008 08:35:45 -0400
Date: Wed, 22 Oct 2008 10:51:46 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@namei.org>, libvir-list@redhat.com,
        Daniel Veillard <veillard@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] sVirt v0.10 - initial prototype
Message-ID: <20081022095146.GA24340@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org> <48FDDFBB.8020005@redhat.com> <20081021162217.GN16442@redhat.com> <48FE165C.3040303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48FE165C.3040303@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 21, 2008 at 01:50:20PM -0400, Daniel J Walsh wrote:
> Daniel P. Berrange wrote:
> > On Tue, Oct 21, 2008 at 09:57:15AM -0400, Daniel J Walsh wrote:
> >> James Morris wrote:
> > I think the 'policytype' bit of the label may thus better live in the
> > host capabilities XML document, so you can query it independantly of
> > any virtual machine
> > 
> > eg perhaps something like
> > 
> > # virsh capabilities 
> > <capabilities>
> > 
> >   <host>
> >     <cpu>
> >       <arch>i686</arch>
> >     </cpu>
> >     <secpolicy model='selinux'>
> >        <type>targetted</type>
> >        <state>enforcing</state>
> >     </secpolicy>
> >   </host>
> > 
> >   .... snip rest of XML...
> > 
> > Is there any meaningful / useful policy version information that can
> > be included here ? Or policy feature bits
> > 
> > The VM config would thus only need
> > 
> >    <domain>
> >      ....
> >      <seclabel model='selinux'>
> >        <label>system_u:system_r:virtd_t:s0</label>
> >      </seclabel>
> >      ...
> >    </domain>
> > 
> > 
> > I should note that the domain XML format is representative of the config
> > for a particular deployment of a virtual machine onto a host. 
> > 
> > It is not a generic interchange format for 'appliances'. If you were
> > distributing an appliance, then the virt-image XML format would be used,
> > and this encodes information on pre-requisites for host capabilities. 
> > 
> > When an appliance is deployed as a virtual domain, the virt-image tool,
> > validate the virt-image XML pre-requisites, against the host capabilites
> > XML to determine if the host is suitable.
> > 
> > Daniel
> Again targeted means nothing.  It is just an arbitrary name given to a
> policy package. So I don't see why it should be mentioned anywhere.
> 
> I think the existance of the kernel policy which understands what a
> system_u:system_r:virtd_t:s0 is what is important.
> 
> Again, I could have a three host machines each one with a different
> policy package say targeted, mls and overt policy package.  If all three
> understand what a system_u:system_r:virtd_t:s0 type is, then all three
> could run the image.

I guess my point was that we need a way to determine whether the policy 
on any machine is suitable for running a VM, before placing the VM on 
that host. In the context of a data center mgmt app we can have 100's or
1000's of possible virtualization enabled hosts. Not all of these
hosts will be providing the same level of functionality / same versions
of software, including selinux policy. 

So before starting a VM, the mgmt app needs to be able to make a reasonably
accurate decision about what host will support the VM's requirements
for SELinux policy capabilities. We can't just pick one at random, try to
start if and see if the kernel complains that 'system_u:system_r:virtd_t:s0'
doesn't exist in its policy.

> Having two machine with a "targeted" policy on them does nothing to
> assure that a processs labeled system_u:system_r:virtd_t:s0
> can run.

It wasn't intended to be a guarentee - its basically metadata to help the
admin / mgmt app pick a suitable virtualization host from amongst their
data center of 100's of machine. 

Maybe exposing the policytype 'targetted' is the wrong thing to be
considering for this purpose. Perhaps we should instead provide an API
to let you query the full list of all defined security domains, roles
and users. Basically enough info to let you validate whether the label
'system_u:system_r:virtd_t:s0' is likely to be supported. NB I use the
word 'likely' here - we don't need an absolute guarentee - we just need
to be able to make a reasonable choice of hosts & if it fails it can be
re-placed elsewhere.

Daniel
-- 
|: Red Hat, Engineering, London   -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org  -o-  http://virt-manager.org  -o-  http://ovirt.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-  F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
