Subject: Re: sepcut is broken
From: Karl MacMillan <kmacmillan@tresys.com>
To: Mark Shakespeare <mshakes@llnl.gov>
Cc: Selinux Dev <selinux-dev@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <p06020415bc3612f59c62@[128.115.96.64]>
References: <p0602040cbc34b0d29bb3@[128.115.96.64]>
	 <1074789931.27824.87.camel@colossus.columbia.tresys.com>
	 <p06020411bc35dc7ed885@[128.115.96.64]>
	 <1074803381.27824.109.camel@colossus.columbia.tresys.com>
	 <p06020412bc35f035775a@[128.115.96.64]>
	 <1074807951.27824.168.camel@colossus.columbia.tresys.com>
	 <p06020414bc35f7241764@[128.115.96.64]>
	 <1074810177.27824.173.camel@colossus.columbia.tresys.com>
	 <p06020415bc3612f59c62@[128.115.96.64]>
Content-Type: text/plain
Message-Id: <1074876530.27824.198.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Fri, 23 Jan 2004 11:48:50 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-22 at 18:58, Mark Shakespeare wrote:
> Karl,
>        Appreciate your help here. I failed to mention that I had installed
> a newer release of BWidgets....version 1.7
> 
> Well....I removed it, and defaulted to version 1.4.1
> 

Great - I'm glad that it is working for you now. We will test setools
with bwidgets 1.7 and get things working for the next release.

> Now sepcut works......although I'am getting a "security_load_policy failed"....
> " make: *** [reload] Error 3 " now...
> 
> any ideas????
> 

Looks like you don't have permission to do a policy reload. Make certain
that you are root and in the sysadm_r:sysamd_t context (the context is
only important if you are in enforcing mode).

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
