Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2P1wBnX031905
 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2014 21:58:11 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 955B020833
 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2014 21:58:09 -0400 (EDT)
Received: from [192.168.1.5] (unknown [66.31.18.51])
 by mail.messagingengine.com (Postfix) with ESMTPA id 4D741680156
 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2014 21:58:09 -0400 (EDT)
Date: Tue, 25 Mar 2014 01:54:08 +0000
From: Colin Walters <walters@verbum.org>
Subject: SELinux policy updates in a post-%post world
To: selinux@tycho.nsa.gov
Message-Id: <1395712688.13975.4@mail.messagingengine.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-rhOoYAQQBHjyDbIN9T9o"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-rhOoYAQQBHjyDbIN9T9o
Content-Type: text/plain; charset=utf-8; format=flowed

Hi,

I mentioned OSTree earlier here.  An issue came up with the SELinux 
integration; to understand it, let me describe how OSTree upgrades work:

1) We perform an rsync-like[1] process to a *new* chroot
2) A "basic" configuration merge is done - we take the new /etc 
defaults, and apply any modified files on top

Note that the policy.19 file is in /etc.

Crucially, there is at present no %post/postinst type functionality.  
This is a dramatic increase in reliability over traditional packages.  
No shell script run as root copy/pasted or just copied from elsewhere 
appended to everything.

For things like /usr/lib/ld.so.cache which is just a cache, this works 
fine because it's just referencing things in /usr/lib - it's all 
precomputed on the compose server.

Now, at least the Fedora selinux-policy has a %post that runs "semodule 
-B" which recompiles the policy (if the client machine has modified it 
locally).

Currently with OSTree, what will happen is it will notice the policy.19 
file is a modified file in /etc, and simply carry it forward.  In other 
words, updates to the base policy have no effect once the admin has 
modified it locally.

Administrators *can* rerun "semodule -B" manually after booting into 
the new root to recompile.

Why can't I just add a %post concept to OSTree?  Well, I could.  But 
I'd like to try as hard as conceivably possible to avoid it, and even 
then only do it where all other avenues are exhausted.  For one thing, 
it would break the ability to do completely offline updates (e.g. open 
up a VM guest disk from the host, and update it).  This ability is 
presently used to great effect in the testing system.

The primary alternative to %post is a "dynamic merge".  For example, 
systemd has a design where the default unit files are in 
/usr/lib/system, and then "dropins" can customize them in 
/etc/systemd/system.  On boot, it unions the two.

Similarly, I added /usr/lib/passwd in addition to /etc/passwd:
https://sourceware.org/bugzilla/show_bug.cgi?id=16142

However...I'm uncertain about doing this for SELinux policy.  The 
policy load happens very early in userspace setup and it's a complex 
task.

One option is to recompile the policy if we can (we're doing an upgrade 
from inside a running system, just chroot to new deployment and rerun 
semodule), and throw an error if we can't do it (the offline upgrade 
case).  The latter would only occur when a machine has a modified 
policy, which doesn't happen for my testing system.

Any other ideas?

[1] It doesn't share any code with rsync, but the details are 
irrelevant for this purpose

--=-rhOoYAQQBHjyDbIN9T9o
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I mentioned OSTree earlier here. &nbsp;An issue came=
 up with the SELinux integration; to understand it, let me describe how OST=
ree upgrades work:</div><div><br></div><div>1) We perform an rsync-like[1] =
process to a *new* chroot</div><div>2) A "basic" configuration merge is don=
e - we take the new /etc defaults, and apply any modified files on top</div=
><div><br></div><div>Note that the policy.19 file is in /etc.</div><div><br=
></div><div>Crucially, there is at present no %post/postinst type functiona=
lity. &nbsp;This is a dramatic increase in reliability over traditional pac=
kages. &nbsp;No shell script run as root copy/pasted or just copied from el=
sewhere appended to everything.</div><div><br></div><div>For things like /u=
sr/lib/ld.so.cache which is just a cache, this works fine because it's just=
 referencing things in /usr/lib - it's all precomputed on the compose serve=
r.</div><div><br></div><div>Now, at least the Fedora selinux-policy has a %=
post that runs "semodule -B" which recompiles the policy (if the client mac=
hine has modified it locally).</div><div><br></div><div>Currently with OSTr=
ee, what will happen is it will notice the policy.19 file is a modified fil=
e in /etc, and simply carry it forward. &nbsp;In other words, updates to th=
e base policy have no effect once the admin has modified it locally.</div><=
div><br></div><div>Administrators *can* rerun "semodule -B" manually after =
booting into the new root to recompile.</div><div><br></div><div>Why can't =
I just add a %post concept to OSTree? &nbsp;Well, I could. &nbsp;But I'd li=
ke to try as hard as conceivably possible to avoid it, and even then only d=
o it where all other avenues are exhausted. &nbsp;For one thing, it would b=
reak the ability to do completely offline updates (e.g. open up a VM guest =
disk from the host, and update it). &nbsp;This ability is presently used to=
 great effect in the testing system.</div><div><br></div><div>The primary a=
lternative to %post is a "dynamic merge". &nbsp;For example, systemd has a =
design where the default unit files are in /usr/lib/system, and then "dropi=
ns" can customize them in /etc/systemd/system. &nbsp;On boot, it unions the=
 two.</div><div><br></div><div>Similarly, I added /usr/lib/passwd in additi=
on to /etc/passwd:</div><div><a href=3D"https://sourceware.org/bugzilla/sho=
w_bug.cgi?id=3D16142">https://sourceware.org/bugzilla/show_bug.cgi?id=3D161=
42</a></div><div><br></div><div>However...I'm uncertain about doing this fo=
r SELinux policy. &nbsp;The policy load happens very early in userspace set=
up and it's a complex task.</div><div><br></div><div>One option is to recom=
pile the policy if we can (we're doing an upgrade from inside a running sys=
tem, just chroot to new deployment and rerun semodule), and throw an error =
if we can't do it (the offline upgrade case). &nbsp;The latter would only o=
ccur when a machine has a modified policy, which doesn't happen for my test=
ing system.</div><div><br></div><div>Any other ideas?</div><div><br></div><=
div>[1] It doesn't share any code with rsync, but the details are irrelevan=
t for this purpose</div>=

--=-rhOoYAQQBHjyDbIN9T9o--
