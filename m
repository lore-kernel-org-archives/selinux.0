Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA3DchWt029568
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 08:38:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA3DcgKl026488
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 13:38:42 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
        by jazzband.ncsc.mil  with ESMTP id hA3Dcf5m026482 for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 13:38:41 GMT
Message-ID: <3FA65A60.3010802@diyab.net>
Date: Mon, 03 Nov 2003 08:38:40 -0500
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: Dale Amon <amon@vnl.com>
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: default policy package
References: <20031103114353.GC13273@vnl.com>
In-Reply-To: <20031103114353.GC13273@vnl.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dale Amon wrote:
> Looks like X windows has really stuck it's tentacles
> into the policy. I can't compile one without it. Something
> in the macros that I haven't tracked down yet:
> 
> ERROR: unknown type initrc_xserver_tmp_t' at token ':' on line 6198:
> allow sysadm_uml_t initrc_xserver_tmp_t:dir search;
> 
> so I removed uml.te, which I didn't need anyway. Next run
> I've now got:
> 
> ERROR: unknown type sysadm_xserver_t' at token ':' on line 7525:
> allow sysadm_xserver_t xserver_tmpfile:dir { read getattr lock search ioctl add name remove_name write };
> 
> This is just some examples. I've been fighting this
> all morning without finding a set that works without 
> any X. (Hardly need X for a machine that normally doesn't
> even have a terminal on it, and when it does it's an old
> dumb b&w character only glass tty)
> 
> I haven't specifically seen where the problem is coming
> from yet: everything seems to have ifdef's around it
> on startx.te or xserver.te but I've not gone through
> every file.
> 
> I'll keep at it, but suggestions are welcome. 

I ran into a similar problem with postgresql.te which contains a 
can_exec statement with dpkg_exec_t that does not have an ifdef around 
it.  So unless you include dpkg.te you get an error attempting to 
compile the policy.  Easiest thing to do from what I've found is to grep 
the everything in domains/program for the context that is giving the error.

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
