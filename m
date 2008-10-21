Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9TH2ncq005394
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2008 13:02:49 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9TH1H4X024069
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2008 17:01:17 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.2/8.14.2) with ESMTP id m9TGKYbl017452
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2008 12:20:34 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.2/8.14.2/Submit) id m9TGKYi6017450
	for selinux@tycho.nsa.gov; Wed, 29 Oct 2008 12:20:34 -0400
Date: Tue, 21 Oct 2008 17:22:17 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@namei.org>, libvir-list@redhat.com,
        Daniel Veillard <veillard@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] sVirt v0.10 - initial prototype
Message-ID: <20081021162217.GN16442@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <alpine.LRH.1.10.0810211144030.10613@tundra.namei.org> <48FDDFBB.8020005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48FDDFBB.8020005@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 21, 2008 at 09:57:15AM -0400, Daniel J Walsh wrote:
> James Morris wrote:

[snip]

> > The domain security label configuration format is as follows:
> > 
> > # virsh dumpxml sys1
> > <domain>
> >     ....
> >   <seclabel model='selinux'>
> >     <label>system_u:system_r:virtd_t:s0</label>
> >     <policytype>targeted</policytype>
> >   </seclabel>
> > </domain>
> > 
> > It's possible to query the security label of a running domain via virsh:
> > 
> > # virsh dominfo sys1
> > Id:             1
> > Name:           sys1
> > UUID:           fa3c8e06-0877-2a08-06fd-f2479b7bacb4
> > OS Type:        hvm
> > State:          running
> > CPU(s):         1
> > CPU time:       11.4s
> > Max memory:     524288 kB
> > Used memory:    524288 kB
> > Autostart:      disable
> > Security label: system_u:system_r:virtd_t:s0 (selinux/targeted/enforcing)

[snip]

> Why do we care about the policy type?  Policy type is a fairly
> meaningless object.  If you are trying to figure out if the host machine
> is valid to run a virtual machine you should just check whether the type
> is valid on the machine,  That way if I define minimum policy with virt
> support on one host and targeted policy with virt support on another
> machine, both would work.  Finally I think it might be ok for the
> administrator to request that this virtual machine would only run on a
> machine with SELinux in enforcing mode. For example if you had a fairly
> untrusted virtual machine you would want to ensure that the machine was
> enforcing SELinux before it got started.

Who/what should be making such a policy decision though ? Seems like the
management app using libvirt would want to do that - perhaps even making
that decison before defining the existance of the VM on the target machine,
let alone starting it.

When migrating a VM from one host to another an application may also 
want to verify that the same policy is available on both the source
and target hosts. A simple 'targeted' vs 'enforcing'  string is likely
not sufficient in this context. This also feels like host level info,
rather per-VM.

I think the 'policytype' bit of the label may thus better live in the
host capabilities XML document, so you can query it independantly of
any virtual machine

eg perhaps something like

# virsh capabilities 
<capabilities>

  <host>
    <cpu>
      <arch>i686</arch>
    </cpu>
    <secpolicy model='selinux'>
       <type>targetted</type>
       <state>enforcing</state>
    </secpolicy>
  </host>

  .... snip rest of XML...

Is there any meaningful / useful policy version information that can
be included here ? Or policy feature bits

The VM config would thus only need

   <domain>
     ....
     <seclabel model='selinux'>
       <label>system_u:system_r:virtd_t:s0</label>
     </seclabel>
     ...
   </domain>


I should note that the domain XML format is representative of the config
for a particular deployment of a virtual machine onto a host. 

It is not a generic interchange format for 'appliances'. If you were
distributing an appliance, then the virt-image XML format would be used,
and this encodes information on pre-requisites for host capabilities. 

When an appliance is deployed as a virtual domain, the virt-image tool,
validate the virt-image XML pre-requisites, against the host capabilites
XML to determine if the host is suitable.

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
