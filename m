Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q44EI07k031493
	for <selinux@tycho.nsa.gov>; Fri, 4 May 2012 10:18:00 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.5/8.14.5) with ESMTP id q44EJ4ER027413
	for <selinux@tycho.nsa.gov>; Fri, 4 May 2012 10:19:05 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.5/8.14.5/Submit) id q44E6Wb1026892
	for selinux@tycho.nsa.gov; Fri, 4 May 2012 10:06:32 -0400
Subject: Re: regression test of security policy
From: Stephen Smalley <sds@tycho.ncsc.mil>
To: Kohei KaiGai <kaigai@kaigai.gr.jp>
Cc: SELinux-NSA <selinux@tycho.nsa.gov>
In-Reply-To: <CADyhKSVyfCxx9dAziaR0bcbPvXW4C6FnV4J-Jux7gaMrT+-L+g@mail.gmail.com>
References: 
	 <CADyhKSVyfCxx9dAziaR0bcbPvXW4C6FnV4J-Jux7gaMrT+-L+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 May 2012 10:00:13 -0400
Message-ID: <1336140013.24121.13.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-05-04 at 15:48 +0200, Kohei KaiGai wrote:
> Does anyone have a tool to run regression test when we construct a patch?
> (Or, is it available to construct using existing tools?)
> 
> Right now, I have to replace a working policy by the modified one whenever
> I prepare to submit a patch towards reference policy. However, the default
> security policy of Fedora is optimized to Fedora environment, thus, it often
> mismatch with the latest upstream policy.
> For example, "allow_execmem" is not defined at Fedora, so, I could not
> load the staff.pp being constructed based on the upstream policy
> 
> So, the solution I'm looking for is a tool that loads a monolithic policy and
> checks its access control decision towards a certain pair of subject context
> and target context according to catalog files, then it prints the result of
> diff commands between the computed one and expected one.

Possibly you could derive such a tool from checkpolicy -d, switching
from a menu-driven interface to a scriptable one.

checkpolicy -Mdb /etc/selinux/targeted/policy/policy.24

setools would be the other option, but sesearch only deals with TE
rules.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
