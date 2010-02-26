Message-ID: <4B8814A3.5010902@redhat.com>
Date: Fri, 26 Feb 2010 13:36:19 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>, Joshua Brindle <method@manicmethod.com>,
        Eric Paris <eparis@parisplace.org>, Chad Sellers <csellers@tresys.com>
Subject: Re: Fixfiles using new setfiles/restorecon simplification
References: <4B85902B.70300@redhat.com> <1267206984.9997.38.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1267206984.9997.38.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/26/2010 12:56 PM, Stephen Smalley wrote:
> Problems with the new fixfiles logic even with kernels>= 2.6.30:
>
> - Bind mounts are not excluded (and note that they aren't marked with
> bind as an option in /proc/mounts - only in /etc/mtab aka mount output):
> # mkdir /foo
> # mount -o bind /etc /foo
> # grep /foo /proc/mounts
> /dev/root /foo ext4 rw,seclabel,relatime,barrier=1,data=ordered 0 0
> # grep /foo /etc/mtab
> /etc /foo none rw,bind 0 0
>
> - You are assuming fixed option ordering and that no other options can
> appear between "rw" and "seclabel" in your grep pattern for
> FILESYSTEMSRW.  As a trivial counterexample, if the user mounts with a
> rootcontext= option (override the root directory context, but allow
> setting of individual file contexts), it won't match.  If we can assume
> that seclabel always follows rw, then you can use grep
> 'rw,.*seclabel' /proc/self/mounts.  If they used a regular context=
> mount option, then seclabel won't be displayed so that will get
> excluded.
>
> - The definition for FILESYSTEMSRO appears to be wrong.  I think
> possibly you want grep 'ro,.*seclabel' there (i.e. filesystems mounted
> read-only that support labeling).  Simple test case:
> # mount -o remount,ro /boot
> # grep 'ro,.*seclabel' /proc/mounts
> /dev/sda1 /boot ext3
> ro,seclabel,relatime,errors=continue,user_xattr,acl,data=ordered 0 0
>
>    
I think we just want to remove this and go with the

restorecon -R /

With the ro fix, I just sent.

The problem with this is if you have a seclabel file system mounted on a 
non seclabel file system, it will not get labeled.  But trying to figure 
out whether a file system is seclabel or not along with figuring out 
bind mounts is not going to be easy.  The way we have it now I think 
will cause multiple passes.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
