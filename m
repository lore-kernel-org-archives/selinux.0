Message-ID: <36282A1733C57546BE392885C0618592015CFD3F@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com, jmorris@namei.org,
        sds@tycho.nsa.gov, paul.moore@hp.com, eparis@redhat.com
Subject: RE: [PATCH 0/1] selinux: secid reconciliation fixes V01: Intro
Date: Mon, 9 Oct 2006 09:56:13 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Do you have a git tree with everything you have so far? Some of your
> patches won't apply to the net-2.6 I have. Perhaps James could put a
> branch in his selinux-2.6?

I unfortunately don't have a git tree accessible from the outside. And
I haven't updated my git tree since Eric Paris was already having to
think about updating RHEL5 networking to accommodate the secid work that was
posted recently. I was really hoping for Eric/Steve to apply this patch to
the lspp tree and spin a new kernel.

But I will try to get a cumulative patch out today that will apply to
the latest net-2.6.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
