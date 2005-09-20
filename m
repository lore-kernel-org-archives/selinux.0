Subject: Re: State of Debian SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dale Amon <amon@vnl.com>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
In-Reply-To: <20050920181039.GL16888@vnl.com>
References: <20050917233111.GA17916@vnl.com>
	 <1127132870.29404.14.camel@moss-spartans.epoch.ncsc.mil>
	 <20050920181039.GL16888@vnl.com>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 16:14:40 -0400
Message-Id: <1127247281.14569.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-20 at 19:10 +0100, Dale Amon wrote:
> Setting up selinux-policy-default (1.18-1) ...
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> libsepol.expand_avtab_insert: Type conflict!
> Out of memory - unable to check assertions
> Check assertions failed.
> make: *** [/etc/selinux/policy/policy.20] Error 255
<snip>
> Suggestions?

Yes, send me (privately) a copy of the policy.conf file.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
