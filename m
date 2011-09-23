Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8NLHNQX004563
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 17:17:23 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8NLHLJp003181
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 21:17:22 GMT
Message-ID: <1316812634.28696.1.camel@localhost>
Subject: Re: [refpolicy] pam_selinux(gdm-password:session): Security Context
 justin:staff_r:insmod_t:s0 Assigned
From: Eric Paris <eparis@redhat.com>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Eric Paris <eparis@parisplace.org>, SE-Linux <selinux@tycho.nsa.gov>
Date: Fri, 23 Sep 2011 17:17:14 -0400
In-Reply-To: <1316812338.2487.77.camel@vortex>
References: <1316144432.85313.YahooMailNeo@web114304.mail.gq1.yahoo.com>
	 <4E736453.8000506@redhat.com> <4E7369AF.3000709@yahoo.com>
	 <4E737223.1060601@redhat.com> <1316795427.12007.110.camel@vortex>
	 <4E7CC41E.5040004@redhat.com> <1316804960.2487.62.camel@vortex>
	 <CACLa4pvtTeTq3LdY7vgFexDXXxk8ZYU5yBQRQexTyghkoL7B1w@mail.gmail.com>
	 <1316812338.2487.77.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-09-23 at 23:12 +0200, Guido Trentalancia wrote:

> You seem to suggest that load_policy -i (and not the kernel) should make
> sure that init has transitioned to its designated context...

Can't speak for Justin's system.  But that's not what I said.  I said
it's /sbin/init's problem to make sure it did the right thing and to
handle errors correctly if it failed.  If Justin has his box enforcing
and can boot without loading a policy that's a bug and needs to be
filed.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
