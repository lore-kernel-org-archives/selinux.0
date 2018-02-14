Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1E9rqY6011953
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 04:53:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 3zhF986z60z4BPFY
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 09:53:48 +0000 (UTC)
Received: from UPBD19PA02.eemsg.mil (unknown [192.168.18.3])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 3zhF986TrKz4BPFW
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 09:53:48 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 14B12408501B
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 09:53:47 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AED8210073AA
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 09:53:46 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 14 Feb 2018 10:53:33 +0100
Message-Id: <20180214095337.1945-1-plautrba@redhat.com>
Subject: Update selinux-sepolgengui to be compatible with Gtk3,
 Python 3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

The following set of patches update polgengui.py, rename polgen.glade to
polgen.ui, convert it to new format, and fix some other sepolicy Python 3
related issues.

Thanks,

Petr
