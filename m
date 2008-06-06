Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m56CGGO2011157
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2008 08:16:16 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m56CGFd3002322
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2008 12:16:15 GMT
Subject: Re: modules.conf problem
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <0794F277152EF94AA637E3AECF5CB70FB9E7C9@blums0042.bluelnk.net>
References: <0794F277152EF94AA637E3AECF5CB70FB9E7C9@blums0042.bluelnk.net>
Content-Type: text/plain
Date: Fri, 06 Jun 2008 08:16:14 -0400
Message-Id: <1212754574.15952.2.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-06-05 at 14:01 -0700, Clarkson, Mike R (US SSA) wrote:
> I'm getting the following compile errors when attempting a clean compile
> of my policy:
> 
> policy/modules/apps/import.if:336: Error: duplicate definition of
> nlscripts_dir_search(). Original definition on 25.
> policy/modules/apps/import.if:344: Error: duplicate definition of
> nlscripts_dir_list(). Original definition on 17.
> 
> The thing is that I have commented out the import module out of the
> modules.conf file. In fact I commented it out several weeks ago and have
> done many clean compiles since without issue until this morning.
> 
> The only way that I have been able to get past these errors is to remove
> the import.{te,if,fc} files from the apps directory. Then the policy
> compiles and loads fine. I must have changed something in one of the
> other policy files that caused this to suddenly crop up today but I have
> no idea what.
> 
> If anyone has any ideas on what may be causing this or ideas on how to
> track down what the problem is I would greatly appreciate hearing them.
> 
> I'm using the RHEL5.1 mls policy.

You have more than one declaration of those two interfaces.  Even if the
module is not enabled in the modules.conf, its interfaces are included,
since if its interfaces are used, they have to be expanded.  Unexpanded
interfaces result in compile failures.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
