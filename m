Message-ID: <5053727C.5000303@tresys.com>
Date: Fri, 14 Sep 2012 14:07:56 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Add initial clipboard access control implementation
References: <1347636256-4457-1-git-send-email-jbrindle@tresys.com> <1347645105.11029.77.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1347645105.11029.77.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
<snip>
> Likely of greater concern are the edge cases for Binder.getCallingPid()
> and SELinux.getPidContext().
>

Are there plans to upstream Binder.getContext()?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
