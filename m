Subject: Re: Labeled networking packets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com
In-Reply-To: <4518302F.4070804@hp.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588443A34@exchange.columbia.tresys.com>
	 <1159198525.21540.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1159202108.4252.4.camel@localhost.localdomain>
	 <1159207486.15305.60.camel@moss-spartans.epoch.ncsc.mil>
	 <1159208755.3169.47.camel@twoface.columbia.tresys.com>
	 <1159209686.4741.46.camel@localhost.localdomain> <4518275B.9040609@hp.com>
	 <1159212339.16246.12.camel@moss-spartans.epoch.ncsc.mil>
	 <4518302F.4070804@hp.com>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 15:56:26 -0400
Message-Id: <1159214186.16246.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 15:38 -0400, Paul Moore wrote:
> > But that doesn't deal with the TE aspect of the socket context, right?
> > So you end up with the sockets being left in xinetd_t.
> 
> That depends on the underlying labeling protocol.  Steve Grubb's xinetd
> patch simply takes the output of getpeercon() and feeds it back into
> setexeccon().  In the case of NetLabel, the context returned by
> getpeercon is the concatenation of the parent socket's TE context and
> the MLS label of the remote socket.  So for NetLabel, yes, the spawned
> server process will run in the xinetd_t domain, or whatever domain
> xinetd was running in when the connection was established.  With labeled
> IPsec this will obviously be different.

Hmmm...using the peer context in total as the new process context isn't
quite what you want, as you want the domain to reflect the service as
well (e.g. run in.ftpd in ftpd_t, not in the client's domain).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
