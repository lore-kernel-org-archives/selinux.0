Date: Wed, 27 Sep 2006 11:14:28 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200609271614.k8RGESES012445@faith.austin.ibm.com>
To: jmorris@namei.org, sds@tycho.nsa.gov
Subject: RE: Labeled networking packets
Cc: chanson@TrustedCS.com, cpebenito@tresys.com, DGoeddel@TrustedCS.com,
        dwalsh@redhat.com, jbrindle@tresys.com, jmorris@redhat.com,
        kmacmillan@mentalrootkit.com, latten@austin.ibm.com, paul.moore@hp.com,
        selinux@tycho.nsa.gov, vyekkirala@TrustedCS.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>In short, nothing really changes from the earlier secid reconciliation
>patches except for dealing with your earlier comments.  And then we also
>need the other patches mentioned in that thread, like labeling the SAs
>from the socket rather than the spd so that we no longer need per-domain
>spd rules, and setting the peer sid on TCP sockets to the reconciled
>secmark.

I need to clarify a few things to determine whether I need to 
modify racoon's code. 
Since we will label SAs from socket rather than from spd, do 
we still need to check SA's label against spd's label? 
If not, do we still need spd to contain a label?

Also, I am not very clear how the local and remote racoons will
negotiate the labels. Initiator sends over security context from
socket... how does Remote side negotiate or determine it is 
valid or acceptable to him?

Regards,
Joy



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
