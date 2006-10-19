Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "Darrel Goeddel" <DGoeddel@tcs-sec.com>
Cc: "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "'Joshua Brindle'" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>,
        <sds@tycho.nsa.gov>
Subject: RE: Denials from newest kernel
Date: Thu, 19 Oct 2006 10:57:16 -0500
Message-ID: <001001c6f397$408b2570$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1161179110.10392.78.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I want to be able to restrict which associations a packet can go over,
> specified by TE policy _alone_.

Yes. The current design (including the constraints for context equality)
is in fact assuring that all packets from apache use the apache_t
association, since it's all coming from apache. This also preserves
the getpeercon semantics in that the remote BIND as well as firefox_t
will see the traffic as coming from apache_t. Choice of association
by "packet type" (specified entirely in the SELinux policy) isn't
possible for the following reasons:

1. secmarking comes into play AFTER the association is chosen. This is just
   how Linux networking operates.
2. In the new secpoint design (if we ever get to do it) there's no "packet
   type" per se. It's a flow-control point (dp_bind_t and dp_firefox_t) that
   apache_t will have to be configured to talk to in the SELinux policy.

So SELinux policy would have to assume that all packets from apache
use a "single" apache_t association, but in reality they may get to
be different associations based on how you have your SPD and SAD and IKE
setup. Also, if we think about it it's not an unreasonable assumption to
make either since this means different socket domains will use different
associations, thus assuring the needed separation. For what IPSec does
(encryption, auth, compress) this seems to be a good-enough isolation.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
