Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4UDvv6F009197
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 09:57:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 40wscM4LnlzJ34F
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 13:57:55 +0000 (UTC)
Received: from UPDC3CPA09_EEMSG_MP25.eemsg.mil (unknown [192.168.18.20])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 40wscM30zTzJ344
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 13:57:55 +0000 (UTC)
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id F0DE21A0C0
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 15:57:50 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id qDiWPK5v11ZE for <selinux@tycho.nsa.gov>;
 Wed, 30 May 2018 15:57:25 +0200 (CEST)
Received: from [10.20.225.173] (unknown [193.53.238.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 7D2D01A055
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 15:57:25 +0200 (CEST)
To: selinux <selinux@tycho.nsa.gov>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <f4d97b61-c4b5-3e05-707b-242500e2848e@debian.org>
Date: Wed, 30 May 2018 15:57:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: system-config-selinux requires root to run
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

I was planning to readd system-config-selinux in the debian package now 
that it has been ported to GIR, python3 and GTK3.

But I realized that it requires root rights (via pkexec) to work.

The problem with that is that it doesn't work with wayland.

Are there any plans to decouple (evermore) the GUI and the backend that 
requires root?

Kind regards,

Laurent Bigonville
