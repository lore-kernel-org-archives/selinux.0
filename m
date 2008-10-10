Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9A9tE8D027625
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 05:55:14 -0400
Received: from etbe.coker.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9A9tBRR014807
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 09:55:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Murray McAllister <mmcallis@redhat.com>
Subject: Re: user guide drafts: "Mounting File Systems"
Date: Fri, 10 Oct 2008 19:55:03 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <48EF03BA.90901@redhat.com>
In-Reply-To: <48EF03BA.90901@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810102055.07274.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 10 October 2008 18:26, Murray McAllister <mmcallis@redhat.com> 
wrote:
> As the Linux root user, use the mount -o
> context=SELinux_user:role:type:level option to temporarily override
> existing SELinux contexts. The -o context option requires a Linux 2.6
> kernel. When a file system is mounted with the -o context option:
>
> # does -o context only work with a 2.6 kernels?

Given that Red Hat never supported SE Linux on a kernel before 2.6, and that 
any form of SE Linux support before 2.6 is prehistoric and no-one can really 
remember it, what is the point of mentioning pre 2.6 stuff?

Mentioning things that are different between RHEL4 and RHEL5 makes sense, as 
does differences with other distributions, and differences in the last few 
Fedora releases.

I don't recall when -o context appeared (ask google).  I do recall that it 
came in stages.  Do a test, you might find that RHEL4 works differently to 
RHEL5.  Incidentally if you don't already have one, I suggest that you get a 
Xen machine with instances for RHEL4, RHEL5, and the last few Fedoras - 
you'll need it to test such things.

> * SELinux context changes only occur in kernel memory, and as such,
> context changes are not written to disk. Any context changes made while
> such a file system is mounted are lost when the file system is unmounted.

What do you mean?

In a test with CentOS 5.2 I was unable to change the context of a file:

# mount /var/lib/xen/save -ocontext=system_u:object_r:mnt_t:s0
# chcon -t root_t /var/lib/xen/save
chcon: failed to change context of /var/lib/xen/save to 
system_u:object_r:root_t: Operation not supported

This is similar to what you wrote below in the <note> section.

> * If a file system is already labeled, and the contexts are overridden
> with the -o context option, the original contexts return when the file
> system is un-mounted.

Or if the filesystem isn't labelled then it remains in that state.

> * Newly-created files and directories appear to have the SELinux context
> specified with -o context; however, since context changes are not
> written to disk for these situations, context changes are lost when the
> file system is un-mounted.
>
> * The -o context option works even if the file system to be mounted does
> not support extended attributes, although, any context changes made to
> such a file system are lost when the file system is unmounted.
>
> The following example labels all files on the file system to be mounted
> with the httpd_sys_content_t type:
>
> # mount -t ext3 -o context="system_u:object_r:httpd_sys_content_t:s0"
> /dev/sdax /mount/point
>
> -t ext3: The -t ext3 option specifies that an ext3 file system is to be
> mounted. Use the -t option to specify the correct file system. Refer to
> the mount(8) manual page for a list of file systems.

Generally mount can figure that out by itself.

> -o context="system_u:object_r:httpd_sys_content_t:s0": The -o
> context="system_u:object_r:httpd_sys_content_t:s0" option specifies the
> SELinux context for all files on the file system to be mounted, as well
> as the mount point. This option overrides existing contexts.
>
> Type Enforcement is the main permission control used in SELinux targeted
> policy. For the most part, SELinux users and roles can be ignored, so,
> when overriding the SELinux context with mount, use the SELinux system_u
> user and object_r role, and concentrate on the type. In this example,
> all files on the /dev/sdax file system will be labeled with the
> httpd_sys_content_t type.

At this time object_r is the only supported role for files.  That may change 
in the near future.

> <note>
> When a file system is mounted with the -o context option, it is not
> possible to use the chcon command to change the SELinux context. Using
> chcon on such a file system results in a Operation not supported error.
> </note>

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
