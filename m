Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7GMruDv003777
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 18:53:56 -0400
Received: from rv-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7GMrtYY025430
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 22:53:55 GMT
Received: by rv-out-0910.google.com with SMTP id k15so290936rvb
        for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 15:53:55 -0700 (PDT)
Message-ID: <7b740b700708161553x549d52ddh22bc3b124e63e687@mail.gmail.com>
Date: Fri, 17 Aug 2007 03:53:54 +0500
From: "shahbaz khan" <shazalive@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: TE for networked resources
Cc: selinux@tycho.nsa.gov, muhammad.alam@uibk.ac.at
In-Reply-To: <1187298501.909.139.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_26648_25323418.1187304834823"
References: <7b740b700708161147q1ce955d4ha64320547ac81663@mail.gmail.com>
	 <1187291188.909.96.camel@moss-spartans.epoch.ncsc.mil>
	 <7b740b700708161401x53a17dd7x628d291f38a6a355@mail.gmail.com>
	 <1187298501.909.139.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_26648_25323418.1187304834823
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/17/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Fri, 2007-08-17 at 02:01 +0500, shahbaz khan wrote:
> > On 8/17/07, Stephen Smalley <sds@tycho.nsa.gov > wrote:
> >         On Thu, 2007-08-16 at 23:47 +0500, shahbaz khan wrote:
> >         > I was curious while reading Brindle et al paper on enhancing
> >         selinux
> >         > policy for network domain that do we really need TE for
> >         these remote
> >         > resources. Can't we just do with IBAC and RBAC? We can let
> >         the local
> >         > subjects handle the TE with their own types with respect to
> >         the IBAC
> >         > and RBAC of remote subject. This might be what they call
> >         equivalence
> >         > mechanism. The problems associated with TE are too tough for
> >         selinux
> >         > and current network controls to handle. The solutions will
> >         cost too
> >         > much.
> >
> >         User identity and role doesn't convey enough information - you
> >         lose the
> >         binding to the actual program/code.  Which matters.  You want
> >         to be able
> >         to allow a given component to interact with another component
> >         specifically, not any arbitrary process running with a given
> >         user
> >         identity or role.
> >
> > I think this arbitration can be solved with iptables' rules. A local
> > to remote port restriction. And further hardened with port labels.
> > Will the label of ports not be enough? At the required points we still
> > have TE.
>
> No, ports aren't adequate for identifying the components.  Think client
> side ports and also think dynamic port assignment (ala portmap).


What about netfilter's connection tracking feature for dynamic port
assignment where labels can be passed to related ports?
We assume that the client is part of the network domain because we also need
to distribute the policy. Thus, the security admin has access to set
iptables and only he is allowed to do so.
Let me check on portmap. But it is'nt an issue as much as I can comprehend
at this time.

Shaz.

> TE definitely gives a security granularity at the program/code level
> > but it is being taken care of by the local system. If the local system
> > ensures it till its boundaries then the remote subject, handling the
> > requests, can contain the security problems with its own context and
> > identity and role of the remote subject.
> >
> > Sacrificing of the code binding at the cost of reasonable reduction in
> > complexity, where code binding is mandatory in the boundaries of
> > computer system but between two systems very little is lost. In the
> > boundaries of the local system a malicious code cannot get executed
> > with the right policy and if it does how can TE help to contain it
> > from the remote system if TE attribute is considered on the remote
> > side? I think identity and role are enough to contain it on the remote
> > side. The tradeoff will only broaden risks for the data of that role
> > and identity because it will not consider its types. Here identity
> > serves as the level of granularity in a specific role.
> >
> > Secondly, with SECMARK and IPSEC associations we do pass on the TE
> > attribute in context. For extra sensitive applications and services,
> > TE can be considered which means we still reduce the penalty of
> > complexity in policy maintenance.
> >
> > Shaz
> >
> >
> >         > Is there any progress on this work. Let me know because I
> >         have also
> >         > working on this and might be able to assist.
> >
> >         --
> >         Stephen Smalley
> >         National Security Agency
> --
> Stephen Smalley
> National Security Agency
>
>

