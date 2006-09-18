Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8IHtTtf015919
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 13:55:29 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8IHsxuA024591
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 17:54:59 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7) with ESMTP id k8IHt3NL013275
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 13:55:03 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7/Submit) id k8IHt3xg013274
	for selinux@tycho.nsa.gov; Mon, 18 Sep 2006 13:55:03 -0400
Message-ID: <450ED8F5.9010304@trustedcs.com>
Date: Mon, 18 Sep 2006 12:35:49 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: semodule quirk
References: <20060916022809.GA16235@sergelap.austin.ibm.com> <1158599181.18951.263.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1158599181.18951.263.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-09-15 at 21:28 -0500, Serge E. Hallyn wrote:
> 
>>[ Oops, sent this earlier from an unsubscribed account ]
>>
>>I've got a policy module which just creates a new type and role,
>>intended for use by a new (linux) user.  An selinux user cannot be
>>defined in the policy module (near as I can tell, else I get
>>	ERROR 'Users cannot be declared in MLS modules' at token ';
>>
>>So I don't define an selinux user, and do:
>>
>>	semodule -i my_module.pp
>>	semanage user -a -R whatever_r -P whatever whatever_u
>>	semanage login -a -s whatever_u whatever
>>
>>But, if the module wants to label a home directory for the user,
>>contexts involving the new (selinux) user are of course not yet
>>valid until after I run semanage.  Likewise I can't create the
>>user using semanage until I've defined the role and type using
>>semodule.
>>
>>So for now I split the module into two, one defining the role
>>and type and related .te rules but an empty .fc, and one with
>>basically empty .te, defining all the filecontexts, and I do
>>
>>	semodule -i my_module.pp
>>	semanage user -a -R whatever_r -P whatever whatever_u
>>	semanage login -a -s whatever_u whatever
>>	semodule -i my_modulefc.pp
>>
>>which works fine.
>>
>>Is there a better solution allowing a single module?  Should
>>there be?  Practically speaking I'm fine with the tradeoff of
>>having to use two separate modules for being able to user
>>semanage user and login, it just seems weird  :)
> 
> 
> Fixing user support in MLS modules is the right solution.  Which I think
> Darrel is very close to enabling, now that we have semantic MLS
> representations.

Yep, you have great timing - I was hacking on this over the weekend.  I have
something working.  It enables range_transitions and users with MLS info to
be placed in modules.  I still want to go over everything again to make sure
that I have things right.  I'll post the patch in a bit for comments/testing.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
