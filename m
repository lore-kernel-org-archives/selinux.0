Subject: Re: xattr support in cgroupfs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Matthew Ife <deleriux@airattack-central.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1304118351.23317.1.camel@home.localdomain>
References: <1304118351.23317.1.camel@home.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 May 2011 08:49:26 -0400
Message-ID: <1304340566.16563.9.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2011-04-30 at 00:05 +0100, Matthew Ife wrote:
> I was wondering what peoples' thoughts where on doing this.
> 
> At the moment cgroupfs does not support xattrs so no labelling of selinux
> types is permitted, but since /proc and other pseudo filesystems support
> it this should be possible.

/proc doesn't actually support xattrs; the only reason you can do ls
-Z /proc is because SELinux gets to interpose on getxattr and provide a
synthetic result containing its attribute where the attribute itself is
determined from policy.  But you can't set an attribute on /proc from
userspace.

sysfs is a better example if you want full xattr support; there we have
implemented support for setxattr.  You should be able to use it as an
example of how to implement support for cgroupfs.

> There are a number of use-cases which would benefit from this. For
> example I have recently been working with application layer integration
> of libcgroup with other services (apache being able to switch
> cgroups for vhosts for example) because cgroups offer an excellent means
> of offering resource control to prevent abuse of resources.
> 
> Aa a typical example i'd like to be able to label some cgroups in
> cgroupfs as "httpd_cgroup_t" / "httpd_cgroup_task_t" so that I can
> control the access of the files it creates for administering tasks and
> altering what goes in the task list. But currently I must give httpd_t
> complete access to cgroup_t files. I can use DAC effectively enough to
> limit access but without SELinux backing me up it makes me feel somewhat
> naked.
> 
> As a matter of fact, I started patching libcgroup to support labelling
> cgroupfs without realizing this facility is unsupported! So I have about
> 70% of an effective patch to do this work properly within libcgroup too.
> 
> I welcome peoples' thoughts on this idea.

You've given examples where it would make sense to let userspace label
cgroup nodes.  Are there also cases where the kernel should be
automatically labeling cgroup nodes in some manner to reflect their
security properties, e.g. based on an associated task label?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
