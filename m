Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k27LIkbi006803
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 16:18:50 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k27LIiRX017796
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 21:18:44 GMT
Subject: Re: refpoliy additions: amavis, clamd
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1140910677.1392.20.camel@wintermute.xmldesign.de>
References: <1140910677.1392.20.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 16:23:04 -0500
Message-Id: <1141766584.30819.165.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-02-26 at 00:37 +0100, Erich Schubert wrote:
> Hi,
> attached are first versions of policies for amavis and clamd, along with
> a slightly updated tor policy (which needs tor ports defined in
> corenetwork!)
> 
> Looks like I might actually be arriving at a point where I can switch
> into enforcing mode... ;-)

Merged, with some notes:

Renamed the clamd module to clamav.

I dropped the clamscan_exec_t type.  Looking at the example policy, it
doesn't look like this was completed, as the per-user domains can't even
read the user's files.  It seems to me that this was over-engineered
before, it would probably be better for the user domains just to be
allowed to connect to clamd, and they'll already have access to their
files to send over the unix domain socket.

Clamd_sock_t should probably be folded in to clamd_var_run_t, as there
doesn't seem to be a need for them to be separate, like in daemons such
as mysql.

Please put informative summaries for the modules.  "Policy for clamd"
does not tell you anything if you don't know what clamd is, and it
should be obvious that it is policy. :)

I did some reordering of the rules to be consistent with the rest of
refpolicy.

There were a few instances of types being explicitly referenced though
they are not owned by the module (e.g., initrc_t in clamav); this is not
allowed.

Comments like these:

	# use random
	dev_read_rand(amavis_t)
	dev_read_urand(amavis_t)

	# use ldap
	ldap_use(amavis_t)

aren't really needed, since they don't tell you anything more than the
interface names already do.

I need a corenetwork patch for the tor port.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
