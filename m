Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB8FA7fn006581
 for <selinux@tycho.nsa.gov>; Tue, 8 Dec 2015 10:10:13 -0500
Received: by wmec201 with SMTP id c201so216689138wme.0
 for <selinux@tycho.nsa.gov>; Tue, 08 Dec 2015 07:10:08 -0800 (PST)
Date: Tue, 8 Dec 2015 16:10:06 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Michal Marciniszyn <michal.marciniszyn@gooddata.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Performance issues - huge amount of AVC misses
Message-ID: <20151208151005.GB32680@x250>
References: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
 <20151208104442.GA32680@x250>
 <CAL8PO=3Dy-SFzE_DMA=99YcuK5+LXybUwAJgTBY1QZaODEM5Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <CAL8PO=3Dy-SFzE_DMA=99YcuK5+LXybUwAJgTBY1QZaODEM5Ew@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Tue, Dec 08, 2015 at 03:56:38PM +0100, Michal Marciniszyn wrote:
> Hi Dominic,
> 
> while there is quite a lot of dontaudit rules around, the amount for
> domains running on this node is not high. Is there any way how to monitor
> which rules are loaded and released from the cache? Anything better than
> plain aggregated stats? We would bot care about performance of such
> monitoring tool if it provides some useful answer. For instance, is there a
> way how to use system tap or similar kernel profiling to get the data?
> 
> I'll do a profiling on how many rules actually apply for the domains on the
> node (i.e. use sesearch to find out). If doing so, does the rule in cache
> hold whole vector (i.e. A is allowed to do X, Y, Z on B or is one cache
> entry A can do X on B)?

Hi,

I will let other people comment on these technical issues since i do
not feel that i am qualified to do so.

Let me instead suggest a different approach to the dontaudit challenge.

You might consider dontauditting on a different level using the base
attributes. This will allow you to catch everything with very little
rules.

So in a development phase you start by just ignoring things you want to
dontaudit in production. Then once you feel that your policy is ready
for production you add a few dontaudit rules that catch everything.

for example common access to files:

dontaudit domain file_type:file { manage_file_perms relabel_file_perms
};

any bind access to port objects:

dontaudit domain port_type:{ tcp_socket udp_socket dccp_socket }
name_bind;

etc etc

The point is that you use high level type attributes to catch
remaining attempts. It is not a perfect solution and it has its
drawbacks but atleast you will not have 300k dontaudit rules.

