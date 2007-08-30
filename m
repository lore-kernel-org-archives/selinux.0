Subject: Re: Time to remove compat_net?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        James Morris <jmorris@namei.org>
In-Reply-To: <200708301607.42110.paul.moore@hp.com>
References: <200708301607.42110.paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 30 Aug 2007 16:12:24 -0400
Message-Id: <1188504744.26572.361.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-30 at 16:07 -0400, Paul Moore wrote:
> Does anyone have any objections to placing the compat_net code on the 
> kernel's "feature removal schedule" (I'd go for removal in 2/2008, six months 
> from now)?  SECMARK can do everything that the older compat_net controls can 
> do, and it does it with less overhead and a cleaner implementation.

I'd be happy to see it go (conditional checks considered harmful), but a
good starting point would be to get secmark turned on in Fedora (it was
still off last I looked) and verify that nothing breaks.

We also don't have any tools capable of managing secmark today; with the
legacy controls, we could labels ports and netifs via semanage.  Only
secmark userland integration to date has been the basic iptables command
line support.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
