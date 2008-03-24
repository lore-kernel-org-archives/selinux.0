Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2OIekS8003281
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 14:40:46 -0400
Received: from web36605.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2OIefQR022000
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 18:40:41 GMT
Date: Mon, 24 Mar 2008 11:13:54 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Removing DAC.
To: Stephen Smalley <sds@tycho.nsa.gov>,
        cinthya aranguren <cinthya.aranguren@gmail.com>
Cc: casey@schaufler-ca.com, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>
In-Reply-To: <1206380713.3302.43.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <207587.93872.qm@web36605.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> 

> > This is a good point. I will experiment with CAP_DAC_OVERRIDE.
> > but .. why SELinux take DAC attributes into account when making
> > decisions ?? this does not violate the separation of "policy" from
> > "Enforcement" ??
> 
> SELinux does not use the DAC attributes (uid, gid, mode bits) as part of
> its decision.

I stand corrected. Somehow I thought that uids came into the
equation, but I guess I was wrong.

> SELinux does however control the use of capabilities/privileges in
> accordance with its policy.  And it does have a notion of user identity
> in its security context, although that is separately managed and is
> usually used just as a "role set" construct in modern SELinux (e.g.
> staff_u authorized for staff_r and sysadm_r).

That's were I was confusing things, the security context uid being
a component of the policy that is maintained in addition to the
traditional uid. Thank you for the clarification.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
