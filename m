Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VDGjrT012067
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 09:16:45 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VDFtID020742
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 13:15:56 GMT
Date: Tue, 31 Aug 2004 14:27:56 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: banning copying of binaries (e.g. mozilla etc).
Message-ID: <20040831132756.GH11456@lkcl.net>
References: <20040830222355.GI31497@lkcl.net> <1093951787.8517.11.camel@moss-spartans.epoch.ncsc.mil> <20040831122506.GE11456@lkcl.net> <1093955694.8517.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1093955694.8517.51.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 31, 2004 at 08:34:54AM -0400, Stephen Smalley wrote:
> On Tue, 2004-08-31 at 08:25, Luke Kenneth Casson Leighton wrote:
> >  ... so it acts a bit like a firewall in this respect?
> 
> Yes, but on the basis of process domains.  Not intended to replace a
> traditional firewall, but to allow control of data flow among domains
> via socket IPC.  To completely support this, one needs labeled
> networking, but the existing mechanism lets you at least control locally
> based on process domain, port type, netif type, and node type.
 
 ... so port type equates to port number.

> >  and, can the _user_ decide to add rules such as mozilla can access
> >  port 8080?
> 
> This can be checked on the client side, as the client OS can perform a
> check based on the sending process domain and the destination port
> type.  In order to do it on the server side as well, we would need
> labeled networking to convey the sending process domain to the server
> OS.  The policy administrator can define such rules.  For user-definable
> rules, you would need a policy daemon that allows users to apply
> specific well-defined changes to the policy without completely changing
> it.
> 
> >  whereas with the "targetted" policy it's the other way round.
> 
> That's not really accurate.  

 ah - an oversimplified tutorial to make it easy to understand.

> >  i would like to provide a mechanism whereby any binary that has an
> >  associated DENY-firewall rule with it, that someone cannot simply
> >  copy that binary to a different name, run _that_ binary and thereby
> >  bypass the DENY-firewall rule [associated with the original binary].
> 
> As I said, you can prevent a domain from executing anything it can
> create/write, and this is good practice for daemons, but difficult to
> impose on users.  Simply preventing copying is pointless.
 
 ... but it would be easy to, say, deny users the ability to execute
 user_u:object_r:user_t binaries, or default_t binaries etc. yes?


> >  if the rules are by default "allow all" and "deny individual", then
> >  surely by copying a binary and running it, it's possible to bypass
> >  the "deny individual" rules???
> > 
> >  tell me that's not so...
> 
> That isn't the way targeted policy works.  It still has to specify
> everything allowed; it just allows more.
 
  *whew*.

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
