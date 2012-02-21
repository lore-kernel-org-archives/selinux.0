Subject: Re: Force avc_has_perm to return success if enforcing == 0;
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4F3D14B3.9090502@redhat.com>
References: <4F3AD084.5060304@redhat.com>
	 <1329402340.25057.3.camel@moss-pluto>  <4F3D14B3.9090502@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Feb 2012 15:37:59 -0500
Message-ID: <1329856679.12501.81.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-02-16 at 09:37 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 02/16/2012 09:25 AM, Stephen Smalley wrote:
> > On Tue, 2012-02-14 at 16:22 -0500, Daniel J Walsh wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >> 
> >> I would like to patch libselinux to always return 0 on
> >> avc_has_perm if the machine is in permissive mode.
> >> 
> >> This will allow Userspace Object Managers to work even if the
> >> system is totally mislabeled and processes as running with bad
> >> context. Currently if a program like dbus asks with a bad process
> >> label it can get denials even in permissive mode.
> >> 
> >> Does anyone see a problem with this?
> > 
> > I'm not fond of it.  Permissive mode is just supposed to control
> > whether permission is granted, not to hide other kinds of errors.
> > Consider how difficult debugging of an actual failure will be if it
> > only shows up in enforcing mode even though it has nothing to do
> > with policy.
> > 
> Well I guess I can only due the return in the audit_has_perm not the
> audit_has_perm_noaudit, since then the audit message will get
> generated but dbus,passwd,xserver ... will allow the access.
> 
> If an app calls audit_has_perm_noaudit, it will still return failure.

That doesn't help.  The issue is that avc_has_perm can fail for reasons
other than permission failure (which is why you are making this change),
but those other reasons are not logged/audited, so if you make them
succeed in permissive mode, then they won't be seen there.  At all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
