Subject: Re: Trouble with setexeccon/setcon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mario Fanelli <mario.fanelli@gmail.com>
Cc: SeLinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <44649047.13bdcb9a.0dcb.4ef4@mx.gmail.com>
References: <44649047.13bdcb9a.0dcb.4ef4@mx.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 12 May 2006 10:16:50 -0400
Message-Id: <1147443410.23563.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-12 at 15:40 +0200, Mario Fanelli wrote:

> Yes, but runcon and newrole are user-space command. 
> 
> I have to modify the SuPhp C source code because I want that the
> process SuPhp has different security context depending of an
> environment variable that mod_suphp set. I try to use setexecon in
> mod_suphp beforce executing SuPhp but the security context don’t
> change..setexeccon return -1…so I try to modify the suPhp exec with a
> calling to setcon but another setcon don’t work.
> 
> If I use runcon all works, but I need to modify the source code…

Right, I meant to look at the runcon.c or newrole.c source code as
examples of how to use setexeccon() as well as how to create a context
in the first place from a combination of the caller's context and some
new type.  What errno do you get after the failed setexeccon() call?  In
addition to replacing object_r with a legitimate process role, you also
need to ensure that the role is authorized for the type/domain.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
