Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7VI0t2l027101
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2012 14:00:56 -0400
Received: by obbwd18 with SMTP id wd18so6962776obb.12
        for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2012 11:00:54 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 31 Aug 2012 11:00:53 -0700
Message-ID: <CACLa4puGhvVECrSKqnYFn2z-YpXEXTf+i=E78-6-SpDe09gAEQ@mail.gmail.com>
Subject: PCRE work and results
From: Eric Paris <eparis@parisplace.org>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The PCRE work looks like a huge win.  There is one patch left, to
autocompile the filecontexts if a user makes an update.  I'll work on
that.  At the moment you have to run something like

sefcontext_compile /etc/selinux/targeted/contexts/files/filecontexts

My results for a 'slow' action like restorecon -RvF / went from 14m
20s to 8m 15s.  This is pretty much all from using pcre instead of
glibc.  I never knew how much of our time was spent in cpu instead of
in disk.  But apparently it was noticeable.

My results for a 'fast' action like a single matchpathcon seems to go
from 0.09 sec to 0.02 seconds.  So about 4.5 times faster if the cpu
time is spent mostly loading and compiling regex's.

restorecon with the old pre-pcre and post-pcre changes found no
differences.  It doesn't mean we don't have any pattern that was wrong
or non-pcre compatible, but it at least works fine on an F18 install.
*smile*

winning.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
