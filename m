Subject: Re: Fixfiles using new setfiles/restorecon simplification
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Joshua Brindle <method@manicmethod.com>,
        Eric Paris <eparis@parisplace.org>, Chad Sellers <csellers@tresys.com>
In-Reply-To: <4B881A0C.5010607@redhat.com>
References: <4B85902B.70300@redhat.com>
	 <1267206984.9997.38.camel@moss-pluto.epoch.ncsc.mil>
	 <4B881A0C.5010607@redhat.com>
Content-Type: text/plain
Date: Fri, 26 Feb 2010 15:49:00 -0500
Message-Id: <1267217340.9997.88.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-02-26 at 13:59 -0500, Daniel J Walsh wrote:
> On 02/26/2010 12:56 PM, Stephen Smalley wrote:
> > Problems with the new fixfiles logic even with kernels>= 2.6.30:
> >
> > - Bind mounts are not excluded (and note that they aren't marked with
> > bind as an option in /proc/mounts - only in /etc/mtab aka mount output):
> > # mkdir /foo
> > # mount -o bind /etc /foo
> > # grep /foo /proc/mounts
> > /dev/root /foo ext4 rw,seclabel,relatime,barrier=1,data=ordered 0 0
> > # grep /foo /etc/mtab
> > /etc /foo none rw,bind 0 0
> >
> > - You are assuming fixed option ordering and that no other options can
> > appear between "rw" and "seclabel" in your grep pattern for
> > FILESYSTEMSRW.  As a trivial counterexample, if the user mounts with a
> > rootcontext= option (override the root directory context, but allow
> > setting of individual file contexts), it won't match.  If we can assume
> > that seclabel always follows rw, then you can use grep
> > 'rw,.*seclabel' /proc/self/mounts.  If they used a regular context=
> > mount option, then seclabel won't be displayed so that will get
> > excluded.
> >
> > - The definition for FILESYSTEMSRO appears to be wrong.  I think
> > possibly you want grep 'ro,.*seclabel' there (i.e. filesystems mounted
> > read-only that support labeling).  Simple test case:
> > # mount -o remount,ro /boot
> > # grep 'ro,.*seclabel' /proc/mounts
> > /dev/sda1 /boot ext3
> > ro,seclabel,relatime,errors=continue,user_xattr,acl,data=ordered 0 0
> >
> >    
> 
> 
> How about this script,  It searches mount eliminating context and bind 
> mounts and then
> searches /proc/self/mounts for seclabel.
> 
> get_mounts() {
> FS=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk 
> '/rw/{print $3}';`

You can drop the grep -v "context=" if you are relying on seclabel
in /proc/mounts, as it won't appear if they used a "context=" mount
(disables setting of security contexts).  Whereas if they used a
rootcontext= or defcontext= mount just to initialize the root directory
context (as with /dev in some distributions and /dev/shm) or to define
the default context if the file lacks an xattr on disk, you still want
to relabel, so excluding anything with context= would exclude too much.
That's a bug in the current fixfiles.

Also, in the old fixfiles, you used \(rw rather than just rw in the
pattern so that you would only match on the mount option, not on any
occurrence of rw in e.g. the name of the device or the directory or the
filesystem type.

Interestingly /dev doesn't appear in mount output aka /etc/mtab but it
does in /proc/self/mounts.  So at present this won't relabel /dev.

> for i in $FS; do
>      grep --silent "$i ".*seclabel /proc/self/mounts && echo $i
> done
> }
> FILESYSTEMRW=`get_mounts`
> echo $FILESYSTEMRW

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
