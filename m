Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76E67rT012176
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 10:06:07 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i76E5Wps001430
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 14:05:33 GMT
Subject: Re: Now that SELinux supports booleans should we replace tunables
	with booleans?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   selinux-dev@tresys.com
In-Reply-To: <411239C9.4020505@redhat.com>
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>
	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>
	 <1091709011.11061.44.camel@moss-spartans.epoch.ncsc.mil>
	 <1091709228.11061.47.camel@moss-spartans.epoch.ncsc.mil>
	 <411239C9.4020505@redhat.com>
Content-Type: text/plain
Message-Id: <1091801095.8590.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 06 Aug 2004 10:04:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-08-05 at 09:44, Daniel J Walsh wrote:
> Here is the current patch I was using for load_policy.  As has been 
> stated this is not the ideal situation.
> Patching the policy.conf is probably the best solution.   Utilities to 
> read booleans probably usefull here.

As an interim solution, I've merged a slightly modified form of this
function into libselinux and changed load_policy to call it; /sbin/init
can likewise be changed to call it after the initial policy load to set
the boolean values.  But we'll still want to pursue a solution that lets
us re-patch the boolean default settings directly in the binary policy
so that there is no interval where the settings are wrong during a
policy reload.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
