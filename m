Message-ID: <3B24F822.B55E8098@watson.ibm.com>
Date: Mon, 11 Jun 2001 12:56:03 -0400
From: Reiner Sailer <sailer@watson.ibm.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Root file system over NFS
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

we are developing in an embedded environment (Linux / Walnut board).
At least for development we need to mount the root file system  over
nfs from a trusted server (no hard-drive, no flash etc.). SELinux is running
in the embedded PowerPC environment.

PROBLEM with root over nfs and SELinux:
--> ALL files are assigned a default type (as it ships: nfs_t). This
means for our embedded system, that no transitions will be made
and basically all processes run as type init_t (which, e.g., makes the
login etc. fail). The only occurring types for processes are kernel_t
and init_t as those are explicitly chosen during startup.

Example:
Normally (on my conventional PC):
INETD usually runs in context: system_u:system_r:inetd_t
When started, the inetd binary with type inetd_t and transition rules in
the policy will change the context from system_u:system_r:init_t to
system_u:system_r:inetd_t
Here (on the embedded system, mounting root fs over nfs):
inetd binary will be assigned default-label: system_u:object_r:nfs_t,
-> no transition rule (as all files mounted over nfs have the same type,
adding a transition rule does not help as this transition rule would be
applied to all files of the nfs)

Changing this default-type for trusted servers (although very useful in
a normal environment) does not solve our problem.. We need fine-grained
type-assignment as for a normal local  root file system.

Possible solutions I think of  in order of preference:

a) handling nfs as it were a local fs - i.e. no default type
    (how to label a nfs ?) [ assume we trust the server for the ss_policy
    file and verify via MACs]

b) manually assign contexts on the client after mounting nfs root  and before
   any program is running (problem: chcon-command for changing contexts
   also has nfs_t  -> does not work out-of-the-box)
    -- good: different clients can specify policies independently

c)  dangerous but probably  for development (if it works at all):
     (i) assign a new standard type for nfs_mounts from trusted servers (ok)
     (ii) allow relabeling from there to any other type by some program  (?)
     (iii) relabel the whole file system ("down") to the values needed during
           system start-up (?)
     (iv) security concerns with  this solution (e.g. nfs security ) that
           I am aware of will be countered as good as possible;  e.g., using
           IPSEC (Client-Server authentication and packet protection) in
          combination with application level security (MACs, encryption etc.)

Please let me know any suggestions to this problem; even if the solution is
not merely policy-based but might involve changes in the SELinux code
kernel or utility programs.

Thanks
Reiner


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
