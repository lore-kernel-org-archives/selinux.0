Subject: Re: libsepol/src/conditional.c:cond_evaluate_expr()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20060306214139.GA7960@sergelap.austin.ibm.com>
References: <20060306214139.GA7960@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 09:02:11 -0500
Message-Id: <1141826531.6157.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-03-06 at 15:41 -0600, Serge E. Hallyn wrote:
> Hi,
> 
> just doing a quick update static analysis scan of the nsa/selinux-usr
> sources.  Most of the output in libsepol seems like the same false
> positives it used to get, but I'm worried about cond_evaluate_expr.
> 
> It is supposed to return -1 on error, but as is, if the second arg
> (expr) is passed in NULL, the value returned is truly undefined -
> it is just taken off the stack.
> 
> Patch appended, in case this is deemed to really be a danger.

Looks sane, applied.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
