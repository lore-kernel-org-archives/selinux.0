Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8ALp47O005302
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 17:51:04 -0400
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8ALoOB2020279
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 21:50:24 GMT
Subject: Re: [refpolicy] new policy for dkim-filter
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Paul Howarth <paul@city-fan.org>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1252615167.22997.1.camel@vogon.seekline.net>
References: <1252611656.2486.44.camel@vogon.seekline.net>
	 <20090910210421.150ff80f@metropolis.intra.city-fan.org>
	 <1252615167.22997.1.camel@vogon.seekline.net>
Content-Type: multipart/mixed; boundary="=-yIA4qjs/veqFsmzSg7pN"
Date: Thu, 10 Sep 2009 23:50:48 +0200
Message-Id: <1252619448.22997.12.camel@vogon.seekline.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-yIA4qjs/veqFsmzSg7pN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2009-09-10 at 22:39 +0200, Stefan Schulze Frielinghaus wrote:
> On Thu, 2009-09-10 at 21:04 +0100, Paul Howarth wrote:
> > On Thu, 10 Sep 2009 21:40:56 +0200
> > Stefan Schulze Frielinghaus <stefan@seekline.net> wrote:
> > 
> > > Attached is a new policy for the dkim-filter application.
> > > 
> > > Chris, is the policy OK/ready for merge?
> > 
> > I think it would be better to merge it with the milter policy. That
> > would then need no changes to the sendmail policy and the milter should
> > work with postfix too.
> 
> Oh sure, milter_template() is far better for this. I wasn't aware of
> such a template. I will have a look at it and send a corrected version.

And here we are. Since the milter_template() is pretty straight forward
I guess we are done now. Thanks again for the tip.

DKIM-Filter runs fine for me with the new milter policy.

--=-yIA4qjs/veqFsmzSg7pN
Content-Disposition: attachment; filename="milter.diff"
Content-Type: text/x-patch; name="milter.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/policy/modules/services/milter.fc b/policy/modules/services/milter.fc
index 55a3e2f..d4494bc 100644
--- a/policy/modules/services/milter.fc
+++ b/policy/modules/services/milter.fc
@@ -1,10 +1,14 @@
+/usr/sbin/dkim-filter		--	gen_context(system_u:object_r:dkimfilter_milter_exec_t,s0)
 /usr/sbin/milter-greylist	--	gen_context(system_u:object_r:greylist_milter_exec_t,s0)
-/usr/sbin/milter-regex				--	gen_context(system_u:object_r:regex_milter_exec_t,s0)
+/usr/sbin/milter-regex		--	gen_context(system_u:object_r:regex_milter_exec_t,s0)
 /usr/sbin/spamass-milter	--	gen_context(system_u:object_r:spamass_milter_exec_t,s0)
 
+/var/db/dkim(/.*)?			gen_context(system_u:object_r:dkimfilter_private_key_t,s0)
+
 /var/lib/milter-greylist(/.*)?		gen_context(system_u:object_r:greylist_milter_data_t,s0)
 /var/lib/spamass-milter(/.*)?		gen_context(system_u:object_r:spamass_milter_state_t,s0)
 
+/var/run/dkim-filter(/.*)?		gen_context(system_u:object_r:dkimfilter_milter_data_t,s0)
 /var/run/milter-greylist(/.*)?		gen_context(system_u:object_r:greylist_milter_data_t,s0)
 /var/run/milter-greylist\.pid	--	gen_context(system_u:object_r:greylist_milter_data_t,s0)
 /var/run/spamass-milter(/.*)?		gen_context(system_u:object_r:spamass_milter_data_t,s0)
diff --git a/policy/modules/services/milter.te b/policy/modules/services/milter.te
index ff7cebc..88be485 100644
--- a/policy/modules/services/milter.te
+++ b/policy/modules/services/milter.te
@@ -1,5 +1,5 @@
 
-policy_module(milter, 1.1.0)
+policy_module(milter, 1.2.0)
 
 ########################################
 #
@@ -10,11 +10,16 @@ policy_module(milter, 1.1.0)
 attribute milter_domains;
 attribute milter_data_type;
 
-# currently-supported milters are milter-greylist, milter-regex and spamass-milter
+# currently-supported milters are dkim-filter, milter-greylist, milter-regex and spamass-milter
+milter_template(dkimfilter)
 milter_template(greylist)
 milter_template(regex)
 milter_template(spamass)
 
+# Type for the private key of dkim-filter
+type dkimfilter_private_key_t;
+files_type(dkimfilter_private_key_t)
+
 # Type for the spamass-milter home directory, under which spamassassin will
 # store system-wide preferences, bayes databases etc. if not configured to
 # use per-user configuration
@@ -23,6 +28,25 @@ files_type(spamass_milter_state_t)
 
 ########################################
 #
+# dkimfilter local policy
+#   DomainKeys Identified Mail sender authentication
+#   http://sourceforge.net/projects/dkim-milter/
+#
+
+allow dkimfilter_milter_t self:capability { setgid setuid };
+
+read_files_pattern(dkimfilter_milter_t, dkimfilter_private_key_t, dkimfilter_private_key_t)
+
+files_read_etc_files(dkimfilter_milter_t)
+
+kernel_read_kernel_sysctls(dkimfilter_milter_t)
+
+sysnet_dns_name_resolve(dkimfilter_milter_t)
+
+dev_read_urand(dkimfilter_milter_t)
+
+########################################
+#
 # milter-greylist local policy
 #   ensure smtp clients retry mail like real MTAs and not spamware
 #   http://hcpnet.free.fr/milter-greylist/

--=-yIA4qjs/veqFsmzSg7pN--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
