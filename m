Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1KVbXZ029990
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 15:31:37 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1KVbfG007521
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 20:31:37 GMT
Subject: RE: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <004301c4c04e$0b8f0180$1e0c010a@columbia.tresys.com>
References: <004301c4c04e$0b8f0180$1e0c010a@columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1099340881.21386.228.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Nov 2004 15:28:01 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 15:04, Frank Mayer wrote:
> I'm still not clear on why TE needs to control MLS.  It seems to me that both
> types of access control should be necessary, neither should be sufficient, in
> order to obtain access.

TE provides a way to identify and control MLS trusted subjects with much
finer granularity than POSIX.1e capabilities, e.g. see 
http://www.securecomputing.com/pdfs/secureos.pdf.  You can then identify
specific domains as having specific MLS privileges and further confine
their ability to use those MLS privileges to specific objects (e.g.
per-file mls_writedown capability).  MLS model needs some external
mechanism for granting such privileges since it has no internal
construct for it, and TE provides a strong basis since you can bind the
privilege to specific code and apply it with fine granularity.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
