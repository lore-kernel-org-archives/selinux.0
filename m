Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VCETrT011573
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 08:14:29 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VCDdID015602
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 12:13:39 GMT
Date: Tue, 31 Aug 2004 13:25:06 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: banning copying of binaries (e.g. mozilla etc).
Message-ID: <20040831122506.GE11456@lkcl.net>
References: <20040830222355.GI31497@lkcl.net> <1093951787.8517.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1093951787.8517.11.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 31, 2004 at 07:29:48AM -0400, Stephen Smalley wrote:
> On Mon, 2004-08-30 at 18:23, Luke Kenneth Casson Leighton wrote:
> > okay, got a weird issue where i am curious as to whether selinux could
> > help.
> > 
> > imagine that ipt_owner has been successfully hacked up (hacked as in
> > the literal and true meaning of the word not the one the press associate
> > with it) to support program names (or as a last resort inodes) as part
> > of the checking / filtering rules.
> >
> > i.e. like fireflier's rather buggy userspace support for allowing
> > e.g. mozilla to do port 80 and port 445 but NOT any other program,
> > only done properly and in the kernel.
> 
> SELinux already allows you to control port binding and socket IPC based
> on the domain, which can encode information about the program as well as
> the caller.  Why do you need additional state and mechanism?
 
 ... so it acts a bit like a firewall in this respect?

 and, can the _user_ decide to add rules such as mozilla can access
 port 8080?

 [assuming that i want to _allow_ users to be able to do that of course]

> > now imagine that someone bypasses these rules by simply copying the
> > binary.
> > 
> > in this way, they would be able to at the very least bypass "DENY"
> > rules.
> 
> You mean "deny program FOO the ability to do X"?  

 DENY as in iptables "DENY" rule.

 the parallels / lessons to be learned between writing selinux policy
 and writing iptables firewall rules are very clear.

 as steven tweedie said in the tutorials (written by russ et al) the
 strict policy you start off with "deny all" and you do "allow" you
 NEVER do "deny one" in strict policy.

 whereas with the "targetted" policy it's the other way round.

 so, likewise, it is necessary to have a strict firewall policy
 where DENY ALL is the default, and "allow one" is added and you
 NEVER do "deny one".

 therefore, that someone raised on the LKML "be careful about adding
 DENY rules" is a bit of a moot point.



> That seems pointless;
> you want to define the set of approved programs, not the set of denied
> programs, as people can alway construct new programs outside of any
> blacklist.
> 
> > my question is, therefore, is there an easy way to ban users from
> > copying binaries, whilst still allowing users to run them?
> 
> The policy can certainly prohibit a given domain from executing anything
> it can create/write.  But I still don't see what you are trying to
> achieve.

 under the circumstances under which someone fails to abide by the good
 practice of not adding a DENY firewall rule in a "strict" iptables
 policy [i.e. the default is DENY ALL at the bottom of the iptables
 chain] then:

 i would like to provide a mechanism whereby any binary that has an
 associated DENY-firewall rule with it, that someone cannot simply
 copy that binary to a different name, run _that_ binary and thereby
 bypass the DENY-firewall rule [associated with the original binary].


 .... in fact.... come to think of it.... isn't there a lesson to be
 learned here with the targetted policy?

 if the rules are by default "allow all" and "deny individual", then
 surely by copying a binary and running it, it's possible to bypass
 the "deny individual" rules???

 tell me that's not so...


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
