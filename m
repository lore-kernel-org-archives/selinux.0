Subject: RE: Denials from newest kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Joy Latten <latten@us.ibm.com>, Joshua Brindle <jbrindle@tresys.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <36282A1733C57546BE392885C0618592015CFC0C@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592015CFC0C@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:21:57 -0400
Message-Id: <1160148117.12253.106.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 11:11 -0400, Venkat Yekkirala wrote:
> Joshua Brindle wrote:
> > On Fri, 2006-10-06 at 10:23 -0400, Venkat Yekkirala wrote:
> > > > -----Original Message-----
> > > > From: Joshua Brindle [mailto:jbrindle@tresys.com]
> > > > Sent: Friday, October 06, 2006 8:56 AM
> > > I would have to refer you to the following discussion we had on how
> > > secpoint err secmark is intended to be used thru to deciding not to
> > > mess with the naming.
> > > http://marc.theaimsgroup.com/?l=selinux&m=115928609916717&w=2
> > 
> > That peer conversation was bin/null'd though,
> 
> Stephen and others can correct me if I am wrong, but while
> the naming was bin/null'd AFTER the con call, the policy was
> going to be done substantially as related in the peer conversation.

Correct.  BTW, that's /dev/null to most people ;)

> > 1) domains send/recv packets
> 
> 1(a). packets "carry" originating socket domains
> 1(b). domains "recv" from other domains the packets are "carrying".
> 
> > 2) packets flow_in and flow_out associations
> 
> 2(a) Associations again merely "carry" the domain of the originating socket
>      and as such are not of much relevance.
> 2(b) domains as carried by packets can either flow_in or flow_out of
>      the security points as defined using the secmark rules.
> 
> > 3) domains polmatch spd's (which are classified as associations)
> 
> I wish the association class were renamed more like "ipsec" considering
> the only 2 perms used in there are polmatch and setcontext.
> 
> > 4) domains sendto/recvfrom associations
> 
> In the compat_net case, yes. But not in the secmark world.
> 
> > 
> > IMO we need to get the permissions and object classes cleared 
> > up before
> > merging this stuff, its very confusing and inappropriate right now.

More importantly:
- We need to fix real bug (e.g. incorrect source or target context for a
given check, incorrect set of checks applied on some operation/code
path).
- We need to document what the checks mean and how they are applied so
that policy writers can understand them.

Renaming them doesn't really help.  Classes have always been a fairly
artificial construct, and you can see that already in the existing
checks prior to this work.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
