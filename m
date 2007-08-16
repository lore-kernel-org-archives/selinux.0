Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7GLNVEE031362
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 17:23:31 -0400
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7GLNUMx019912
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 21:23:30 GMT
Received: by rv-out-0910.google.com with SMTP id k15so275569rvb
        for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 14:23:29 -0700 (PDT)
Message-ID: <7b740b700708161423t561192btf7885acd24678137@mail.gmail.com>
Date: Fri, 17 Aug 2007 02:23:29 +0500
From: "shahbaz khan" <shazalive@gmail.com>
To: "Joshua Brindle" <method@manicmethod.com>
Subject: Re: TE for networked resources
Cc: selinux@tycho.nsa.gov, "Masoom Alam" <muhammad.alam@uibk.ac.at>
In-Reply-To: <46C4B276.3000009@manicmethod.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_26420_22668652.1187299409289"
References: <7b740b700708161147q1ce955d4ha64320547ac81663@mail.gmail.com>
	 <46C4B276.3000009@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_26420_22668652.1187299409289
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/17/07, Joshua Brindle <method@manicmethod.com> wrote:
>
> shahbaz khan wrote:
> > I was curious while reading Brindle et al paper on enhancing selinux
> > policy for network domain that do we really need TE for these remote
> > resources. Can't we just do with IBAC and RBAC? We can let the local
> > subjects handle the TE with their own types with respect to the IBAC
> > and RBAC of remote subject. This might be what they call equivalence
> > mechanism. The problems associated with TE are too tough for
> > selinux and current network controls to handle. The solutions will
> > cost too much.
> >
> Like Steve said, we want to be able to bind executable code to domains
> most of the time. However, the scheme we proposed leaves the translation
> layer vague intentionally. There is nothing that prevents you from
> making a translation server that only uses IBAC and RBAC.  One potential
> use of this is interacting with non-TE security systems.


What if we centralize the user and roles and propagate them through Policy
Server? This is a vaguely structured question but you will understand the
possibilities. I can see an ease of management and analysis here. Consider a
centralize policy at the same place for atleast the shared resources.

> Is there any progress on this work. Let me know because I have also
> > working on this and might be able to assist.
>
> Not as of late. We have the iptools patches in svn but other than that
> nothing much has happened.
>
>


-- 
Shaz
Research Associate,
IMSciences, Peshawar,
Pakistan.
Email: shazalive@gmail.com
cell: +92 91 0300 5944647

------=_Part_26420_22668652.1187299409289
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>
<div><span class="gmail_quote">On 8/17/07, <b class="gmail_sendername">Joshua Brindle</b> &lt;<a href="mailto:method@manicmethod.com">method@manicmethod.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">shahbaz khan wrote:<br>&gt; I was curious while reading Brindle et al paper on enhancing selinux<br>&gt; policy for network domain that do we really need TE for these remote
<br>&gt; resources. Can&#39;t we just do with IBAC and RBAC? We can let the local<br>&gt; subjects handle the TE with their own types with respect to the IBAC<br>&gt; and RBAC of remote subject. This might be what they call equivalence
<br>&gt; mechanism. The problems associated with TE are too tough for<br>&gt; selinux and current network controls to handle. The solutions will<br>&gt; cost too much.<br>&gt;<br>Like Steve said, we want to be able to bind executable code to domains
<br>most of the time. However, the scheme we proposed leaves the translation<br>layer vague intentionally. There is nothing that prevents you from<br>making a translation server that only uses IBAC and RBAC.&nbsp;&nbsp;One potential
<br>use of this is interacting with non-TE security systems.</blockquote>
<div>&nbsp;</div>
<div>What if we centralize the user and roles and propagate them through Policy Server? This is a vaguely structured question but you will understand the possibilities. I can see an ease&nbsp;of management and analysis here. Consider a centralize policy at the same place for atleast the shared resources.
</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; Is there any progress on this work. Let me know because I have also<br>&gt; working on this and might be able to assist.
<br><br>Not as of late. We have the iptools patches in svn but other than that<br>nothing much has happened.<br><br></blockquote></div><br><br clear="all"><br>-- <br>Shaz<br>Research Associate,<br>IMSciences, Peshawar,<br>
Pakistan.<br>Email: <a href="mailto:shazalive@gmail.com">shazalive@gmail.com</a><br>cell: +92 91 0300 5944647 

------=_Part_26420_22668652.1187299409289--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
