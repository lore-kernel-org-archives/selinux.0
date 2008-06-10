Subject: Re: tracking down execstack & execmem violations
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <0794F277152EF94AA637E3AECF5CB70FB9EAC8@blums0042.bluelnk.net>
References: <0794F277152EF94AA637E3AECF5CB70FB9EAC8@blums0042.bluelnk.net>
Content-Type: text/plain
Date: Tue, 10 Jun 2008 13:15:22 -0400
Message-Id: <1213118122.30576.147.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-06-10 at 10:10 -0700, Clarkson, Mike R (US SSA) wrote:
> I'm writing a policy for a very large legacy CORBA application, with
> many separate processes. Without fail, every one of our processes
> requires execstack & execmem privileges. I would like to track down the
> cause, but I really don't have any idea how. Does anybody have any good
> recommendations?
> 
> I'd like to at least be able to determine whether the offending code is
> ours or some vender's (like our CORBA vender), and if it is ours I'd
> like to track down the source. I'm betting there is a common source
> causing the issue.

Resources:
http://people.redhat.com/drepper/selinux-mem.html
http://people.redhat.com/drepper/nonselsec.pdf

Also, what does execstack -q show for the executables in question?
And are these programs:
- multi-threaded?,
- Java-based?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
