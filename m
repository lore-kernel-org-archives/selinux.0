Message-ID: <430C776B.4060309@redhat.com>
Date: Wed, 24 Aug 2005 09:34:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Problems with MCS/Targeted policy update.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I would like to be able to upgrade rawhide with a new targeted policy 
containing MCS.   I see a couple of problems when I do this.

The number one problem, it that it still requires an relable.  Even 
though the latest kernel defaults everything to level of "sid file"
getfilecon or the kernel is is still reading the file context off disks 
without the "s0" so the kernel is reporting hundreds of invalid 
contexts, need to figure a way to fix this or we will need a relabel.  
(Relabeling when upgrading from FC4-FC5 will not be pretty).

Certain applications like chcon, might need to change to use _raw 
functions, _raw function/options would be nice to add to certain 
coreutils, at least for debugging purposes.


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
