Date: Thu, 24 Mar 2005 22:19:54 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
Subject: Re: [RFC & PATCH] inherited type definition.
Message-ID: <20050324221954.GE8553@lkcl.net>
References: <20050322001439.GB8444@lkcl.net> <200503221353.j2MDrT8R010539@gotham.columbia.tresys.com> <20050324110438.GC13372@lkcl.net> <4242B32D.9050109@ak.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4242B32D.9050109@ak.jp.nec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Mar 24, 2005 at 09:31:41PM +0900, Kaigai Kohei wrote:
> Hello,
> 
> >  and your original question was: when you use A "extends" B and C
> >  "extends" B, and B contains "@"s, how do you potentially make A
> >  ignore the "@" but C _not_ ignore the "@"?
> 
> That means as follows, doesn't it ?
> <type B>
>  + <type A>
>  + <type C>
 
 yes.

> "allow foo_t @B - @C:file getattr ;" is rolled out to
> "allow foo_t {B A}:file getattr ;" as you want.

 ah ha!

 great.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
