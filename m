Message-ID: <41741A2C.8040408@redhat.com>
Date: Mon, 18 Oct 2004 15:31:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Adding alternate root patch to restorecon (setfiles?)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We are beginning to look into how we could support clusters with SELinux. 
Usually in clusters you move your configuration off on to some shared 
storage.

So you might do a cp -a  /var/named /shared/var/named

We need some way of relabeling these directories with file context.  My 
idea is to add an alternate
root qualifier to restorecon

So in the above example you would do a

restorecon -R -p /shared /shared/var/named

I think this would work fairly well for chroot environments also.

Ideas?


Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
