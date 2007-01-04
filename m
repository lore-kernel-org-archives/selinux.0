Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l04MD93W024306
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 17:13:09 -0500
Received: from web36614.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l04MDjeK002035
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 22:13:46 GMT
Date: Thu, 4 Jan 2007 14:13:00 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd, and newrole
To: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Antill <jantill@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        redhat-lspp <redhat-lspp@redhat.com>
In-Reply-To: <459D72EF.3090707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <926802.72514.qm@web36614.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Daniel J Walsh <dwalsh@redhat.com> wrote:

> We still have a problem on MLS machines, in that
> newrole can be used to 
> pass data via pseudo terminals.
> 
> script
> newrole -l SystemHigh
> cat TopSecret.doc
> ^d
> ^d
> cat typescript
> 
> I propose we add this patch to newrole to check if
> we are on a pseudo 
> terminal and then fail if user is using -l.
> 
> Basically this patch checks the major number of the
> stdin, stdout, 
> stderr for a number in the pseudo number range,  If
> yes the pseudo 
> terminal, if not continue.  Not pretty but it solves
> the problem.  I 
> could not figure out another way to check if you are
> on a pseudo terminal. 
> 
> Comments?

Are you 100% certain that this is only a pty
issue? Any chance you'll have a similar problem
with other devices, pipes, fifos, UDS or the like?
My pair of Lincolns says otherwise, but they've
been wrong before.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
