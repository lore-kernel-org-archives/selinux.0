Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5BFcqjG017826
 for <selinux@tycho.nsa.gov>; Thu, 11 Jun 2015 11:38:52 -0400
Received: by wibbw19 with SMTP id bw19so3950079wib.2
 for <selinux@tycho.nsa.gov>; Thu, 11 Jun 2015 08:38:50 -0700 (PDT)
Received: from siphos.be (ip-81-11-253-41.dsl.scarlet.be. [81.11.253.41])
 by mx.google.com with ESMTPSA id u6sm1588802wja.40.2015.06.11.08.38.48
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jun 2015 08:38:49 -0700 (PDT)
Sender: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Thu, 11 Jun 2015 17:38:31 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Why does semanage_migrate_store migrate file_contexts.local?
Message-ID: <20150611153831.GA15810@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I noticed that /var/lib/selinux/msc/active on my system contained a stale
file_contexts.local file. Whenever the policy is rebuild (using "semanage
-B") this file is moved along to the new active store.

However, the file_contexts.local that is used by the utilities (such as
matchpathcon, semanage fcontext, restorecon) is the one inside
/etc/selinux/mcs/contexts/files. I'm thus assuming that the
file_contexts.local file insode /var/lib/selinux/mcs/active can be removed.

Wkr,
        Sven Vermeulen
