Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3N1nZfL022022
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 21:49:35 -0400
Date: Tue, 22 Apr 2014 21:49:29 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: David Miller <davem@davemloft.net>, linux-audit@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/6][v2] audit: implement multicast socket for journald
Message-ID: <20140423014929.GL20182@madcap2.tricolour.ca>
References: <20140422.161904.1187535812839850973.davem@davemloft.net>
 <cover.1398215388.git.rgb@redhat.com>
 <20140422.214300.171999077259349189.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140422.214300.171999077259349189.davem@davemloft.net>
Cc: linux-security-module@vger.kernel.org, sgrubb@redhat.com, eparis@redhat.com,
 selinux@tycho.nsa.gov, hadi@mojatatu.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 14/04/22, David Miller wrote:
> From: Richard Guy Briggs <rgb@redhat.com>
> Date: Tue, 22 Apr 2014 21:31:52 -0400
> 
> > This is a patch set Eric Paris and I have been working on to add a restricted
> > capability read-only netlink multicast socket to kernel audit to enable
> > userspace clients such as systemd/journald to receive audit logs, in addition
> > to the bidirectional auditd userspace client.
> 
> Series applied, thanks Richard.

Thanks for your patience, David.  Can I assume you adopted the 3 audit
patches too, becuase of the dependence?

- RGB

--
Richard Guy Briggs <rbriggs@redhat.com>
Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545