> 
> Thanks,
> 
> --michal
> 
> On Tue, Dec 8, 2015 at 11:44 AM, Dominick Grift <dac.override@gmail.com>
> wrote:
> 
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA512
> >
> > On Tue, Dec 08, 2015 at 11:25:40AM +0100, Michal Marciniszyn wrote:
> > > Hello,
> > >
> > > we are heavy SELinux shop and we recently run into AVC related
> > performance
> > > issue. I was trying to find an answer on freenode IRC chat but I was sent
> > > here by multiple guys. We're running on Scientific Linux 6.6 (upgrade to
> > > 6.7 ongoing) and we see this on some of our nodes:
> > >
> > > # cat /selinux/avc/cache_stats
> > > lookups hits misses allocations reclaims frees
> > > 3976846641 3626568307 350278334 350303465 344833264 346344169
> > > 3474274460 3092218096 382056364 382081270 381170512 382671551
> > > 2037181411 1655679702 381501709 381527148 380680320 382162477
> > > 1943162363 1651603455 291558908 291584892 288099840 289631602
> > > 829213467 406079951 423133516 423158604 422311024 423847681
> > > 1963015875 1555848944 407166931 407192104 406718592 408227742
> > > 3490131033 3117047653 373083380 373108386 372270880 373862706
> > > 940880689 549698684 391182005 391207388 390339328 391888374
> > > 4098417807 3712068859 386348948 386373592 385604096 387172806
> > > 3931378773 3549502965 381875808 381901074 381059904 382628308
> > >
> > > Also we see
> > >
> > > # cat /selinux/avc/hash_stats
> > > entries: 499
> > > buckets used: 257/512
> > > longest chain: 6
> > >
> > > Some times under load we see SELinux consuming about 30% of CPU time.
> > There
> > > is about 16% of cache misses on these nodes (and sometimes it goes as
> > high
> > > as 30%). The lates article about the issue is from RHEL 5 times -
> > >
> > https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/SELinux_Guide/rhlcommon-section-0102.html
> > > . We do not feel this to be too relevant in this case.
> > >
> > > Are there any recommendations on cache sizing for SELinux? We can resize
> > > cache to 1024 or 2048 entries, but would this help to resolve the issue?
> > >
> > > I'm attaching seinfo from node with our policy and then for comparison
> > from
> > > node without any policy.
> > >
> > > With policy:
> > > # seinfo
> > >
> > > Statistics for policy file: /etc/selinux/targeted/policy/policy.24
> > > Policy Version & Type: v.24 (binary, mls)
> > >
> > >    Classes:            81    Permissions:       238
> > >    Sensitivities:       1    Categories:       1024
> > >    Types:            4273    Attributes:        295
> > >    Users:               9    Roles:              12
> > >    Booleans:          234    Cond. Expr.:       274
> > >    Allow:          352554    Neverallow:          0
> > >    Auditallow:        140    Dontaudit:      321786
> > >    Type_trans:      42813    Type_change:        38
> > >    Type_member:        48    Role allow:         19
> > >    Role_trans:        409    Range_trans:      6421
> > >    Constraints:        90    Validatetrans:       0
> > >    Initial SIDs:       27    Fs_use:             23
> > >    Genfscon:           84    Portcon:           505
> > >    Netifcon:            0    Nodecon:             0
> > >    Permissives:        91    Polcap:              2
> >
> > I don't have any useful input but just an unrelated observation: you
> > almost have as many dontaudit rules as you have allow rules. I would not
> > be surprised if that were to be somehow related.
> >
> > >
> > >
> > >
> > > Without policy:
> > >
> > > seinfo
> > >
> > > Statistics for policy file: /etc/selinux/targeted/policy/policy.24
> > > Policy Version & Type: v.24 (binary, mls)
> > >
> > >    Classes:            81    Permissions:       238
> > >    Sensitivities:       1    Categories:       1024
> > >    Types:            3926    Attributes:        295
> > >    Users:               9    Roles:              12
> > >    Booleans:          234    Cond. Expr.:       274
> > >    Allow:          320969    Neverallow:          0
> > >    Auditallow:        140    Dontaudit:      273256
> > >    Type_trans:      41915    Type_change:        38
> > >    Type_member:        48    Role allow:         19
> > >    Role_trans:        386    Range_trans:      6069
> > >    Constraints:        90    Validatetrans:       0
> > >    Initial SIDs:       27    Fs_use:             23
> > >    Genfscon:           84    Portcon:           479
> > >    Netifcon:            0    Nodecon:             0
> > >    Permissives:        91    Polcap:              2
> > >
> > >
> > > Any help or guidance would be very much appreciated, if there is more
> > > in-depth info needed I'll be more than happy to provide it.
> > >
> > > Yours sincerely,
> > >
> > > Michal Marciniszyn
> > > Manager - SW Engineering
> > > GoodData
> >
> > > _______________________________________________
> > > Selinux mailing list
> > > Selinux@tycho.nsa.gov
> > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > To get help, send an email containing "help" to
> > Selinux-request@tycho.nsa.gov.
> >
> >
> > - --
> > 02DFF788
> > 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> > https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
> > Dominick Grift
> > -----BEGIN PGP SIGNATURE-----
> > Version: GnuPG v2
> >
> > iQGcBAEBCgAGBQJWZrSWAAoJENAR6kfG5xmctzkMALax9f+yHvM9hiH/RFgf4JMH
> > 2avyWCkJggce+DilkHLGuhAZe0yMJW/h4WryF/a93y52q/09l/vYpa4oEShhrasD
> > dsOmCOINVW77E6TyWMuv80hYywPoXft+h3XIIgLO9FrURCJoCNlY7WGEpuVIy9PF
> > fxk6dxSov4yxxVGnEFW43X8SZ9haypuTiq3DkfvCVTbfeEs1xYu5j2vQ2Ghi0BN0
> > N9JdiLiPBBjAZo4O6VFkfgJ3Jt+EfyYuImcL3EhKmOc7c+vTtggc3VEamaSRXnhY
> > oXYUnKEqDraaJ7kizgODntPw79YRVpVqpaRipArZq96Qjq9loH/3RsG9DEyRTBgR
> > f3VH63L0URGeA7O/qWQmjiHro8ZgZvmKdfnRWtnwtUCfHmaGU8r8rDgWHReC42HD
> > FeRn+ymouSp0JDfq9wg3Nbk8R5z/FF4qIk4NpUNIm4KWRREbYQnkTjhMwN3hepg4
> > ikMHBdfUP/coPw1kPJtCwYNtwcv+z1D1XbRBiU/icQ==
> > =41nB
> > -----END PGP SIGNATURE-----
> >

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWZvLHAAoJENAR6kfG5xmcGxEMAIWpCUl/BWQFTYMgPG5t85bB
NHMaIAKdRPw0IdxWOEzSRWHS4bmOgx0c6ChMlAxBAIAm0ncOpOoZgY5JO6PlOYp4
cvcXUC88b+QVa/BfReemZCb5jeFelW8o0aZYkQVl3IaMvXJLgXVE/O9xwJH5n459
TZGGD08GEVRykM8qn9fgcKlp02RGtZcFCqjgXPeZum291k8cdo7e+ejwTRmssQfs
tPtL3MsGWsIxaQq+G4u0OJVJmASNV0zjje8jLWFxUoV33vbwPCrLPqCsoAtVAPkJ
2Vjd+U1dw8ncL1R8dXWt3Y0finXBnI7n7QCiHCg3UIBoRPSZhAQ4DevNWbrYvZjl
RYRf+fAOIWHmgzxlQJAqKnPu0rc6QQgk/0XhvjpQb/jPbSpF2UEWD1aKrYmoNmkJ
ij2g7/UMm6RLNnncKXL2ff6Zatl8z7ObDl0+mrCG2cgDBwLGRapzVtVBQCMlbXa8
JKR31LXE1CgRRfhDhG19mY/KHh3GTAV7SLF/4dHrWQ==
=p9u8
-----END PGP SIGNATURE-----
