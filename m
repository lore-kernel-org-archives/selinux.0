Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8IC3Oem007538
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 08:03:24 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8IC2tOQ005515
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 12:02:55 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7) with ESMTP id k8IC2xgT004058
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 08:02:59 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7/Submit) id k8IC2xIC004057
	for selinux@tycho.nsa.gov; Mon, 18 Sep 2006 08:02:59 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8G2SDL6015362
	for <selinux@tycho.nsa.gov>; Fri, 15 Sep 2006 22:28:13 -0400
Received: from e2.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8G2Rkjx027556
	for <selinux@tycho.nsa.gov>; Sat, 16 Sep 2006 02:27:46 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8G2SCA2029778
	for <selinux@tycho.nsa.gov>; Fri, 15 Sep 2006 22:28:12 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8G2SCRY297512
	for <selinux@tycho.nsa.gov>; Fri, 15 Sep 2006 22:28:12 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8G2SCUQ013738
	for <selinux@tycho.nsa.gov>; Fri, 15 Sep 2006 22:28:12 -0400
Received: from sergelap.hallyn.com (sig-9-49-167-123.mts.ibm.com [9.49.167.123])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k8G2SBD5013659
	for <selinux@tycho.nsa.gov>; Fri, 15 Sep 2006 22:28:11 -0400
Date: Fri, 15 Sep 2006 21:28:09 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: semodule quirk
Message-ID: <20060916022809.GA16235@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[ Oops, sent this earlier from an unsubscribed account ]

I've got a policy module which just creates a new type and role,
intended for use by a new (linux) user.  An selinux user cannot be
defined in the policy module (near as I can tell, else I get
	ERROR 'Users cannot be declared in MLS modules' at token ';

So I don't define an selinux user, and do:

	semodule -i my_module.pp
	semanage user -a -R whatever_r -P whatever whatever_u
	semanage login -a -s whatever_u whatever

But, if the module wants to label a home directory for the user,
contexts involving the new (selinux) user are of course not yet
valid until after I run semanage.  Likewise I can't create the
user using semanage until I've defined the role and type using
semodule.

So for now I split the module into two, one defining the role
and type and related .te rules but an empty .fc, and one with
basically empty .te, defining all the filecontexts, and I do

	semodule -i my_module.pp
	semanage user -a -R whatever_r -P whatever whatever_u
	semanage login -a -s whatever_u whatever
	semodule -i my_modulefc.pp

which works fine.

Is there a better solution allowing a single module?  Should
there be?  Practically speaking I'm fine with the tradeoff of
having to use two separate modules for being able to user
semanage user and login, it just seems weird  :)

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
