Subject: Re: ping broken symptoms
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1126901679.18007.138.camel@sgc.columbia.tresys.com>
References: <1126901679.18007.138.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 16:17:13 -0400
Message-Id: <1126901833.27393.146.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-16 at 16:14 -0400, Christopher J. PeBenito wrote:
> At the bottom of the ping policy, there is this ifdef:
> 
> ifdef(`hide_broken_symptoms', `
> allow ping_t init_t:fd use;
> ')
> 
> Isn't the purpose of the hide_broken_symptoms m4 tunable to dontaudit
> broken code that can work without these accesses, not allow them?

Yes, looks like a mistake to me.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
