Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5HIV8rT011824
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 14:31:08 -0400 (EDT)
Received: from smtp-bedford.mitre.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5HIUwMX022183
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 18:30:59 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i5HIV6l10329
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 14:31:06 -0400
Received: from divan.mitre.org (divan.mitre.org [129.83.10.75])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i5HIV4s10315
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 14:31:04 -0400
Received: from divan.mitre.org (localhost [127.0.0.1])
	by divan.mitre.org (8.12.11/8.12.10) with ESMTP id i5HIV4FE030752
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 14:31:04 -0400
To: selinux@tycho.nsa.gov
Subject: Re: Fedora Core 2 setools RPM
References: <200406171535.i5HFZVSf032291@gotham.columbia.tresys.com>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 17 Jun 2004 14:31:04 -0400
In-Reply-To: <200406171535.i5HFZVSf032291@gotham.columbia.tresys.com>
Message-ID: <ogtoenic9zr.fsf@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Karl MacMillan" <kmacmillan@tresys.com> writes:

> In general, we have not spent many resources addressing the use of
> libapol outside of setools.

>From my perspective, the application programmer's interface provided
by libapol seems to provide an attractive platform on top of which I
should be able to build a version of slat that can analyze binary
policy configuration files.  The alternative for me is to cobble
something together from the sources in the checkpolicy directory.  My
guess is that I would have to duplicate functionality already present
in libapol.

My greatest concern with using libapol for slat is that it seems to
provide no routines that expose CONSTRAIN statements in a policy.
When I did a grep on the sources, I notice the word "constrain" is not
in any header file but one, and libapol/binpol/borrowed.h contains the
following comment.

/* needed for constraints (which apol currently ignores */

John

$ grep -i constrain libapol/*.* libapol/*/*.*
libapol/apolicy_parse.y:/* from originial constraint.h */
libapol/apolicy_parse.y:typedef struct constraint_expr {
libapol/apolicy_parse.y:	struct constraint_expr *left;
libapol/apolicy_parse.y:	struct constraint_expr *right;
libapol/apolicy_parse.y:} constraint_expr_t;
libapol/apolicy_parse.y:/* end from constraint.h */
libapol/apolicy_parse.y:static int define_constraint(void);
libapol/apolicy_parse.y:static constraint_expr_t *define_cexpr(__u32 expr_type, __u32 arg1, __u32 arg2);
libapol/apolicy_parse.y:%token CONSTRAIN
libapol/apolicy_parse.y:			  opt_mls te_rbac users opt_constraints 
libapol/apolicy_parse.y:/* added July 2002; made constraints optional */
libapol/apolicy_parse.y:opt_constraints         : constraints
libapol/apolicy_parse.y:constraints		: constraint_def
libapol/apolicy_parse.y:			| constraints constraint_def
libapol/apolicy_parse.y:constraint_def		: CONSTRAIN names names cexpr ';'
libapol/apolicy_parse.y:			{ if (define_constraint()) return -1; }
libapol/apolicy_parse.y:static int define_constraint(void)
libapol/apolicy_parse.y:static constraint_expr_t *
libapol/apolicy_parse.y:	return (constraint_expr_t *)1; /* any non-NULL value */
libapol/apolicy_scan.l:CONSTRAIN |
libapol/apolicy_scan.l:constrain			{ return(CONSTRAIN); }
libapol/binpol/binpol.c:	 * buf[5] num constraints (ignore constraints) */	
libapol/binpol/binpol.c:	/* ignore constraints */
libapol/binpol/borrowed.h:/* needed for constraints (which apol currently ignores */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
