Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4TIsFU8010722
 for <selinux@tycho.nsa.gov>; Mon, 29 May 2017 14:54:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DD0E320B1C
 for <selinux@tycho.nsa.gov>; Mon, 29 May 2017 18:53:53 +0000 (UTC)
Date: Mon, 29 May 2017 14:53:48 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: SElinux list <selinux@tycho.nsa.gov>
Subject: Access Vector Cache initialization audit message
Message-ID: <20170529185348.GW6203@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi, 
  
On kernel Access Vector Cache (AVC) initialization, there is an audit KERNEL 
type message logged to announce this fact.

The general format of audit messages are label=value pair fields.  Steve Grubb 
has been asking to have these records normalized by having a predictable set of 
field labels present.

There already exists an audit KERNEL message giving audit state which has been 
normalized thus:
        "state=initialized audit_enabled=%u res=1"

The AVC initialization audit message doesn't currently fit that format:
        "AVC INITIALIZED"

I'd created an issue to normalize the AVC initialization along these lines or 
to have it move to a new message type and Paul Moore is questioning whether
this message is required at all:
        https://github.com/linux-audit/audit-kernel/issues/48

Can this message simply be eliminated?

Thanks!


- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
