Subject: Re: [RFC PATCH 1/2] fs/vfs/security: pass last path component to
 LSM on	inode creation
From: Eric Paris <eparis@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>,
        penguin-kernel@I-love.SAKURA.ne.jp
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk,
        hch@lst.de
In-Reply-To: <4CF9C1A1.7050603@schaufler-ca.com>
References: <20101203214518.30001.89859.stgit@paris.rdu.redhat.com>
	 <4CF9C1A1.7050603@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 04 Dec 2010 16:34:41 -0500
Message-ID: <1291498481.4929.77.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-12-03 at 20:20 -0800, Casey Schaufler wrote:
> On 12/3/2010 1:45 PM, Eric Paris wrote:
> > SELinux would like to implement a new labeling behavior of newly created
> > inodes.  We currently label new inodes based on the parent and the creating
> > process.  This new behavior would also take into account the name of the
> > new object when deciding the new label.  This is not the (supposed) full path,
> > just the last component of the path.
> 
> I see. Pathname based controls. In SELinux.

Actually you of (almost) all people shouldn't make this mistake.  There
is absolutely no pathname based controls being implemented.  This is an
extension of the object labeling model to facilitate and simply some
userspace issues related to the labeling of NEW objects.  SELinux very
much so is and will continue to be based solely on label based controls.
The intention is to remove some particularly gross userspace hacks
related to new object labeling (read udev/restorecond/anything to do
with /var/run, etc).  It simplifies userspace, removes numerous races,
and does so with no reduction in security (and theoretically the
possibility of a more secure system)

> > This is very useful because creating /etc/shadow is different than creating
> > /etc/passwd but the kernel hooks are unable to differentiate these
> > operations.
> 
> If I recall correctly, this has been the Apparmor/TOMOYO argument all along.

They are similar arguments but not at all the same.  Some people may not
understand the distinction between the initial labeling an object and
access controls.  If that distinction is not clear to anyone please let
me know.  They talk about access controls based on the name.  I'm only
talking about new object labeling.

> > We currently require that userspace realize it is doing some
> > difficult operation like that and that userspace jump through SELinux hoops
> > to get things set up correctly.  This patch does not implement new
> > behavior, that is obviously contained in a seperate SELinux patch, but it
> > does pass the needed name down to the correct LSM hook.  If no such name
> > exists it is fine to pass NULL.
> 
> Why can't you use the existing pathname hooks?

Because the pathname hooks are about pathname based access controls,
which I contend for both philosophical and technical reasons are not
appropriate.  Discussed more later.

> If you want pathname based behavior there are already two perfectly good
> LSMs that do that. Why do we need a third? Especially when the people who
> run SELinux have been so adamant that name based access controls have no
> place in the kernel?

Good thing I'm not adding name based access controls   :)

> Sure, you're just talking about the final component, but that's because
> you've already done user space labeling of the entire file system and are
> counting on standardized directory structures. Let's face it, outside the
> context of a specific distribution and an SELinux policy tailored to that
> distribution, final component name based controls do not have any kind of
> generality.

It's true that a relatively standard directory and naming structure is
helpful in getting the refpolicy to work.  But the tweaks to get SELinux
running on a new distro (assuming it uses PAM, sorry slackware) should
not huge.  If anything your argument is against pathname based systems,
not against label based LSMs or the patch in question.  I'm not sure
what point you were trying to make here.

> If you really have seen the light and believe that pathname based access
> controls have merit a scheme that is half based on labels and half based
> on final components can't possibly seem satisfactory.

Sadly I'm both still living in the dark and I agree with that statement
completely.  Pathname based access controls are not the best and a
hybrid model is no better.  

> Or am I missing something?

You are (and I'm guessing rather intentionally :-P)

[next message explains my thoughts]

On Sat, 2010-12-04 at 17:01 +0900, Tetsuo Handa wrote:
> /etc/shadow as an absolute pathname makes special meaning but etc_t + shadow
> does not always make special meaning. Using "struct dentry" instead of
> "struct qstr" is not sufficient, for it would be sufficient for /etc/shadow
> case because /etc/ directory is known to be within / partition but it is not
> sufficient for /etc/foo/etc/shadow case because /etc/foo/ directory is not
> always within / partition. Assigning shadow_t when creating /etc/foo/etc/shadow
> (where the pathname derived from "struct dentry" is /etc/shadow) is wrong.

(I should start by saying that there will likely never be a rule related
to /etc/shadow since it is rarely a newly created object, but I'm
willing to use it as my example, since most people reasonably understand
the security implications of it.)

You actually point out exactly the flaw of pathname based security, not
a problem with my new object labeling extension.  If the program
responsible for creating /etc/shadow is able to be tricked into
creating /etc/foo/shadow instead, that file is still going to contain
passwords and information that should be protected just like /etc/shadow
needs to be protected.  It's irrelevant if the pathname is wrong.  It's
about the data and the integrity/confidentiality of the data.  If that
file contains password data (or at least what something/someone thought
was password data) it should be protected exactly the same as the real
one.  We are at diametrically opposed view points on this and I doubt we
ever come to agree.  This patch makes no changes to SELinux in that
regard and I don't see such a change in the future.

I don't understand some of your logic (why does /etc have to be on the
same partition as /?  How can a useful struct dentry, much less a struct
path [I assume you meant path rather than vfsmount], exist before the
struct inode?) but those parts seem irrelevant.  Pathname based security
is (at least in my view) fundamentally flawed if you want to make real
security claims.  Label based security can make real guarantees (ok
Casey insert you snide comment about how SELinux policy is so large its
hard->impossible to analyze/make claims) but when implemented on
flexible systems (as opposed to to static systems such as those used in
3 letter gov't agencies) labeling is hard to do and this change makes it
easier.

Let me give some examples of where I plan to actually use this new
behavior.

devtmpfs/udev:  currently devtmpfs creates new char and block files
'magically' in /dev.  It does so with the label device_t because it
can't possibly know better.  It then calls up to hotplug, which call
udev, which does a pathname based check in userspace, and resets the
label to something better.  How horrific is that?  With this patch the
kernel can tell that mem != console and can just do the right thing,
race free.  'Really secure' installations don't use devtmpfs/udev and
instead have static premade /dev with proper labeling (yeah MAKEDEV!).
I'm fine if you are crazy enough to do that, but I'd rather live in the
modern world with tools that just work.

/var/run:  Lots of programs used to (and many still do) create files
directly in /var/run/.  We in the fedora land have urged packages to
use /var/run/[package name] because it made labeling easier to get
right.  This is SELinux forcing it's way of life onto userspace.
Something we would rather avoid if it's possible to automate.

~/.ssh:  When a user or even sshd creates the ~/.ssh directory the
kernel doesn't realize that this is different than creating the
directory "Downloads."  How do we solve that today?  We have a program
that puts an inotify watch on ~/.ssh when you log in and which will, as
fast as it can, relabel that directory to the correct label.  How much
crap is that?

SELinux from Red Hat out of the box (I can't speak definitely for not RH
based distros) fails on one of the major tenets of its own security
model.  It fails at label tranquility (aka once an object is labeled
that label never changes).  We have things which automatically and
dynamically relabel existing objects (I just mentioned two of them.)
I'd like to remove both of those exceptions, simplify userspace
applications, and in doing so bring the flexibility of a real usable
dynamic system to the security of one which meets something closer to a
statically labeled system....

Make sense?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
