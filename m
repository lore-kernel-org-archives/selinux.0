Subject: RE: ipsec and getpeercon()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Joy Latten <latten@us.ibm.com>,
        selinux@tycho.nsa.gov, paul.moore@hp.com
In-Reply-To: <36282A1733C57546BE392885C061859201512CD9@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C061859201512CD9@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 09:41:50 -0400
Message-Id: <1157118110.26621.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-01 at 09:16 -0400, Venkat Yekkirala wrote:
> > Ok, aside from the bug I'm apparently experiencing (Joy is 
> > looking in to
> > it) I think I have misunderstood what getpeercon() is suppose 
> > to do over
> > ipsec. I was under the impression it would act like getpeercon() over
> > unix stream sockets and get the context of the application on 
> > the other
> > side of the socket but that is apparently not what getpeercon() for
> > ipsec does.
> 
> It should indeed return the peer's context when using ipsec as well.
> I would consider the current behaviour as a bug. Joy is looking but
> I will try to take a look as well.

I'd tentatively guess that the lack of any definition or rules
authorizing polmatch is causing the SAs to be left unlabeled.

But Joshua's point about needing to manually define spd entries per
context (at least per TE domain/type, even if using a MLS range), would
still hold, right?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
