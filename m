Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3N1gtWf021774
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 21:43:03 -0400
Date: Tue, 22 Apr 2014 21:43:00 -0400 (EDT)
Message-Id: <20140422.214300.171999077259349189.davem@davemloft.net>
To: rgb@redhat.com
Subject: Re: [PATCH 0/6][v2] audit: implement multicast socket for journald
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1398215388.git.rgb@redhat.com>
References: <20140422.161904.1187535812839850973.davem@davemloft.net>
 <cover.1398215388.git.rgb@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com,
 linux-security-module@vger.kernel.org, linux-audit@redhat.com,
 selinux@tycho.nsa.gov, jamal@mojatatu.com, sgrubb@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Richard Guy Briggs <rgb@redhat.com>
Date: Tue, 22 Apr 2014 21:31:52 -0400

> This is a patch set Eric Paris and I have been working on to add a restricted
> capability read-only netlink multicast socket to kernel audit to enable
> userspace clients such as systemd/journald to receive audit logs, in addition
> to the bidirectional auditd userspace client.

Series applied, thanks Richard.
