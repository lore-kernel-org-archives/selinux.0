Message-ID: <36282A1733C57546BE392885C061859201512CD9@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joy Latten <latten@us.ibm.com>,
        selinux@tycho.nsa.gov, paul.moore@hp.com
Subject: RE: ipsec and getpeercon()
Date: Fri, 1 Sep 2006 09:16:32 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Ok, aside from the bug I'm apparently experiencing (Joy is 
> looking in to
> it) I think I have misunderstood what getpeercon() is suppose 
> to do over
> ipsec. I was under the impression it would act like getpeercon() over
> unix stream sockets and get the context of the application on 
> the other
> side of the socket but that is apparently not what getpeercon() for
> ipsec does.

It should indeed return the peer's context when using ipsec as well.
I would consider the current behaviour as a bug. Joy is looking but
I will try to take a look as well.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
