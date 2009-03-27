Subject: Re: [Labeled-nfs] [nfsv4] New MAC label support Internet Draft
 posted to IETF	website
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Williams <Nicolas.Williams@Sun.COM>
Cc: Jarrett Lu <Jarrett.Lu@Sun.COM>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org, nfsv4@ietf.org
In-Reply-To: <20090327001102.GU9992@Sun.COM>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
	 <49C9F0E1.1040202@sun.com> <20090325163317.GV9992@Sun.COM>
	 <49CB4A18.3090709@sun.com> <20090326150934.GR9992@Sun.COM>
	 <49CBFB94.6030408@sun.com>  <20090327001102.GU9992@Sun.COM>
Content-Type: text/plain
Date: Fri, 27 Mar 2009 08:55:39 -0400
Message-Id: <1238158539.15207.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-03-26 at 19:11 -0500, Nicolas Williams wrote:
> On Thu, Mar 26, 2009 at 03:03:00PM -0700, Jarrett Lu wrote:
> > CALIPSO spec doesn't tie a DOI with a particular label encoding. For 
> 
> CALIPSO is very specific about label domination -- that means that
> having any application protocol w/ labeling above IP requires that we be
> able to determine whether an application-level label is dominated by a
> CALIPSO label, and the rules given are MLS with Bell-LaPadula.
> 
> Perhaps that does not mean that we must adopt MLS and Bell-LaPadula at
> the application layer, but it certainly seems like the easiest path,
> particularly if we can also represent DTE that way.

You can't represent Type Enforcement via MLS/BLP; TE is strictly more
expressive than BLP, not the other way around.  It also has no inherent
notion of dominance; the access matrix is explicitly defined and may
include intransitive relationships, which are required for integrity
goals and guaranteed invocation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
