Date: Sat, 15 Sep 2012 02:22:00 +0000
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Serge Hallyn <serge@hallyn.com>,
        selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] selinux-testsuite:  Allow test domains to read
 /etc/passwd
Message-ID: <20120915022200.GB6438@mail.hallyn.com>
References: <1347545325.15047.34.camel@moss-pluto.epoch.ncsc.mil>
 <5051FB6A.8040106@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5051FB6A.8040106@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Daniel J Walsh (dwalsh@redhat.com):
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 09/13/2012 10:08 AM, Stephen Smalley wrote:
> > Several test cases require the ability to read /etc/passwd to look up
> > usernames.  Recent Fedora introduced a separate type on /etc/passwd and
> > therefore we need to add an interface call to test_global.te.  Fixes three
> > test failures on Fedora 17.
> > 
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov> --- 
> > policy/test_global.te | 2 ++ 1 file changed, 2 insertions(+)
> > 
> > diff --git a/policy/test_global.te b/policy/test_global.te index
> > 77121ae..fdfd291 100644 --- a/policy/test_global.te +++
> > b/policy/test_global.te @@ -88,3 +88,5 @@
> > selinux_compute_access_vector(testdomain) 
> > selinux_compute_create_context(testdomain) 
> > selinux_compute_relabel_context(testdomain) 
> > selinux_compute_user_contexts(testdomain) + +auth_read_passwd(testdomain)
> > 
> Probably should use
> 
> auth_use_nsswitch(testdomain)
> 
> Since this will handle cases where users are listed in ldap or use sssd.

Stephen, would you like that instead?

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
