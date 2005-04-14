Subject: Re: You mentioned somewhere there is a step by step
	guide	to	getting the MLS policy installed on a machine?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <425ED188.3020008@hp.com>
References: <41EC4682.8050807@trustedcs.com>
	 <41F6D30D.9070904@trustedcs.com>
	 <1106771757.23386.348.camel@moss-spartans.epoch.ncsc.mil>
	 <42408CAB.4030007@redhat.com>
	 <1111583468.21107.15.camel@moss-spartans.epoch.ncsc.mil>
	 <424175DA.9040804@redhat.com>
	 <1111586615.21107.60.camel@moss-spartans.epoch.ncsc.mil>
	 <425ED188.3020008@hp.com>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 16:38:13 -0400
Message-Id: <1113511093.2123.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-14 at 16:24 -0400, Paul Moore wrote:
> I just wanted to get some clarification here as the MLS README is a 
> little vague in this area - assuming I have followed all of the install 
> instructions in the README file, what we be the correct label to use for 
> the mountpoints (one of the last steps in the install process), 
> especially the pseudo filesystems such as /proc?

Good timing; I just got done converting a fresh FC4 test2 install over
to MLS, and James Morris has recently experimented with the MLS
conversion as well.  I'm making some minor updates to README.MLS based
on that experience.  chcon system_u:object_r:file_t:s0 /proc should work
for you.  A few other points to note:
1) I had to umount /proc/bus/usb and /proc/sys/fs/binfmt_misc prior to
being able to umount /proc.
2) I also had to umount and relabel /var/lib/nfs/rpc_pipefs.
3) Rather than immediately booting the MLS-enabled kernel into multi-
user mode, you should instead boot with enforcing=0 single to fix up the
context on /etc/mtab, which is re-created by the shutdown while you were
still running with selinux=0.  You can run /sbin/restorecon /etc/mtab
from single-user mode, then /usr/sbin/setenforce 1 and exit the single-
user shell to come up multi-user.

I did the conversion from strict policy.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
