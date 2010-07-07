Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o67K8DJ0008257
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2010 16:08:13 -0400
Received: from hrndva-omtalb.mail.rr.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o67K7KAe019987
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2010 20:07:20 GMT
Date: Wed, 7 Jul 2010 15:08:56 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: deduplication and SE virtual machines
Message-ID: <20100707200856.GA20082@hallyn.com>
References: <201007042141.34168.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201007042141.34168.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Russell Coker (russell@coker.com.au):
> I'm thinking of setting up a Linux virtual machine server for SE Linux 
> training, and with most COW setups the initial relabel of the filesystem will 
> put all the meta-data into a separate copy.  So ideally there would be a way 
> of deduplicating this.  Also there's no guarantee that the disk blocks used 
> would be the same so a simple un-COW operation on LVM or something probably 
> wouldn't be a viable option.

Here's an idea - you could create the base fs as a qcow2 block device.
Create copy-on-write images based on that
	for i in `seq 1 20`; do
		qemu-img create -f qcow2 -b selinux-base.img selinux-vm$i.img
	done
Then use qemu-nbd to export those as /dev/nbdX devices
	for i in `seq 1 20`; do
		qemu-nbd -c /dev/nbd$i selinux-vm$i
	done

I'm guessing at the commands as I haven't quite done it.  But then your
containers or VMS or chroots or whatever can mount /dev/nbd$i like a
normal block device, COW based on the same base image.

I'm not sure that would suffice though, if there are a lot of small
files, since presumably the xattrs will be spread out along with the
data.  So if that does not suffice (I'd love to hear a report if anyone
tests this), then I think we have another motivator for pushing a
'xattr_file=' mount option, where the specified file has
(inode_num,name,value) triplets for the inodes on the fs, i.e.
	25,security.selinux,root_u:root_r:root_t
	25,security.capabilities,<whatever>
	30,security.selinux,user_u:user_r:serge_t
That way the base fs wouldn't need to change much at all for each
of your VMs.  The other motivator of course is common filesystems
which don't support xattrs like squashfs and CIFS.  I wonder what
sort of reception such a patch would receive...  "welcome back to
year 2000"?

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
