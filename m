Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7FFqtWM006841
 for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2014 11:53:01 -0400
Received: by mail-yk0-f193.google.com with SMTP id 142so545678ykq.8
 for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2014 08:53:07 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 15 Aug 2014 09:53:07 -0600
Message-ID: <CAPubmWV2PvEsnsuAKLZ6N-v2t8ySMQwq_NSb3qT8Gmm+2dYWpw@mail.gmail.com>
Subject: Lots of audits for "selinux_audit_rule_match: stale rule"
From: Andrew Ruch <adruch2002@gmail.com>
To: SELinux ML <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This issue came up on the Audit mailing list when trying to figure out
why my audit queues were being overwhelmed. I'm running RHEL 6.5.

Sometimes when I run a command like "semanage user -a ...", I'm
receiving 15000+ audit events. Most of the events are
"selinux_audit_rule_match: stale rule".  I can see in services.c in
the kernel code how 'latest_granting' is being incremented when the
policy is being loaded. What I don't understand is why I only
sometimes see these errors when I run the command. Is there anything I
can do to prevent getting in this state?

Thanks,
Andrew Ruch
