Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j36Cq8Do017019
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 08:52:09 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j36Cl1Cb025461
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 12:47:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: [RFC & PATCH] inherited type definition.
Date: Wed, 6 Apr 2005 22:49:11 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com
References: <42346C17.3090301@kaigai.gr.jp> <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil> <4236CC03.5010104@kaigai.gr.jp>
In-Reply-To: <4236CC03.5010104@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Message-Id: <200504062249.14886.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 15 March 2005 22:50, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
> Does 'unifying file type' means as follows ?
> e.g)
>  /var             ... var_t
>  /var/lib         ... var_lib_t extends var_t
>  /var/log         ... var_log_t extends var_t
>  /var/log/message ... var_log_message_t extends var_log_t
> Of course, such a usage is also possible.

This is an example of how not to do it.

Many domains need search access to /var.  Most of them should not be granted 
any access to /var/log, but your example would have them granted search 
access to /var/log as var_log_t inherits from var_t.

Many domains access /var/log (probably more than we desire but that's a 
separate issue - the fact that user_ssh_t is granted read access to files of 
type var_log_t seems like a policy bug to me).  /var/log/message may have 
data that is more secret than the other files/directories labeled as 
var_log_t, and we don't want user_ssh_t to read it.

On Wednesday 16 March 2005 15:42, Kaigai Kohei <kaigai@ak.jp.nec.com> wrote:
> Indeed, a user_t process can take permissions of a user_ext_t process
> through ptrace. It was blid spot for me.

To address this you could have user_t inherit from a virtual base type 
user_base_t which doesn't have ptrace access.

> I have an idea that ALLOW statement is added an new option
> For example:
>   ALLOW @user_t @user_t:process {ptrace};
>   ALLOW user_t @user_t:process {transition};

I don't like that idea.  Tracking when the '@' symbol should be used will be 
beyond the skill of most people who write policy.  Then there is the issue of 
someone writing a domain with the idea that it will never be used for 
inheritance but then having it used for inheritance later.  If the inherited 
domain has it's policy in the public repository then things can get fixed, 
but if someone inherits a domain for their own private use then they could 
get surprised by a policy update that grants some access they didn't expect 
because the upstream policy developers didn't plan for inheritance and didn't 
use the '@' symbol.

Your message on the 23rd of March seems to be OK in terms of access, but I 
doubt that the '@' operator will result in good policy.



About a year ago I was involved in some discussions about these issues, and 
one of the major factors was how to deal with user_t/user_r/user_ssh_t and 
other_t/other_r/other_ssh_t type inheritance.  One of the NSA guys asked me 
to write up a proposal for how to do this.  After thinking about it for a 
year I haven't devised a good answer.  If your work can result in a solution 
to this problem then I'm sure that everyone will be willing to accept some 
trade-offs.  But currently I am not convinced that the benefits outweigh the 
costs of this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
