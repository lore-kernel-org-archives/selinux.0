Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7GL1ZuU029545
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 17:01:35 -0400
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7GL1XMx016312
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 21:01:33 GMT
Received: by rv-out-0910.google.com with SMTP id k15so271872rvb
        for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 14:01:32 -0700 (PDT)
Message-ID: <7b740b700708161401x53a17dd7x628d291f38a6a355@mail.gmail.com>
Date: Fri, 17 Aug 2007 02:01:32 +0500
From: "shahbaz khan" <shazalive@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: TE for networked resources
Cc: selinux@tycho.nsa.gov, muhammad.alam@uibk.ac.at
In-Reply-To: <1187291188.909.96.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_26340_14336867.1187298092490"
References: <7b740b700708161147q1ce955d4ha64320547ac81663@mail.gmail.com>
	 <1187291188.909.96.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_26340_14336867.1187298092490
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/17/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2007-08-16 at 23:47 +0500, shahbaz khan wrote:
> > I was curious while reading Brindle et al paper on enhancing selinux
> > policy for network domain that do we really need TE for these remote
> > resources. Can't we just do with IBAC and RBAC? We can let the local
> > subjects handle the TE with their own types with respect to the IBAC
> > and RBAC of remote subject. This might be what they call equivalence
> > mechanism. The problems associated with TE are too tough for selinux
> > and current network controls to handle. The solutions will cost too
> > much.
>
> User identity and role doesn't convey enough information - you lose the
> binding to the actual program/code.  Which matters.  You want to be able
> to allow a given component to interact with another component
> specifically, not any arbitrary process running with a given user
> identity or role.


I think this arbitration can be solved with iptables' rules. A local to
remote port restriction. And further hardened with port labels. Will the
label of ports not be enough? At the required points we still have TE.

TE definitely gives a security granularity at the program/code level but it
is being taken care of by the local system. If the local system ensures it
till its boundaries then the remote subject, handling the requests, can
contain the security problems with its own context and identity and role of
the remote subject.

Sacrificing of the code binding at the cost of reasonable reduction in
complexity, where code binding is mandatory in the boundaries of computer
system but between two systems very little is lost. In the boundaries of the
local system a malicious code cannot get executed with the right policy and
if it does how can TE help to contain it from the remote system if TE
attribute is considered on the remote side? I think identity and role are
enough to contain it on the remote side. The tradeoff will only broaden
risks for the data of that role and identity because it will not consider
its types. Here identity serves as the level of granularity in a specific
role.

Secondly, with SECMARK and IPSEC associations we do pass on the TE attribute
in context. For extra sensitive applications and services, TE can be
considered which means we still reduce the penalty of complexity in policy
maintenance.
Shaz



> > Is there any progress on this work. Let me know because I have also
> > working on this and might be able to assist.
>
> --
> Stephen Smalley
> National Security Agency
>

------=_Part_26340_14336867.1187298092490
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><span class="gmail_quote">On 8/17/07, <b class="gmail_sendername">Stephen Smalley</b> &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:sds@tycho.nsa.gov" target="_blank">sds@tycho.nsa.gov</a>
&gt; wrote:</span> </div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Thu, 2007-08-16 at 23:47 +0500, shahbaz khan wrote:<br>&gt; I was curious while reading Brindle et al paper on enhancing selinux 
<br>&gt; policy for network domain that do we really need TE for these remote<br>&gt; resources. Can&#39;t we just do with IBAC and RBAC? We can let the local<br>&gt; subjects handle the TE with their own types with respect to the IBAC 
<br>&gt; and RBAC of remote subject. This might be what they call equivalence<br>&gt; mechanism. The problems associated with TE are too tough for selinux<br>&gt; and current network controls to handle. The solutions will cost too 
<br>&gt; much.<br><br>User identity and role doesn&#39;t convey enough information - you lose the<br>binding to the actual program/code.&nbsp;&nbsp;Which matters.&nbsp;&nbsp;You want to be able<br>to allow a given component to interact with another component 
<br>specifically, not any arbitrary process running with a given user<br>identity or role.</blockquote>
<div>&nbsp;</div>
<div>I think this arbitration can be solved with iptables&#39; rules. A&nbsp;local to remote port restriction.&nbsp;And further hardened with port labels. Will the label of ports not be enough? At the required points we still have TE.
</div>
<p>TE definitely gives a security granularity at the program/code level but it is being taken care of by the local system. If the local system ensures it till its boundaries then the remote subject, handling the requests, can contain the security problems with its own context and identity and role of the remote subject.
</p>
<p>Sacrificing of the code binding at the cost of reasonable reduction in complexity, where code binding is mandatory in the boundaries of computer system but between two systems&nbsp;very little is lost. In the boundaries of the local system a malicious code cannot get executed with the right policy and if it does how can TE help to contain it from the remote system if TE attribute is considered on the remote side? I think identity and role are enough to contain it on the remote side. The tradeoff will only broaden risks for the data of that role and identity because it will not consider its types. Here identity serves as the level of granularity in a specific role.
</p>
<p>Secondly, with SECMARK and IPSEC associations we do pass on the TE attribute in context. For extra sensitive applications and services, TE can be considered which means we still reduce the penalty of complexity in policy maintenance.
</p>
<div>Shaz</div>
<div><br>&nbsp;</div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; Is there any progress on this work. Let me know because I have also<br>&gt; working on this and might be able to assist. 
<br><br>--<br>Stephen Smalley<br>National Security Agency<br></blockquote>

------=_Part_26340_14336867.1187298092490--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
