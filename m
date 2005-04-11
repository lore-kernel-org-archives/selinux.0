Subject: Re: getfattr works, but getfilecon doesn't
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ncunningham@cyclades.com
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1112999252.3261.5.camel@desktop.cunningham.myip.net.au>
References: <1112999252.3261.5.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain
Date: Mon, 11 Apr 2005 12:28:45 -0400
Message-Id: <1113236925.22198.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-04-09 at 08:27 +1000, Nigel Cunningham wrote:
> I've made further progress, such that I now know that the labels are
> properly stored and accessible through the getfattr command, but not
> through getfilecon.
> 
> I added printks to the kernel, and see them activated in the case of
> getfattr, but not for getfilecon. The return code that getfilecon
> received back from its getxattr call is -1.
> 
> I can keep working through this myself, but if someone knows the answer
> offhand, I'd really appreciate hearing it.

BTW, a copy of your patch would be helpful in diagnosing the
problem...you presumably would have had to update the original one for
the xattr consolidation and changes to the security hooks.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
