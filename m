Date: Fri, 27 Mar 2009 12:26:32 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Jarrett Lu <Jarrett.Lu@sun.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, selinux@tycho.nsa.gov, nfsv4@ietf.org
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted to IETF	website
Message-ID: <20090327172632.GA9992@Sun.COM>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <49C9F0E1.1040202@sun.com> <20090325163317.GV9992@Sun.COM> <49CB4A18.3090709@sun.com> <20090326150934.GR9992@Sun.COM> <49CBFB94.6030408@sun.com> <20090327001102.GU9992@Sun.COM> <1238158539.15207.6.camel@localhost.localdomain> <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49CD06E7.6030802@sun.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Mar 27, 2009 at 10:03:35AM -0700, Jarrett Lu wrote:
> I agree with your statements on TE vs. MLS/BLP. The problem we try to 
> solve is whether a DOI field + an opaque string is sufficient to solve 
> the interoperability problem. My opinion is that it's insufficient as it 
> doesn't take the "how to interpret MAC attribute agreement among all 
> communicating peers" into account. The current proposal seems to assume 
> when a node sees a DOI value of 5, it knows how to interpret the opaque 
> field. This may not be true. In MLS, one also needs to know which agreed 
> upon label encoding file to use in order to interpret label in the 
> opaque filed. I believe the same is true for TE -- one needs to know the 
> security policy being used in order to correctly interpret security 
> context string in the opaque field. DOI + opaque field doesn't say which 
> label encoding scheme or which security policy.

What would you add or remove on the wire to solve this problem?  My
guess: a registry of per-DOI rules, like CALIPSO does.  I don't think a
registry of DOI rules is strictly necessary for NFS (though I can see
how it helps in the case of IP), but I certainly don't object.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
