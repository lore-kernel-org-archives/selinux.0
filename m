Subject: Re: [selinux] Re: SElinux vs. Grsecruity vs. RSBAC (vs.
	TrustedBSD?)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <200308262106.21978.russell@coker.com.au>
References: <FAB2059733EB46409AD28AC957F663F70BEE5C@pusmde04.mt.pweh.com>
	 <20030825170259.GB4409@rahul.net> <1061889339.1665.1548.camel@kusturica>
	 <200308262106.21978.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1061902509.23880.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 26 Aug 2003 08:55:09 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-08-26 at 07:06, Russell Coker wrote:
> The patches are in some cases large and in some cases weren't done in the way 
> the upstream desired.  With the new SE Linux a focus will be made by me and 
> other people who are involved in getting the patches accepted upstream.  This 
> does not have to require that much work by the NSA people.  The NSA have 
> limited resources to spend on this, I think it's best for everyone if they 
> concentrate on kernel work and other things that they are best at, while 
> people from distributions deal with getting patches merged upstream (what 
> they are best at).

I think that the many of the userland patches have been significantly
streamlined and cleaned up as part of reworking them for the new SELinux
API (this reworking of the userland patches was done by Dan Walsh of Red
Hat), so it should be easier to get them upstream now.  It should also
help that the underlying kernel APIs are stable and in mainline 2.6, and
that SELinux itself is now in mainline 2.6.

> > Not a directly technical but very important consideration: selinux
> > is the first and yet only MAC model in the upstream kernel, and is
> 
> Along with DTE.  But DTE does not have the level of support that SE Linux has.

To clarify, DTE is not currently in the upstream Linux kernel.  Last I
checked, the only security modules that are upstream are the dummy
module (traditional uid 0 logic), capability (Linux/POSIX.1e
capabilities), root_plug (sample module by Greg KH for a LJ article),
and SELinux.

> I suspect that SE Linux would not work out of the box on TBSD.  SE Linux 
> configuration needs to know the locations of files and device names.  There 
> is no support for TBSD device and file names in the sample policy, so either 
> the TBSD people have been holding back on us or they don't have good policy 
> support yet.  I would be happy to assist anyone who wants to develop sample 
> policy for TBSD and/or to run a TBSD play machine.

The SEBSD project has its own policy configuration.  Merging the two
policies don't seem like a good idea, although there can certainly be
some sharing for common applications.  It isn't important to have a
single unified policy configuration for both SELinux and SEBSD, but it
is important to retain compatibility at the policy.conf level so that
policy tools will work with both.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
