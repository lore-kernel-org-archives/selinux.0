Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3N3vwMJ030129
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 23:57:58 -0400
Message-ID: <1398225475.750.7.camel@localhost>
Subject: Re: [PATCH 0/6][v2] audit: implement multicast socket for journald
From: Eric Paris <eparis@redhat.com>
To: Steve Grubb <sgrubb@redhat.com>
Date: Tue, 22 Apr 2014 23:57:55 -0400
In-Reply-To: <26389161.vp9iWSVLPX@x2>
References: <20140422.161904.1187535812839850973.davem@davemloft.net>
 <cover.1398215388.git.rgb@redhat.com> <26389161.vp9iWSVLPX@x2>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-audit@redhat.com,
 selinux@tycho.nsa.gov, jamal@mojatatu.com, davem@davemloft.net
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2014-04-22 at 22:25 -0400, Steve Grubb wrote:
> On Tuesday, April 22, 2014 09:31:52 PM Richard Guy Briggs wrote:
> > This is a patch set Eric Paris and I have been working on to add a
> > restricted capability read-only netlink multicast socket to kernel audit to
> > enable userspace clients such as systemd/journald to receive audit logs, in
> > addition to the bidirectional auditd userspace client.
> 
> Do have the ability to separate of secadm_r and sysadm_r? By allowing this, we 
> will leak to a sysadmin that he is being audited by the security officer. In a 
> lot of cases, they are one in the same person. But for others, they are not. I 
> have a feeling this will cause problems for MLS systems.

Why?  This requires CAP_AUDIT_READ.  Just don't give CAP_AUDIT_READ to
places you don't want to have read permission.  Exactly the same as you
don't give CAP_AUDIT_CONTROL to sysadm_r.  (If we are giving
CAP_AUDIT_CONTROL to sysadm_r and you think that any file protections
on /var/log/audit/audit.log are adequate we are fooling ourselves!)

> Also, shouldn't we have an audit event for every attempt to connect to this 
> socket? We really need to know where this information is getting leaked to.

We certainly can.  What would you like to see in that event?

-Eric
