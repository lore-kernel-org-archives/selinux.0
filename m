Subject: Re: [patch] enhanced MLS support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>, Chad Hanson <chanson@TrustedCS.com>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <41F6D30D.9070904@trustedcs.com>
References: <41EC4682.8050807@trustedcs.com>
	 <41F6D30D.9070904@trustedcs.com>
Content-Type: multipart/mixed; boundary="=-W5g1Otmzcip/1SUbHVP+"
Message-Id: <1106771757.23386.348.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 Jan 2005 15:35:57 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-W5g1Otmzcip/1SUbHVP+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-01-25 at 18:15, Darrel Goeddel wrote:
> I have new patches that incorporates feedback that I have received (and some 
> things that I noticed).  There is some code cleanup, and some bugfixes that 
> never made their way into the the MLS code before.  The most noticeable change 
> is the addition of the "-l" option to newrole to allow changing of levels. These 
> are also against the latest CVS tree form SourceForge.
> 
> The new patches (and a diff between the original and latest) are here:
> 
> http://dgoeddel.home.insightbb.com/kern-0125.patch
> http://dgoeddel.home.insightbb.com/usr-0125.patch
> http://dgoeddel.home.insightbb.com/0117to0125.patch
> 
> Note that the mounting issue pointed out by Stephen is not addressed by this 
> patch.  I figured that would best be addressed separately because it is not 
> specific to these changes.

Thanks.  Merged into sourceforge CVS.  I also applied the attached
policy Makefile patch relative to your patch as a compatibility measure;
it ensures that if you rebuild policy after updating to the new
checkpolicy, it will still build policy.18 as well (for older kernels)
and if you perform a make load and your kernel does not support the
latest policy version, it will fall back to policy.18.

Note to Dan:  You should likely wait on updating to the new libsepol
(1.3.1) and checkpolicy (1.21.1) from sourceforge CVS until we submit
the kernel changes upstream.  While they do have the usual compatibility
code for older policy binary versions, there is no advantage to updating
yet and further changes to the policy binary version may be coming.  But
feel free to continue updating from policycoreutils (newrole -l support)
and policy; that should have no impact on you.

Follow-up to my earlier note about getting a system up and running with
the enhanced MLS support:  In addition to the changes I described
earlier (and included in the patch I posted), I also had to make several
further changes for basic operation at multiple levels:
1) Set the clearance for the kernel SID to the max, i.e.
initial_sid_contexts contains:
	sid kernel system_u:system_r:kernel_t:s0 - s9:c0 . c127
2) Authorize system_u for the max, i.e. users contains:
	user system_u roles system_r level s0 range s0 - s9:c0 . c127;
3) Add mlsprocread, mlsprocwrite attributes to kernel_t (necessary for
the share permission check between kernel_t and init_t when init is
executed).
4) Add mlsfileread, mlsfilewrite, mlsfileupgrade, mlsfiledowngrade,
mlsprocsetsl attributes to newrole_t (necessary for newrole -l support
to work in enforcing mode).



-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

--=-W5g1Otmzcip/1SUbHVP+
Content-Disposition: attachment; filename=policy-Makefile.diff
Content-Type: text/x-patch; name=policy-Makefile.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policy/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/Makefile,v
retrieving revision 1.64
retrieving revision 1.65
diff -u -r1.64 -r1.65
--- policy/Makefile	26 Jan 2005 19:22:00 -0000	1.64
+++ policy/Makefile	26 Jan 2005 19:46:00 -0000	1.65
@@ -22,7 +22,9 @@
 LOADPOLICY  = $(SBINDIR)/load_policy
 CHECKPOLICY = $(BINDIR)/checkpolicy
 SETFILES = $(SBINDIR)/setfiles
-POLICYVER := policy.$(shell $(CHECKPOLICY) $(POLICYCOMPAT) -V |cut -f 1 -d ' ')
+VERS := $(shell $(CHECKPOLICY) $(POLICYCOMPAT) -V |cut -f 1 -d ' ')
+KERNVERS := $(shell cat /selinux/policyvers)
+POLICYVER := policy.$(VERS)
 INSTALLDIR = $(DESTDIR)/etc/selinux/strict
 POLICYPATH = $(INSTALLDIR)/policy
 SRCPATH = $(INSTALLDIR)/src
@@ -127,6 +129,9 @@
 $(LOADPATH):  policy.conf $(CHECKPOLICY)
 	mkdir -p $(POLICYPATH)
 	$(CHECKPOLICY) $(CHECKPOLMLS) -o $@ policy.conf
+ifneq ($(VERS),18)
+	$(CHECKPOLICY) $(CHECKPOLMLS) -c 18 -o $(POLICYPATH)/policy.18 policy.conf
+endif
 # Note: Can't use install, so not sure how to deal with mode, user, and group
 #	other than by default.
 
@@ -134,11 +139,18 @@
 
 $(POLICYVER):  policy.conf $(FC) $(CHECKPOLICY)
 	$(CHECKPOLICY) $(CHECKPOLMLS) -o $@ policy.conf
+ifneq ($(VERS),18)
+	$(CHECKPOLICY) $(CHECKPOLMLS) -c 18 -o policy.18 policy.conf
+endif
 	@echo "Validating file_contexts ..."
 	$(SETFILES) -q -c $(POLICYVER) $(FC)
 
 reload tmp/load: install
+ifeq ($(VERS), $(KERNVERS))
 	$(LOADPOLICY) $(LOADPATH)
+else
+	$(LOADPOLICY) $(POLICYPATH)/policy.18
+endif
 	touch tmp/load
 
 load: tmp/load

--=-W5g1Otmzcip/1SUbHVP+--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
