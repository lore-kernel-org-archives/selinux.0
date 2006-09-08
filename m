Subject: Re: Latest policycoreutils patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45001F1A.3080004@redhat.com>
References: <45001F1A.3080004@redhat.com>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 10:35:59 -0400
Message-Id: <1157726159.31695.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-07 at 09:31 -0400, Daniel J Walsh wrote:
> Have newrole ignore sigpipe so it gives correct error message when 
> flooded with 4000 character security context.

I'm a little unclear on this one, although I did find a bug report about
it (which would be helpful to identify in the patch posting in the
future when it applies for easy reference), at
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=203801

If I read that one correctly, the SIGPIPE is actually happening when
libselinux tries to write the context to the setrans socket, because the
daemon is dropping the connection immediately upon getting the header
with such a large length (more generally, any failure in the daemon
before reading the entire request could lead to this).  So that could
affect any user of libselinux, not just newrole, right?

Looking around a bit, I see that if we changed the use of writev() in
libselinux to instead use sendmsg() with an explicit MSG_NOSIGNAL flag,
we could avoid having such failures generate SIGPIPE altogether.  Then
we would just get an error return and have the usual fallback handling.

> Add -i qualifier to restorecon to tell it to ignore files that do not 
> exist.  This fixes a problem in
> fixfiles -R rpmlint restore
> 
> 
> Which could hand restorecon files that do not exists and restorecon 
> prints ugly warnings.
> 
> restorecond init script description needs line continuation marks to 
> make system-config-services happy.
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
