Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8IHYSGt015293
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 13:34:28 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8IHY0uA021530
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 17:34:00 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7) with ESMTP id k8IHXvCa013143
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 13:33:57 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7/Submit) id k8IHXvu7013142
	for selinux@tycho.nsa.gov; Mon, 18 Sep 2006 13:33:57 -0400
Subject: Re: semodule quirk
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20060916022809.GA16235@sergelap.austin.ibm.com>
References: <20060916022809.GA16235@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 13:06:21 -0400
Message-Id: <1158599181.18951.263.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-15 at 21:28 -0500, Serge E. Hallyn wrote:
> [ Oops, sent this earlier from an unsubscribed account ]
> 
> I've got a policy module which just creates a new type and role,
> intended for use by a new (linux) user.  An selinux user cannot be
> defined in the policy module (near as I can tell, else I get
> 	ERROR 'Users cannot be declared in MLS modules' at token ';
> 
> So I don't define an selinux user, and do:
> 
> 	semodule -i my_module.pp
> 	semanage user -a -R whatever_r -P whatever whatever_u
> 	semanage login -a -s whatever_u whatever
> 
> But, if the module wants to label a home directory for the user,
> contexts involving the new (selinux) user are of course not yet
> valid until after I run semanage.  Likewise I can't create the
> user using semanage until I've defined the role and type using
> semodule.
> 
> So for now I split the module into two, one defining the role
> and type and related .te rules but an empty .fc, and one with
> basically empty .te, defining all the filecontexts, and I do
> 
> 	semodule -i my_module.pp
> 	semanage user -a -R whatever_r -P whatever whatever_u
> 	semanage login -a -s whatever_u whatever
> 	semodule -i my_modulefc.pp
> 
> which works fine.
> 
> Is there a better solution allowing a single module?  Should
> there be?  Practically speaking I'm fine with the tradeoff of
> having to use two separate modules for being able to user
> semanage user and login, it just seems weird  :)

Fixing user support in MLS modules is the right solution.  Which I think
Darrel is very close to enabling, now that we have semantic MLS
representations.

-- 
Stephen Smalley
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
