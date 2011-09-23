Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8NKj60l002810
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 16:45:06 -0400
Received: from mail-vx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8NKj57S007125
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 20:45:06 GMT
Received: by vcdn13 with SMTP id n13so1881489vcd.12
        for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 13:45:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1316804960.2487.62.camel@vortex>
References: <1316144432.85313.YahooMailNeo@web114304.mail.gq1.yahoo.com>
	<4E736453.8000506@redhat.com>
	<4E7369AF.3000709@yahoo.com>
	<4E737223.1060601@redhat.com>
	<1316795427.12007.110.camel@vortex>
	<4E7CC41E.5040004@redhat.com>
	<1316804960.2487.62.camel@vortex>
Date: Fri, 23 Sep 2011 16:45:05 -0400
Message-ID: <CACLa4pvtTeTq3LdY7vgFexDXXxk8ZYU5yBQRQexTyghkoL7B1w@mail.gmail.com>
Subject: Re: [refpolicy] pam_selinux(gdm-password:session): Security Context
 justin:staff_r:insmod_t:s0 Assigned
From: Eric Paris <eparis@parisplace.org>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 23, 2011 at 3:09 PM, Guido Trentalancia
<guido@trentalancia.com> wrote:
> On Fri, 2011-09-23 at 13:38 -0400, Daniel J Walsh wrote:

> Yes, very good. At the end, a very polite message is not the first
> priority in such as situation...
>
> But unfortunately this is not the case for the upstream bits.
>
> Ideally should be tackled in the SELinux kernel code. Did RHEL and
> Fedora patch the kernel then to achieve that ?

No we consider init to be part of the trusted base required to load
policy.  The Fedora init (systemd not, but it's been old init, some
scripts in the initramfs, and who know what else) tries to load policy
and if it can't and it was supposed to be enforcing will either print
and error and halt for a really long time and then exit, or exit
directly.  init exiting is enough to make the kernel panic and thus
shut down the box.

The tool that is trusted to load the policy is what needs to make this check.

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
