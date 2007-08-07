Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77JTwqF022263
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 15:29:58 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l77JTwI4023047
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 19:29:58 GMT
Received: by an-out-0708.google.com with SMTP id c38so402310ana
        for <selinux@tycho.nsa.gov>; Tue, 07 Aug 2007 12:29:58 -0700 (PDT)
Message-ID: <9f066ee90708071229y1e13259cned89f25185b0a01@mail.gmail.com>
Date: Tue, 7 Aug 2007 15:29:57 -0400
From: Mark <elihusmails@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: beginner to SE Linux policy
Cc: "shahbaz khan" <shazalive@gmail.com>, selinux@tycho.nsa.gov,
        fedora-selinux-list@redhat.com
In-Reply-To: <1186514347.26457.114.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_128005_32368945.1186514997406"
References: <9f066ee90707271204p2bfe6da7k4f8f50798c50c2e8@mail.gmail.com>
	 <7b740b700707280714u72d59b83j3f6c3065d15e2b79@mail.gmail.com>
	 <9f066ee90708071056j74618a8akd860ef084f055243@mail.gmail.com>
	 <1186514347.26457.114.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_128005_32368945.1186514997406
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you for the information.  I will continue working with the reference
policy and reading the information you provided.


-- 
..Cheers
Mark

On 8/7/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Tue, 2007-08-07 at 13:56 -0400, Mark wrote:
> > Thanks for the help.  I just want to become more familiar with SE
> > Linux and understand the context of the te, fe, if..etc files and how
> > I can modify them so that my programs are more secure.  There just
> > seems to be alot of information that may or may not be related in
> > order to help me.  For instance, there is the seedit tools, SLIDE and
> > RedHat tools available.  Also, which is a better distribution to learn
> > SE Linux, CentOS or Fedora Core?
>
> Fedora Core tracks the latest SELinux developments more closely.
>
> The reference policy documentation should help you, online at
> http://oss.tresys.com/projects/refpolicy/wiki/Documentation and if you
> have selinux-policy installed, locally available docs
> under /usr/share/doc/selinux-policy-x.y.z/.
>
> SLIDE is an eclipse plugin that leverages reference policy and provides
> the typical IDE-style auto-completion, interface lookup, wizards for
> constructing domains, etc.  Useful if you are ok working in an IDE.
>
> SEEdit is more about hiding the underlying abstractions and presenting a
> very simple UI.  Requires switching to its own policy entirely, away
> from the stock policy.
>
> > I am an application developer who really just needs to learn how to
> > write policies for the programs I am developing.  Things like
> > policies, domains and domain transition are important areas I really
> > want to learn.
>
> There are a number of resources, e.g. see
> http://selinux.sourceforge.net/resources.php3 , but many of them predate
> the reference policy.  Reference policy documentation and SLIDE are your
> best bets right now, along with the book.
>
> --
> Stephen Smalley
> National Security Agency
>
>

------=_Part_128005_32368945.1186514997406
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you for the information.&nbsp; I will continue working with the reference policy and reading the information you provided.<br><br clear="all"><br>-- <br>..Cheers<br>Mark
<br><br><div><span class="gmail_quote">On 8/7/07, <b class="gmail_sendername">Stephen Smalley</b> &lt;<a href="mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Tue, 2007-08-07 at 13:56 -0400, Mark wrote:<br>&gt; Thanks for the help.&nbsp;&nbsp;I just want to become more familiar with SE<br>&gt; Linux and understand the context of the te, fe, if..etc files and how<br>&gt; I can modify them so that my programs are more secure.&nbsp;&nbsp;There just
<br>&gt; seems to be alot of information that may or may not be related in<br>&gt; order to help me.&nbsp;&nbsp;For instance, there is the seedit tools, SLIDE and<br>&gt; RedHat tools available.&nbsp;&nbsp;Also, which is a better distribution to learn
<br>&gt; SE Linux, CentOS or Fedora Core?<br><br>Fedora Core tracks the latest SELinux developments more closely.<br><br>The reference policy documentation should help you, online at<br><a href="http://oss.tresys.com/projects/refpolicy/wiki/Documentation">
http://oss.tresys.com/projects/refpolicy/wiki/Documentation</a> and if you<br>have selinux-policy installed, locally available docs<br>under /usr/share/doc/selinux-policy-x.y.z/.<br><br>SLIDE is an eclipse plugin that leverages reference policy and provides
<br>the typical IDE-style auto-completion, interface lookup, wizards for<br>constructing domains, etc.&nbsp;&nbsp;Useful if you are ok working in an IDE.<br><br>SEEdit is more about hiding the underlying abstractions and presenting a
<br>very simple UI.&nbsp;&nbsp;Requires switching to its own policy entirely, away<br>from the stock policy.<br><br>&gt; I am an application developer who really just needs to learn how to<br>&gt; write policies for the programs I am developing.&nbsp;&nbsp;Things like
<br>&gt; policies, domains and domain transition are important areas I really<br>&gt; want to learn.<br><br>There are a number of resources, e.g. see<br><a href="http://selinux.sourceforge.net/resources.php3">http://selinux.sourceforge.net/resources.php3
</a> , but many of them predate<br>the reference policy.&nbsp;&nbsp;Reference policy documentation and SLIDE are your<br>best bets right now, along with the book.<br><br>--<br>Stephen Smalley<br>National Security Agency<br><br></blockquote>
</div><br>

------=_Part_128005_32368945.1186514997406--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
