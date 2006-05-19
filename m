Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4JHcn0Q012080
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 13:38:49 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4JHcmfP010292
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 17:38:49 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <446DD270.4090703@redhat.com>
References: <446C9926.5070802@redhat.com>
	 <1148047494.31984.56.camel@sgc.columbia.tresys.com>
	 <446DD270.4090703@redhat.com>
Content-Type: text/plain
Date: Fri, 19 May 2006 13:40:51 -0400
Message-Id: <1148060451.31984.67.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-19 at 10:13 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Thu, 2006-05-18 at 11:56 -0400, Daniel J Walsh wrote:
> >> Added unconfined_execmem_exec_t so that I can change the global 
> >> allow_execmem to off.  OpenOffice, valgrind and mplayer need it.  
> >> Probably could eliminate java, and wine domain and change to this.
> >>     
> >
> > I think this would be better if we had this transparently integrated
> > into the unconfined policy.  So we just add the rules to unconfined.te,
> > and put the domain transition into unconfined_domtrans().  The
> > differences between the two domains is just the execmem, so it should be
> > ok.  In fact this might be a simple example of hierarchy.

So basically, we want unconfined_execmem_t to be the exact same as
unconfined_t, except have execmem too.  So the best way to do that would
be to have the unconfined interfaces also act on unconfined_execmem_t.
For example:

interface(`unconfined_domtrans',`
	domain_auto_trans($1,unconfined_exec_t,unconfined_t)
	domain_auto_trans($1,unconfined_execmem_exec_t,unconfined_execmem_t)
')

interface(`unconfined_dbus_send',`
	allow $1 { unconfined_t unconfined_execmem_t }:dbus send_msg;
')

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
