Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3N3tKCP029996
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 23:55:20 -0400
Date: Tue, 22 Apr 2014 23:55:15 -0400 (EDT)
Message-Id: <20140422.235515.1172733305552022632.davem@davemloft.net>
To: rgb@redhat.com
Subject: Re: [PATCH 0/6][v2] audit: implement multicast socket for journald
From: David Miller <davem@davemloft.net>
In-Reply-To: <20140423014929.GL20182@madcap2.tricolour.ca>
References: <cover.1398215388.git.rgb@redhat.com>
 <20140422.214300.171999077259349189.davem@davemloft.net>
 <20140423014929.GL20182@madcap2.tricolour.ca>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: hadi@mojatatu.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 eparis@redhat.com, linux-security-module@vger.kernel.org,
 linux-audit@redhat.com, selinux@tycho.nsa.gov, sgrubb@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Richard Guy Briggs <rgb@redhat.com>
Date: Tue, 22 Apr 2014 21:49:29 -0400

> On 14/04/22, David Miller wrote:
>> From: Richard Guy Briggs <rgb@redhat.com>
>> Date: Tue, 22 Apr 2014 21:31:52 -0400
>> 
>> > This is a patch set Eric Paris and I have been working on to add a restricted
>> > capability read-only netlink multicast socket to kernel audit to enable
>> > userspace clients such as systemd/journald to receive audit logs, in addition
>> > to the bidirectional auditd userspace client.
>> 
>> Series applied, thanks Richard.
> 
> Thanks for your patience, David.  Can I assume you adopted the 3 audit
> patches too, becuase of the dependence?

Yes.
