Date: Mon, 14 Mar 2005 15:13:51 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
   SELinux Mail List <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com
Subject: Re: [RFC & PATCH] inherited type definition.
Message-ID: <20050314151351.GC1246@lkcl.net>
References: <42346C17.3090301@kaigai.gr.jp> <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 14, 2005 at 08:50:02AM -0500, Stephen Smalley wrote:

> 3) What should happen with rules between the parent and itself?  It
> looks like you are translating "self" rules to only involve the child
> and its descendants, but this would still mean that any explicit rule of
> the form "allow parent_t parent_t:process sigkill;" would be inherited
> by the child, i.e. "allow child_t parent_t:process sigkill;", right?
 
 i would expect syntax allow parent_t self:process sigkill to
 be inherited to "allow child_t self:process sigkill"

 and expect "allow parent_t parent_t:process sigkill to
 be inherited to "allow child_t parent_t:process sigkill"

 except that wouldn't work if there's a "special" meaning given
 to "self:".
 
 there's no special meaning given to self: is there?

 it's just for convenience in case you want to change the name
 of the domain, isn't it?


> 4) What should happen with transition rules that involve the parent?  In
> some cases, you will likely want to inherit them, but in others, you may
> want the child to transition to a separate derived domain from the one
> used by the parent. 
 
 subdivide the parent domain into rules which you do want to be
 inherited, and those that you do not.

 derive a child domain that gives you the original one, so you
 don't have any code uses to change.

 derive other domains from the smaller parent one.


 5) what about multiple inheritance?

    syntax should allow for such - to combine two parent
    sets into one child domain.

 l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
