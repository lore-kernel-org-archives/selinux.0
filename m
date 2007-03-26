Subject: Re: Separating libselinux/libsepol (Was:  Re: BusyBox: load_policy
	applet)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Yuichi Nakamura <ynakam@hitachisoft.jp>, busybox@kaigai.gr.jp,
        selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <1174918097.3864.83.camel@moss-spartans.epoch.ncsc.mil>
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>
	 <1174654177.31436.188.camel@moss-spartans.epoch.ncsc.mil>
	 <20070326102809.e4f80126.ynakam@hitachisoft.jp>
	 <1174918097.3864.83.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 12:12:46 -0400
Message-Id: <1174925566.28830.61.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-03-26 at 10:08 -0400, Stephen Smalley wrote:
> On Mon, 2007-03-26 at 10:28 +0900, Yuichi Nakamura wrote:
> > On Fri, 23 Mar 2007 08:49:37 -0400
> > Stephen Smalley  wrote:
> > > On Fri, 2007-03-23 at 15:15 +0900, Yuichi Nakamura wrote:
> > > > Attached patch is to support load_policy for BusyBox.
> > > > load_policy is a program to load SELinux policy to kernel.
> > > > This applet is very important for SELinux, 
> > > > because SELinux is not activated until policy is loaded.
> > > > 
> > > > And this applet is _not_ based on latest load_policy, 
> > > > is based on old load_policy.
> > > > This is because the size of latest load_policy is bigger than old one,
> > > > and old load_policy has enough feature for embedded device.

> I wanted to discuss further your proposal to "separate" libsepol from
> libselinux (i.e. provide a build option for libselinux to allow building
> it without selinux_mkload_policy() and thus without a dependency on
> libsepol, IIUC).
> 
> I have a couple of concerns with that proposal:
[...]
> I'd also like to find out what you think about libsemanage and
> managed/modular policy in embedded environments, as mainstream selinux
> has migrated to using them entirely and we are considering dropping
> support for the old way of dealing with booleans and local users from
> libsepol and libselinux (see my prior [RFC] Drop setlocaldefs support
> from trunk posting on Feb 22).  That would require use of libsemanage
> and managed policy going forward for boolean manipulation, so if that is
> a problem for embedded, we need to know now.  And even if you think they
> are too heavy presently, we want to work toward enabling use of managed
> policy in those environments, so it would make sense to work on
> optimizing the size of libsemanage (or providing a build option for a
> cut-down version of it) and the size of the policy module store further
> (some improvements like removing the previous copy and linked policy
> file were already made, but others like bzip2 support and removing files
> from the module store after installation haven't yet been done, at least
> not completely - there are some RFC patches floating around). 

I'm not involved in what Yuichi and KaiGai are doing, so I can't speak
to their goals, but I figured I'd put in my $0.02.  The setup that I
have originated pre selinux-enabled busybox and pre managed policy
(example policy based).  I basically took busybox, libselinux (including
the util programs), policycoreutils (the C code pieces) and my
application, and jammed it into a little more than 8MB including the
kernel.

In my personal opinion, if you are really going tiny, that means its a
customized system, which includes customized policy.  That means you
should be setting the correct initial boolean values when you build the
policy, which also means monolithic instead of modular.  I took the
example policy,  removed a great deal of it and got a policy with less
than 8000 rules (actual rules since it was pre v20 policy), and sysadm
could still log in, and do a few admin tasks like toggle booleans,
restart the services and shutdown.  If you take refpolicy's kernel
layer, you get a little over 200 rules (v21 policy) and get a ~60k
binary policy, so its easy to get a tiny policy base to start on today.

So to summarize my rambling, my personal opinion is, embedded systems do
not use managed policy, therefore do not require libsemanage.  They do
not use a distro policy, but rather compile their own, therefore do not
use the setlocaldefs support.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
