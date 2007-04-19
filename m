Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JKlNqc018353
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 16:47:23 -0400
Received: from ladon.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3JKlMuv014476
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 20:47:22 GMT
Received: from host-118.dtccom.net (host-118.dtccom.net [204.117.95.118] (may be forged))
	by ladon.golden-gryphon.com (8.13.8/8.13.8/Debian-3) with ESMTP id l3JKlA9u024776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 15:47:10 -0500
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by host-118.dtccom.net (8.13.8/8.13.8/Debian-3) with ESMTP id l3JKj4c8007698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 15:45:05 -0500
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Re: ANN: Reference Policy Release
References: <1176822437.11059.3.camel@sgc.columbia.tresys.com>
Date: Thu, 19 Apr 2007 15:45:04 -0500
In-Reply-To: <1176822437.11059.3.camel@sgc.columbia.tresys.com> (Christopher
	J. PeBenito's message of "Tue\, 17 Apr 2007 11\:07\:16 -0400")
Message-ID: <87mz14um9b.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Apr 2007 11:07:16 -0400, Christopher J PeBenito
<cpebenito@tresys.com> said:  

> A new release of the SELinux Reference Policy is now available on the
> Tresys OSS site, http://oss.tresys.com.  The primary change in this
> release is the addition of support for Booleans and tunables in
> modules.  For proper use of modules with Booleans, libsepol 1.16.2 or

        I had hoped that was a typo, since I have just upgraded Debian
 Sid to the stable release, and that means libsepol at
 1.16.1. Unfortunately, I am running into errors trying to  play around
 with the refpolicy, for instance, semodule_deps with the new strict
 policy gives:

,----
| libsepol.scope_copy_callback: miscfiles: Duplicate declaration in
|    module: type/attribute public_content_rw_t 
| semodule_deps:  Error while linking packages
`----

	And loading modules fails on me as well:
,----
| libsepol.expand_module: Error while indexing out symbols
| libsemanage.semanage_expand_sandbox: Expand module failed
| semodule:  Failed!
| Failed to load module rpc.pp
`----

> newer is required.  Smaller changes include the merging of ls_exec_t
> and sbin_t into bin_t, and the removal of disable_trans Booleans in
> the targeted policy.  The complete change log for this release follows
> at the bottom of the email.

        Since this is very early in the lenny release cycle, I would not
 be averse to packaging the development release for lenny (surely our
 release cycles are faster than Debian's), and will do so unless there
 are vocal objections.

        manoj
--
I'm also pre-POURED pre-MEDITATED and pre-RAPHAELITE!!
Manoj Srivastava <manoj.srivastava@stdc.com> <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
