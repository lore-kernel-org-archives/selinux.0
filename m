Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s69E4Zcw023001
 for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2014 10:04:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 09 Jul 2014 10:04:37 -0400
From: David Quigley <selinux@davequigley.com>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux with overlayfs between squashfs and jffs2
In-Reply-To: <617426951.7751.1404892888617.JavaMail.root@bureau-frontal2.univ-amu.fr>
References: <617426951.7751.1404892888617.JavaMail.root@bureau-frontal2.univ-amu.fr>
Message-ID: <993ce51c36173e829ab3f34e732908d2@countercultured.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/09/2014 04:01, Antoine MOISE wrote:
> Hi,
> I try to use SELinux on embedded system, which contains an overlay
> used for saving changes of the rootfs.
> The rootfs is stored on a squashfs read-only, and the rootfs' changes
> are stored in a jffs2 partition.
> In this situation changing file's context is impossible because
> SELinux tried to modify the squashfs inode, not creating or modifying
> inode in the overlay to store the new SELinux context.
> Is it a security purpose of not supporting such mecanism?
> 
> 
> Best Regards
> Antoine MOÏSE
> 
> Aix-Marseille University
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to 
> Selinux-request@tycho.nsa.gov.


Also from what I can see it doesn't look like overlayfs is actually in 
mainline yet. Is this the case?

Dave
