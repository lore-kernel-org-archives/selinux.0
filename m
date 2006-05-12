Subject: Re: Trouble with setexeccon/setcon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Mario Fanelli <mario.fanelli@gmail.com>,
        SeLinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <20060512101152.GA7473@thorium.jmh.mhn.de>
References: <44643eb7.025ecbeb.7447.326d@mx.gmail.com>
	 <20060512101152.GA7473@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Fri, 12 May 2006 08:38:00 -0400
Message-Id: <1147437480.23563.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-12 at 12:11 +0200, Thomas Bleher wrote:
> * Mario Fanelli <mario.fanelli@gmail.com> [2006-05-12 10:10]:
> > Hello, my name is Mario and I have a trouble with selinux's api. My goal is
> > to modify the suPhp apache module, but the function setcon and function
> > setexeccon don't work. 
> > 
> > My apache process runs in dummy_t domain and suPhp file has a security
> > context "user_u:object_r:dummy_exec_t"; in the policy file I write:
> > 
> > "domain_trans(dummy_t,dummy_exec_t,dummy_change_context_t)"
> > 
> > "domain_trans(dummy_t,dummy_exec_t,dummy_change1_context_t)"
> > 
> > And before calling apr_create_process in mod_suphp, I use
> > setexeccon("user_u:object_r:dummy_change_context_t") but the function return
>                      ^^^^^^^^
> > always -1 
> 
> You need user_r instead of object_r. I've never used this api so I can't
> comment further, but at least you need to change this.

Yes, and please don't hardcode security contexts in your program.  Make
sure that they are configurable so that your code can adapt to other
policies.  Note that you likely just want to configure the type, and let
the rest be inherited from the caller's context.  See newrole (in
policycoreutils) or runcon (in coreutils) for examples of how to
construct a context by taking an existing context and then just mutating
a particular field, like the type.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
