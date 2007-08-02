Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72GmH5L004723
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 12:48:17 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l72Gm9OD022589
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:48:10 GMT
Subject: Re: Containing vmware player 2.0.0 with SELINUX
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Louis Lam <lshoujun@yahoo.com>
Cc: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <47609.47348.qm@web34809.mail.mud.yahoo.com>
References: <47609.47348.qm@web34809.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 16:47:38 +0000
Message-Id: <1186073258.4015.84.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 00:01 -0700, Louis Lam wrote:
> Today i managed to make the vmplayer run in its own domain. What I did
> was added the statement to my vmware.te. Thanks to Ken and his
> suggestion (and all of the help so far), i've got the "Selinux by
> example" book that i've been reading as a reference. 
> 
> domain_auto_trans(unconfined_t, vmware_exec_t, vmware_t)
> 
> Evident from the large amount of avc denials in setroubleshoot when i
> launch vmplayer, i was able to see that vmplayer was running in the
> context of :
> 
> root:system_r:vmware_t
> 
> Two questions from security angle on this approach though:
> 
> 1. If i allow transition from unconfined_t to vmware_t, it means that
> any unconfined process can transit to vmware_t and be able to access
> the vmware files. This is probably not what i'd desire. What would be
> a good recommendation for this? Any best practices?

It doesn't matter, unconfined_t is unconfined; therefore, it already has
access to vmware files.

> 2. I still want to start vmware as a user program, probably not as a
> service. In that case, would I still need to do something in the
> vmware.if so that the domain auto trans can take on a role ?

I don't understand this question.  Vmware has daemon parts for the
vmnets, and the user application is the player itself.

> Now that i'm able to run it under vmware_t domain, and see a lot of
> avcs, i intend to make vmware run properly again. I'd go with allowing
> whatever vmware wants to do, then tightening the security. There are a
> few approaches i can use, and i'd like to seek your opinions on how to
> go about doing it:
>
> 1. audit2allow: This will list all of the avcs and turn them into
> allow statements. By adding these statements to my vmware.te, this
> would enable vmware to function again. Problem is that i may end up
> with too many statements.

Correct.

>  There would probably be macros to cover these.

There should already be sufficient existing interfaces, since there is
policy, though I tested it with vmware workstation, not the player (I
don't imagine they are very different access-wise).

> 2. macros: This is somethings i'm not familiar with. Are there any
> documentation that describe some of the more commonly used macros? Or
> it is better just to see the source?

By looking a few of the source files, you can see the commonly used
interfaces.  You can also look at the interface documentation, but it
has all the macros, not just the common ones:

http://oss.tresys.com/docs/refpolicy/api

> 3. policygentool: From what i understand, this is a script that would
> generate a module for you. the question is how do i combine  it with
> the vmware source code that I've taken from the reference policy?
> (that i'm using now)? I forsee a lot of conflicts to be resolved. and
> may actually not be so clean.

I believe this tool is designed to be run on a service that doesn't
already have a policy.  It just gets you a starting point, creating some
types, some interfaces, and a handful of common rules (leveraging
refpolicy interfaces).


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
