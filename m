Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA27593
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 12:05:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA12979
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 16:04:53 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA12975
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 16:04:53 GMT
Date: Fri, 16 Aug 2002 12:05:03 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Frank Mayer <mayerf@tresys.com>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: RE: proposed patch: policy management
In-Reply-To: <ACEHIKGIGFEDAIKEMMMICEGBKFAA.mayerf@tresys.com>
Message-ID: <Pine.GSO.4.33.0208161203270.29385-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 15 Aug 2002, Frank Mayer wrote:

> It's been pointed out to me that I mistakenly posted the original proposed
> policy patch rather than the updated version.  I've (hopefully) attached the
> correct patch file here.  Sorry for the mix up!

This patch has been committed to the sourceforge CVS tree, with a few
revisions.  The installation procedure has also been updated to install
the policy sources via the new install-src target.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
