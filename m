Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA3KBiWt002474
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 15:11:44 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA3KBNC7013371
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 20:11:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hA3KBMuw013368
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 20:11:22 GMT
Subject: Re: default policy package
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Diyab <diyab@diyab.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3FA65A60.3010802@diyab.net>
References: <20031103114353.GC13273@vnl.com>  <3FA65A60.3010802@diyab.net>
Content-Type: text/plain
Message-Id: <1067890301.29084.24.camel@moss-huskies>
Mime-Version: 1.0
Date: 03 Nov 2003 15:11:41 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-11-03 at 08:38, Diyab wrote:
> Dale Amon wrote:
> > Looks like X windows has really stuck it's tentacles
> > into the policy. I can't compile one without it. Something
> > in the macros that I haven't tracked down yet:
> > 
> > ERROR: unknown type initrc_xserver_tmp_t' at token ':' on line 6198:
> > allow sysadm_uml_t initrc_xserver_tmp_t:dir search;
> > 
> > so I removed uml.te, which I didn't need anyway. Next run
> > I've now got:
> > 
> > ERROR: unknown type sysadm_xserver_t' at token ':' on line 7525:
> > allow sysadm_xserver_t xserver_tmpfile:dir { read getattr lock search ioctl add name remove_name write };
> > 
> > This is just some examples. I've been fighting this
> > all morning without finding a set that works without 
> > any X. (Hardly need X for a machine that normally doesn't
> > even have a terminal on it, and when it does it's an old
> > dumb b&w character only glass tty)
> > 
> > I haven't specifically seen where the problem is coming
> > from yet: everything seems to have ifdef's around it
> > on startx.te or xserver.te but I've not gone through
> > every file.
> > 
> > I'll keep at it, but suggestions are welcome. 
> 
> I ran into a similar problem with postgresql.te which contains a 
> can_exec statement with dpkg_exec_t that does not have an ifdef around 
> it.  So unless you include dpkg.te you get an error attempting to 
> compile the policy.  Easiest thing to do from what I've found is to grep 
> the everything in domains/program for the context that is giving the error.
> 
> Timothy,

The most recent release of the default policy on nsa.gov has the ifdef
isolating the can_exec statement.

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Office of Defensive Computing Research
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
