Message-ID: <1484318901.32375.32.camel@tycho.nsa.gov>
Subject: Re: [PATCH] restorecon manpage: link back to fixfiles
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>, selinux@tycho.nsa.gov
Date: Fri, 13 Jan 2017 09:48:21 -0500
In-Reply-To: <6cd88833-0af5-c935-3c8f-04afc000ceff@gmail.com>
References: <20170111124110.5721-1-alan.christopher.jenkins@gmail.com>
 <20170111124110.5721-2-alan.christopher.jenkins@gmail.com>
 <1484251293.16361.3.camel@tycho.nsa.gov>
 <8194a97b-705d-d147-854a-32f95187bc6d@gmail.com>
 <1484256222.16361.23.camel@tycho.nsa.gov>
 <6cd88833-0af5-c935-3c8f-04afc000ceff@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-01-12 at 23:42 +0000, Alan Jenkins wrote:
> My main puzzle here[*] is why `fixfiles` handles sysfs (/sys/) fine,
> but 
> then there's floods of warnings about debugfs
> (/sys/kernel/debug/).  The 
> same seems to happen with /dev/ being fine, but not the other
> virtual 
> fs's with seclabel which are mounted in subdirectories of /dev/.

This is a bug/regression.  Thanks for reporting it.  In commit
36f1ccbb5743749c404ad8f960867923544b90d9, Dan added this warning but
only if the user explicitly does a restorecon /path/to/foo and
/path/to/foo does not have any matching label in file_contexts; in the
case of a restorecon -R or setfiles, it isn't supposed to happen.  The
check on the recursive flag got dropped when this logic was taken into
selinux_restorecon(3) in libselinux
(commit f2e77865e144ab2e1313aa78d99b969f8f48695e).  Will fix.  The
reason it occurs for /sys/kernel/debug is that there is an explicit
entry in file_contexts that indicates that setfiles/restorecon should
not try to label anything under /sys/kernel/debug (/sys/kernel/debug/.*
<<none>>).

With regard to sysfs, a bit of historical context: originally all sysfs
nodes were created with a single security context, specified in kernel
policy. Later, we needed finer-grained control to support libvirt
labeling of specific nodes that needed to be accessible to VMs, so
support was added to permit userspace labeling of sysfs nodes (hence
restorecon/setfiles started working on sysfs).  Then in Android we
needed to label a number of sysfs nodes, so Android started doing the
equivalent of restorecon -R /sys on boot (using an optimization to
avoid walking parts of the sysfs tree that do not need to change from
the default).  Linux distributions don't do that presently but do label
a few specific sysfs nodes via /usr/lib/tmpfiles.d/selinux-policy.conf.
More recently, we introduced improved support in the kernel for per-
file labeling of sysfs nodes at creation time as well (based on
pathname from the root of sysfs), so we can specify those via genfscon
statements in policy.  So the kernel does assign an initial default,
but userspace retains the ability to override selectively (if
authorized by policy).

> What frustrates me is that `fixfiles check` generates this flood of 
> messages even immediately after `fixfiles restore`.  (Or
> equivalently, 
> that `fixfiles restore -v` does not converge to a smaller number of 
> messages).

Yes, agreed that we ought to fix that.

> 
> My use case was to install the latest version of some software from 
> source (fwupd), apply the labels expected by the distribution
> policy, 
> and also check what that involved.
> 
> I learnt about fixfiles from /usr/libexec/selinux/selinux-
> autorelabel.
> 
> (I notice the autorelabel script "handles" any messages by
> redirecting 
> to /dev/null.  But, it's using `fixfiles restore` without `-v`,
> which 
> doesn't generate these warnings.  It seems it would also miss out on
> the 
> nice percentage progress indicator. Weird).
> 
> Thanks
> Alan
> 
> [*] Ok, I was also surprised that fixfiles dug into my home
> directory.  
> It's happy with `touch /home/alan-sysop/t` (user_home_t), but after
> I 
> "move to wastebasket", it complains the file needs to marked as 
> data_home_t.  No idea what happens if you relabel and then try to 
> restore files from the wastebasket, e.g. `.ssh` or
> `public_html`.  But 
> then `public_html` doesn't seem to get labeled when I create it
> either.  
> Clearly there's something I don't understand.

Not sure about the different types on Trash vs Home.
But if I create public_html directory, it does get assigned
httpd_user_content_t automatically (probably a name-based type
transition or alternatively restorecond).
