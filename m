Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAKGY9nQ000764
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 11:34:09 -0500
Received: from web36611.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kAKGWSEc013417
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 16:32:29 GMT
Message-ID: <20061120163410.12804.qmail@web36611.mail.mud.yahoo.com>
Date: Mon, 20 Nov 2006 08:34:09 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [redhat-lspp] labeled ipsec policy
To: Paul Moore <paul.moore@hp.com>, Joy Latten <latten@austin.ibm.com>
Cc: cpebenito@tresys.com, redhat-lspp@redhat.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
In-Reply-To: <200611201124.19292.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Paul Moore <paul.moore@hp.com> wrote:


> Hmmm, I suspect this will probably be a problem as
> the IPsec management tools 
> serve a dual purpose, they control the IPsec
> configuration (sysadm_r) as well 
> as the policy relating to labeling SAs (secadm_r). 
> I guess we'll just have 
> to settle for sysadm_r and deal with the fact that
> sysadm_r is going to have 
> some control over the system's security policy in
> this case.

Alternatively, you might consider a separate
network security administrator role that is
associated with those tools. It might be better
than giving sysadm_r the additional responsibility.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
