Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: db conflict ?
Date: Fri, 12 Apr 2002 15:27:57 +0200
Cc: Tom <tom@lemuria.org>, <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204120907250.21729-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204120907250.21729-100000@raven>
MIME-Version: 1.0
Message-Id: <20020412132757.47C8023B16@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Apr 2002 15:09, Stephen Smalley wrote:
> On Fri, 12 Apr 2002, Russell Coker wrote:
> > Steve, I think that we need an option in the policy.conf file to specify
> > the version of the policydb.  If we add it now then it'll break
> > compatability with old versions of checkpolicy (which is desired).  Then
> > we can say "policy v8" in the config file and count on any older version
> > refusing to compile it.
>
> The policy.conf file isn't necessarily tied to a particular version of the
> policydb (the binary representation).  The change from policydb version 7
> to policydb version 8 had no impact on policy.conf, just on the resulting
> policy (/ss_policy) file compiled by checkpolicy.

I realise that, I'm sorry if I gave the impression that things are otherwise.

However what I would like to do is distribute a package of tools for version 
8 and a policy.conf file to match which is resistant to errors that the user 
may make.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
