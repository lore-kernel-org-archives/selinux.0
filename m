Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8NMcX3M007556
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 18:38:33 -0400
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8NMcV7S021256
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 22:38:32 GMT
Message-ID: <1316817499.2487.89.camel@vortex>
Subject: Re: [refpolicy] pam_selinux(gdm-password:session): Security Context
 justin:staff_r:insmod_t:s0 Assigned
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@redhat.com>
Cc: Eric Paris <eparis@parisplace.org>, SE-Linux <selinux@tycho.nsa.gov>
Date: Sat, 24 Sep 2011 00:38:19 +0200
In-Reply-To: <1316812634.28696.1.camel@localhost>
References: <1316144432.85313.YahooMailNeo@web114304.mail.gq1.yahoo.com>
	 <4E736453.8000506@redhat.com> <4E7369AF.3000709@yahoo.com>
	 <4E737223.1060601@redhat.com> <1316795427.12007.110.camel@vortex>
	 <4E7CC41E.5040004@redhat.com> <1316804960.2487.62.camel@vortex>
	 <CACLa4pvtTeTq3LdY7vgFexDXXxk8ZYU5yBQRQexTyghkoL7B1w@mail.gmail.com>
	 <1316812338.2487.77.camel@vortex> <1316812634.28696.1.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Eric.

On Fri, 2011-09-23 at 17:17 -0400, Eric Paris wrote:
> On Fri, 2011-09-23 at 23:12 +0200, Guido Trentalancia wrote:
> 
> > You seem to suggest that load_policy -i (and not the kernel) should make
> > sure that init has transitioned to its designated context...
> 
> Can't speak for Justin's system.  

That's for sure. But it seems to me that he already stated that it just
loaded plain refpolicy from git on a plain F15 system. Since we are on
the list he might even confirm once again...

> But that's not what I said.  I said
> it's /sbin/init's problem to make sure it did the right thing and to
> handle errors correctly if it failed.  If Justin has his box enforcing
> and can boot without loading a policy that's a bug and needs to be
> filed.

He has loaded the policy.

The point is that when init does not transition to init_t nothing
happens and the system keeps running with all processes in kernel_t or
insmod_t.

It surely use to happen with upstream components and policy back at the
beginning of this year (I did test that and reported it to the refpolicy
mailing list).

Apparently it also happens with Fedora 15 according to what Justin
reported on here when he started this thread...

Earlier on Daniel Walsh said Fedora and RHEL would crash in such case
(init has not transitioned properly to init_t). I said "very good" (as
that is what I expect from a SELinux system) and asked "how did you
achieved that ?" because I believe such behavior should be definitely be
imported in upstream. But then I thought Daniel's statement doesn't
match with what Justin reported.

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
