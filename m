Subject: Re: I am more worried about open then read and write, SELinux
	needs open access checks.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <4797B92E.7050901@redhat.com>
References: <4797B92E.7050901@redhat.com>
Content-Type: text/plain
Date: Thu, 24 Jan 2008 08:08:32 -0500
Message-Id: <1201180112.21288.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-01-23 at 17:01 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> One of the things I have talked about in the past was separating the
> access for open from read/write.
> 
> 
> An example of where this is a problem is the following AVC from a
> bugzilla I got today.
> type=AVC msg=audit(1201052518.765:1352): avc: denied { write } for
> pid=5767 comm="dbus-daemon" path="/home/zack/startx.log" dev=sda3
> ino=2227350
> scontext=unconfined_u:unconfined_r:unconfined_dbusd_t:s0-s0:c0.c1023
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file
> 
> 
> This indicates that zack started x windows with startx.  With its
> standard output directed to /home/zack/startx.log.  The avc indicates
> that dbus has suddenly started trying to write files in the users home
> directory.
> 
> My choice is to allow it or dontaudit it.
> 
> Neither is correct.  I really want to know if a confined application
> suddenly opens a file in the users homedir for writing, but if the
> processes is handed an open file descriptor, I want to allow it.
> 
> This is a fundamental flaw in the usability of SELinux.  Handling of
> stdin/stdout/stderr are always generating AVC messages that we either
> cover up or allow, and this can prevent us from discovering a real
> cracker situation.
> 
> I would like to propose that we add one or more avc's to deal with
> opening a file.  open or open_read open_write.  Leave the existing
> access for those that are worried about leaking file descriptors and
> information flow, but allow us to concentrate on real vulnerability s
> versus noicy avc messages.

I'm not opposed to adding an open permission check - we just need to do
it in a way that preserves compatibility (i.e. no denials for legacy
systems, especially for akpm's test boxes).  That means at present that
we need to use the policy capability mechanism introduced by Paul Moore
to selectively enable/disable this check depending on whether the policy
was built with a new capability indicating that it supports the new
check.  Unfortunately, the handle unknown support isn't sufficient as
there are legacy distros that don't have it enabled (in fact, AFAIK,
only Fedora 8 has it enabled - unless you've back ported the
checkpolicy/libsepol support to Fedora 7 and rebuilt policy there with
handle_unknown = allow, which would be helpful btw).

The other delicate point is that this check would apply to all file
classes, yet we can't add permissions to the common definitions at
present as that would disturb the existing per-class definitions.  So
we'd have to add this new permission per-class, and have a mapping array
or function that maps each class to the right permission for use at the
permission check call site.

To do it, we need:
1) someone to implement the kernel side support, including adding a new
policy capability, adding the new permission, and implementing the new
check with a conditional test on the new capability.
2) someone to implement the libsepol/checkpolicy side support in order
to allow policies to be built that turn on the capability.
3) someone to go through policy and either manually decides now where to
add open permissions or just create a script that automatically inserts
open everywhere there is read or write on a file class and then later
gradually pare down the use of open to only where needed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
