Received: from smtpweb146.aruba.it (smtpweb146.aruba.it [62.149.158.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442332566FD
	for <selinux@vger.kernel.org>; Mon,  9 Jun 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479822; cv=none; b=LfMuCg0tUOy7frJHIY1SudeXA6k3bkvPYeElD09sqnyudrn45ECETub30kp159wSDY33Hi4GvADr2hMJ0az2w0DtCyiEogQBTFaEoYBP5ur+7I9q+o8ia1vB8a/of4vrxoxNnYatbTrsHs56WjCumYYh2m24VctIO19AkisjZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479822; c=relaxed/simple;
	bh=9LjzWFPwea1QfglyCCABc5cgf9CPWVMyflkPlP2ENdg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=u/kh2QkeMAbn3bHOufdBaqYy/H5jSzz+TSvgk+q6kRm4vecvgI2fR/mRh6TDNVS+JJSQDDDlFnUWjKBt2H2M1CLeLJj7jRmj3a/6CrqORNIPyUUEmCJMV93Ak5+vc+fSbn93I+Gu9BvMkbo97iDTtqwBcvDyTI6JVzc44pOeIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com; spf=pass smtp.mailfrom=trentalancia.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=CeJX1RfR; arc=none smtp.client-ip=62.149.158.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="CeJX1RfR"
Received: from [192.168.43.2] ([109.54.140.89])
	by Aruba SMTP with ESMTPSA
	id OdZOuD7Ej2QPuOdZPuafkQ; Mon, 09 Jun 2025 16:33:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1749479631; bh=9LjzWFPwea1QfglyCCABc5cgf9CPWVMyflkPlP2ENdg=;
	h=Subject:From:To:Date:Content-Type:Mime-Version;
	b=CeJX1RfRr5VtDO6O6xVnQUbx/kPfFX/ArG2A8DWBNqcbYwZdRzCo692DhAvwEfRFV
	 vD13MYetDKy3jaBvyJaHFBG+JDGU46VZWt1cYfzm6Tt7S/Avmqg6GBUHLVFGO5Kpkn
	 lh1EVpji5tJ9vU0ed/23p2P7Ou9Z0Z+IuRM0ihTGgRumRXG1DgmaC5dNZJivS1o9LN
	 +ytXjFBHCxgRu3Y/D4RneZ0yyrMbJ3rm4hLFxPCUyS2L3rbCnAd9WJxGltPGaRYMb2
	 lsQUCSYoUa5k87sseKUD+nPHexbsSo167ibBX/QhhWcxriw7So+OWSnIMWKALQYoTP
	 l8R8TrdeLR2mA==
Message-ID: <1749479630.6137.1.camel@trentalancia.com>
Subject: Re: [PATCH v2] Only set the initial SID for early-boot userspace
 tasks if the policy supports the new capability
From: Guido Trentalancia <guido@trentalancia.com>
To: Ondrej Mosnacek <omosnace@redhat.com>, stephen.smalley.work@gmail.com, 
	paul@paul-moore.com
Cc: selinux@vger.kernel.org
Date: Mon, 09 Jun 2025 16:33:50 +0200
In-Reply-To: <CAFqZXNufHFEA8304qvTi8znWUmrznqyywWMDJYgBASN+VbvLSA@mail.gmail.com>
References: <1748100564.11369.2.camel@trentalancia.com>
	 <CAFqZXNufHFEA8304qvTi8znWUmrznqyywWMDJYgBASN+VbvLSA@mail.gmail.com>
X-Priority: 1
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfH5bQbsxh98vzItywqUFWq8IRlTG9cIkvKqyhsz0xAL8oVMKzWmzeh7z2n0Gj72a08zoRS9zlSPUn68tSJGCH0FhfJcGPp0pWADFtfvGKlUWamX2OI39
 0ejNiAkZZILpO5cjVqnY1awJIqSqgs72ligQmvunNIWg7XCO3Zjr2zA7s19D2OIdiuro7IK4do/rN6tGlNYwFjWr3VaSo8eoZpX2Rq7im4/jDSx/KtTKBwPt
 o8z52YIykB0eO100IV11UjjNnf63ux0e0oVcwTN/KzYTx/eNa10UgDzm2CF9OeKEhAOLX0F3bjB14CH2YZW3xg==

Can you please check if this v2 patch sorts out the issue ? It does
sort things for me...

Before the policy is loaded, only set the initial SID
for early-boot userspace tasks if the policy supports
such capability.

We cannot actually check if the policy supports the new
POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT capability, so
we perform a speculative call to security_transition_sid()
with SECINITSID_INIT as the SID parameter and check
if it returns SECINITSID_INIT and no transition is
defined.

See: https://github.com/dracut-ng/dracut-ng/issues/377

Fixes: ae254858ce07 ("selinux: introduce an initial SID for early boot processes")
Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
---
 security/selinux/hooks.c |   30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

--- a/security/selinux/hooks.c	2025-06-09 15:25:21.999585231 +0200
+++ b/security/selinux/hooks.c	2025-06-09 16:18:09.470999478 +0200
@@ -2295,6 +2295,7 @@ static int selinux_bprm_creds_for_exec(s
 	struct inode_security_struct *isec;
 	struct common_audit_data ad;
 	struct inode *inode = file_inode(bprm->file);
+	u32 saved_sid;
 	int rc;
 
 	/* SELinux context only depends on initial program or script and not
@@ -2314,16 +2315,29 @@ static int selinux_bprm_creds_for_exec(s
 	new_tsec->sockcreate_sid = 0;
 
 	/*
-	 * Before policy is loaded, label any task outside kernel space
-	 * as SECINITSID_INIT, so that any userspace tasks surviving from
-	 * early boot end up with a label different from SECINITSID_KERNEL
-	 * (if the policy chooses to set SECINITSID_INIT != SECINITSID_KERNEL).
+	 * Before policy is loaded, label any task outside kernel space as
+	 * SECINITSID_INIT, so that any userspace task surviving from early
+	 * boot ends up with a label different from SECINITSID_KERNEL: this
+	 * is needed to support the new POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT
+	 * capability.
+	 *
+	 * Because the policy is not loaded yet, we cannot check whether such
+	 * capability is enabled in the policy, hence we check if a call to
+	 * security_transition_sid() returns SECINITSID_INIT when called with
+	 * SECINITSID_INIT and there is no transition defined.
 	 */
 	if (!selinux_initialized()) {
-		new_tsec->sid = SECINITSID_INIT;
-		/* also clear the exec_sid just in case */
-		new_tsec->exec_sid = 0;
-		return 0;
+		saved_sid = current_sid();
+		rc = security_transition_sid(SECINITSID_INIT, SECINITSID_INIT,
+					     SECCLASS_PROCESS, NULL,
+					     &new_tsec->sid);
+		if (rc && new_tsec->sid == SECINITSID_INIT) {
+			/* also clear the exec_sid just in case */
+			new_tsec->exec_sid = 0;
+			return 0;
+		} else {
+			new_tsec->sid = saved_sid;
+		}
 	}
 
 	if (old_tsec->exec_sid) {

On Thu, 05/06/2025 at 14.45 +0200, Ondrej Mosnacek wrote:
> On Sat, May 24, 2025 at 5:32 PM Guido Trentalancia
> <guido@trentalancia.com> wrote:
> > 
> > Before the policy is loaded, only set the initial SID
> > for early-boot userspace tasks if the policy supports
> > such capability.
> > 
> > Check for POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> > otherwise preserve the old behavior of using the
> > SECINITSID_KERNEL label for early-boot userspace
> > processes.
> > 
> > Fixes: ae254858ce07 ("selinux: introduce an initial SID for early
> > boot processes")
> > Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
> > ---
> >  security/selinux/hooks.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/security/selinux/hooks.c  2025-05-24 14:37:45.499997561 +0200
> > +++ b/security/selinux/hooks.c  2025-05-24 14:36:58.453997848 +0200
> > @@ -2319,7 +2319,7 @@ static int selinux_bprm_creds_for_exec(s
> >          * early boot end up with a label different from
> > SECINITSID_KERNEL
> >          * (if the policy chooses to set SECINITSID_INIT !=
> > SECINITSID_KERNEL).
> >          */
> > -       if (!selinux_initialized()) {
> > +       if (!selinux_initialized() &&
> > selinux_policycap_userspace_initial_context()) {
> >                 new_tsec->sid = SECINITSID_INIT;
> >                 /* also clear the exec_sid just in case */
> >                 new_tsec->exec_sid = 0;
> > 
> 
> This doesn't make sense - obviously you can't check what capabilities
> the policy supports when it's not loaded yet... Does the current
> behavior break something for you?
> 
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
> 
> 
