Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA1BoYDf017051
 for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2016 07:50:35 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E1BBF85540
 for <selinux@tycho.nsa.gov>; Tue,  1 Nov 2016 11:50:32 +0000 (UTC)
Received: from dhcp-10-19-62-196.boston.devel.redhat.com
 (dhcp-25-17.bos.redhat.com [10.18.25.17])
 by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 uA1BoWDX014073
 for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2016 07:50:32 -0400
To: SELinux <selinux@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Subject: Discussion on setting the /proc/self/oom_score_adj file label.
Message-ID: <649de230-05ee-5b12-70dd-ac4f64cf9020@redhat.com>
Date: Tue, 1 Nov 2016 07:50:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I wrote a blog http://danwalsh.livejournal.com/75282.html which talks
about chrome sandbox and its attempt to change its parents oom_score_adj
value.  Which is labeled unconfined_t, the question has come up on
Twitter to be able to change the label on just this object.

I think we discussed this before, but how difficult would it be to
change individual file labels under /proc/self/?
