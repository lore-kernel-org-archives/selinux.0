Message-ID: <1347975902.29192.17.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] selinux-testsuite:  Allow test domains to read
 /etc/passwd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        Eric Paris
	 <eparis@redhat.com>
Date: Tue, 18 Sep 2012 09:45:02 -0400
In-Reply-To: <20120915022200.GB6438@mail.hallyn.com>
References: <1347545325.15047.34.camel@moss-pluto.epoch.ncsc.mil>
	 <5051FB6A.8040106@redhat.com> <20120915022200.GB6438@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2012-09-15 at 02:22 +0000, Serge E. Hallyn wrote:
> Quoting Daniel J Walsh (dwalsh@redhat.com):
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > On 09/13/2012 10:08 AM, Stephen Smalley wrote:
> > > Several test cases require the ability to read /etc/passwd to look up
> > > usernames.  Recent Fedora introduced a separate type on /etc/passwd and
> > > therefore we need to add an interface call to test_global.te.  Fixes three
> > > test failures on Fedora 17.
> > > 
> > > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov> --- 
> > > policy/test_global.te | 2 ++ 1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/policy/test_global.te b/policy/test_global.te index
> > > 77121ae..fdfd291 100644 --- a/policy/test_global.te +++
> > > b/policy/test_global.te @@ -88,3 +88,5 @@
> > > selinux_compute_access_vector(testdomain) 
> > > selinux_compute_create_context(testdomain) 
> > > selinux_compute_relabel_context(testdomain) 
> > > selinux_compute_user_contexts(testdomain) + +auth_read_passwd(testdomain)
> > > 
> > Probably should use
> > 
> > auth_use_nsswitch(testdomain)
> > 
> > Since this will handle cases where users are listed in ldap or use sssd.
> 
> Stephen, would you like that instead?

No, it doesn't work - you cannot pass an attribute name to that
interface.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
