Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97DRZWt011243
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 09:27:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h97DRX0p026636
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 13:27:33 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h97DRWr7026628
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 13:27:32 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 8F7E992472
	for <selinux@tycho.nsa.gov>; Tue,  7 Oct 2003 23:27:26 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 83D357F09C
	for <selinux@tycho.nsa.gov>; Tue,  7 Oct 2003 23:27:19 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: mkinitrd on Debian
Date: Tue, 7 Oct 2003 23:27:18 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_28rg/Bfu/V5L5KN"
Message-Id: <200310072327.18877.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_28rg/Bfu/V5L5KN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

If you copy the attached script into /etc/mkinitrd/scripts on a Debian system 
then it should support building a correct initrd for the new SE Linux.

Should being the operative word, as I have not converted any Debian systems 
which support initrd to the new SE Linux I could not properly test this.

Let me know how it works.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_28rg/Bfu/V5L5KN
Content-Type: application/x-shellscript;
  name="selinux-mkinitrd"
Content-Transfer-Encoding: 7bit
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

--Boundary-00=_28rg/Bfu/V5L5KN--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
