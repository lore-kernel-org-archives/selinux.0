Subject: Re: I think this is a bug in the kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <48283791.80709@redhat.com>
References: <4824560E.8060500@redhat.com>  <48283791.80709@redhat.com>
Content-Type: text/plain
Date: Mon, 12 May 2008 09:08:51 -0400
Message-Id: <1210597731.6206.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-05-12 at 08:26 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Daniel J Walsh wrote:
> | https://bugzilla.redhat.com/show_bug.cgi?id=445709
> |
> | libvirtd is clearly not ptracing the unconfined_t domain.  It is
> | problably looking under /proc for some information about the app that is
> | communicating with it.  It might be reading unconfined_t environment.  I
> | am not sure, but we generate a ptrace and stop the app from working.  My
> | only choice is to allow virtd to ptrace unconfined_t processes which is
> | not a good idea.  This has to be fixes in the kernel.
> |
> | Dan
> 
> The policykit developer informs me that
> 
> "PolicyKit is trying to resolve the /proc/<pid>/exe link for the
> connecting client."

Racy and unsafe, as previously noted.

However, I did post a patch to split the ptrace checking in proc that
should change SELinux to only checking <sourcedomain>
<targetdomain>:file read; for access to those symlinks and environ like
it used to do prior to 2.6.18.  See the separate thread.  So if you want
to get that added to the F10/rawhide kernel, you can take that up with
Eric.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
