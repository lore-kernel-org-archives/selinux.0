Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2PLLj4S013700
 for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2014 17:21:45 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5E6B321379
 for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2014 17:21:33 -0400 (EDT)
Date: Tue, 25 Mar 2014 21:17:30 +0000
From: Colin Walters <walters@verbum.org>
Subject: Re: SELinux policy updates in a post-%post world
To: Stephen Smalley <sds@tycho.nsa.gov>
Message-Id: <1395782490.32359.2@mail.messagingengine.com>
In-Reply-To: <5331B955.6010600@tycho.nsa.gov>
References: <1395712688.13975.4@mail.messagingengine.com>
 <5331B955.6010600@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-bK05GBRBSDp9pqtvNv1J"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-bK05GBRBSDp9pqtvNv1J
Content-Type: text/plain; charset=utf-8; format=flowed



On Tue, Mar 25, 2014 at 1:13 PM, Stephen Smalley <sds@tycho.nsa.gov> 
wrote:
> 
> Can you explain when/why you cannot run semodule -B?  As long as you
> also pass it -n and -s <store-name> and possibly -p <rootpath>, it
> should work and should not affect the running system until reboot or
> next policy load.

Right.  The first reason is at the moment I have an update system that 
*has no %post at all*.  It's much less flexible than traditional 
packages, but is much more reliable.

I have two high level concerns:
1) If I'm running arbitrary code, I want it to be started by systemd 
and ensure any log messages from it go to the journal, any error code 
is tracked, any processes started are properly cleaned up, etc.  Were I 
to add a %post type thing I'd likely use systemd-nspawn for this to 
ensure that /proc is mounted and all other requirements are met.

On the other hand, if it's just SELinux for now I may just commit 
support into the ostree core to recompile the policy in the new root 
directly from the main process and not fork off any other tool.

2) External tools may not match the "fdatasync policy".  Looking at the 
implementation of semanage_direct_commit() in 
selinux/libsemanage/src/direct_api.c, we create empty files, but don't 
open the parent directory fd and sync it.  Similarly, 
semanage_write_policydb() appears to just use fclose() and does not 
attempt to fdatasync() the policy file on disk.

This has been a real world problem with other triggers like 
gtk-update-icon-cache.  RPM is pretty careful to fdatasync() files it 
writes to disk.  But until:
https://git.gnome.org/browse/gtk+/commit/?id=6c6b49392629a8ee2facafb66c8867a49a3e9036
if you pulled the power after RPM said a "transaction" was complete, 
you could end up with a corrupted icon cache.

Now I admit, right now in OSTree I am simply doing a global sync() 
before swapping the bootloader configuration:
https://git.gnome.org/browse/ostree/tree/src/libostree/ostree-sysroot-deploy.c#n692

But that's a short term hack since sync() doesn't return errors, and it 
forces a flush of *everything* which can be a major performance hit.

On the other hand, there are cases where we *don't* want to 
fdatasync(), like constructing mock/pbuilder type build roots.  Some 
discussion here:
https://bugs.freedesktop.org/show_bug.cgi?id=70366

> Effectively semodule -B is performing a merge, by merging any local
> policy customizations into the updated policy.  You do want the merge
> because the updated policy may include changes required for the 
> updated
> system components, while the local customizations may be required for
> system operation (e.g. local file_contexts entries, boolean settings,
> login mappings, added allow rules for third party software or
> non-standard configurations), so using either just the modified policy
> from before the upgrade or just the unmodified updated policy could
> leave the system in a non-functional state.

Right, absolutely.  I want policy updates to work with local 
configuration as they do with traditional packages.  I also want 
upgrades to be fully atomic.  The goal is to do both =)



--=-bK05GBRBSDp9pqtvNv1J
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable



