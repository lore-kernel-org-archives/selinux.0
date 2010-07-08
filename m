Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o682pqI3030209
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2010 22:51:52 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o682rfVo015340
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2010 02:53:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: deduplication and SE virtual machines
Date: Thu, 8 Jul 2010 12:51:45 +1000
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <201007042141.34168.russell@coker.com.au> <20100707200856.GA20082@hallyn.com>
In-Reply-To: <20100707200856.GA20082@hallyn.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201007081251.45420.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 Jul 2010, "Serge E. Hallyn" <serge@hallyn.com> wrote:
> Here's an idea - you could create the base fs as a qcow2 block device.
> Create copy-on-write images based on that
> 	for i in `seq 1 20`; do
> 		qemu-img create -f qcow2 -b selinux-base.img selinux-vm$i.img
> 	done
> Then use qemu-nbd to export those as /dev/nbdX devices
> 	for i in `seq 1 20`; do
> 		qemu-nbd -c /dev/nbd$i selinux-vm$i
> 	done
> 
> I'm guessing at the commands as I haven't quite done it.  But then your
> containers or VMS or chroots or whatever can mount /dev/nbd$i like a
> normal block device, COW based on the same base image.

That's an interesting concept.  I guess I can use NBD over ::1 for Xen too.

Also I guess if I wanted to have multiple Xen servers then I could have one 
machine supplying all the main storage disk and the others just having disks 
for swap spaces.

Is there any Xen management software to setup dozens of virtual machines with 
user-names and passwords associated with them to permit all management tasks 
including create, destroy, and view the console of Xen servers?  Please reply 
off-list if you know of any such software.
 
> I'm not sure that would suffice though, if there are a lot of small
> files, since presumably the xattrs will be spread out along with the
> data.  So if that does not suffice (I'd love to hear a report if anyone
> tests this), then I think we have another motivator for pushing a
> 'xattr_file=' mount option, where the specified file has
> (inode_num,name,value) triplets for the inodes on the fs, i.e.
> 	25,security.selinux,root_u:root_r:root_t
> 	25,security.capabilities,<whatever>
> 	30,security.selinux,user_u:user_r:serge_t
> That way the base fs wouldn't need to change much at all for each
> of your VMs.  The other motivator of course is common filesystems
> which don't support xattrs like squashfs and CIFS.  I wonder what
> sort of reception such a patch would receive...  "welcome back to
> year 2000"?

No, it's more like back to 2003 or whenever it was such support was removed.  
;)

But seriously I think there is a good reason for having this, probably not for 
deduplication of unusual cases of virtual machines but for filesystems that 
don't have native support for labeling.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
