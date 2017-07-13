Message-ID: <1499967307.624.12.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Milos Malik <mmalik@redhat.com>, selinux@tycho.nsa.gov
Date: Thu, 13 Jul 2017 13:35:07 -0400
In-Reply-To: <1499964819.624.8.camel@tycho.nsa.gov>
References: <1499944132-6721-1-git-send-email-mmalik@redhat.com>
 <1499964819.624.8.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] Additional tests for long-time supported netlink classes
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-07-13 at 12:53 -0400, Stephen Smalley wrote:
> On Thu, 2017-07-13 at 13:08 +0200, Milos Malik wrote:
> > This patch contains tests for classes which are already supported
> > for
> > a
> > long time but are not tested by the selinux-testsuite yet. These
> > tests
> > involve classes like: netlink_route_socket, netlink_xfrm_socket,
> > netlink_selinux_socket, netlink_audit_socket,
> > netlink_kobject_uevent_socket, netlink_connector_socket,
> > netlink_scsitransport_socket, netlink_fib_lookup_socket.
> 
> These look fine (aside from a whitespace issue which git am
> complained
> about) and ran successfully for me on Fedora, but I did have one
> question:
> 
> policy/Makefile and tests/Makefile only enable the netlink_socket
> tests
> if the new netlink socket classes are defined by the base policy, and
> tests/Makefile further excludes them from running on RHEL7 because
> RHEL7.3 back-ported the policy change defining the new classes but
> not
> the kernel support.  In contrast, the tests you are adding could be
> run
> on RHEL7 (and earlier).  If we want them to be run on RHEL7 or
> earlier,
> then you need to split them into their own test policy and test case
> that can be separately enabled, or otherwise wrap the current ones to
> allow use on RHEL7.  You can see examples in other test policies and
> scripts of such conditional inclusion of subsets of the
> tests/policies
> (e.g. commit 32015aad4972321ba23611795b4f0479bf213943 or commit
> b6e5e01a282582322185d67eb628569ac1a9f2dc). Do we want these to be
> tested on RHEL7 or earlier?

Also, I wanted to mention that this still doesn't address testing of
the finer-grained permissions for netlink sockets, e.g.
nlmsg_read/write/..., as noted in the open issue:
https://github.com/SELinuxProject/selinux-testsuite/issues/17

That isn't an obstacle to taking this one, but wanted to note that we
still want to address that at some point.

Also, on the kernel side, we might want to consider defining those
permissions for more of the netlink socket classes, particularly the
newer ones, if/where it makes sense to do so.  Or, alternatively, to
implement support analogous to the ioctl whitelisting support for
netlink messages so that we can do fine-grained restrictions there.

