From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: redhat-lspp@redhat.com, SELinux@tycho.nsa.gov, sgrubb@redhat.com,
   dwalsh@redhat.com, Janak Desai <jdesai@us.ibm.com>,
   Kris Wilson <krisw@us.ibm.com>, gcwilson@us.ibm.com, vivijim@br.ibm.com
Subject: problem changing role.
Date: Tue, 7 Feb 2006 14:52:17 -0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200602071452.18452.glommer@br.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry for posting for both lists. I'm reporting a whole problem, and I think 
there are pieces of them of interest for each one of you. Since it's not been 
that easy to isolate that parts, I'm posting the whole picture here.

I noticed the problem when doing the newrole command. When trying to change 
root's role to sysadm_r , I got the following message:

[root@localhost ~]# newrole -r sysadm_r -t sysadm_t
Authenticating root.
Password:
Error sending audit message.

The problem remained even in permissive mode. I then checked the AVC messages 
from audit log, and *problem 1*, noticed that some objects of the system did 
not had any categories associated with they mls labels (i.e. , they were s0 
instead of s0:c0.c255). This led the process and the object to be in an 
uncomparable state, and the chcon command fixed it. However, our installation 
here is pretty much a default one. Vivi (CC'ed) may be able to give more 
information on this, but maybe it's a signal that there is something wrong 
with default installation. We may give you more info if you want, as 
requested.

The offending labels were on:
/usr/share/fonts and /var/cache/fontconfig/*

Fixing the labels of the files got rid with AVC denial messages, but the 
problem persisted. However, audit log now shows the following message:

type=SELINUX_ERR msg=audit(1139315244.562:56): SELinux:  unrecognized netlink 
message type=2300 for sclass=49

The following piece of code from security/selinux/hooks.c in kernel tree 
reveals that is not a great issue in permissive mode (err = 0 statement), but 
I honestly don't know what does this message represent, and what sould be the 
consequences of it while enforcing, so, reporting I am:

        if (err) {
                if (err == -EINVAL) {
                        audit_log(current->audit_context, GFP_KERNEL, 
AUDIT_SELINUX_ERR,
                                  "SELinux:  unrecognized netlink message"
                                  " type=%hu for sclass=%hu\n",
                                  nlh->nlmsg_type, isec->sclass);
                        if (!selinux_enforcing)
                                err = 0;
                }

But after that, newrole did not yet worked. To put it to work, I got 
policycoreutils-1.29.18-2.src.rpm from fedora development tree. I then 
compiled it, (tip for packagers, I was unable to do it without issuing a ln 
-s /lib/libsepol.so.1 /lib/libsepol.so) and this time, I was able to change 
roles.

However, It *DOES NOT* seems like a versioning problem, as shown by the 
following output:

[root@localhost log]# rpm -qa policycoreutils
policycoreutils-1.29.18-2

Wich just makes me clueless about what the real problem is. 
For practical purposes, we're now able to do the tasks we were trying to. But 
some questions remains unanswered (specially the kernel message and the 
newrole problem). Hope this report helps you guys to somehow improve the 
process. 

Let me know if there can be any valuable information that can be provided.


Glauber.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
