Message-ID: <36282A1733C57546BE392885C061859201512E87@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle
	 <jbrindle@tresys.com>,
        Joy Latten <latten@austin.ibm.com>, latten@us.ibm.com,
        selinux@tycho.nsa.gov
Subject: RE: ipsec and getpeercon()
Date: Tue, 5 Sep 2006 12:27:43 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > In the secmark world, we will be setting peer_sid to the 
> final secmark
> > of the packet (post reconciliation). So, I am not as much 
> worried about
> > the above netlabel behavior (unless someone is intent on 
> using the compat
> > case in conjunction with cipso with any seriousness).
> 
> This is an important discussion but I think it's probably 
> best until you
> post the entire secid reconciliation patch so we are all on 
> the same page.

Well, there are always people out there that appreciate getting a feel
for what's coming up, but I understand your anxiousness. :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
