Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s46Hl0jA018339
 for <selinux@tycho.nsa.gov>; Tue, 6 May 2014 13:47:00 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id DDA951A071
 for <selinux@tycho.nsa.gov>; Tue,  6 May 2014 19:46:56 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id EknSctT1hPbC for <selinux@tycho.nsa.gov>;
 Tue,  6 May 2014 19:46:54 +0200 (CEST)
Received: from soldur.bigon.be (ip-83-134-183-90.dsl.scarlet.be
 [83.134.183.90])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id A88B51A052
 for <selinux@tycho.nsa.gov>; Tue,  6 May 2014 19:46:54 +0200 (CEST)
Date: Tue, 6 May 2014 19:46:49 +0200
From: Laurent Bigonville <bigon@debian.org>
To: <selinux@tycho.nsa.gov>
Subject: PAM modules ordering
Message-ID: <20140506194649.2f3aa358@soldur.bigon.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

I was wondering, is there a list of pam modules that need to be called
between pam_selinux close/open?

On Fedora I see pam_loginuid, but are there other modules that must be
in between, or can all the other modules be after the "pam_selinux
open" one?

Cheers,

Laurent Bigonville
