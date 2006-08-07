Subject: Re: [PATCH 0/2] new and improved range_transition statements
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Valdis.Kletnieks@vt.edu, James Morris <jmorris@namei.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1154961267.31522.237.camel@sgc>
References: <44CA2919.4010708@trustedcs.com>
	 <1154351236.26550.14.camel@localhost.localdomain>
	 <1154354184.1447.23.camel@moss-spartans.epoch.ncsc.mil>
	 <200607311428.k6VESR6m004599@turing-police.cc.vt.edu>
	 <1154356995.1447.64.camel@moss-spartans.epoch.ncsc.mil>
	 <200607311510.k6VFAhrw006155@turing-police.cc.vt.edu>
	 <1154697573.3919.18.camel@moss-spartans.epoch.ncsc.mil>
	 <1154961267.31522.237.camel@sgc>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 15:17:54 -0400
Message-Id: <1154978274.26697.157.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-08-07 at 10:34 -0400, Christopher J. PeBenito wrote:
> On Fri, 2006-08-04 at 09:19 -0400, Stephen Smalley wrote:
> > On Mon, 2006-07-31 at 11:10 -0400, Valdis.Kletnieks@vt.edu wrote:
> > > On Mon, 31 Jul 2006 10:43:15 EDT, Stephen Smalley said:
> > > 
> > > > I agree that it is too late for 2.6.18, but just to clarify - the kernel
> > > > patch preserves backward compatibility for older binary policy
> > > > formats.  
> > > > 
> > > > As far as compatibility is concerned, FC4 will need some kind of
> > > > userland update when it updates to a kernel with the new policy format;
> > > > otherwise, init will give up when it cannot find policy.21 or policy.20
> > > > (older sysvinit selinux patch only tried n and (n-1)), and the policy in
> > > > FC4 was version 19.
> 
> > After a bit of discussion (see bug 201242 in the redhat bugzilla) about
> > updating FC4 userland, it seems that we should try to address this
> > compatibility concern for legacy userland in the kernel.  We could first
> > upstream the patch below, then re-base the range_transition kernel patch
> > against it.  This patch makes the maximum policy version a kernel config
> > option so that it can be adjusted down to accommodate legacy userland,
> > with instructions and examples in the help text of the config option on
> > how to determine what value to use.  The range_transition kernel patch
> > would then adjust the "range" and "default" attributes of this new
> > config option to reflect the new version support, while users could
> > still build kernels to an older version.  Thoughts?
> 
> My feeling is that this is optimized for the wrong case.  Since the
> current userland has known how to auto downgrade for a while, no one
> will actually need this option unless they're building a kernel for for
> FC3 or 4, so the common case would be not to override the max version,
> especially as time progresses and FC3 and 4 become no longer maintained.
> Also, people that compile their kernel, and use `make oldconfig` won't
> know they need to update their max version in their config when the
> policydb version increases.  My suggestion is to have this as an option,
> so that if needed the max version can be overridden.  Then if the option
> is off, it uses the actual max version.

Ok, the patch below takes this approach.  I would then expect the range
transition patch to just update the "range" attribute max in Kconfig and
the definition of POLICYDB_VERSION_MAX in the #else clause in security.h
for the new version, while leaving the rest alone.

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 814ddc4..e718381 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -124,3 +124,36 @@ config SECURITY_SELINUX_ENABLE_SECMARK_D
 
 	  If you are unsure what do do here, select N.
 
+config SECURITY_SELINUX_POLICYDB_VERSION_MAX
+	bool "NSA SELinux maximum supported policy format version"
+	depends on SECURITY_SELINUX
+	default n
+	help
+	  This option enables the maximum policy format version supported
+	  by SELinux to be set to a particular value.  This value is reported
+	  to userspace via /selinux/policyvers and used at policy load time.
+	  It can be adjusted downward to support legacy userland (init) that
+	  does not correctly handle kernels that support newer policy versions.
+
+	  Examples:  For FC3 or FC4, enable this option and set the value via
+	  the next option.  For FC5 and later, do not enable this option.
+
+	  If you are unsure how to answer this question, answer N.
+
+config SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
+	int "NSA SELinux maximum supported policy format version value"
+	depends on SECURITY_SELINUX_POLICYDB_VERSION_MAX
+	range 15 20
+	default 19
+	help
+	  This option sets the value for the maximum policy format version
+	  supported by SELinux.
+
+	  Examples:  For FC3, use 18.  For FC4, use 19.
+
+	  If you are unsure how to answer this question, look for the
+	  policy format version supported by your policy toolchain, by
+	  running 'checkpolicy -V'. Or look at what policy you have
+	  installed under /etc/selinux/$SELINUXTYPE/policy, where
+	  SELINUXTYPE is defined in your /etc/selinux/config.
+
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 063af47..f4b784f 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -27,7 +27,11 @@ #define POLICYDB_VERSION_AVTAB		20
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_AVTAB
+#ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
+#define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
+#else
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_AVTAB
+#endif
 
 extern int selinux_enabled;
 extern int selinux_mls_enabled;


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
