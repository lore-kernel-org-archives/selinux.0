Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: db conflict ?
Date: Fri, 12 Apr 2002 17:12:52 +0200
Cc: Tom <tom@lemuria.org>, <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204121042260.21729-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204121042260.21729-100000@raven>
MIME-Version: 1.0
Message-Id: <20020412151252.D5E1D23B16@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Apr 2002 16:48, Stephen Smalley wrote:
> On Fri, 12 Apr 2002, Russell Coker wrote:
> > So what directory would we use?  /etc/selinux?
>
> Probably not.  You are using /etc/selinux to store the policy source
> files, right (and using the policy_src_t type)?

I was not using policy_src_t as it's not referenced in file_contexts.  My 
next version will change this.

> It seems preferable to
> keep the compiled policy in a separate directory and type
> (policy_config_t).  That should ultimately allow us to set up a direct
> pipeline enforced by the kernel from the policy sources through
> checkpolicy to the compiled policy.  I was thinking of a direct
> subdirectory of /, e.g. /selinux.

OK, that'll do.

Also while we're at it could we make the file names be 
"/selinux/ss_policy.%d", policy_version?

Then when we change policy versions we can easily switch between kernels that 
implement different versions of policy.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
