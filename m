Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA14260
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 12:36:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA14750
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 17:34:33 GMT
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA14746
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 17:34:33 GMT
Message-ID: <3A5DEEFB.6C988852@sgi.com>
Date: Thu, 11 Jan 2001 09:35:55 -0800
From: Casey Schaufler <casey@sgi.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: Christoph Hellwig <hch@ns.caldera.de>, selinux@tycho.nsa.gov,
        linux-privs-discuss@sourceforge.net
Subject: Re: [Linux-privs-discuss] SELinux & Linux-privs projects
References: <Pine.SOL.3.95.1010111111746.23465T-100000@clipper.gw.tislabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Stephen Smalley wrote:

> The POSIX.1e MAC tightly couples policy and enforcement because
> it is designed for a particular kind of security policy.
> It assumes a certain kind of security label.

I don't know who told you that, but it certainly wasn't
anyone who worked on the standard. The 1e MAC specification
is explicitly devoid of any such assumptions. That's one
reason there's no specification on Moldy directories, for
example.

> It assumes hierarchical relationships among labels.

It assumes that there are two relationships, equality
and dominance, between labels. I can easily show labeling
schemes which are cyclic, but which can be represented
in terms of these relationships.

> It assumes that it is
> sufficient to treat all operations as being read, write, or execute.

That's because those are the only operations POSIX systems
support! It's implicit in being a POSIX (DRAFT) standard.

> In order to support Type Enforcement or Role-Based Access
> Control or other kinds of mandatory security, you are very likely
> to need to change or at least recompile the file system code,
> the networking code, etc.

Yes, and?

-- 

Casey Schaufler				Manager, Trust Technology, SGI
casey@sgi.com				voice: 650.933.1634
casey_p@pager.sgi.com			Pager: 888.220.0607

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
