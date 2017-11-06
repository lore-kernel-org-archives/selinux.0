Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vA6Frmsk007275
 for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2017 10:53:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4EE80806B0
 for <selinux@tycho.nsa.gov>; Mon,  6 Nov 2017 15:00:47 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C48195D979
 for <selinux@tycho.nsa.gov>; Mon,  6 Nov 2017 15:00:46 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon,  6 Nov 2017 16:00:37 +0100
Message-Id: <20171106150040.25300-1-plautrba@redhat.com>
In-Reply-To: <20171103082211.GA8075@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <20171103082211.GA8075@pl-rpi.tpb.lab.eng.brq.redhat.com>
Subject: Re: [PATCH] python/semanage: Do not try to reload policy
 when SELinux is disabled
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

First two patches do a little cleanup and try to re factorize the code
used for seobject object initialization.

The 3rd patch changes the behavior in order to call
semanage_set_reload() only if -N is used.
