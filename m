Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAKGOIAb000452
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 11:24:18 -0500
Received: from ccerelrim03.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAKGNWHO018223
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 16:23:33 GMT
From: Paul Moore <paul.moore@hp.com>
To: Joy Latten <latten@austin.ibm.com>
Subject: Re: [redhat-lspp] labeled ipsec policy
Date: Mon, 20 Nov 2006 11:24:18 -0500
Cc: redhat-lspp@redhat.com, selinux@tycho.nsa.gov, cpebenito@tresys.com,
        jbrindle@tresys.com
References: <1163802623.17737.398.camel@faith.austin.ibm.com> <200611201000.06118.pcmoore@engin.umich.edu> <1164035382.17737.408.camel@faith.austin.ibm.com>
In-Reply-To: <1164035382.17737.408.camel@faith.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200611201124.19292.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 20 November 2006 10:09 am, Joy Latten wrote:
> On Mon, 2006-11-20 at 10:00 -0500, Paul Moore wrote:
> > On Friday 17 November 2006 5:30 pm, Joy Latten wrote:
> > > The following policy enables labeled ipsec to run
> > > in enforcing mode. I configure labeled ipsec in sysadm_r role.
> > > Thus the rules I needed were specific to this role.
> >
> > I'll let the policy gurus comment on the rest of the policy, but I think
> > that we would want only the secadm_r role (in the MLS/LSPP policy) to be
> > able to configure labeled IPsec.  Yes?
>
> Actually, I wondered about this too. But when I took a look at the
> policy source, I noticed that in userdomain.te, sysadm_t was allowed
> to execute ipsec programs ipsec_exec_mgmt(sysadm_t), so I just assumed I
> should use sysadm_r role. Not sure if this was correct or not. Tried
> secadm_r role out of curiousity and got quite a lot of avc denied
> messages. So went with sysadm_r. :-)

Hmmm, I suspect this will probably be a problem as the IPsec management tools 
serve a dual purpose, they control the IPsec configuration (sysadm_r) as well 
as the policy relating to labeling SAs (secadm_r).  I guess we'll just have 
to settle for sysadm_r and deal with the fact that sysadm_r is going to have 
some control over the system's security policy in this case.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
