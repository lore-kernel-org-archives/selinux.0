Subject: debian and initrd with selinux on 2.6.0-test1
From: max barwell <maxb@paradise.net.nz>
To: SElinux list <SELinux@tycho.nsa.gov>
Cc: Russell Coker <russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1058642159.776.16.camel@orac.lite.net.nz>
Mime-Version: 1.0
Date: 20 Jul 2003 07:15:59 +1200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I had selinux running well on a 2.4 kernel but decided to be a bit more
adventurous, so I am trying to get it going on 2.6.0-test1.

I am using Debian sid and the selinux-2.5-2003071106.tgz set of tools,
from the NSA website.

In an email from Stephen Smalley he told me that the userland tools for
2.5 would be fine with 2.6, but one thing in the readme has me stumped,
you have to patch your mkinitrd script to make an initrd image for
selinux. The example given is for patching redhat 9's mkinitrd.

I am assuming this is possible, I am not so hot at coding, so
writing my own patch could be a big ask for me. Could someone please
tell/help/point me in the right direction, to get an initrd image for
selinux and debian.
 

regards Max Barwell


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
