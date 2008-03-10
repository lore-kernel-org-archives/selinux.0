Subject: Re: Problem compiling policy on Fedora 5.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: kihamba nengo <knengo@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <548571.73722.qm@web90404.mail.mud.yahoo.com>
References: <548571.73722.qm@web90404.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 10 Mar 2008 08:12:17 -0400
Message-Id: <1205151137.23866.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-03-10 at 04:36 -0700, kihamba nengo wrote:
> 
> Hi, 
> When i run make in the policy directory, i get the error below.How can
> i solve this problem? I am running Fedora 5, checkpolicy-1.32-1.
> 
> Compiling refpolicy policy.21
> WARNING: Policy version mismatch!  Is your OUTPUT_POLICY set
> correctly?
> 
> /usr/bin/checkpolicy policy.conf -o policy.21
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> tmp/rolemap.conf:1017:ERROR 'syntax error' at token 'ntfs-3g' on line
> 2430160:
> genfscon ntfs-3g / system_u:object_r:dosfs_t
> genfscon msdos / system_u:object_r:dosfs_t
> checkpolicy:  error(s) encountered while parsing configuration
> make: *** [policy.21] Error 1

You apparently are trying to build a newer source policy than your
checkpolicy supports.  There is naturally no guarantee that newer source
policies can be built with older checkpolicy versions.  You need to
either back up to an older policy source tree or move forward to a newer
checkpolicy.

Before we go too far down this road though, the first question is why do
you want to recompile the entire policy on Fedora 5?  Fedora 5 and later
support loadable policy modules, so you can actually build a policy
module with a set of local rules and load it without needing to rebuild
the entire policy at all.  You only need to rebuild the entire policy if
you are making a major change to policy, and even then, you ought to
build it modular rather than monolithic (set MONOLITHIC=n in build.conf
or put that on the make command line) so that you can continue to use
semodule and semanage to manage your policy.

If you want to upgrade your checkpolicy to the latest stable release,
you can download the libsepol and checkpolicy sources from:
 http://www.nsa.gov/selinux/code/download-stable.cfm
and then untar and build them.

It sounds like you tried to directly use the Fedora 6 checkpolicy binary
earlier, which generally isn't safe due to dependencies.  Safer to
either grab the upstream tarball and build it or grab the .src.rpm and
rebuild it on your system.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
