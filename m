Subject: Re: selinuxfs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mario Fanelli <mario.fanelli@gmail.com>
Cc: SeLinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <448bd760.7fefe58f.4603.ffffeef3@mx.gmail.com>
References: <448bd760.7fefe58f.4603.ffffeef3@mx.gmail.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 10:56:50 -0400
Message-Id: <1150124210.8086.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-06-11 at 10:42 +0200, Mario Fanelli wrote:
> Under the directory /selinux, I found this file but I don't understand their
> meaning..
> 
> access
> checkreqprot
> context 
> create
> disable
> enforce 
> load
> member
> mls
> null 
> policyvers
> relabel
> user
> 
> Anyone can give me an help?

I suppose a selinuxfs man page might be nice.  selinux-doc/README has a
brief description at the end of the original set of selinuxfs nodes, but
hasn't been kept up to date.  Note that you really aren't supposed to
directly operate on the selinuxfs nodes - you should access them
indirectly via the libselinux interfaces (using helper utilities as
appropriate) for portability.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
