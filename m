Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OFsWrT027961
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:54:32 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OFsUCV008354
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 15:54:31 GMT
Date: Tue, 24 Aug 2004 17:05:45 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: patch for fsadm
Message-ID: <20040824160545.GA25322@lkcl.net>
References: <20040823215041.GC13677@lkcl.net> <200408250136.19967.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408250136.19967.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 25, 2004 at 01:36:19AM +1000, Russell Coker wrote:
> On Tue, 24 Aug 2004 07:50, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > usb-mount uses sg_map and disktype.
> >
> > both these programs require some extra stuff.
> 
> # this is for sg_map and disktype
> allow fsadm_t scsi_generic_device_t:chr_file { ioctl read };
> 
> It only needs ioctl and read access?  I'll give it r_file_perms.
> 
> +allow fsadm_t tape_device_t:chr_file { read };
> 
> Why does it need to access tape devices?
> 
> allow fsadm_t removable_device_t:lnk_file { read };
> 
> This is wrong.  We don't want to label lnk_file objects under /dev other than 
> as device_t.
> 
> +# /bin/mountpoint to read /dev/shm
> +allow fsadm_t devpts_t:dir { search };
> +allow fsadm_t tmpfs_t:dir { getattr search };
> 
> The tmpfs_t part is good, I'm not so sure about the devpts_t part.
 
 cool, hey, well, if enough ends up in the default policy, such that at
 some point in the future i can just do apt-get install
 selinux-policy-default and it works, _great_.

 until then, my lack of experience will mean i have lots of crud
 to throw at you, hopefully you'll know which bits to catch and which
 to dodge...

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
