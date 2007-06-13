Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <200706132116.05065.russell@coker.com.au>
References: <20070611204336.GA30846@sergelap.austin.ibm.com>
	 <20070612154412.GC14397@sergelap.austin.ibm.com>
	 <1181663857.17547.227.camel@moss-spartans.epoch.ncsc.mil>
	 <200706132116.05065.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 13 Jun 2007 08:31:50 -0400
Message-Id: <1181737910.17547.315.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-13 at 21:16 +1000, Russell Coker wrote:
> On Wednesday 13 June 2007 01:57, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > Well, first, no script should be allowed a capability that is not given
> > to its caller directly ;)
> 
> Why not?  Isn't that the entire point of this authoritative granting of 
> capabilities patch?

_script_, not program.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
