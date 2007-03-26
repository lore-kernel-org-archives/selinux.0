Subject: Separating libselinux/libsepol (Was:  Re: BusyBox: load_policy
	applet)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: busybox@kaigai.gr.jp, selinux@tycho.nsa.gov,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <20070326102809.e4f80126.ynakam@hitachisoft.jp>
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>
	 <1174654177.31436.188.camel@moss-spartans.epoch.ncsc.mil>
	 <20070326102809.e4f80126.ynakam@hitachisoft.jp>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 10:08:17 -0400
Message-Id: <1174918097.3864.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-03-26 at 10:28 +0900, Yuichi Nakamura wrote:
> Hi.
> 
> On Fri, 23 Mar 2007 08:49:37 -0400
> Stephen Smalley  wrote:
> > On Fri, 2007-03-23 at 15:15 +0900, Yuichi Nakamura wrote:
> > > Attached patch is to support load_policy for BusyBox.
> > > load_policy is a program to load SELinux policy to kernel.
> > > This applet is very important for SELinux, 
> > > because SELinux is not activated until policy is loaded.
> > > 
> > > And this applet is _not_ based on latest load_policy, 
> > > is based on old load_policy.
> > > This is because the size of latest load_policy is bigger than old one,
> > > and old load_policy has enough feature for embedded device.
> > 
> > Hmm...are you sure?  Functionality that you are losing from the new load
> > policy logic that lives in libselinux these days:
> > - automatic discovery of the right policy file,
> > - automatic downgrading of the policy file format to the kernel
> > supported format if necessary (e.g. new policy, old kernel),
> > - loading of local user and/or boolean definitions (obsolete if you
> > choose to use libsemanage and managed policy, but not clear you are
> > doing that in embedded),
> > - preservation of boolean settings across a policy reload so they aren't
> > reset to the policy defaults.
> > 
> > Boolean management seems the greatest concern, and using policy booleans
> > on an embedded device to change policy states based on events /
> > environmental factors is quite reasonable.
> We wanted to prepare minimum(the smallest) load_policy at first.
> Boolean is useful as you say, 
> we will submit boolean support to BusyBox in the future, 
> as a separate CONFIG option.
> # And we have to prepare separating libselinux/libsepol..

(removed busybox list from the cc line, as I'm not subscribed to it and
this part of the discussion is likely not of interest to them)

I wanted to discuss further your proposal to "separate" libsepol from
libselinux (i.e. provide a build option for libselinux to allow building
it without selinux_mkload_policy() and thus without a dependency on
libsepol, IIUC).

I have a couple of concerns with that proposal:
1) I think you will ultimately need libsepol or some subset of it to
support booleans and other forms of local customization.  Hence, it may
be better to leave the dependency of libselinux on libsepol and work on
creating a minimal version of libsepol via a build option in it instead
as well as working to optimize its size in general.  As long as you are
using shared libraries and dynamic linking, you should only need one
instance of the libsepol code regardless of how many programs link
against it (or do you use static linking in that environment?).

2) selinux_mkload_policy() and selinux_init_load_policy() encapsulate
and standardize the policy loading logic, enabling us to evolve that
logic without needing to re-patch /sbin/init or the load_policy binary
in the future.  This includes not only things like finding the right
policy file, but also selecting the initial state for SELinux
(enabled/disabled, enforcing/permissive) based on both
the /etc/selinux/config file and the kernel command line arguments.  It
is desirable to keep that logic standard across all selinux systems if
possible.  If you omit them from your libselinux and re-introduce that
logic elsewhere (in your load_policy applet and your busybox init
functionality), there seems strong potential for divergence.  On the
initial policy load topic, I think Ubuntu is looking at handling it from
initramfs instead of init, see:
https://lists.ubuntu.com/archives/ubuntu-hardened/2007-March/000171.html
https://lists.ubuntu.com/archives/ubuntu-hardened/2007-March/000175.html
which might obviate the need for selinux_init_load_policy() in libselinux.

I'd also like to find out what you think about libsemanage and
managed/modular policy in embedded environments, as mainstream selinux
has migrated to using them entirely and we are considering dropping
support for the old way of dealing with booleans and local users from
libsepol and libselinux (see my prior [RFC] Drop setlocaldefs support
from trunk posting on Feb 22).  That would require use of libsemanage
and managed policy going forward for boolean manipulation, so if that is
a problem for embedded, we need to know now.  And even if you think they
are too heavy presently, we want to work toward enabling use of managed
policy in those environments, so it would make sense to work on
optimizing the size of libsemanage (or providing a build option for a
cut-down version of it) and the size of the policy module store further
(some improvements like removing the previous copy and linked policy
file were already made, but others like bzip2 support and removing files
from the module store after installation haven't yet been done, at least
not completely - there are some RFC patches floating around). 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
