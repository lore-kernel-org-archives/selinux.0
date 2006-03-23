Subject: Re: How can modular policy ever have worked? [patch]
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Erich Schubert <erich@debian.org>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1142958084.28649.14.camel@sgc.columbia.tresys.com>
References: <1142691657.4017.23.camel@wintermute.xmldesign.de>
	 <1142865553.16487.21.camel@moss-spartans.epoch.ncsc.mil>
	 <1142867787.6145.18.camel@wintermute.xmldesign.de>
	 <1142873874.20739.54.camel@sgc>
	 <1142958084.28649.14.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 15:12:44 -0500
Message-Id: <1143144764.28120.419.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-03-21 at 11:21 -0500, Christopher J. PeBenito wrote:
> I've committed all of the prerequisite changes.  The patch to enable
> optionals in base is attached; when I apply it, I get:
> 
> Compiling refpolicy policy.20
> /usr/bin/checkpolicy policy.conf -o policy.20
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> libsepol.expand_module: Error while indexing out symbols
> Error while expanding policy
> make: *** [policy.20] Error 1
> 
> when compiling monolithic.  This is on last week's release versions of
> the toolchain.  It doesn't happen with the default base module from make
> conf, but if you add enough modules to base, it will also hit this
> error.

FYI, this was fixed in checkpolicy 1.30.1, available in sourceforge cvs.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
