Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA20839
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 15:50:07 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA08376
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 20:49:59 GMT
Received: from juno.methaz.com ([63.81.125.129])
	by jazzband.ncsc.mil  with ESMTP id UAA08372
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 20:49:58 GMT
Message-ID: <3A9AC14F.19FAEC1A@methaz.com>
Date: Mon, 26 Feb 2001 15:49:19 -0500
From: Chuck Watson <cwatson@juno.methaz.com>
MIME-Version: 1.0
To: Jose Nazario <jose@biocserver.bioc.cwru.edu>,
        Mark Lucas <mlucas@imagelinks.com>
CC: selinux@tycho.nsa.gov
Subject: Clusters and SELinux (was Re: New to list)
References: <Pine.LNX.4.30.0102261405460.27706-100000@biocserver.BIOC.CWRU.Edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Hello everyone -
  We are currently experimenting with SELinux on our backup cluster console, as
well as playing with various job control and submission methods.  We have two 32
processor Beowulfs running meteorological hazard models (some stuff is on-line at
http://www.methaz.com/wxdata/tracking; there is a small storm that just made
landfall in northern Australia).   We want to restrict access to some kinds of
model runs and output data for a variety of reasons, such as, for instance,
confidential insurance data.  Currently sensitive work is on the "off network"
cluster, and the physically connected only long enough to transmit data to the
transfer site.

  I agree with Jose that the place for security is at the cluster console, job
summission machine, or perimeter.  Our compute nodes are as clean as we can
possibly make them for performance reasons, and are on their own subnet off of
the console anyway, as with most clusters.   I'm not sure what the performance
hit would be using SELinux on the compute nodes, but in most fluid dynamic models
every clock cycle counts.  On our net, the only machine available to the even the
inside world is the console, which would be the point of external attack unless
someone physically breaks in (and the compute nodes are headless, so unless they
cart the whole thing off in a truck, again the console is the place to worry).

Chuck

Jose Nazario wrote:

> On Mon, 26 Feb 2001, Mark Lucas wrote:
>
> > Just signed up on the list.  We are building BeoWulf clusters as
> > geospatial rendering engines and are working with several government
> > agencies in the process.  I'm hoping that we can apply the excellent
> > work of this group towards improving our system and satisfying the
> > various security concerns as our systems begin to integrate with
> > various secure networks.
>
> hi mark
>
> i've built a beowulf, i do a lot of high performance computing in my line
> of work. and honestly, aside from the perimeter, i can't see any advantage
> to using SELinux or any similar facility for clustered computing.
>
> file access can be guarded using standard UNIX DACLs to a sufficient
> level. if you're not finding this to be true, i would imagine you're not
> toying with them enough.
>
> rarely do users need to access system portions in their calculations or
> computing that cannot be handled within the kernel using normal Beowulf
> structures (ie shared memory).
>
> as for the gateway, again, some tight normal UNIX DACLs and good firewall
> rules and you should be set. we never had a problem with users requiring
> system access to get to usable portions of the cluster.
>
> i'm also a bit familiar (though not as much as many on this list, to be
> sure) with SELinux and what i tdoes, too. i love it, but i just don't see
> it being applicable in a situation like this.
>
> however, maybe i'm looking at this in way too limited a view. i'd be happy
> to hear how you want to apply it.
>
> ____________________________
> jose nazario                                                 jose@cwru.edu
>                      PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
>                                        PGP key ID 0xFD37F4E5 (pgp.mit.edu)
>
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
Chuck Watson
Watson Technical Consulting
cwatson@methaz.com
http://www.methaz.com/
(912) 663-1254

   The purpose of computing is insight, not numbers.
          -- Hamming




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
