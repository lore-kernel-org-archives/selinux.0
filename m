Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA25783
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 08:15:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA00863
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 12:14:30 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA00859
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 12:14:29 GMT
Date: Fri, 16 Aug 2002 08:14:27 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: /bin/login
In-Reply-To: <Pine.GSO.4.33.0208160728480.29385-100000@raven>
Message-ID: <Pine.GSO.4.33.0208160809480.29385-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 16 Aug 2002, Stephen Smalley wrote:

> Yes and no.  As explained in the Security Model section of the Configuring
> the SELinux Policy report (as well as in the older policy report and in
> the Ottawa paper), the SELinux TE model does not internally distinguish
> domains from types and uses a single type attribute in the security
> context for both processes and objects.  Hence, "Enter type" is
> legitimate, as is name for the /etc/security/default_type file.  However,
> if we want to use the language of the traditional TE model, we could make
> this "Enter domain" and /etc/security/default_domain.  No big deal either
> way.

While we're on the topic of nomenclature, I should note that if you want
to get away from TE altogether, just replace "TE" with "Lampson Access
Matrix (LAM)", "domain" with "subject" and "type" with "object".  An
interview with Earl Boebert where he mentions that TE is simply the
"Lampson Access Matrix organized into equivalence classes for efficiency"
is available at http://www.linuxjournal.com/article.php?sid=4963.  He
cites the following reference for the Lampson Access Matrix:

Lampson, Butler W. "Protection." Mar. Proc. 5th Princeton Symp. on
Information Sciences and Systems, 1971, pp.437-443.  Reprinted January
1974 in ACM SIGOPS OSR 8(1), pp.18-24.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