> 
> > 
> > Signed-off-by: Milos Malik <mmalik@redhat.com>
> > ---
> >  policy/test_netlink_socket.te |  8 ++++
> >  tests/netlink_socket/test     | 99
> > ++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 106 insertions(+), 1 deletion(-)
> > 
> > diff --git a/policy/test_netlink_socket.te
> > b/policy/test_netlink_socket.te
> > index c852c04..aaa6e4d 100644
> > --- a/policy/test_netlink_socket.te
> > +++ b/policy/test_netlink_socket.te
> > @@ -40,6 +40,14 @@ netlink_socket_test(netlink_iscsi_socket)
> >  netlink_socket_test(netlink_netfilter_socket)
> >  netlink_socket_test(netlink_generic_socket)
> >  netlink_socket_test(netlink_crypto_socket)
> > +netlink_socket_test(netlink_route_socket)
> > +netlink_socket_test(netlink_xfrm_socket)
> > +netlink_socket_test(netlink_selinux_socket)
> > +netlink_socket_test(netlink_audit_socket)
> > +netlink_socket_test(netlink_kobject_uevent_socket)
> > +netlink_socket_test(netlink_connector_socket)
> > +netlink_socket_test(netlink_scsitransport_socket)
> > +netlink_socket_test(netlink_fib_lookup_socket)
> >  
> >  #
> >  # Common rules for all netlink socket class test domains.
> > diff --git a/tests/netlink_socket/test b/tests/netlink_socket/test
> > index 487edbc..cc8c2d4 100755
> > --- a/tests/netlink_socket/test
> > +++ b/tests/netlink_socket/test
> > @@ -1,7 +1,7 @@
> >  #!/usr/bin/perl
> >  
> >  use Test;
> > -BEGIN { plan tests => 8 }
> > +BEGIN { plan tests => 24 }
> >  
> >  $basedir = $0;
> >  $basedir =~ s|(.*)/[^/]*|$1|;
> > @@ -53,3 +53,100 @@ $result = system(
> >  "runcon -t test_no_netlink_crypto_socket_t --
> > $basedir/netlinkcreate
> > crypto 2>&1"
> >  );
> >  ok($result);
> > +
> > +# Verify that test_netlink_route_socket_t can create a
> > NETLINK_ROUTE
> > socket.
> > +$result = system(
> > +"runcon -t test_netlink_route_socket_t -- $basedir/netlinkcreate
> > route 2>&1"
> > +);
> > +ok( $result, 0 );
> > +
> > +# Verify that test_no_netlink_route_socket_t cannot create a
> > NETLINK_ROUTE socket.
> > +$result = system(
> > +"runcon -t test_no_netlink_route_socket_t --
> > $basedir/netlinkcreate
> > route 2>&1"
> > +);
> > +ok($result);
> > +
> > +# Verify that test_netlink_xfrm_socket_t can create a NETLINK_XFRM
> > socket.
> > +$result = system(
> > +"runcon -t test_netlink_xfrm_socket_t -- $basedir/netlinkcreate
> > xfrm
> > 2>&1"
> > +);
> > +ok( $result, 0 );
> > +
> > +# Verify that test_no_netlink_xfrm_socket_t cannot create a
> > NETLINK_XFRM socket.
> > +$result = system(
> > +"runcon -t test_no_netlink_xfrm_socket_t -- $basedir/netlinkcreate
> > xfrm 2>&1"
> > +);
> > +ok($result);
> > +
> > +# Verify that test_netlink_selinux_socket_t can create a
> > NETLINK_SELINUX socket.
> > +$result = system(
> > +"runcon -t test_netlink_selinux_socket_t -- $basedir/netlinkcreate
> > selinux 2>&1"
> > +);
> > +ok( $result, 0 );
> > +
> > +# Verify that test_no_netlink_selinux_socket_t cannot create a
> > NETLINK_SELINUX socket.
> > +$result = system(
> > +"runcon -t test_no_netlink_selinux_socket_t --
> > $basedir/netlinkcreate selinux 2>&1"
> > +);
> > +ok($result);
> > +
> > +# Verify that test_netlink_audit_socket_t can create a
> > NETLINK_AUDIT
> > socket.
> > +$result = system(
> > +"runcon -t test_netlink_audit_socket_t -- $basedir/netlinkcreate
> > audit 2>&1"
> > +);
> > +ok( $result, 0 );
> > +
> > +# Verify that test_no_netlink_audit_socket_t cannot create a
> > NETLINK_AUDIT socket.
> > +$result = system(
> > +"runcon -t test_no_netlink_audit_socket_t --
> > $basedir/netlinkcreate
> > audit 2>&1"
> > +);
> > +ok($result);
> > +
> > +# Verify that test_netlink_kobject_uevent_socket_t can create a
> > NETLINK_KOBJECT_UEVENT socket.
> > +$result = system(
> > +"runcon -t test_netlink_kobject_uevent_socket_t --
> > $basedir/netlinkcreate kobject_uevent 2>&1"
> > +);
> > +ok( $result, 0 );
> > +
> > +# Verify that test_no_netlink_kobject_uevent_socket_t cannot
> > create
> > a NETLINK_KOBJECT_UEVENT socket.
> > +$result = system(
> > +"runcon -t test_no_netlink_kobject_uevent_socket_t --
> > $basedir/netlinkcreate kobject_uevent 2>&1"
> > +);
> > +ok($result);
> > +
> > +# Verify that test_netlink_connector_socket_t can create a
> > NETLINK_CONNECTOR socket.
> > +$result = system(
> > +"runcon -t test_netlink_connector_socket_t --
> > $basedir/netlinkcreate
> > connector 2>&1"
> > +);
> > +ok( $result, 0 );
> > +
> > +# Verify that test_no_netlink_connector_socket_t cannot create a
> > NETLINK_CONNECTOR socket.
> > +$result = system(
> > +"runcon -t test_no_netlink_connector_socket_t --
> > $basedir/netlinkcreate connector 2>&1"
> > +);
> > +ok($result);
> > +
> > +# Verify that test_netlink_scsitransport_socket_t can create a
> > NETLINK_SCSITRANSPORT socket.
> > +$result = system(
> > +"runcon -t test_netlink_scsitransport_socket_t --
> > $basedir/netlinkcreate scsitransport 2>&1"
> > +);
> > +ok( $result, 0 );
> > +
> > +# Verify that test_no_netlink_scsitransport_socket_t cannot create
> > a
> > NETLINK_SCSITRANSPORT socket.
> > +$result = system(
> > +"runcon -t test_no_netlink_scsitransport_socket_t --
> > $basedir/netlinkcreate scsitransport 2>&1"
> > +);
> > +ok($result);
> > +
> > +# Verify that test_netlink_fib_lookup_socket_t can create a
> > NETLINK_FIB_LOOKUP socket.
> > +$result = system(
> > +"runcon -t test_netlink_fib_lookup_socket_t --
> > $basedir/netlinkcreate fib_lookup 2>&1"
> > +);
> > +ok( $result, 0 );
> > +
> > +# Verify that test_no_netlink_fib_lookup_socket_t cannot create a
> > NETLINK_FIB_LOOKUP socket.
> > +$result = system(
> > +"runcon -t test_no_netlink_fib_lookup_socket_t --
> > $basedir/netlinkcreate fib_lookup 2>&1"
> > +);
> > +ok($result);
> > +
