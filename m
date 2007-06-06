Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Paul Moore'" <paul.moore@hp.com>, "KaiGai Kohei" <kaigai@ak.jp.nec.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "KaiGai Kohei" <kaigai@kaigai.gr.jp>, "Joe Nall" <joe@nall.com>,
        "SELinux Mail List" <selinux@tycho.nsa.gov>, <ewalsh@tycho.nsa.gov>
Subject: RE: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an interface)
Date: Wed, 6 Jun 2007 08:38:10 -0500
Message-ID: <000301c7a83f$ecf25920$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200706060745.31980.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Your proposal is slightly different in that I view it more as 
> a per-domain 
> renaming scheme where you rename/relabel packets based on the 
> receiving 
> domain.  Can you help me understand the advantage of 
> renaming "untrusted_network_t" to "sepgsql_client_t" from a 
> policy point of 
> view?  For example, how would these two policy rules be 
> different or have any 
> advantage over one another:
> 
>  allow sepgsql_t untrusted_network_t:<class> <perms>;
>  allow sepgsql_t sepgsql_client_t:<class> <perms>:

I doubt that the intent here is to change the permission checks
to use the transition label. Rather the idea seems to be to
have getpeercon() return the transition label (sepgsql_client_t).

Coincidentally we (Darrel, Chad and myself) were talking about this
and it seems like a good idea.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