<br><br>On Tue, Mar 25, 2014 at 1:13 PM, Stephen Smalley &lt;sds@tycho.nsa.=
gov&gt; wrote:<br>
<blockquote type=3D"cite"><div class=3D"plaintext" style=3D"white-space: pr=
e-wrap;">
Can you explain when/why you cannot run semodule -B?  As long as you
also pass it -n and -s &lt;store-name&gt; and possibly -p &lt;rootpath&gt;,=
 it
should work and should not affect the running system until reboot or
next policy load.</div></blockquote><div><br></div><div>Right. &nbsp;The fi=
rst reason is at the moment I have an update system that *has no %post at a=
ll*. &nbsp;It's much less flexible than traditional packages, but is much m=
ore reliable.</div><div><br></div><div>I have two high level concerns:</div=
><div>1) If I'm running arbitrary code, I want it to be started by systemd =
and ensure any log messages from it go to the journal, any error code is tr=
acked, any processes started are properly cleaned up, etc. &nbsp;Were I to =
add a %post type thing I'd likely use systemd-nspawn for this to ensure tha=
t /proc is mounted and all other requirements are met.</div><div><br></div>=
<div>On the other hand, if it's just SELinux for now I may just commit supp=
ort into the ostree core to recompile the policy in the new root directly f=
rom the main process and not fork off any other tool.</div><div><br></div><=
div>2) External tools may not match the "fdatasync policy". &nbsp;Looking a=
t the implementation of semanage_direct_commit() in selinux/libsemanage/src=
/direct_api.c, we create empty files, but don't open the parent directory f=
d and sync it. &nbsp;Similarly, semanage_write_policydb() appears to just u=
se fclose() and does not attempt to fdatasync() the policy file on disk.</d=
iv><div><br></div><div>This has been a real world problem with other trigge=
rs like gtk-update-icon-cache. &nbsp;RPM is pretty careful to fdatasync() f=
iles it writes to disk. &nbsp;But until:</div><div><a href=3D"https://git.g=
nome.org/browse/gtk+/commit/?id=3D6c6b49392629a8ee2facafb66c8867a49a3e9036"=
>https://git.gnome.org/browse/gtk+/commit/?id=3D6c6b49392629a8ee2facafb66c8=
867a49a3e9036</a></div><div>if you pulled the power after RPM said a "trans=
action" was complete, you could end up with a corrupted icon cache.</div><d=
iv><br></div><div>Now I admit, right now in OSTree I am simply doing a glob=
al sync() before swapping the bootloader configuration:</div><div><a href=
=3D"https://git.gnome.org/browse/ostree/tree/src/libostree/ostree-sysroot-d=
eploy.c#n692">https://git.gnome.org/browse/ostree/tree/src/libostree/ostree=
-sysroot-deploy.c#n692</a></div><div><br></div><div>But that's a short term=
 hack since sync() doesn't return errors, and it forces a flush of *everyth=
ing* which can be a major performance hit.</div><div><br></div><div>On the =
other hand, there are cases where we *don't* want to fdatasync(), like cons=
tructing mock/pbuilder type build roots. &nbsp;Some discussion here:</div><=
div><a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D70366">https:=
//bugs.freedesktop.org/show_bug.cgi?id=3D70366</a></div><div><br></div><blo=
ckquote type=3D"cite"><div class=3D"plaintext" style=3D"white-space: pre-wr=
ap;">Effectively semodule -B is performing a merge, by merging any local
policy customizations into the updated policy.  You do want the merge
because the updated policy may include changes required for the updated
system components, while the local customizations may be required for
system operation (e.g. local file_contexts entries, boolean settings,
login mappings, added allow rules for third party software or
non-standard configurations), so using either just the modified policy
from before the upgrade or just the unmodified updated policy could
leave the system in a non-functional state.</div></blockquote><br><div>Righ=
t, absolutely. &nbsp;I want policy updates to work with local configuration=
 as they do with traditional packages. &nbsp;I also want upgrades to be ful=
ly atomic. &nbsp;The goal is to do both =3D)</div><div><br></div>=

--=-bK05GBRBSDp9pqtvNv1J--
