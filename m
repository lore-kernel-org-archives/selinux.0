Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7CBQ8D3019208
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 07:26:08 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7CBQ7FJ026887
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 11:26:08 GMT
Date: Tue, 12 Aug 2008 21:25:51 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
cc: libvir-list@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [libvirt] [ANNOUNCE][RFC] sVirt: Integrating SELinux and
 Linux-based virtualization
In-Reply-To: <20080812110803.GI13067@redhat.com>
Message-ID: <alpine.LRH.1.10.0808122115240.14171@tundra.namei.org>
References: <alpine.LRH.1.10.0808111201430.4083@tundra.namei.org> <20080812110803.GI13067@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 12 Aug 2008, Daniel P. Berrange wrote:

>         Do we instead add the info the udev rules, so when /dev is
>         populated at boot time by udev the device nodes get the desired
>         initial labelling ?  Or do we manually  chcon() the device
>         at the time we boot the VM ?

Dan Walsh has mentioned wanting to label the device at VM launch so that 
MCS labels can be dynamically assigned.  This raises some other possible 
issues such as revoking any existing access (Linux doesn't have general 
revocation) and having the security of the system depend on whatever is 
performing the relabel (although we can enforce relabelfrom/relabelto 
permissions).

I wonder if existing work/concepts related to MLS device allocation would 
be useful here.

See:
http://sourceforge.net/projects/devallocator/


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
