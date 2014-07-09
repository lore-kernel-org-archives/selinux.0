Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s69CPlSu016233
 for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2014 08:25:48 -0400
Message-ID: <53BD34CB.7060407@davequigley.com>
Date: Wed, 09 Jul 2014 08:25:47 -0400
From: Dave Quigley <dpquigl@davequigley.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: SELinux with overlayfs between squashfs and jffs2
References: <617426951.7751.1404892888617.JavaMail.root@bureau-frontal2.univ-amu.fr>
In-Reply-To: <617426951.7751.1404892888617.JavaMail.root@bureau-frontal2.univ-amu.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/9/2014 4:01 AM, Antoine MOISE wrote:
> Hi,
> I try to use SELinux on embedded system, which contains an overlay used for saving changes of the rootfs.
> The rootfs is stored on a squashfs read-only, and the rootfs' changes are stored in a jffs2 partition.
> In this situation changing file's context is impossible because SELinux tried to modify the squashfs inode, not creating or modifying inode in the overlay to store the new SELinux context.
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
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>


I don't think this is an SELinux issue but rather an issue with what 
overlayfs is doing with the permission denial. The setting of the 
security label should be done with an xattr handler. If it fails on the 
root you'd think that it would copyup the file and then store the 
changes on the jffs2 like it would any other write failure. However it 
seems like its just taking the failure to set the xattr as a fatal 
failure and giving up. I can try to take a look at it more later but I 
don't think this is really an SELinux permission problem and more 
overlayfs not knowing how to handle SELinux properly.

Dave
