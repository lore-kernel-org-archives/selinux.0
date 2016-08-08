Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u78HfhBw009729
 for <selinux@tycho.nsa.gov>; Mon, 8 Aug 2016 13:41:43 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A560446202
 for <selinux@tycho.nsa.gov>; Mon,  8 Aug 2016 17:41:31 +0000 (UTC)
Received: from dhcp-10-19-62-196.boston.devel.redhat.com
 (dhcp-25-88.bos.redhat.com [10.18.25.88])
 by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 u78HfVEW006230
 for <selinux@tycho.nsa.gov>; Mon, 8 Aug 2016 13:41:31 -0400
To: SELinux <selinux@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Subject: Any way to label /proc/self/mem with a different type then the
 process type.
Message-ID: <8f97fb23-65b5-bef5-bbae-f6139a2766f4@redhat.com>
Date: Mon, 8 Aug 2016 13:41:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I have been requested by some container people to make this only
readable not writable to prevent certain types of attacks on the

kernel.  No idea if this is a good idea or not.
