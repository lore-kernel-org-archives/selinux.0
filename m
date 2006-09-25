Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588443A34@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588443A34@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 11:35:25 -0400
Message-Id: <1159198525.21540.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-09-23 at 10:13 -0400, Joshua Brindle wrote:
> > From: Venkat Yekkirala [mailto:vyekkirala@TrustedCS.com] 
> > Let's go back to the drawing board, first of all define the 
> > problems we are trying to solve, and come up with a design.
> > 
> 
> My single requirement is that getpeercon() returns the full context of
> the remote process (or some translation negotiated by racoon). 

That single requirement is bogus - you'll never get it.  At most, you'll
get the full context of the remote socket endpoint.  Which might be the
same as the process, but not necessarily.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
