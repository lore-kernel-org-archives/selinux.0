Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27864
	for <selinux@tycho.nsa.gov>; Tue, 12 Mar 2002 11:29:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA09801
	for <selinux@tycho.nsa.gov>; Tue, 12 Mar 2002 16:28:25 GMT
Received: from lyta.coker.com.au (213-84-84-34.adsl.xs4all.nl [213.84.84.34])
        by jazzband.ncsc.mil  with ESMTP id QAA09770 for <selinux@tycho.nsa.gov>; Tue, 12 Mar 2002 16:28:18 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: Firewall Policy
Date: Tue, 12 Mar 2002 17:29:10 +0100
References: <Pine.GSO.4.33.0203120933540.10942-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203120933540.10942-100000@raven>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020312162911.5C7F75953@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 12 Mar 2002 16:05, Stephen Smalley wrote:
> We've defined a new domain for the rpm utilities when run as system cron
> jobs, and granted that domain the necessary permissions.  That domain
> (along with many other changes to the example policy) will be included in
> the next public release, which should be soon.

Please send me the RPM sample policy ASAP so I can get you a policy for dpkg, 
dselect, and apt-get in time for the next release!!!

> This is more difficult than it might seem.  Many applications end up
> accessing the network transparently for various services, e.g. NIS lookups
> to map uids to usernames, DNS lookups to lookup hosts and IP addresses,

Can't this all go through nscd?  If so then all you need is nscd access (unix 
domain socket) for all those applications.

> NFS accesses, etc.  Hence, removing can_network for a given domain might

Does NFS access go through the security policy as network access?  Surely NFS 
would be regarded as regular access to untyped files?

> If you simply want the policy to treat all ftp sessions identically, then
> you can use an unmodified ftpd with a very limited ftpd_t domain, as in
> the current example policy.  In that case, you don't need to define any
> user domains for ftp users.

Or you could take the cynical view that there's no point investing the effort 
of installing SE Linux if you're just going to go run insecure programs such 
as FTP servers.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
