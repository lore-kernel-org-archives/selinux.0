From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an interface)
Date: Wed, 6 Jun 2007 17:34:38 -0400
Cc: vyekkirala@TrustedCS.com, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Joe Nall <joe@nall.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>, ewalsh@tycho.nsa.gov
References: <000701c7a868$fbdc6a60$cc0a010a@tcssec.com> <200706061648.37402.paul.moore@hp.com> <466724DE.4010302@manicmethod.com>
In-Reply-To: <466724DE.4010302@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706061734.38293.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, June 6 2007 5:19:26 pm Joshua Brindle wrote:
> Paul Moore wrote:
> > On Wednesday, June 6 2007 4:31:51 pm Joshua Brindle wrote:
> >> Is this info going to be stored in the policy ala ocontexts? How are you
> >> planning to manage it? Adding it to libsemanage and semanage seems like
> >> the best route to take here.
> >
> > As I envision it right now this new static external label would be
> > managed via NetLabel (it is a framework after all, not just CIPSO) so we
> > wouldn't need to introduce any more per-packet access checks, similar to
> > how
> > iptables/netfilter manages the SECMARK labels.  The impact to the SELinux
> > kernel code should be quite minimal using this approach.
> >
> > Policy integration is still open in my mind, although considering the
> > lessons learned from integrating the SECMARK iptables commands into
> > policy I wonder if we are best off leaving the labeling details out of
> > the policy itself and leaving it in the hands of the NetLabel tools and
> > perhaps libsemanage.
>
> I'm fine with that, I didn't even think about the netlabel tools
> handling it (possibly because I never used them ;) )

Josh, I'm both shocked and hurt! ;)

> The unfortunate part is that we are going to have all these systems for
> managing different kinds of external labels, it would be nice if there
> was a centralized management system, even if the backends are spread all
> over the place.

Yes, I agree, this was another reason why I thought using the NetLabel 
framework was the best choice for this - no new tools/userspace.

> I don't mean a GUI here either (not that a GUI would be 
> bad) but more along the lines of a central management library that can
> handle it all that a GUI could later use. I'm not sure if libsemanage is
> the place for this either, particularly with ipsec where management
> really means updating SPD entries to have contexts, I don't know how
> people currently manage SPD entries so I'm not sure where we can
> interject ourselves without disturbing users..

I agree that consolidation is a good goal to have, I'm just not sure we are 
going to solve that right now.  In the meantime I think the best approach is 
to keep going like we have been with encapsulating most/all of the required 
functionality into libraries which can be utilized by other tools.  There are 
a few people out there who are starting to write some nice SELinux management 
tools and I suspect as we continue to expand the feature set of the network 
access controls in SELinux to meet user requests there will be more incentive 
for the tool developers to incorporate the right "knobs" in their tools.

FYI, the netlabel_tools package consists of libnetlabel, a library which 
implements all of the important NetLabel configuration/management 
functionality.  The CLI application, netlabelctl, is very small and serves 
only as an interface into this library.

http://netlabel.svn.sf.net/viewvc/netlabel/netlabel_tools/head/libnetlabel/ 
http://netlabel.svn.sf.net/viewvc/netlabel/netlabel_tools/head/include/libnetlabel.h?view=markup

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
