Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
        "KaiGai Kohei" <kaigai@kaigai.gr.jp>
Cc: "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        "'Paul Moore'" <paul.moore@hp.com>,
        "KaiGai Kohei" <kaigai@ak.jp.nec.com>, "Joe Nall" <joe@nall.com>,
        "SELinux Mail List" <selinux@tycho.nsa.gov>, <ewalsh@tycho.nsa.gov>
Subject: RE: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an interface)
Date: Wed, 6 Jun 2007 13:37:04 -0500
Message-ID: <000801c7a869$aecf1d70$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1181152890.3699.189.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Yes, I'm not referring to fallback behavior there but instead to how
> they are using security_compute_create() to compute the domain
> transition on the child.  While preserving the MLS range from 
> the peer.

Just curious; how does policy analysis based on allow rules you (Stephen)
mentioned earlier play into this in userland?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
