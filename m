Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8NNCofp009047
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 19:12:50 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8NNCl7S024759
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 23:12:48 GMT
Message-ID: <1316819560.2652.2.camel@localhost>
Subject: Re: [refpolicy] pam_selinux(gdm-password:session): Security Context
 justin:staff_r:insmod_t:s0 Assigned
From: Eric Paris <eparis@redhat.com>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Eric Paris <eparis@parisplace.org>, SE-Linux <selinux@tycho.nsa.gov>
Date: Fri, 23 Sep 2011 19:12:40 -0400
In-Reply-To: <1316817499.2487.89.camel@vortex>
References: <1316144432.85313.YahooMailNeo@web114304.mail.gq1.yahoo.com>
	 <4E736453.8000506@redhat.com> <4E7369AF.3000709@yahoo.com>
	 <4E737223.1060601@redhat.com> <1316795427.12007.110.camel@vortex>
	 <4E7CC41E.5040004@redhat.com> <1316804960.2487.62.camel@vortex>
	 <CACLa4pvtTeTq3LdY7vgFexDXXxk8ZYU5yBQRQexTyghkoL7B1w@mail.gmail.com>
	 <1316812338.2487.77.camel@vortex> <1316812634.28696.1.camel@localhost>
	 <1316817499.2487.89.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2011-09-24 at 00:38 +0200, Guido Trentalancia wrote:
> Hello Eric.
> 
> On Fri, 2011-09-23 at 17:17 -0400, Eric Paris wrote:
> > On Fri, 2011-09-23 at 23:12 +0200, Guido Trentalancia wrote:
> > 
> > > You seem to suggest that load_policy -i (and not the kernel) should make
> > > sure that init has transitioned to its designated context...
> > 
> > Can't speak for Justin's system.  
> 
> That's for sure. But it seems to me that he already stated that it just
> loaded plain refpolicy from git on a plain F15 system. Since we are on
> the list he might even confirm once again...
> 
> > But that's not what I said.  I said
> > it's /sbin/init's problem to make sure it did the right thing and to
> > handle errors correctly if it failed.  If Justin has his box enforcing
> > and can boot without loading a policy that's a bug and needs to be
> > filed.
> 
> He has loaded the policy.
> 
> The point is that when init does not transition to init_t nothing
> happens and the system keeps running with all processes in kernel_t or
> insmod_t.
> 
> It surely use to happen with upstream components and policy back at the
> beginning of this year (I did test that and reported it to the refpolicy
> mailing list).
> 
> Apparently it also happens with Fedora 15 according to what Justin
> reported on here when he started this thread...
> 
> Earlier on Daniel Walsh said Fedora and RHEL would crash in such case
> (init has not transitioned properly to init_t).

Ahhh, different than I was talking sorry.  In upstream systemd git the
code in question looks like so:

               /* Transition to the new context */
               r = label_get_create_label_from_exe(SYSTEMD_BINARY_PATH, &label);
               if (r < 0 || label == NULL) {
                       log_open();
                       log_error("Failed to compute init label, ignoring.");
               } else {
                       r = setcon(label);

                       log_open();
                       if (r < 0)
                               log_error("Failed to transition into init label '%s', ignoring.", label);

                       label_free(label);
               }

sds, what do you think, should we make these?  We do know the requisite
enforce state in this function...

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
