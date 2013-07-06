Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r66CfcFM024398
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2013 08:41:38 -0400
Received: by mail-qc0-f174.google.com with SMTP id m15so1598978qcq.19
        for <selinux@tycho.nsa.gov>; Sat, 06 Jul 2013 05:41:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130706063952.GA29221@siphos.be>
References: <20130705183902.GA26996@siphos.be>
	<2894544.bL1dEvHUlK@sifl>
	<20130706063952.GA29221@siphos.be>
Date: Sat, 6 Jul 2013 14:41:21 +0200
Message-ID: <CAPzO=NxsvuEjfd8G4MVzRu=s=N39JifP-Kr-zowvKxq4Tt+Sqw@mail.gmail.com>
Subject: Re: Labeled IPSec trying to match policy for peer label?
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Paul Moore <paul@paul-moore.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jul 06, 2013 at 08:39:52AM +0200, Sven Vermeulen wrote:
> On Fri, Jul 05, 2013 at 04:50:41PM -0400, Paul Moore wrote:
> > > spdadd 10.1.2.0/24 10.1.3.0/24 any -ctx 1 1
> > >   "system_u:object_r:ipsec_spd_t:s0" -P out ipsec
> > >   esp/tunnel/192.168.100.152-192.168.100.153/require;
> > >
> > > spdadd 10.1.3.0/24 10.1.2.0/24 any -ctx 1 1
> > >   "system_u:object_r:ipsec_spd_t:s0" -P in ipsec
> > >   esp/tunnel/192.168.100.153-192.168.100.152/require;
> [...]
> > Is the server side running the same SELinux policy as the client?  Does the
> > server have a SPD entry that is labeled, e.g. '-ctx 1 1
> > "system_u:object_r:ipsec_spd_t:s0"'?
>
> Yes, both sides have the same setkey instructions (only the in/out is
> switched) and are running the same SELinux policy & type. The racoon
> configurations are also the same (of course each one with the right
> addresses in the remote { ... } and sainfo { ... } definitions.

I tried with ipsec-tools 0.8.1 but no difference; I started racoon with
debugging on to see what I could have done wrong. Here is my analysis and
output:

At a certain point in time, isakmp_quick.c's get_proposal_r() method is
called, where the policy is eventually queried for:

#v+
/* get inboud policy */
sp_in = getsp_r(&spidx);
if (sp_in == NULL) {
  ...
  plog(LLV_ERROR, LOCATION, NULL, "no policy found: %s\n", spidx2str(&spidx));
}
#v-

The error I get at the end (no policy found) is triggered when getsp_r
doesn't return any policy. I enabled generate_policy in racoon just to make
sure it is here in the code that getsp_r returns no matches (as racoon then
tries to generate code and I see additional logging events).

So I take a look at the getsp_r() code, which traverses the &sptree list and
does two checks:

#v+
for (p = TAILQ_FIRST(&sptree); p; p = TAILQ_NEXT(p, chain)) {
        if (!cmpspidxstrict(spidx, &p->spidx))
                return p;

        if (!found && !cmpspidxwild(spidx, &p->spidx))
                found = p;
}
#v-

So the spidx one is the information from the packet, while &p->spidx is the
one from the database, right?

The cmpspidxstrict() method checks if the entries match (dir,
prefs, prefd, ul_proto) and if the socket addresses (?) match.

The cmpspidxwild() method checks similar stuff on the dir(ection), protocol,
family, and then it checks the differences on the socket level.

Now, considering the following output:

#v+
Jul  6 13:24:06 test racoon: DEBUG: sub:0x3f88b6e2c58: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=in
sec_ctx:doi=1,alg=1,len=36,str=root:sysadm_r:ping_t:s0-s0:c0.c1023
Jul  6 13:24:06 test racoon: DEBUG: db :0x7e2229aca0: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=fwd
sec_ctx:doi=1,alg=1,len=45,str=system_u:object_r:ipsec_spd_t:s0-s0:c0.c1023

Jul  6 13:24:06 test racoon: DEBUG: sub:0x3f88b6e2c58: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=in
sec_ctx:doi=1,alg=1,len=36,str=root:sysadm_r:ping_t:s0-s0:c0.c1023
Jul  6 13:24:06 test racoon: DEBUG: db: 0x7e2229aca0: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=fwd
sec_ctx:doi=1,alg=1,len=45,str=system_u:object_r:ipsec_spd_t:s0-s0:c0.c1023
#v-

No match; I get the entries twice (once for cmpspidxstrict() and one for
cmpspidxwild()).

#v+
Jul  6 13:24:06 test racoon: DEBUG: sub:0x3f88b6e2c58: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=in
sec_ctx:doi=1,alg=1,len=36,str=root:sysadm_r:ping_t:s0-s0:c0.c1023
Jul  6 13:24:06 test racoon: DEBUG: db :0x7e2229af60: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=in
sec_ctx:doi=1,alg=1,len=45,str=system_u:object_r:ipsec_spd_t:s0-s0:c0.c1023
Jul  6 13:24:06 test racoon: DEBUG: sub:0x3f88b6e2c58: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=in
sec_ctx:doi=1,alg=1,len=36,str=root:sysadm_r:ping_t:s0-s0:c0.c1023
Jul  6 13:24:06 test racoon: DEBUG: db: 0x7e2229af60: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=in
sec_ctx:doi=1,alg=1,len=45,str=system_u:object_r:ipsec_spd_t:s0-s0:c0.c1023
Jul  6 13:24:06 test racoon: DEBUG: 0x3f88b6e2c58 masked with /24: 10.1.3.0[0]
Jul  6 13:24:06 test racoon: DEBUG: 0x7e2229af60 masked with /24: 10.1.3.0[0]
Jul  6 13:24:06 test racoon: DEBUG: 0x3f88b6e2c58 masked with /24: 10.1.2.0[0]
Jul  6 13:24:06 test racoon: DEBUG: 0x7e2229af60 masked with /24: 10.1.2.0[0]
#v-

Here, I get the same entries again, but now with the "masked" stuff as well.
These masked stuff entries come from cmspidxwild(), so the earlier checks
all match (which we can see from the output).

Also, because I see two sets of "masked with" events, the first check
succeeds:

#v+
        mask_sockaddr((struct sockaddr *)&sa1, (struct sockaddr *)&a->src,
                b->prefs);
        mask_sockaddr((struct sockaddr *)&sa2, (struct sockaddr *)&b->src,
                b->prefs);
        plog(LLV_DEBUG, LOCATION, NULL, "%p masked with /%d: %s\n",
                a, b->prefs, saddr2str((struct sockaddr *)&sa1));
        plog(LLV_DEBUG, LOCATION, NULL, "%p masked with /%d: %s\n",
                b, b->prefs, saddr2str((struct sockaddr *)&sa2));
        if (cmpsaddr((struct sockaddr *)&sa1, (struct sockaddr *)&sa2)
> CMPSADDR_WILDPORT_MATCH)
                return 1;
#v-

But the second check seems to fail, because after the second check I would
expect information on the range checking:

#v+
        mask_sockaddr((struct sockaddr *)&sa1, (struct sockaddr *)&a->dst,
                b->prefd);
        mask_sockaddr((struct sockaddr *)&sa2, (struct sockaddr *)&b->dst,
                b->prefd);
        plog(LLV_DEBUG, LOCATION, NULL, "%p masked with /%d: %s\n",
                a, b->prefd, saddr2str((struct sockaddr *)&sa1));
        plog(LLV_DEBUG, LOCATION, NULL, "%p masked with /%d: %s\n",
                b, b->prefd, saddr2str((struct sockaddr *)&sa2));
        if (cmpsaddr((struct sockaddr *)&sa1, (struct sockaddr *)&sa2)
> CMPSADDR_WILDPORT_MATCH)
                return 1;
#v-

What is it trying to do here? Why are the checks on b->prefd in both
cases (and not on a->prefd first and then b->prefd)?

When I don't add the contexts, I don't even get to this location. It
nicely matches (I think the match then is in cmpspidxstrict()),
doesn't show the "masked with" information.

#v+
Jul  6 14:32:01 test racoon: DEBUG: sub:0x3a74d3e2418: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=in
Jul  6 14:32:01 test racoon: DEBUG: db :0x7fde6a2f30: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=fwd
Jul  6 14:32:01 test racoon: DEBUG: sub:0x3a74d3e2418: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=in
Jul  6 14:32:01 test racoon: DEBUG: db: 0x7fde6a2f30: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=fwd
Jul  6 14:32:01 test racoon: DEBUG: sub:0x3a74d3e2418: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=in
Jul  6 14:32:01 test racoon: DEBUG: db :0x7fde6a31f0: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=in
#v-

Here it has found a match, because the next check uses an outgoing "sub":

#v+
Jul  6 14:32:01 test racoon: DEBUG: sub:0x3a74d3e2418: 10.1.2.0/24[0]
10.1.3.0/24[0] proto=any dir=out
Jul  6 14:32:01 test racoon: DEBUG: db :0x7fde6a2f30: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=fwd
Jul  6 14:32:01 test racoon: DEBUG: sub:0x3a74d3e2418: 10.1.2.0/24[0]
10.1.3.0/24[0] proto=any dir=out
Jul  6 14:32:01 test racoon: DEBUG: db: 0x7fde6a2f30: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=fwd
Jul  6 14:32:01 test racoon: DEBUG: sub:0x3a74d3e2418: 10.1.2.0/24[0]
10.1.3.0/24[0] proto=any dir=out
Jul  6 14:32:01 test racoon: DEBUG: db :0x7fde6a31f0: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=in
Jul  6 14:32:01 test racoon: DEBUG: sub:0x3a74d3e2418: 10.1.2.0/24[0]
10.1.3.0/24[0] proto=any dir=out
Jul  6 14:32:01 test racoon: DEBUG: db: 0x7fde6a31f0: 10.1.3.0/24[0]
10.1.2.0/24[0] proto=any dir=in
Jul  6 14:32:01 test racoon: DEBUG: sub:0x3a74d3e2418: 10.1.2.0/24[0]
10.1.3.0/24[0] proto=any dir=out
Jul  6 14:32:01 test racoon: DEBUG: db :0x7fde6a35f0: 10.1.2.0/24[0]
10.1.3.0/24[0] proto=any dir=out
Jul  6 14:32:01 test racoon: DEBUG: suitable SP found:10.1.2.0/24[0]
10.1.3.0/24[0] proto=any dir=out
#v-

Wkr,
Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
