MIME-Version: 1.0
In-Reply-To: <1254226904.2252.28.camel@moss-pluto.epoch.ncsc.mil>
References: <20090908055806.GA24297@myhost.felk.cvut.cz> <20090909100647.GE24297@myhost.felk.cvut.cz>
	<1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil> <200909271734.23340.russell@coker.com.au>
	<1254145079.2257.115.camel@moss-pluto.epoch.ncsc.mil> <f73f7ab80909281622r3c63436gf80bc99852ab7f43@mail.gmail.com>
	<1254226904.2252.28.camel@moss-pluto.epoch.ncsc.mil>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Tue, 29 Sep 2009 09:54:56 -0400
Message-ID: <f73f7ab80909290654l25863d74n7b5919028cfde66d@mail.gmail.com>
Subject: Re: MCS and default labels
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: russell@coker.com.au, Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>,
        selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
        Paul Moore <paul.moore@hp.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 29, 2009 at 08:21, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2009-09-28 at 19:22 -0400, Kyle Moffett wrote:
>> Hmm, I've been thinking about a way to resolve this for a while now...
>>  The company I work for builds trusted guards, and people keep asking
>> us about allowing some amount of secure remote management.
>>
>> I wonder if it is possible to build some kind of automatic IPsec
>> negotiation based on the SELinux MLS label.  Currently you can
>> manually create IPsec tunnels and associate a different *type* with
>> each tunnel, however I can find no way to do a different tunnel per
>> MLS level (on-demand).
>
> Doesn't this get done via labeled IPSEC already? It should request a
> separate SA for each unique sending socket security context.
> http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/

The problem is that there is no way to do catch-all rules *based* on
the MLS label.  For example, if I have a TopSecret wire and I want to
allow (for example) Unclass and TS//SI/TK traffic over it without
risking mixing of data or exposure, there is no way for me to set it
up without a lot of manual and duplicated configuration.  What I want
to happen is:

  (1) If any of 8 different SELinux domains of TS-level processes (IE:
s4) try to communicate out the network interface, the policy is "none"
  (2) If those *same* SELinux domains with any of TS//SI/TK (s4:c1),
TS//BYEMAN (s4:c2) try to communicate, the policy should be
"esp/transport//require", using *different* certificates depending on
the domain.
  (3) Again, if those *same* SELinux domains with U (IE: s1) try to
communicate, the policy would be "ah/transport//require", (and yet
more certificates).

If it's possible to do this with the existing tools, that's great, but
I played around with it for a good long while and was not able to work
out a way to do so.  I suppose at the very least the feature needs
some better documentation :-D.  If the feature does already exist,
then assuming I can get it working, I'd be glad to go write some.

Cheers,
Kyle Moffett


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
