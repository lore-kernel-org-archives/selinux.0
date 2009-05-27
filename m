Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4RJaufs026628
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 15:36:56 -0400
Received: from g1t0028.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4RJaoE4015918
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 19:36:50 GMT
From: Paul Moore <paul.moore@hp.com>
To: Nigel Rumens <wooky@btconnect.com>
Subject: Re: selinux and sctp
Date: Wed, 27 May 2009 15:36:47 -0400
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <4A191AAC.4000500@btconnect.com> <200905261832.44705.paul.moore@hp.com> <4A1D6CDB.5030905@btconnect.com>
In-Reply-To: <4A1D6CDB.5030905@btconnect.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200905271536.47821.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 27 May 2009 12:39:55 pm Nigel Rumens wrote:
> On 05/26/2009 11:32 PM, Paul Moore wrote:
> > Hi Nigel,
> >
> > Can you send us the AVC denial messages?  If you are running a recent
> > kernel (F11/Rawhide should qualify and F10 will likely as well) there
> > should only be a handful of areas where you should be hitting transport
> > protocol specific code that isn't SCTP aware in the kernel, it would be
> > nice to verify that so we could better identify what work needs to be
> > done.
>
> Certainly - here you are.

...

> Raw Audit Messages :
>
> node=bear.cwb.uk type=AVC msg=audit(1242974819.377:32014): avc: denied {
> name_bind } for pid=14773 comm="sctp_darn" src=9876
> scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:port_t:s0 tclass=rawip_socket
> node=bear.cwb.uk type=SYSCALL msg=audit(1242974819.377:32014):
> arch=c000003e syscall=49 success=no exit=-13 a0=3 a1=7fff08b0bdd0 a2=10
> a3=7fff08b0bdc0 items=0 ppid=14732 pid=14773 auid=500 uid=500 gid=500
> euid=500 suid=500 fsuid=500 egid=500 sgid=500 fsgid=500 tty=pts2 ses=51
> comm="sctp_darn" exe="/usr/bin/sctp_darn"
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)

Thanks!

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
