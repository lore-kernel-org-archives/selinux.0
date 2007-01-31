Subject: Re: provoking fsetfilecon failure in a test case
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87y7nk8g3a.fsf@rho.meyering.net>
References: <87y7nk8g3a.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Wed, 31 Jan 2007 11:30:07 -0500
Message-Id: <1170261007.12293.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-30 at 20:33 +0100, Jim Meyering wrote:
> I'm adding a test case for the 'cp -a' failure reported here:
> 
>   http://bugzilla.redhat.com/219900
> 
> In my comment there, I asked this:
> 
>   I'd like to add a test script to exercise this fix, but depending on
>   the existence of a writable, NFS-mounted partition is not a recipe for
>   good coverage. Can anyone suggest an easier way to provoke fsetfilecon
>   failure on a file we've just opened (but not created -- it already
>   existed) for writing?
> 
> Any ideas?

fsetfilecon will fail if any of the following apply:
- the filesystem was mounted with a context= option or the filesystem
doesn't support setxattr for the security namespace (EOPNOTSUPP),
- the process fsuid doesn't match the file's uid and the process lacks
CAP_FOWNER (EPERM),
- the process lacks relabelfrom permission to the old file context,
- the new context isn't valid (EINVAL),
- the process lacks relabelto permission to the new file context,
- the relationship between the old and new file contexts violates a
validatetrans constraint,
- the new file context is not allowed to be associated with the
filesystem context.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