------=_Part_26648_25323418.1187304834823
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>
<div><span class="gmail_quote">On 8/17/07, <b class="gmail_sendername">Stephen Smalley</b> &lt;<a href="mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Fri, 2007-08-17 at 02:01 +0500, shahbaz khan wrote:<br>&gt; On 8/17/07, Stephen Smalley &lt;<a href="mailto:sds@tycho.nsa.gov">
sds@tycho.nsa.gov</a> &gt; wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; On Thu, 2007-08-16 at 23:47 +0500, shahbaz khan wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; I was curious while reading Brindle et al paper on enhancing<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; selinux<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; policy for network domain that do we really need TE for
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; these remote<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; resources. Can&#39;t we just do with IBAC and RBAC? We can let<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the local<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; subjects handle the TE with their own types with respect to<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the IBAC<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; and RBAC of remote subject. This might be what they call<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; equivalence<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; mechanism. The problems associated with TE are too tough for<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; selinux
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; and current network controls to handle. The solutions will<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cost too<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; much.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; User identity and role doesn&#39;t convey enough information - you
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lose the<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; binding to the actual program/code.&nbsp;&nbsp;Which matters.&nbsp;&nbsp;You want<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to be able<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to allow a given component to interact with another component<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; specifically, not any arbitrary process running with a given
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; identity or role.<br>&gt;<br>&gt; I think this arbitration can be solved with iptables&#39; rules. A local<br>&gt; to remote port restriction. And further hardened with port labels.<br>
&gt; Will the label of ports not be enough? At the required points we still<br>&gt; have TE.<br><br>No, ports aren&#39;t adequate for identifying the components.&nbsp;&nbsp;Think client<br>side ports and also think dynamic port assignment (ala portmap).
</blockquote>
<div>&nbsp;</div>
<div>What about netfilter&#39;s connection tracking feature for dynamic port assignment where labels&nbsp;can be&nbsp;passed to related ports?</div>
<div>We assume that the client is part&nbsp;of the network domain because we also need to distribute the policy. Thus, the security admin has access to set iptables and only he is allowed to do so.</div>
<div>Let me check on portmap. But it&nbsp;is&#39;nt&nbsp;an issue as much as I can comprehend at this time.</div>
<div>&nbsp;</div>
<div>Shaz.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; TE definitely gives a security granularity at the program/code level<br>&gt; but it is being taken care of by the local system. If the local system
<br>&gt; ensures it till its boundaries then the remote subject, handling the<br>&gt; requests, can contain the security problems with its own context and<br>&gt; identity and role of the remote subject.<br>&gt;<br>&gt; Sacrificing of the code binding at the cost of reasonable reduction in
<br>&gt; complexity, where code binding is mandatory in the boundaries of<br>&gt; computer system but between two systems very little is lost. In the<br>&gt; boundaries of the local system a malicious code cannot get executed
<br>&gt; with the right policy and if it does how can TE help to contain it<br>&gt; from the remote system if TE attribute is considered on the remote<br>&gt; side? I think identity and role are enough to contain it on the remote
<br>&gt; side. The tradeoff will only broaden risks for the data of that role<br>&gt; and identity because it will not consider its types. Here identity<br>&gt; serves as the level of granularity in a specific role.<br>&gt;
<br>&gt; Secondly, with SECMARK and IPSEC associations we do pass on the TE<br>&gt; attribute in context. For extra sensitive applications and services,<br>&gt; TE can be considered which means we still reduce the penalty of
<br>&gt; complexity in policy maintenance.<br>&gt;<br>&gt; Shaz<br>&gt;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Is there any progress on this work. Let me know because I<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; have also<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; working on this and might be able to assist.
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Stephen Smalley<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; National Security Agency<br>--<br>Stephen Smalley<br>National Security Agency<br><br></blockquote></div>

------=_Part_26648_25323418.1187304834823--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
