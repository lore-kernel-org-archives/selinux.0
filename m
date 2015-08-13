Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7D2mZPF001469
 for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2015 22:48:35 -0400
From: Paul Moore <pmoore@redhat.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-audit@redhat.com, Paul Osmialowski <p.osmialowsk@samsung.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: auditing kdbus service names
Date: Wed, 12 Aug 2015 22:48:10 -0400
Message-ID: <1988863.rx1nHfWkfd@sifl>
In-Reply-To: <18456537.MDqL7RWdSn@x2>
References: <3754565.WlII3JJvve@sifl> <18456537.MDqL7RWdSn@x2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, August 12, 2015 05:38:14 PM Steve Grubb wrote:
> On Wednesday, August 12, 2015 08:40:34 AM Paul Moore wrote:
> > Hello all,
> > 
> > I'm currently working on a set of LSM hooks for the new kdbus IPC
> > mechanism
> > and one of the things that I believe we will need to add is a new audit
> > field for the kdbus service name (very similar to the old fashioned dbus
> > service name).  I was thinking "kdbus_svc" for the field name, any
> > objections?
> 
> What was used on the old dbus events?

The very generic "service" field name, see the "acquire_svc" example in the 
URL below.  I believe there is some value in picking a new field name since 1) 
the field name is too generic in my opinion and 2) kdbus != dbus.

 * http://lists.freedesktop.org/archives/dbus/2004-November/001728.html

-- 
paul moore
security @ redhat
