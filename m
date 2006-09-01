Date: Fri, 1 Sep 2006 13:17:23 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200609011817.k81IHNlO019842@faith.austin.ibm.com>
To: vyekkirala@TrustedCS.com
Subject: RE: ipsec and getpeercon()
Cc: jbrindle@tresys.com, paul.moore@hp.com, sds@tycho.nsa.gov,
        selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> Ok, aside from the bug I'm apparently experiencing (Joy is 
>> looking in to
>> it) I think I have misunderstood what getpeercon() is suppose 
>> to do over
>> ipsec. I was under the impression it would act like getpeercon() over
>> unix stream sockets and get the context of the application on 
>> the other
>> side of the socket but that is apparently not what getpeercon() for
>> ipsec does.
>
>It should indeed return the peer's context when using ipsec as well.
>I would consider the current behaviour as a bug. Joy is looking but
>I will try to take a look as well.

Ok, I looked at the code, and yes, if the socket class is 
tcp_socket, the dst for the socket is examined for a 
xfrm (in other words, an SA). If there is a xfrm, the context 
in the xfrm is used. Otherwise, we return -ENOPROTOOPT.

So yes, it is assumed that the context in the SA associated with the 
destination is the peer's context. I have always viewed labeled SAs 
as meaning, I want to restrict access to this socket/traffic stream 
to this context.  

Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
