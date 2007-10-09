Message-ID: <470BBBAF.7090606@manicmethod.com>
Date: Tue, 09 Oct 2007 13:34:39 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: jwcart2@tycho.nsa.gov
CC: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: Are the reference policy abstractions the right ones?
References: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:
> I would like to start a discussion on whether reference policy is
> providing the right abstractions for writing policy.
>
> This is not intended to be an attack on Chris or Dan, or their work.  I
> think that it is obvious that reference policy is much better organized,
> far more useful, and works way better than the old example policy.  We
> don't want to go back to example policy.
>
> One of the goals of reference policy is to provide a more modern feel to
> the policy by eliminating the use of types in a global manner across the
> whole policy.  It does this by allowing interfaces to be defined through
> which permissions can be granted to the types of a module.  There seems
> to be several problems with this.
>
> 1) The user is constantly presented with types.  They are in the audit
> logs, when the label of a process or file is displayed, and even in the
> man pages ("Set cgi scripts with httpd_sys_script_exec_t to allow them
> to run with access to all sys types.")
>
>   


We've been talking about this here as well. I think its clear that types 
should either be global in policy and implementation or they should not 
be global. The latter means sticking with the kinds of abstraction in 
refpolicy but extending it so that audit logs and on-disk labels are 
both presented with those abstractions. This means potentially making 
the kernel implementation of SELinux more complicated but completing the 
currently ill-fated abstractions that we have.

> 2) We have traded needing to know about 2500 types or so to write
> policy, for needing to know around 4000 interfaces.  And no, I don't
> think that SELinux Clippy is the answer.
>
>   

The interfaces have documentation and are well organized where types 
aren't (they aren't even consistent in naming because of legacy names 
being used).

> 3) We don't need to abstract class and permissions, because they don't
> change very much, but frequently the interfaces consist of only a few
> allow rules.  Over 60% of the interfaces have only one line (not
> counting gen_require or refpolicywarn lines).
> Lines   # of Interfaces
>      0    53	These only have a refpolicywarn line
>      1  3080    Around 300 of these consist of a single dontaudit rule
>   

not too surprising, think of these like OO accessors :) The unfortunate 
part is that the symbols still end up globally (which is the other part 
of the problem).

>      2  1224
>      3   269
>      4    80
>      5    29
>      6    14
>      7    11
>      8    10
>      9     5
>     10     7
>  11-50    17
> 51-100     2
>   >100     0
>
> It is true that some to many of these are calling other interfaces or
> macros, so they are a little bit longer than indicated here.  Templates
> are much more useful, but there are still many very short ones.
> Lines   # of Templates
>      1    51
>      2    32
>      3    12
>      4     7
>      5     5
>      6     3
>      7     1
>      8     4
>      9     2
>     10     1
>  11-50    34
> 51-100    24
>   >100    21
>
>
> I think that we need:
>
> 1) A way to say, "I want a domain like that one, without this
> permission, but with that one".  I think that inheritance is the answer,
> because a macro requires you to know ahead of time that someone might be
> interested in making something similar.  I believe that Karl tried to
> start a discussion on inheritance a month ago, but there wasn't any
> interest.  Let's restart that discussion.  I think that whether through
> macros or inheritance, a rule to remove permissions is needed, because
> without one, we have to get the base classes or macros perfect.
>
>   

> 2) A way to export types in some manner that would still allow
> flexibility in renaming or splitting a type locally, without having to
> change the global name.  That global name would also have to be what
> shows up in audit logs and other things.  Maybe this is impossible and
> we are just stuck treating types as global entities.
>   

This relates to what I said earlier about completing the refpolicy 
abstractions by removing the global symbols. I'm not sure how well this 
can be done but I think its worth thinking about, if scoping symbols 
wasn't useful programming would be much different than it is today :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
