Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l62F7gYO008530
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 11:07:42 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l62F7f49006972
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 15:07:42 GMT
Subject: Re: [patch] refpolicy update for cap_setfcap
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070628191707.GA13973@sergelap.austin.ibm.com>
References: <20070628191707.GA13973@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 02 Jul 2007 11:05:43 -0400
Message-Id: <1183388743.4084.6.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-28 at 15:17 -0400, Serge E. Hallyn wrote:
> A tentative patch to support file capabilities introduces a new
> CAP_SETFCAP capability.  This patch adds setfcap to the refpolicy
> access_vectors.

I'd prefer to wait until the file caps code starts going upstream.  It
looks like discussions about it continue, assuming I am understanding
the threads I've unburied from the apparmor flood.

> Index: policy/flask/access_vectors
> ===================================================================
> --- policy/flask/access_vectors (revision 2359)
> +++ policy/flask/access_vectors (working copy)
> @@ -363,6 +363,7 @@
>         lease
>         audit_write
>         audit_control
> +       setfcap
>  }
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing
> list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
