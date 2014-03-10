Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2ALjb4K031427
 for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2014 17:45:37 -0400
Received: by mail-qg0-f41.google.com with SMTP id i50so18021915qgf.0
 for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2014 14:45:36 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: nguyen thai <thai.bkset@gmail.com>
Subject: Re: Detail description of some projects in TO DO list page
Date: Mon, 10 Mar 2014 17:45:33 -0400
Message-ID: <2911268.ly5TttHi39@sifl>
In-Reply-To: <CACBeRbY32sYaN8LWKxQ5f=6kyV6_dNgdhVkesTV07i-DRwkKrA@mail.gmail.com>
References: <CACBeRbb2fZCWgH93aJ61nfkCCZoJSG3aeaW=9ODSccVXzRQ9xg@mail.gmail.com>
 <52FB8288.1080004@tycho.nsa.gov>
 <CACBeRbY32sYaN8LWKxQ5f=6kyV6_dNgdhVkesTV07i-DRwkKrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Monday, March 10, 2014 02:31:29 PM nguyen thai wrote:
> On Wed, Feb 12, 2014 at 9:17 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 02/11/2014 09:24 PM, nguyen thai wrote:
> >> Hi everyone,
> >> 
> >> I have started my study in SELinux recently. I found some projects in TO
> >> DO
> >> list page were really interesting. Can anyone give me more details
> >> (what's
> >> problem now? it's effects or drawbacks) of one of following projects or
> >> any
> >> other projects that i can start to work on?
> >> 
> >>  - Investigate security policy for cgroups
> >>  - CIFS support for single-context clients
> >>  - Real device labeling and access control
> >> 
> >> Thank you very much.
> > 
> > That TODO list is old and not actively maintained, so it may be better
> > to look at recent mailing list archives to see areas where you can
> > contribute most effectively.  Also look for recent discussions of
> > selinux in the linux-security-module and linux-kernel mailing list
> > archives.
> > 
> > On the cgroup item, it should be possible to support finer-grained
> > labeling of cgroup files now that cgroup supports xattrs, but it will
> > require a small kernel change (similar to the changes previously made
> > for sysfs and rootfs; need to generalize that), and thereby enabling
> > policy control over specific cgroup files.  There may also be work
> > required inside the cgroup code to add security hooks and permission
> > checks for MAC; that would require analysis of the cgroup
> > implementation, existing DAC checks, ways in which they can permit
> > different security labels to interact/interfere with each other, etc.
> 
> Hi,
> I have spent several weeks on digging into cgroup code and its problems.
> As i understand, there are several reasons why you want to enable MAC
> checks over specific cgroup file:
> 
> + The cgroup interface is filesystem, means that users can change
> permissions on subdirectories and
>    give access to a non-privileged security domain, ie non-root users.
> Leading to an individual application
>    can interact directly with the cgroup filesystem. It ends up
> exposing control knobs which are tightly
>    coupled to kernel implementation details right into lay binaries
> and scripts directly used by end users.
> 
> + The cgroups trees are a shared resource. Many applications can use
> it simultaneously. So they can
>    conflicts with others. Ex, move tasks, delete or move the cgroups
> that belong to  other applications.
> 
> MAC check can improve some of the cgroup problems. But I've heard that
> cgroup and systemd developers have
> been making really big changes to fix these cgroup problems. As they
> described here
> http://lists.freedesktop.org/archives/systemd-devel/2013-June/011521.html
> or http://www.freedesktop.org/wiki/Software/systemd/ControlGroupInterface/
> They are creating a centralized userland authority which takes full
> ownership of the cgroup filesystem
> interface, and makes policy decisions based on configuration and
> requests. This may solve above problems.
> 
> So does implementing MAC checks on cgroup can is needed anymore? Can
> it help improving some other problems?
> I'm getting stuck finding something to do here.

I think it might make sense to first look at what you are hoping to 
accomplish, not in terms of code/hooks/etc., but rather high-level access 
controls.  Try not to focus on the implementation to start, for example:

* What can one do with cgroups, how are they managed?  Of all the different 
configuration/management operations, which are significant from a security 
perspective?

* For each of these operations, what is the SELinux subject and object?  What 
would the security policy look like?  Does it make sense?

... and go from there.

-- 
paul moore
www.paul-moore.com
