Message-ID: <45A7D773.8040800@redhat.com>
Date: Fri, 12 Jan 2007 13:46:11 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: We currently have a problem with cp -a /media/cdrom  /etc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently in policy we do NOT have the following rule

allow iso9660_t fs_t:filesystem associate;

This causes cp -a to blow up when copying a cdrom to ext3.   I notice in 
policy we do allow this for nfs_t and dosfs_t to be assicoated with fs_t.

So this causes two problems, if we use cp -a from nfs_t or dosfs_t we 
end up with files on local disk labeled as nfs_t/dosfs_t when I believe 
we would be better off if they had transitioned.  So I could change 
policy to similarly allow iso9660_t files to be created and fix the cp 
-a problem.

Or I could remove the nfs_t and dosfs_t association and make the cp -a 
problem worse.  Since cp -a gets permission denied it really has no way 
of knowing what the correct behavior should be. 

Maybe a fix would be to allow cp to ask the kernel what to do if it can 
not setfscreatecon a particular context on a file system.

Thoughts?

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
