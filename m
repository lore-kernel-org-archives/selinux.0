Message-ID: <42431DB0.7040803@redhat.com>
Date: Thu, 24 Mar 2005 15:06:08 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <SELinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   Russell Coker <russell@coker.com.au>
Subject: Re: I would like to propose some kind of consolidation of tmpfs_t
 and tmp_t
References: <4242CABC.70400@redhat.com>	 <1111675057.12486.39.camel@moss-spartans.epoch.ncsc.mil> <1111685458.13486.61.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1111685458.13486.61.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------030702070503050409010908"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030702070503050409010908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Thu, 2005-03-24 at 09:37 -0500, Stephen Smalley wrote:
>  
>
>>For /tmp, a fscontext= mount seems to have an issue in that it is still
>>using type transitions for labeling inodes (including the root), so we
>>end up with mount_tmp_t on /tmp at least under strict policy.  Possibly
>>we could/should change the way that works for the root inode.
>>    
>>
>
>Possible workaround - mount with fscontext=, then run restorecon /tmp
>(not recursively, just on the top-level directory) from rc.sysinit.
>That would get us tmp_t on the superblock and tmp_t on the root
>directory.  Then you just need a few policy modifications like allow
>tmpfile_t tmp_t:filesystem associate;, and you still can perform
>[gs]etfilecon and setfscreatecon on the filesystem.
>
>  
>
I don't think we have do do any of that.  It seems to work if you do a
restorecon /tmp
in the init scripts.

I am running strict policy with tmpfs mounted on /tmp

mount
/dev/mapper/VolGroup00-LogVol00 on / type ext3 (rw)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda1 on /boot type ext3 (rw)
none on /tmp type tmpfs (rw)
none on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)


-- 



--------------030702070503050409010908
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

--- initscripts-8.05/rc.d/rc.sysinit~	2005-03-24 15:02:51.000000000 -0500
+++ initscripts-8.05/rc.d/rc.sysinit	2005-03-24 15:03:11.000000000 -0500
@@ -593,6 +593,7 @@
 fi
 
 # Clean up various /tmp bits
+restorecon /tmp
 rm -f /tmp/.X*-lock /tmp/.lock.* /tmp/.gdm_socket /tmp/.s.PGSQL.*
 rm -rf /tmp/.X*-unix /tmp/.ICE-unix /tmp/.font-unix /tmp/hsperfdata_* \
        /tmp/kde-* /tmp/ksocket-* /tmp/mc-* /tmp/mcop-* /tmp/orbit-*  \

--------------030702070503050409010908--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
