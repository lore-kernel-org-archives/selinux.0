Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8RGkwR7023661
	for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2006 12:46:58 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8RGkPJr006448
	for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2006 16:46:25 GMT
Message-ID: <36282A1733C57546BE392885C061859201573A09@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joy Latten <latten@austin.ibm.com>, jmorris@namei.org, sds@tycho.nsa.gov
Cc: Chad Hanson <chanson@TrustedCS.com>, cpebenito@tresys.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jbrindle@tresys.com, jmorris@redhat.com, kmacmillan@mentalrootkit.com,
        paul.moore@hp.com, selinux@tycho.nsa.gov,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Subject: RE: Labeled networking packets
Date: Wed, 27 Sep 2006 12:46:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> >In short, nothing really changes from the earlier secid 
> reconciliation
> >patches except for dealing with your earlier comments.  And 
> then we also
> >need the other patches mentioned in that thread, like 
> labeling the SAs
> >from the socket rather than the spd so that we no longer 
> need per-domain
> >spd rules, and setting the peer sid on TCP sockets to the reconciled
> >secmark.
> 
> I need to clarify a few things to determine whether I need to 
> modify racoon's code. 
> Since we will label SAs from socket rather than from spd, do 
> we still need to check SA's label against spd's label? 

Yes. This way we can control what "domains" would use (un)labeled
IPSec. These domains would "polmatch" to the spd label in the policy.

> If not, do we still need spd to contain a label?

Regardless an spd needn't contain a label; e.g.: you don't want to
export the domain with the data; in this case you would use unlabeled
IPSec; the domain would then have to polmatch to "unlabeled_t".

> 
> Also, I am not very clear how the local and remote racoons will
> negotiate the labels. Initiator sends over security context from
> socket... how does Remote side negotiate or determine it is 
> valid or acceptable to him?

racoon on the remote side will make sure the domain sent by the
Initiator polmatches a policy on its (repsonder's) side, before
responding. This should be already happening, so I don't envision
any changes to racoon because of the change in the kernel. racoon
will be just dealing with a different context received from the
kernel, that's all.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
