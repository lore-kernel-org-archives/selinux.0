Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w26JSmhW019326
 for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2018 14:28:48 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC11.oob.disa.mil (Postfix) with SMTP id 3zwmzJ1qtczg5pw
 for <selinux@tycho.nsa.gov>; Tue,  6 Mar 2018 19:28:44 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC11.oob.disa.mil (Postfix) with ESMTP id 3zwmzH1RFszg5pr
 for <selinux@tycho.nsa.gov>; Tue,  6 Mar 2018 19:28:43 +0000 (UTC)
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 John Johansen <john.johansen@canonical.com>,
 James Morris <james.l.morris@oracle.com>, gregkh@linuxfoundation.org,
 serge@hallyn.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
References: <20170908164001.21138-1-sds@tycho.nsa.gov>
 <CAHC9VhSga+mg8VTtVoafdbpQ2K62PEBGrWidB8SUwWtRO+hahA@mail.gmail.com>
 <alpine.LRH.2.21.1709090808200.15026@namei.org>
 <CAHC9VhQ3YRmk7k5DQO9zoGKRXi3CSTHvmRuLa891NVWsVNCZZA@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8b1ea069-2389-5298-c187-647202762d72@schaufler-ca.com>
Date: Tue, 6 Mar 2018 11:28:34 -0800
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQ3YRmk7k5DQO9zoGKRXi3CSTHvmRuLa891NVWsVNCZZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] usb, signal, security: only pass the cred,
 not the secid, to kill_pid_info_as_cred and security_task_kill
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 3/6/2018 11:01 AM, Paul Moore wrote:
> On Fri, Sep 8, 2017 at 6:09 PM, James Morris <jmorris@namei.org> wrote:
>> On Fri, 8 Sep 2017, Paul Moore wrote:
>>> Looks fine to me from a SELinux perspective.  If Casey and John are
>>> happy with this I can volunteer to pull it into the selinux/next tree
>>> (once the merge window closes), otherwise if someone else wants to
>>> merge this my ack is below.
>> As this impacts multiple LSMs, I'd prefer to take it via my tree.
> What happened to this James?  As best I can tell there were never any
> objections, and plenty of ACKs, but I don't see it in Linus' tree.
> I'll extend my offer to merge it, but I know you expressed a desire to
> pull this via your tree.

I was also surprised that it had not been included.

>
> * http://kernsec.org/pipermail/linux-security-module-archive/2017-September/003156.html
>
