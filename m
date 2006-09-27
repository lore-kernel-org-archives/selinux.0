Date: Wed, 27 Sep 2006 14:15:33 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200609271915.k8RJFXXj013322@faith.austin.ibm.com>
To: jmorris@namei.org, latten@austin.ibm.com, sds@tycho.nsa.gov,
        vyekkirala@TrustedCS.com
Subject: RE: Labeled networking packets
Cc: chanson@TrustedCS.com, cpebenito@tresys.com, DGoeddel@TrustedCS.com,
        dwalsh@redhat.com, jbrindle@tresys.com, jmorris@redhat.com,
        kmacmillan@mentalrootkit.com, paul.moore@hp.com, selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> >In short, nothing really changes from the earlier secid 
>> reconciliation
>> >patches except for dealing with your earlier comments.  And 
>> then we also
>> >need the other patches mentioned in that thread, like 
>> labeling the SAs
>> >from the socket rather than the spd so that we no longer 
>> need per-domain
>> >spd rules, and setting the peer sid on TCP sockets to the reconciled
>> >secmark.
>> 
>> I need to clarify a few things to determine whether I need to 
>> modify racoon's code. 
>> Since we will label SAs from socket rather than from spd, do 
>> we still need to check SA's label against spd's label? 
>
>Yes. This way we can control what "domains" would use (un)labeled
>IPSec. These domains would "polmatch" to the spd label in the policy.
>
>> If not, do we still need spd to contain a label?
>
>Regardless an spd needn't contain a label; e.g.: you don't want to
>export the domain with the data; in this case you would use unlabeled
>IPSec; the domain would then have to polmatch to "unlabeled_t".
>
>> 
>> Also, I am not very clear how the local and remote racoons will
>> negotiate the labels. Initiator sends over security context from
>> socket... how does Remote side negotiate or determine it is 
>> valid or acceptable to him?
>
>racoon on the remote side will make sure the domain sent by the
>Initiator polmatches a policy on its (repsonder's) side, before
>responding. This should be already happening, so I don't envision
>any changes to racoon because of the change in the kernel. racoon
>will be just dealing with a different context received from the
>kernel, that's all.

Ok, thanks. I get it now. 
Venkat, let me know if there is anything I can 
do to help out with this portion, for example
any coding. 

Regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
