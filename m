Message-ID: <36282A1733C57546BE392885C061859201512F12@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joy Latten <latten@austin.ibm.com>, jbrindle@tresys.com, paul.moore@hp.com
Cc: latten@us.ibm.com, sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: RE: ipsec and getpeercon()
Date: Tue, 5 Sep 2006 16:01:47 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> >Or it could just be that I'm retarded and booted up on the 
> wrong kernel
> >after cloning the VM. The new results (with no SAD or SPD 
> entries) is a
> >nice "Protocol not available" on both sides. With the 
> entries I now get 
> >
> >server: got connection from 10.1.13.104, 
> system_u:object_r:unlabeled_t
> >
> >which is the correct label of the local ipsec socket 
> (changed it to make
> >sure it was getting the local context) which still isn't 
> what I'd expect
> >getpeercon() to tell me.
> >
> 
> Actually, this sounds correct. If neither Cipso nor IPSec or 
> configured,
> then code should return -ENOPROTOPT. Thus the "Protocol not 
> available".
> 
> When using basic IPSec, two SAs, an In & Out SA must exist for each 
> traffic stream you wish to protect and on both the local and 
> remote machines. 
> When using labeled SAs, we have extended this such that 
> whatever you have
> as the label in the SA, is what that socket is restricted to 
> send or receive on 
> both the local and remote machines. Thus you can conclude, that the 
> label getpeercon() gets back from labeled SA is the label of 
> the remote socket.
> 

It should have been whatever context is associated with the incoming SA.
But the current code returns the context associated with the outgoing SA
and this is not right. Even so, this doesn't explain getpeercon returning
the local socket context as opposed to the outgoing SA's context (which
is derived from the SPD entry currently).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
