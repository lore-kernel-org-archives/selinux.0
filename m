Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8II9kAG011668
	for <selinux@tycho.nsa.gov>; Wed, 18 Sep 2013 14:09:46 -0400
Received: by mail-vb0-f48.google.com with SMTP id w16so5433323vbf.21
        for <selinux@tycho.nsa.gov>; Wed, 18 Sep 2013 11:09:44 -0700 (PDT)
Message-ID: <1379527776.3032.56.camel@localhost>
Subject: Re: [PATCH] selinux: add Paul Moore as a SELinux maintainer
From: Eric Paris <eparis@parisplace.org>
To: Paul Moore <pmoore@redhat.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 18 Sep 2013 14:09:36 -0400
In-Reply-To: <13288872.e4rikYWUTT@sifl>
References: <20130918171403.24618.84645.stgit@localhost>
	 <1379524979.3032.53.camel@localhost> <13288872.e4rikYWUTT@sifl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2013-09-18 at 14:05 -0400, Paul Moore wrote:

> I believe everything should be fixed now, take a look and if I've messed 
> something up again, let me know.

You used merge instead of rebase, but either way is fine.  Send an
e-mail to sfr@canb.auug.org and ask him to pull your tree (be sure to
tell him which branch) and to drop my tree.  It should also go to
linux-next@vger.kernel.org and cc me.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
