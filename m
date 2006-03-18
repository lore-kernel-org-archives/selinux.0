Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2IEL20H027333
	for <selinux@tycho.nsa.gov>; Sat, 18 Mar 2006 09:21:03 -0500
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2IEJNCa026767
	for <selinux@tycho.nsa.gov>; Sat, 18 Mar 2006 14:19:24 GMT
Subject: How can modular policy ever have worked? [patch]
From: Erich Schubert <erich@debian.org>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: multipart/mixed; boundary="=-8tN20xU3GBPUxVLulq6F"
Date: Sat, 18 Mar 2006 15:20:57 +0100
Message-Id: <1142691657.4017.23.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-8tN20xU3GBPUxVLulq6F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,
After investigating the M4 macros a bit closer (and after being pointed
in the right direction by Method), I wonder how modular policy ever can
have worked.

<Method> right now while building base the optional_policy is turned
into an m4 ifdef, if the module that activates the optional_policy isn't
also in base it essentially disappears

Fact (look at the source):
optional(`whatever',`...')
gets reduced to nothing when building base.pp and whatever as module.
That way base.pp doesn't contain any optional statements, because the
compiler used to not support that yet. (Method says he added this
support)
When building a module, it is expanded to a proper optional {}
statement.

I discovered this after investigating why building mta into base and
policy as module didn't work right - the optional(`postfix',`...') part
gets lost, so /usr/lib/sendmail can't transition into postdrop_t, so it
can't write mails to the postfix queues.
When I build mta as module this worked just fine.

However, this is a chain, and the only "stable" solution is to build a
monolithic policy. Some examples:

policy/modules/kernel/kernel.te:
optional_policy(`init',`

So if you have kernel in base (which is required) you should also put
init, logging, selinuxutil, rpc, portmap, nis, library, hotplug
into base, in order not to lose the optional statements in kernel.
Other modules in base have similar "optional dependencies", of course.

Now let's look at init... you'll find just about any service package
having an optional statement in init.te (which I consider ugly,
actually, having to have
something in the init.te module for a service!)

So basically, unless you build a monolithic policy, certain rules will
be missing from your linked policy that were "optional" in the policy
source. Ouch.

Attached patch will write appropriate optional {} statements to the base
policy.
In my module configuration (I've lots of stuff in base), diffstat for
the base.conf file gives: 36558 insertions(+), no deletions.
(I have filtered any "#line 123" and whitespace-only lines from this
stat)

So (as the attached diff should suggest anyway), this will only generate
additional statement for the policy.

The resulting base.pp file is almost twice as big, however the
"expanded" policy is only half the size and missing like 19k lines...
most of them pretty essential :-( So linking is not yet working
correctly; it doesn't throw any errors but the resulting files are badly
shreddered.

This also seems to turn up a problem in the linux kernel (2.6.15, not
the latest patches yet, sorry):
Even the _working_ (well, except for the missing rules) policy generated
without this patch, will link, but not load any more:
[...]
Committing changes:
/usr/sbin/load_policy:  Can't load policy:  Invalid argument

So it seems the kernel is now rejecting any policy loads, albeit it
still in permissive mode.

best regards,
Erich Schubert
--=20
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
       The best things in life are free: Friendship and Love.       //\
     Gl=FCck ist, wenn man daf=FCr geliebt wird, wie man eben ist.      V=
_/_

--=-8tN20xU3GBPUxVLulq6F
Content-Disposition: attachment; filename=refpolicy-module-optionals.diff
Content-Type: text/x-patch; name=refpolicy-module-optionals.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Index: policy/support/loadable_module.spt
===================================================================
--- policy/support/loadable_module.spt	(Revision 63)
+++ policy/support/loadable_module.spt	(Revision 64)
@@ -24,7 +24,14 @@
 # For use in interfaces, to optionally insert a require block
 #
 define(`gen_require',`
-	ifdef(`self_contained_policy',`',`
+	ifdef(`self_contained_policy',`
+		ifdef(`modular_base_policy',`
+			ifdef(`in_optional_statement',`
+				require {
+					$1
+				}
+			')
+		')',`
 		require {
 			$1
 		}
@@ -87,10 +94,26 @@
 #
 define(`optional_policy',`
 	ifdef(`self_contained_policy',`
-		ifdef(`$1.te',`$2',`$3')
+		ifdef(`$1.te',`$2',`
+			ifdef(`modular_base_policy',`
+				optional {
+					pushdef(`in_optional_statement') dnl
+					$2
+					popdef(`in_optional_statement') dnl
+				ifelse(`$3',`',`',`
+				} else {
+					$3
+				')
+				}
+			',`
+				$3
+			')
+		')
 	',`
 		optional {
+			pushdef(`in_optional_statement') dnl
 			$2
+			popdef(`in_optional_statement') dnl
 		ifelse(`$3',`',`',`
 		} else {
 			$3
Index: Rules.modular
===================================================================
--- Rules.modular	(Revision 63)
+++ Rules.modular	(Revision 64)
@@ -111,7 +111,7 @@
 	@test -d $(TMPDIR) || mkdir -p $(TMPDIR)
 	@test -d $(dir $(BASE_CONF)) || mkdir -p $(dir $(BASE_CONF))
 # checkpolicy can use the #line directives provided by -s for error reporting:
-	$(verbose) m4 -D self_contained_policy $(M4PARAM) -s $^ > $(TMPDIR)/$(@F).tmp
+	$(verbose) m4 -D self_contained_policy -D modular_base_policy $(M4PARAM) -s $^ > $(TMPDIR)/$(@F).tmp
 	$(verbose) sed -e /^portcon/d -e /^nodecon/d -e /^netifcon/d < $(TMPDIR)/$(@F).tmp > $@
 # the ordering of these ocontexts matters:
 	$(verbose) grep ^portcon $(TMPDIR)/$(@F).tmp >> $@ || true

--=-8tN20xU3GBPUxVLulq6F--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
