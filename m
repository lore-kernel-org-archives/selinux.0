From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [PATCH 0/7] secid reconciliation-v02: Repost patchset with updates
Date: Mon, 18 Sep 2006 17:25:46 -0400
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org,
        sds@tycho.nsa.gov, chanson@TrustedCS.com
References: <45019F50.1090408@trustedcs.com>
In-Reply-To: <45019F50.1090408@trustedcs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609181725.46900.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 September 2006 12:50 pm, Venkat Yekkirala wrote:
> UPCOMING WORK:
>
> The following per the discussion at:
>   http://marc.theaimsgroup.com/?l=selinux&m=115755980516072&w=2
>
> - Create IPSec SAs to be acquired with the creating sock's context as
> opposed to that of the matching SPD rule, resulting in a simpler SPD as
> well as policy. - Set peer_sid on tcp sockets to the reconciled secmark so
> trusted applications can retrieve and service the data at the appropriate
> context.

Considering the discussions that have taken place on the SELinux list I think 
doing the work to set the peer_sid value on TCP sockets is an important part 
of the secid work and should be included in this patchset.  I don't believe 
it would be that difficult, and it would make some of the code much 
cleaner/simpler I think.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
