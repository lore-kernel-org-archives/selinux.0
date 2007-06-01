Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l51F2G2J015047
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2007 11:02:16 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l51F2FA6011664
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2007 15:02:15 GMT
Subject: Re: With the release of Fedora Core 7 I have bumped the policy
	version in Rawhide
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <465F19D1.7040706@redhat.com>
References: <465F19D1.7040706@redhat.com>
Content-Type: text/plain
Date: Fri, 01 Jun 2007 11:01:04 -0400
Message-Id: <1180710064.28862.5.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-31 at 14:54 -0400, Daniel J Walsh wrote:
> Tomorrows rawhide will have selinux-policy-3.0.1. 
> 
> This policy is the first release of the merged (strict/targeted) 
> policy.  As such there is no longer a selinux-policy-strict.  This is 
> real experimental and I expect some problems.  I have been running it 
> here for a couple of days. 
> 
> With this policy you can install the strict type users staff_u, user_u, 
> sysadm_u.  As well as the unonfined_u/system_u.  You should be able to 
> mix and match the users.  So if you want to setup a Guest X-Windows 
> login you would set it up with a user of user_u:user_r:user_t.  And you 
> might have your regular login as system_u:unconfined_r:unconfined_t.

As a side note is that an unconfined_u seuser is going to be added,
which will be the appropriate seuser to use for unconfined users.  So
eventually you'll end up with unconfined_u:unconfined_r:unconfined_t.

> The idea is if you remove the unconfined policy package, you will be 
> basically running in strict policy mode.  (This has not been tested.) 

Actually you also have to take out anaconda and firstboot since they
unconditionally depend on unconfined.  Otherwise it should work.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
