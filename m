Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t91MWALo005322
 for <selinux@tycho.nsa.gov>; Thu, 1 Oct 2015 18:32:12 -0400
From: Paul Moore <pmoore@redhat.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-audit@redhat.com, Paul Osmialowski <p.osmialowsk@samsung.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: auditing kdbus service names
Date: Thu, 01 Oct 2015 18:32:05 -0400
Message-ID: <22922684.UpyKycrUO2@sifl>
In-Reply-To: <2836805.Af3VO2DWPn@x2>
References: <3754565.WlII3JJvve@sifl> <1988863.rx1nHfWkfd@sifl>
 <2836805.Af3VO2DWPn@x2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, August 13, 2015 04:40:52 PM Steve Grubb wrote:
> On Wednesday, August 12, 2015 10:48:10 PM Paul Moore wrote:
> > On Wednesday, August 12, 2015 05:38:14 PM Steve Grubb wrote:
> > > On Wednesday, August 12, 2015 08:40:34 AM Paul Moore wrote:
> > > > Hello all,
> > > > 
> > > > I'm currently working on a set of LSM hooks for the new kdbus IPC
> > > > mechanism and one of the things that I believe we will need to add is
> > > > a new audit field for the kdbus service name (very similar to the old
> > > > fashioned dbus service name).  I was thinking "kdbus_svc" for the
> > > > field name, any objections?
> > > 
> > > What was used on the old dbus events?
> > 
> > The very generic "service" field name, see the "acquire_svc" example in
> > the URL below.  I believe there is some value in picking a new field name
> > since 1) the field name is too generic in my opinion and 2) kdbus != dbus.
> 
> In my book, they are the same. They are programs providing services on the
> bus. One thing I noticed in the dbus events is that there are a number of
> user controlled fields that are not escaped.

Following up on this ...

Decided to just reuse "service" since the rest of the audit record will make 
it obvious (new obj class/perms) that the record if for a kdbus event and not 
a dbus event.  The next patchset will include the audit bits, I'll CC the 
patchset here.

-- 
paul moore
security @ redhat
