Subject: Re: [PATCH] policy server API
From: Christopher Ashworth <cashworth@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, selinux-dev <selinux-dev@tresys.com>
In-Reply-To: <1150147826.13647.6.camel@moss-spartans.epoch.ncsc.mil>
References: <1148417141.20016.53.camel@popeye.columbia.tresys.com>
	 <1148494501.517.76.camel@popeye.columbia.tresys.com>
	 <1149008008.19716.1.camel@popeye.columbia.tresys.com>
	 <1150143204.8086.159.camel@moss-spartans.epoch.ncsc.mil>
	 <1150144439.3003.18.camel@popeye.columbia.tresys.com>
	 <1150147826.13647.6.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 10:18:57 -0400
Message-Id: <1150208337.13179.30.camel@popeye.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-06-12 at 17:30 -0400, Stephen Smalley wrote:

> I'd like something with which to exercise the new code.

Understood.  Please consider this just an RFC for now, and we will
resubmit when a test suite or an update to the policy server is
available.
> 
> > Our thinking here was that the public APIs that already exist are
> using
> > ints.  (e.g. module_list)  We opted for the internal check and
> > consistent use of int externally rather than changing the public
> API,
> > but we could certainly go uint32_t throughout if you prefer.
> 
> Even if you keep the interface as is, I'm not sure why you cast to
> unsigned int for comparison (and when will this be > UINT32_MAX?) and
> then later to uint32_t.

The cast to unsigned is to eliminate the compile time warning of
comparison between a signed and unsigned.  Granted, it will not be
greater than UINT32_MAX currently, but nonetheless the spec only
mandates that an unsigned int is at least 16 bits.  A happily moot point
in the event of changing everything to a uint32.
> 
> No, we just don't want it to crash, i.e. it just needs to propagate
> errors properly to the client program, and the client program will
> hopefully generate a (admittedly uninformative) error message already.

Ah, in that case, with the printout removed it behaves as desired.

Thanks for the feedback; we will resubmit when your points are addressed
and a test is available.  What do you prefer regarding the uint32
question?

Chris


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
