Subject: Re: policy hierarchy patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <425AE087.7090001@trustedcs.com>
References: <1112631282.19526.18.camel@localhost>
	 <1112635440.7629.125.camel@moss-spartans.epoch.ncsc.mil>
	 <1112643447.19527.30.camel@localhost>  <4251BA1E.9040406@trustedcs.com>
	 <1112709782.19531.39.camel@localhost> <425320BD.5050207@trustedcs.com>
	 <425456F1.5000905@trustedcs.com>
	 <1112877155.27110.15.camel@moss-spartans.epoch.ncsc.mil>
	 <42556015.6090405@trustedcs.com> <1112907833.19565.9.camel@localhost>
	 <4255A62F.80405@trustedcs.com> <1112984816.10298.5.camel@localhost>
	 <425AE087.7090001@trustedcs.com>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 09:01:31 -0400
Message-Id: <1113483691.373.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-04-11 at 15:39 -0500, Darrel Goeddel wrote:
> Thanks for merging my changes into the main patch.  I have a few additions in 
> the attached patch, which is relative to your latest patch.
> 
> I had a possible double free in define_category.  I added back the declaration 
> for is_valid_identifier in policy_scan.l to avoid a warning.  I also removed 
> including '-' as a valid character in the standard IDENTIFIER (this is what we 
> were after, right?).  There are a few tweaks to the policy Makefile.  The first 
> is changing "s9 : c0.c127" to "s9:c0.c127" - I thought that was a bit more 
> readable.  The second is changing MLS=n to MLS=y in the makefile when running 
> the mlsconvert target.

Thanks, both patches have been merged into sourceforge CVS (except for
the policy patch, which I've separated and forwarded along to Jim Carter
so that he can include it with the next update to policy), as of
libsepol version 1.5.5 and checkpolicy version 1.23.1.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
