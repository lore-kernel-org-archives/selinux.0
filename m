Subject: Re: [patch] libselinux:  do not set compat_net upon policy load
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        James Morris <jmorris@namei.org>
In-Reply-To: <1156360389.8506.100.camel@moss-spartans.epoch.ncsc.mil>
References: <1156360389.8506.100.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 15:37:25 -0400
Message-Id: <1156361845.4242.18.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-23 at 15:13 -0400, Stephen Smalley wrote:
> Revert the change to automatically set /selinux/compat_net at policy
> load time based on the policy, as this prevents compat_net from being
> effectively used with refpolicy-based policies that include the packet
> class definition.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 

So it has to be set manually now? How does the setting persist?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
