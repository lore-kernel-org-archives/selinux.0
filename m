Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9FHeT4v031630
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 13:40:29 -0400
Received: from nz-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9FHeSlE013295
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 17:40:29 GMT
Received: by nz-out-0506.google.com with SMTP id i1so985441nzh
        for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 10:40:02 -0700 (PDT)
Message-ID: <7b740b700710151033h77f51349rcaef35571da0646f@mail.gmail.com>
Date: Mon, 15 Oct 2007 22:33:53 +0500
From: "shahbaz khan" <shazalive@gmail.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Subject: Re: configured virtual environment with SElinux
Cc: Jax <cybercorecentre@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <1192455622.2913.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_44569_6630604.1192469633873"
References: <4710018B.20607@gmail.com>
	 <1192455622.2913.3.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_44569_6630604.1192469633873
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 10/15/07, Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:
>
> On Sat, 2007-10-13 at 01:21 +0200, Jax wrote:
> > Hi guys,
> >
> > I still learning many thing in selinux and I want to ask you about is
> > there any image where someone already configured selinux for many
> > application? It can be vmware, uml, openvz whatever, but it would help
> > me a lot in learning, and understanding selinux by examples because the
> > theory itself incredibly boring. I read many docs on the site and I
> > don't feel I making any progress in this.
> >
> > Thanks
> >
> > Jax
> >
>
> Installing Fedora (or one of the other supported distros) will get you a
> fully configured selinux system.


Fedora will give you an example system but you will need to download the
reference policy from Tresys website. Refference policy is a nice division
of policy into a base and then modular policy per package. It will enable
you to understand the way the SELinux team handles policy. If I can remember
correctly they did some work on Xen and VMware. Check out the mailing
list archives as well. You might find something useful there. The theory
might be boring to you but you will always need some reference material to
grip on to the concepts and policy clearly.


-- 
Shaz

Group: http://securityengineering.wordpress.com
Email: shazalive@gmail.com
cell: +92 91 0300 5944647

------=_Part_44569_6630604.1192469633873
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><span class="gmail_quote">On 10/15/07, <b class="gmail_sendername">Karl MacMillan</b> &lt;<a href="mailto:kmacmillan@mentalrootkit.com">kmacmillan@mentalrootkit.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Sat, 2007-10-13 at 01:21 +0200, Jax wrote:<br>&gt; Hi guys,<br>&gt;<br>&gt; I still learning many thing in selinux and I want to ask you about is
<br>&gt; there any image where someone already configured selinux for many<br>&gt; application? It can be vmware, uml, openvz whatever, but it would help<br>&gt; me a lot in learning, and understanding selinux by examples because the
<br>&gt; theory itself incredibly boring. I read many docs on the site and I<br>&gt; don&#39;t feel I making any progress in this.<br>&gt;<br>&gt; Thanks<br>&gt;<br>&gt; Jax<br>&gt;<br><br>Installing Fedora (or one of the other supported distros) will get you a
<br>fully configured selinux system.</blockquote>
<div>&nbsp;</div>
<div>Fedora will give you an example system but you will need to download the reference policy from Tresys website. Refference policy is a nice division of policy into a base and then modular policy per package. It will enable you to understand the way the SELinux team handles policy. If I can remember correctly they did some work on Xen and VMware. Check out the mailing list&nbsp;archives as well. You might find something useful there. The theory might be boring to you but you will always need some reference material to grip on to the concepts and policy clearly. 
</div></div><br clear="all"><br>-- <br>Shaz<br><br>Group: <a href="http://securityengineering.wordpress.com">http://securityengineering.wordpress.com</a><br>Email: <a href="mailto:shazalive@gmail.com">shazalive@gmail.com</a>
<br>cell: +92 91 0300 5944647 

------=_Part_44569_6630604.1192469633873--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
