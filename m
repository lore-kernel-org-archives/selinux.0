Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA11399
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 01:42:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA26399
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 05:40:54 GMT
Received: from unicorn.lemuria.org (b067207.adsl.hansenet.de [62.109.67.207])
	by jazzswing.ncsc.mil  with ESMTP id FAA26395
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 05:40:53 GMT
Date: Wed, 2 Oct 2002 07:42:01 +0200
From: Tom <tom@lemuria.org>
To: Tracy R Reed <treed@ultraviolet.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: SE Linux on Debian
Message-ID: <20021002074201.C28663@lemuria.org>
References: <20021001153638.J5416@ultraviolet.org> <20021002014815.GB14890@snoopy.apana.org.au> <20021001221022.B18667@ultraviolet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021001221022.B18667@ultraviolet.org>; from treed@ultraviolet.org on Tue, Oct 01, 2002 at 10:10:22PM -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 01, 2002 at 10:10:22PM -0700, Tracy R Reed wrote:
> On Wed, Oct 02, 2002 at 11:48:15AM +1000, Brian May spake thusly:
> > I think you are looking for the coreutils, fileutils, shellutils, and
> > procps packages.
> 
> But are those patched for SE Linux?

yes, they are. look into the version string, if it has "bam" in it,
it's the patched version.


> home:/etc/selinux# make
> mkdir -p /etc/security/selinux
> /usr/sbin/checkpolicy -o tmp/pol /etc/security/selinux/src/policy.conf
> /usr/sbin/checkpolicy:  loading policy configuration from
> /etc/security/selinux/src/policy.conf
> ERROR 'name conflict for type run_deb_t' at token ';' on line 121201:
> #
> type run_deb_t, domain, privrole, privuser, privlog, auth;
> /usr/sbin/checkpolicy:  error(s) encountered while parsing configuration
> make: *** [/etc/security/selinux/policy.12] Error 1

you need to delete two files:

/etc/selinux/domains/program/run_deb.te
/etc/selinux/domains/program/run_init.te

their content was moved into other files, so they are not needed
anymore now and result in the above conflict



-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
