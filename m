Date: Wed, 16 Mar 2005 10:00:34 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC & PATCH] inherited type definition.
Message-ID: <20050316100034.GJ6055@lkcl.net>
References: <42346C17.3090301@kaigai.gr.jp> <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil> <4235C937.3030404@kaigai.gr.jp> <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil> <4236CC03.5010104@kaigai.gr.jp> <1110897751.25947.52.camel@moss-spartans.epoch.ncsc.mil> <4237B950.2090604@ak.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4237B950.2090604@ak.jp.nec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 16, 2005 at 01:42:56PM +0900, Kaigai Kohei wrote:

> I have an idea that ALLOW statement is added an new option
> For example:
>   ALLOW @user_t @user_t:process {ptrace};
>   ALLOW user_t @user_t:process {transition};
> 
> When '@' is added in front of the type name, this means source/target
> type is only user_t, not including user_ext_t and descendant.
> Above example is rolled out as follows:
>   ALLOW user_t user_t:process {ptrace};
>   ALLOW {user_t user_ext_t}:process {transition};

 that i like.

 an "after-the-fact" scheme i don't [one where you inherit and then
 specify what you _don't_ want to be included].

 an explicit marker on parent rules saying "you can't inherit this"
 i like.

 i like best the one which explicity says "all these rules within these
 curly braces are inheritable".

 positive statements, the default being "nothing is inheritable",
 matches up better with the "mandatory access control" methodology.
 
 no assumptions.  nothing granted by mistake.  always explicitly say
 what's allowed.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
