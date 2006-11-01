MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: SELinux Networking Enhancements
Date: Wed, 1 Nov 2006 14:59:44 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885149A4@exchange.columbia.tresys.com>
In-Reply-To: <Pine.LNX.4.64.0611011456530.8872@d.namei>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "James Morris" <jmorris@namei.org>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: <vyekkirala@TrustedCS.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        <selinux@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>,
        <gcwilson@us.ibm.com>, "Paul Moore" <paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: James Morris [mailto:jmorris@namei.org] 
> 
> On Wed, 1 Nov 2006, Christopher J. PeBenito wrote:
> 
> > This is not acceptable for SELinux because the rules would be in 
> > netfilter instead of MAC policy.
> 
> Not necessarily -- an iptables module can call into the AVC 
> for a policy decision if needed.
> 

Then what would the filter rules look like? It sounded like Venkat
wanted something that would drop a packet based on a label (from secmark
or external) which would be enforcement. I don't know what the iptables
rule would look like if it was just going to call into the security
server.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
