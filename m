Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA1Jvk5g032156
	for <selinux@tycho.nsa.gov>; Wed, 1 Nov 2006 14:57:46 -0500
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA1Juu0M015152
	for <selinux@tycho.nsa.gov>; Wed, 1 Nov 2006 19:56:57 GMT
Date: Wed, 1 Nov 2006 14:57:43 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
cc: vyekkirala@TrustedCS.com, Venkat Yekkirala <vyekkirala@tcsfw4.tcs-sec.com>,
        jbrindle@tresys.com, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, gcwilson@us.ibm.com,
        Paul Moore <paul.moore@hp.com>
Subject: RE: SELinux Networking Enhancements
In-Reply-To: <1162403736.4095.12.camel@sgc>
Message-ID: <Pine.LNX.4.64.0611011456530.8872@d.namei>
References: <000c01c6fdce$8b49fcd0$cc0a010a@tcssec.com> <1162403736.4095.12.camel@sgc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Nov 2006, Christopher J. PeBenito wrote:

> This is not acceptable for SELinux because the rules would be in
> netfilter instead of MAC policy.

Not necessarily -- an iptables module can call into the AVC for a policy 
decision if needed.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
