Date: Fri, 12 Apr 2002 09:09:35 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Tom <tom@lemuria.org>, <SELinux@tycho.nsa.gov>
Subject: Re: db conflict ?
In-Reply-To: <20020412120516.E261F2845B@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204120907250.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Russell Coker wrote:

> Steve, I think that we need an option in the policy.conf file to specify the
> version of the policydb.  If we add it now then it'll break compatability
> with old versions of checkpolicy (which is desired).  Then we can say
> "policy v8" in the config file and count on any older version refusing to
> compile it.

The policy.conf file isn't necessarily tied to a particular version of the
policydb (the binary representation).  The change from policydb version 7
to policydb version 8 had no impact on policy.conf, just on the resulting
policy (/ss_policy) file compiled by checkpolicy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
