Message-ID: <36282A1733C57546BE392885C061859201512DD1@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>, Joy Latten <latten@austin.ibm.com>
Cc: latten@us.ibm.com, Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        jbrindle@tresys.com, sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: RE: ipsec and getpeercon()
Date: Fri, 1 Sep 2006 16:49:55 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Unfortunately, the fix
> is not immediately obvious.

You would use the xfrm_sid and in it's absence the node
sid as the base sid.

If using secmark, it will get copied into peer_sid.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
