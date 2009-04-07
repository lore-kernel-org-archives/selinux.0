Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n373GZvW004507
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 23:16:35 -0400
Received: from smtp101.prem.mail.sp1.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n373GZCU002032
	for <selinux@tycho.nsa.gov>; Tue, 7 Apr 2009 03:16:35 GMT
Message-ID: <49DAC587.5000400@schaufler-ca.com>
Date: Mon, 06 Apr 2009 20:16:23 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Robert Mykland <robert@ascenium.com>
CC: linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Interoperation with SELinux
References: <49DA8BE2.2040302@ascenium.com>
In-Reply-To: <49DA8BE2.2040302@ascenium.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Robert Mykland wrote:
> Gentlemen,
>
> I am trying to write something that will allow only a particular
> application to access a particular block device in the system, except
> that maybe directory reads are allowed.  It seems clear that this
> would be simple to do as a security module, but SELinux is also used
> on the system I'm writing this for.  Reading the archives, it seems as
> though there's currently no way to write a security module that will
> interoperate with the SELinux security module.  Am I wrong?

No, you are correct. Stacking of Linux Security Modules (LSMs) is not
supported and the notion is currently out of favor.

>
> From my untutored perusal of the SELinux docs, I'm also getting the
> sense that I couldn't write this into an SELinux profile of some sort.

At the risk of sounding sarcastic (I'm the leader of the Loyal Opposition
to SELinux) I suspect that there is a way to do it using SELinux policy,
but that attempting it may require significant policy development skills.
You might take your question to the SELinux mailing list (I've cc'ed it
for you) as that's likely to be your best resource on this. Good luck.


>
> Your thoughts on this would be greatly appreciated.
>
> -- Robert.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
