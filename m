Date: Tue, 5 Sep 2006 09:36:10 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200609051436.k85EaAOt022422@faith.austin.ibm.com>
To: jbrindle@tresys.com, paul.moore@hp.com
Subject: Re: ipsec and getpeercon()
Cc: latten@austin.ibm.com, latten@us.ibm.com, sds@tycho.nsa.gov,
        selinux@tycho.nsa.gov, vyekkirala@TrustedCS.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>Or it could just be that I'm retarded and booted up on the wrong kernel
>after cloning the VM. The new results (with no SAD or SPD entries) is a
>nice "Protocol not available" on both sides. With the entries I now get 
>
>server: got connection from 10.1.13.104, system_u:object_r:unlabeled_t
>
>which is the correct label of the local ipsec socket (changed it to make
>sure it was getting the local context) which still isn't what I'd expect
>getpeercon() to tell me.
>

Actually, this sounds correct. If neither Cipso nor IPSec or configured,
then code should return -ENOPROTOPT. Thus the "Protocol not available".

When using basic IPSec, two SAs, an In & Out SA must exist for each 
traffic stream you wish to protect and on both the local and remote machines. 
When using labeled SAs, we have extended this such that whatever you have
as the label in the SA, is what that socket is restricted to send or receive on 
both the local and remote machines. Thus you can conclude, that the 
label getpeercon() gets back from labeled SA is the label of the remote socket.

Yes, this can result in lots of SAs, but that is something we did consider.
Some work has been done recently by the networking maintainer to improve
performance inserting and I think searching the policy and SA databases.

I have started working on the documentation on how to use the labeled
SA feature.

Regards,
Joy



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
