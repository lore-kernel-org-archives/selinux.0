Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3RKMiRb001060
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 16:22:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3RKKWZx015831
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 20:20:32 GMT
Received: from stingray.missi.ncsc.mil (stingray.missi.ncsc.mil [144.51.50.20])
	by jazzswing.ncsc.mil  with ESMTP id i3RKKVJv015825
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 20:20:31 GMT
Message-ID: <200404271949.i3RJntRK009239@stingray.missi.ncsc.mil>
From: CDSelle@missi.ncsc.mil
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
Subject: RE: mkinitrd on Debian
Date: Tue, 27 Apr 2004 16:23:23 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C42C95.7CFC3830"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C42C95.7CFC3830
Content-Type: text/plain;
	charset="iso-8859-1"

Russel,

We haven't met, but I'm a SELinux user trying to install on a Debian system.
Is the script you attached to this message in October still current, or is
there a better way to make a SELinux initrd for Debian sid systems now?

Thanks,
Chad Sellers



-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au]
Sent: Tuesday, October 07, 2003 9:27 AM
To: SE Linux
Subject: mkinitrd on Debian


If you copy the attached script into /etc/mkinitrd/scripts on a Debian
system 
then it should support building a correct initrd for the new SE Linux.

Should being the operative word, as I have not converted any Debian systems 
which support initrd to the new SE Linux I could not properly test this.

Let me know how it works.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


------_=_NextPart_000_01C42C95.7CFC3830
Content-Type: application/octet-stream;
	name="selinux-mkinitrd"
Content-Disposition: attachment;
	filename="selinux-mkinitrd"

#!/bin/sh

cp /etc/security/selinux/policy.15 $INITRDDIR
cp /usr/sbin/load_policy $INITRDDIR/sbin
mkdir $INITRDDIR/selinux
cat > $INITRDDIR/scripts/selinux << END
mount -n none -t selinuxfs /selinux
/sbin/load_policy /policy.15
umount -n /selinux
END
chmod 755 $INITRDDIR/scripts/selinux

------_=_NextPart_000_01C42C95.7CFC3830--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
