Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1181745113.17547.357.camel@moss-spartans.epoch.ncsc.mil>
References: <1181591750.8805.151.camel@moss-spartans.epoch.ncsc.mil>
	 <1181654688.17547.110.camel@moss-spartans.epoch.ncsc.mil>
	 <1181681436.17547.280.camel@moss-spartans.epoch.ncsc.mil>
	 <1181682766.17547.304.camel@moss-spartans.epoch.ncsc.mil>
	 <1181745113.17547.357.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 13 Jun 2007 11:06:37 -0400
Message-Id: <1181747197.21771.5.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-13 at 10:31 -0400, Stephen Smalley wrote:
> Updated policy patch below, defines the new class and permissions,
> and introduces an interface for allowing the cap_override permissions
> that ensures that these domains are excluded from the set of domains
> that can be controlled by unconfined domains.

[...]

> +interface(`domain_capoverride',`

I would probably call this domain_capability_override() or
domain_cap_override(), maybe even domain_authoritative_caps().

> +	gen_require(`
> +		attribute capoverride_domain_type;
> +	')
> +
> +	typeattribute $1 capoverride_domain_type;
> +
> +	allow $1 self:cap_override $2;

I think it would be better to just have the allow rule in the TE file.
Then you can put your cap_override and capability allow rules next to
each other and see more clearly which ones are being overridden and
which aren't.

> +')

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
