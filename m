Date: Fri, 12 Apr 2002 10:48:22 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Tom <tom@lemuria.org>, <SELinux@tycho.nsa.gov>
Subject: Re: db conflict ?
In-Reply-To: <20020412143847.D5446281EF@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204121042260.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Russell Coker wrote:

> So what directory would we use?  /etc/selinux?

Probably not.  You are using /etc/selinux to store the policy source
files, right (and using the policy_src_t type)?  It seems preferable to
keep the compiled policy in a separate directory and type
(policy_config_t).  That should ultimately allow us to set up a direct
pipeline enforced by the kernel from the policy sources through
checkpolicy to the compiled policy.  I was thinking of a direct
subdirectory of /, e.g. /selinux.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
