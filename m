From: "Lamont R. Peterson" <lrp@xmission.com>
Reply-To: lrp@xmission.com
To: "L. Dean Risinger Jr." <deanr@acl.lanl.gov>, SELinux@tycho.nsa.gov
Subject: Re: Possible bug in build for scsi
Date: Wed, 2 Apr 2003 17:58:35 -0700
Cc: kbintz@lanl.gov
References: <20030402131736.A795@acl.lanl.gov>
In-Reply-To: <20030402131736.A795@acl.lanl.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304021758.35451.lrp@xmission.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 02 April 2003 01:17 pm, L. Dean Risinger Jr. wrote:
-SNIP-
> OS: Redhat Linux 8.0 with kernel 2.4.18smp
>
> SELinux version: 2.4 LSM-based Prototype
>
> SELinux Configuration: Default, with the addition of support for the
> ext3 filesystem.  Trying to build kernel 2.4.20

Have you double checked your paths?  is linux symlinked properly to the 2.4.20 
kernel sources?  I hate it when I get to the end of a kernel build only to 
discover that I did something stupid like this (though it's been a long time 
since that's happened to me :-).

> Steps followed:
>       unzipped/untarred source into /root
>
>       cd /root/selinux
>       cd module
>       make insert
>
>       cd /root/lsm-2.4
>       make menuconfig
>       make dep
>       make
>       make modules
>       make install

I may be showing a lack of experience with Red Hat 8.0 (I've never even 
touched it, yet), but shouldn't this list read:

make dep
make bzImage [or something similar]
make modules
make modules_install
make install [I usually use cp to install my kernels]

-SNIP-
-- 
Sincerely,
Lamont R. Peterson <lrp@xmission.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
