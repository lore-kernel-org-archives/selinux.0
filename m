Subject: Re: [RFC & PATCH] inherited type definition.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
   SELinux Mail List <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com
In-Reply-To: <20050314151351.GC1246@lkcl.net>
References: <42346C17.3090301@kaigai.gr.jp>
	 <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>
	 <20050314151351.GC1246@lkcl.net>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 10:22:12 -0500
Message-Id: <1110813732.21378.91.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-14 at 15:13 +0000, Luke Kenneth Casson Leighton wrote:
>  i would expect syntax allow parent_t self:process sigkill to
>  be inherited to "allow child_t self:process sigkill"
> 
>  and expect "allow parent_t parent_t:process sigkill to
>  be inherited to "allow child_t parent_t:process sigkill"

I would not expect there to be any difference, as self is just a
convenience notation, and in this particular example, someone who writes
either form likely would not want the child to be able to kill the
parent without an explicit allow rule from the child to the parent.

>  except that wouldn't work if there's a "special" meaning given
>  to "self:".

The policy compiler can (and does) distinguish self for processing, e.g.
	allow domain self:process sigkill;
expands to what you would expect, i.e.
	allow domain0_t domain0_t:process sigkill;
	allow domain1_t domain1_t:process sigkill;
	...

Hence, the policy compiler can handle self differently if desired, but
in this case, I don't think we want it to be handled differently.

>  subdivide the parent domain into rules which you do want to be
>  inherited, and those that you do not.
> 
>  derive a child domain that gives you the original one, so you
>  don't have any code uses to change.
> 
>  derive other domains from the smaller parent one.

Yes, but if you are willing to refactor existing domains in this manner,
then it is unclear that you gain much benefit from having the
inheritance support (vs. just defining macros that partition the domain
in the same manner, and only including the desired macros in the "child"
domains).

>  5) what about multiple inheritance?
> 
>     syntax should allow for such - to combine two parent
>     sets into one child domain.

I think that KaiGai's patch allows for such multiple inheritance, but
think about the implications there for type transition rules - what
happens if they have a different default transition on the same
executable type?

If you look at existing derived domains for programs, you'll see that
they don't fall neatly into this kind of inheritance scheme, as they
gain some permissions that aren't directly allowed to the user domain
and drop some permissions (and most/all transitions) possessed by the
user domain that the program doesn't need.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
