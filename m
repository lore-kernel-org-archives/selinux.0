Message-ID: <36282A1733C57546BE392885C0618592015CF6F5@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
        Linda Knippers
	 <linda.knippers@hp.com>
Cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        redhat-lssp@redhat.com, paul.moore@hp.com,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>, jmorris@namei.org
Subject: RE: RHEL5 Kernel with labeled networking
Date: Tue, 3 Oct 2006 13:16:26 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Only if you set /selinux/compat_net to 1.
> Otherwise, you need modified policy to define and allow 
> flow_in/flow_out
> permissions as required, and I suspect you need more in order to deal
> with the fact that we now get labeled traffic on loopback by default
> (thus affecting packet send/recv as well).  Venkat, do you 
> have a policy
> patch?

Will post one in a couple of hours.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
