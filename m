Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w537Miib021963
 for <selinux@tycho.nsa.gov>; Sun, 3 Jun 2018 03:22:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 40z8fV6C0rz25sRv
 for <selinux@tycho.nsa.gov>; Sun,  3 Jun 2018 07:22:42 +0000 (UTC)
Received: from UPDC3CPA02.eemsg.mil (unknown [192.168.18.9])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 40z8fT0Mvfz25sRt
 for <selinux@tycho.nsa.gov>; Sun,  3 Jun 2018 07:22:41 +0000 (UTC)
From: Russell Coker <russell@coker.com.au>
To: Nick Kralevich <nnk@google.com>
Reply-To: russell@coker.com.au
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Sun, 03 Jun 2018 17:20:40 +1000
Message-ID: <1712013.6eZNtS9oRy@xev>
In-Reply-To: <CAFJ0LnHum9-xHsAOXgtiL16p2eCfPsUXo=P2hN+C55U5yLdGdw@mail.gmail.com>
References: <1556412.5WZ4KfFcyq@liv>
 <CAFJ0LnHum9-xHsAOXgtiL16p2eCfPsUXo=P2hN+C55U5yLdGdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Re: BTRFS losing SE Linux labels on power failure or "reboot -nffd".
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sunday, 3 June 2018 4:18:09 AM AEST Nick Kralevich wrote:
> Does BTRFS have the equivalent of an fsck command which is run on
> boot? I've seen similar problems before where fsck tries fixing up the
> filesystem after an unclean shutdown, and the SELinux labels aren't
> properly handled by the fsck program.

https://en.wikipedia.org/wiki/Btrfs

BTRFS is designed to be self-healing and has no equivalent to the Ext2/3/4 
fsck program.  /bin/fsck.btrfs is a shell script that returns 8 if the device 
doesn't exist and 0 in all other cases, it has a comment saying "You should 
set fs_passno to 0".

The design of BTRFS is similar to ZFS in that you expect to be able to push 
reset and have the system just work again with kernel code doing the recovery.

It's definitely a kernel bug.  The question is where the bug is and who will 
fix it.

Thanks for the suggestion though.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
