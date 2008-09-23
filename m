Date: Wed, 24 Sep 2008 07:05:11 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul.moore@hp.com>
Subject: Re: [RFC][PATCH] selinux:  use default proc sid on symlinks
In-Reply-To: <1222181917.28396.8.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <alpine.LRH.1.10.0809240703300.31367@tundra.namei.org>
References: <1222112479.18735.85.camel@moss-spartans.epoch.ncsc.mil>  <alpine.LRH.1.10.0809232321390.28321@tundra.namei.org> <1222181917.28396.8.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Sep 2008, Stephen Smalley wrote:

> On Tue, 2008-09-23 at 23:21 +1000, James Morris wrote:
> > On Mon, 22 Sep 2008, Stephen Smalley wrote:
> > 
> > > Patch below for the recent /proc/net bug related to selinux thread on linux-kernel.
> > > If this looks sane, then possibly it should be re-sent on that thread.
> > > 
> > > As we are not concerned with fine-grained control over reading of
> > > symlinks in proc, always use the default proc SID for all proc symlinks.
> > > This should help avoid permission issues upon changes to the proc tree
> > > as in the /proc/net -> /proc/self/net example.
> > > This does not alter labeling of symlinks within /proc/pid directories.
> > > ls -Zd /proc/net output before and after the patch should show the difference.
> > 
> > I'm not seeing any difference.
> 
> Before the patch:
> $ ls -Zd /proc/net
> lrwxrwxrwx  root root system_u:object_r:proc_net_t:s0  /proc/net -> self/net
> 
> (/proc/net symlink has proc_net_t type due to matching net in
> genfs_contexts, and as legacy policy didn't expect any symbolic links to
> have proc_net_t, applications are denied access to read the symlink)
> 
> After the patch:
> $ ls -Zd /proc/net
> lrwxrwxrwx  root root system_u:object_r:proc_t:s0      /proc/net -> self/net
> 
> (/proc/net symlink has proc_t type due to always using default proc sid,
> and as legacy policy already allows domains to read proc_t:lnk_file to
> follow /proc/self, applications previously allowed to access /proc/net
> before it was changed to a symlink will just work)

Ok, it wasn't easy to spot after a flight across the Pacific :-)

Do you see any reaosn not to apply this to security-testing-2.6#next  ?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
