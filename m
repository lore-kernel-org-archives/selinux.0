Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1FDuRb007473
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 10:13:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB1FDGp5007932
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 15:13:16 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hB1FDFt0007893
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 15:13:15 GMT
Subject: Re: policy under version control
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andreas Schuldei <andreas@schuldei.org>
Cc: Russell Coker <russell@coker.com.au>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20031129132619.GE26960@lukas.schuldei.com>
References: <20031129132619.GE26960@lukas.schuldei.com>
Content-Type: text/plain
Message-Id: <1070291615.12270.120.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Dec 2003 10:13:35 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-11-29 at 08:26, Andreas Schuldei wrote:
> I find it tiresom and uneffective to make changes to policy
> without and easy way to feed my effords upstream. Actually i feel
> selinux stands and falls with a smoothly working policy. this
> needs attention and time of many, not just one.
> 
> i would therefor suggest to create a public readabel repository
> against which one can update and also some scripts for mailing
> back/submitting to the repository(?) the changes needed to make
> the subsystems work.
> 
> some with some clue should go through this and apply those
> patches. 
> 
> does it make sense to make this a inter-distribution-spanning
> process, perhaps with manpower from the nsa? the nsa policy seems
> to be not intended for use, right now and lacks relevance in that
> regard.

There is already a sourceforge CVS tree, and patches can be posted to
the selinux list.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
