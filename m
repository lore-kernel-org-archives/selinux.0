Subject: Re: PATCH: peersid capability support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        "Todd C. Miller" <tmiller@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <200712031232.17773.paul.moore@hp.com>
References: <200711301734.lAUHYKFJ031076@cadmus.columbia.tresys.com>
	 <200711301748.05733.paul.moore@hp.com> <4750A883.5070906@tresys.com>
	 <200712031232.17773.paul.moore@hp.com>
Content-Type: text/plain
Date: Mon, 03 Dec 2007 13:21:44 -0500
Message-Id: <1196706104.27820.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-12-03 at 12:32 -0500, Paul Moore wrote:
> On Friday 30 November 2007 7:19:15 pm Joshua Brindle wrote:
> > Paul Moore wrote:
> > > 5. Tried installing the module
> > > /usr/sbin/load_policy:  Can't load policy:  Invalid argument
> > > libsemanage.semanage_reload_policy: load_policy returned error code 2.
> > > semodule:  Failed!
> > >
> > > Help/Ideas?
> >
> > dmesg should have the error if load_policy fails.
> 
> I haven't had a chance to look into it yet, but this is the only thing I can 
> see in dmesg that looks related ...
> 
>  security: ebitmap: map size 4 does not match my size 64 (high bit was 4)

Looks like the libsepol patch puts the policycaps ebitmap at a different
location in the policy image than the kernel patch expects.  Todd,
please fix.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
