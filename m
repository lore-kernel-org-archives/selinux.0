Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2EQPXZ005724
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 09:26:25 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2EP44G009003
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 14:25:04 GMT
Subject: RE: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <00ba01c4c0e5$29f78e70$1e0c010a@columbia.tresys.com>
References: <00ba01c4c0e5$29f78e70$1e0c010a@columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1099405366.31739.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 09:22:46 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-02 at 09:06, Frank Mayer wrote:
> But my instinct still says that orthogonal, rather than hybrid, TE/MLS would be
> better.  I'm trying to read up on the reasons for the design decision but
> perhaps you could explain further the rationale for the dependency (other than
> implementation detail).

MLS requires some way to identify trusted subjects and grant them the
necessary privileges to override the BLP restrictions.  How would you do
it?  Conventional approaches include POSIX.1e capabilities (e.g. if the
process has the CAP_MAC_WRITE capability, it can write down) or TE (e.g.
if the policy contains "allow foo_t bar_t:file mls_writedown;" then a
process in "foo_t" can write down to files labeled "bar_t").  Either
approach lets you bind MLS privileges to specific programs, but the
TE-based approach is clearly finer-grained (per-object) and provides
better support for protecting and isolating the trusted subject.  We
didn't invent this idea, TE has been used in this manner from the
beginning IIUC (and we have certainly used it in this manner in research
predecessors of SELinux).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
