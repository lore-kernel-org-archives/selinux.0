Subject: Re: Use of type_change and type_transition declarations
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Mario Fanelli <mario.fanelli@gmail.com>,
        SeLinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <1148996823.14262.105.camel@sgc.columbia.tresys.com>
References: <447b3031.200d0097.6f44.118c@mx.gmail.com>
	 <1148996823.14262.105.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 30 May 2006 11:09:45 -0400
Message-Id: <1149001785.524.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-30 at 09:47 -0400, Christopher J. PeBenito wrote:
> On Mon, 2006-05-29 at 19:32 +0200, Mario Fanelli wrote:
> > I don’t understand what means type_change declaration. 
> > 
> > Anyone can give me an explanation? What are the difference between
> > type_change and type_transition declarations? 
> > 
> > If I declare a type_transition like type_transition dom1_t
> > dom2_exec_t:process dom2_t, why I have to use an allow rule?
> 
> type_change is information that userland programs use for relabeling
> (retrieved by security_compute_relabel()), it does not do anything by
> itself.  The current use of type_change is to tell login programs what
> label the user's terminal should be relabeled to.
> 
> type_transition changes the default type when a new object is created,
> it does not allow access.  The default type is the type of the
> container; for example, a file's default type is the type of the
> directory it is being created in.  When used on processes like your
> example above, dom1_t will exec() dom2_exec_t and the new process will
> be in dom2_t, assuming the transition is allowed.

To answer the latter question (why does one have to specify an allow
rule given that one has specified a type_transition rule), we chose to
keep separate the default labeling rules (type_transition) from the
access rules (allow) so that:
1) The full set of permitted accesses is captured in the allow rules, so
they are sufficient for analysis of potential information flow, and
2) The precise set of permitted accesses can be customized for different
transitions.

Note that type transitions only specify default behaviors;
security-aware applications can override those defaults via the SELinux
API if allowed to do so by policy.  Only the allow rules are
authoritative.

The policy compiler could auto-generate the minimal set of allow rules
required to allow a given type_transition, but one would still need to
specify some allow rules related to the transition (e.g. inheritance of
state) and that would then require analyzers to factor in the
type_transition rules as well.

Note that at least some of your questions could be answered by reading
the existing (admittedly stale) documentation, e.g.
http://www.nsa.gov/selinux/papers/policy2/t1.html

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
