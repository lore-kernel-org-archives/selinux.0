Subject: RE: checkpolicy is broken (which is not)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: russell@coker.com.au, dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <SNT139-W640BE6F3829A2C5D982BDDAB210@phx.gbl>
References: <4E3AEA75.3090602@redhat.com>
	 ,<1312550851.19283.35.camel@moss-pluto> <4E3C0152.7000105@redhat.com>
	 ,<201108060130.49464.russell@coker.com.au>
	 ,<1312561259.19283.76.camel@moss-pluto>
	 <SNT139-W640BE6F3829A2C5D982BDDAB210@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 08 Aug 2011 08:01:55 -0400
Message-ID: <1312804915.29877.4.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-08-08 at 06:41 +0000, HarryCiao wrote:
> Hi Stephen,
> 
> As for removing above "ambiguity between declaration and use", so it
> would be desirable to remove the association between a regular type
> and type attributes in the current type-attribute rule, and shrink it
> to some "type" rule only for type declaration, and request policy
> writers to setup the association explicitly via the typeattribute
> rule. 
> 
> Also we should handle roles in a similar way: use some "role" rule
> solely for role declaration and "attribute_role" rule for role
> attribute declaration, then "roleattribute" rule for setting up their
> associations.
> 
> Is that right?
> 
> Also this would introduce significant change to the original
> type-attribute rule, how would it be easier for the community to
> accept such change?

I'm not asking for any further changes to the language, just explaining
the analogy to the type-related statements.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
