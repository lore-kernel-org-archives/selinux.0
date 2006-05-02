Message-ID: <44576B91.8060607@redhat.com>
Date: Tue, 02 May 2006 10:24:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Paul Nasrat <pnasrat@redhat.com>, Jeremy Katz <katzj@redhat.com>,
        James Antill <jantill@redhat.com>
Subject: We are attempting once again to split policy out into individual
 RPMS.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I had more meetings with the install and RPM team at Red Hat about 
splitting out policy into individual packages for RHEL5/FC6.  We had 
many discussions about possible ways of doing this including breaking 
out policy into separate packages, ie http_policy.rpm but this was 
discounted as it was seen as a policy explosion.  Also we discussed only 
doing the semodule as the last in the transaction but this ability is 
being de-emphasized in the installer, so it was thought to keep it 
simple and install the policy within each RPM that ships with policy, 
sort of the ldconfig model.

We need the ability for RPM to be able to write a file context on disk 
without the kernel verifying it.  The kernel should treat this as an 
unlabeled_t file. the same way it would if I ran

semodule -i XYZ.pp
restorecon /usr/bin/XYZ
semoduel -e XYZ

I don't think this is an unreasonable request to allow rpm_t to have the 
privilege of writing the "invalid" context to disk.

Secondly the rpm team would like to be able to execute the equivalent of 
matchpathcon(XYZ.pp)  IE be able to extract the FC file mapping from the 
policy package and combine it with the on disk representation to 
determine the file context to associate with the new files being put on 
disk.

At the end of the rpm install, postinstall would do an semodule -i XYZ.pp.

We want to start out with just a couple of packages shipping policy to 
prove the technology and then to allow third parties to ship using this 
method.

Dan







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
