Date: Mon, 2 Jun 2003 20:11:18 +0200
From: Tom <tom@lemuria.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Default Policy question?
Message-ID: <20030602201118.K2944@lemuria.org>
References: <3EDB7585.8050308@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3EDB7585.8050308@redhat.com>; from dwalsh@redhat.com on Mon, Jun 02, 2003 at 12:04:21PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 02, 2003 at 12:04:21PM -0400, Daniel J Walsh wrote:
> Has anyone discussed the problem of having root be a member of the 
> sysadm_r role.  

I think it was mentioned on this list, yes. In fact, I've made it a
habit to remove root from sysadm_r.


> Is there a way to define policy such that you could
> allow a sysadmin to manipulate configuration without allowing them to
> effect policy?  Ie, does the default policy allow someone the ability to
> change the /etc/printcap file but not run load_policy?  

Yes, it does. The policy files have their own types, so it would be
easy to restrict them more than normal config files. In fact, many
config files have their own types as well, so you can seperate
different applications and have different admins for them.


> Should we have three levels of user by default.  

More :)

I've just started working on something. I will likely post a proposal
in a couple of days. If you want to work with me on this, just yell.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
