Date: Mon, 14 Mar 2005 16:01:58 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
   SELinux Mail List <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com
Subject: Re: [RFC & PATCH] inherited type definition.
Message-ID: <20050314160158.GD1246@lkcl.net>
References: <42346C17.3090301@kaigai.gr.jp> <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil> <20050314151351.GC1246@lkcl.net> <1110813732.21378.91.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1110813732.21378.91.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

sounds all-in-all like a "partial" inheritance is needed, which
refactoring would give you - but not in an ideal fashion.

i've never ever heard of any object orientated system
_excluding_ certain functionality of the parent on inheritance
[has anyone else?]

i've heard of public, protected and private interfaces - but
never of exclusion: always, refactoring is used.

seriously considering the provision of some partial inheritance
reminds me of the spoof languages article that was making the
rounds in about 1989 - the one with "SLOBOL" - which amongst
other things described some extensions to BASIC.  a "GO FROM"
construct, which would periodically attempt to pinch program
control from a line, and try to undo some of the commands if
it missed.

so.

what is the one significant distinct advantage that the proposed
inheritance thing gives you that macro refactoring cannot?

my guess would be on how handling of "self" was made to work.

On Mon, Mar 14, 2005 at 10:22:12AM -0500, Stephen Smalley wrote:

> On Mon, 2005-03-14 at 15:13 +0000, Luke Kenneth Casson Leighton wrote:
> >  i would expect syntax allow parent_t self:process sigkill to
> >  be inherited to "allow child_t self:process sigkill"
> > 
> >  and expect "allow parent_t parent_t:process sigkill to
> >  be inherited to "allow child_t parent_t:process sigkill"
> 
> I would not expect there to be any difference, as self is just a
> convenience notation, and in this particular example, someone who writes
> either form likely would not want the child to be able to kill the
> parent without an explicit allow rule from the child to the parent.

 can i suggest having a policy checker similar to "lint" which would
 warn users of such, in instances where a developer inherits "self"
 rules rather than "allow parent_t parent_t:.... ...." rules?

 or ... to make the compiler tools spit out a warning which needs
 to be explicitly disabled with a --no-warn-inherit-allow-self
 option or something?


> >  except that wouldn't work if there's a "special" meaning given
> >  to "self:".
> 
> The policy compiler can (and does) distinguish self for processing, e.g.
> 	allow domain self:process sigkill;
> expands to what you would expect, i.e.
> 	allow domain0_t domain0_t:process sigkill;
> 	allow domain1_t domain1_t:process sigkill;
> 	...

 ahh.  yes, of course.  i always wondered what made self: particularly
 needed.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
