Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l78HLdOI019526
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 13:21:39 -0400
Received: from an-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l78HLbCU006126
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 17:21:37 GMT
Received: by an-out-0708.google.com with SMTP id c38so47661ana
        for <selinux@tycho.nsa.gov>; Wed, 08 Aug 2007 10:21:37 -0700 (PDT)
Message-ID: <9f066ee90708081021s73309c97j7ea244c033affba9@mail.gmail.com>
Date: Wed, 8 Aug 2007 13:21:36 -0400
From: Mark <elihusmails@gmail.com>
To: "Forrest Taylor" <ftaylor@redhat.com>
Subject: Re: only allow 1 port for listening
Cc: selinux@tycho.nsa.gov,
        "fedora-selinux-list@redhat.com" <fedora-selinux-list@redhat.com>
In-Reply-To: <1186593396.21910.77.camel@papa.taylor.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4889_21185889.1186593696632"
References: <9f066ee90708080840q627adbbavb9e83b45a9f017e8@mail.gmail.com>
	 <1186591749.21910.74.camel@papa.taylor.com>
	 <9f066ee90708081012q6d70d876la8f1a4fd2db69c53@mail.gmail.com>
	 <1186593396.21910.77.camel@papa.taylor.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_4889_21185889.1186593696632
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ok.  Thanks.

So I need to update corenetwork.te, recompile the policy, set the policy to
the newly compiled one and reboot?  Correct?



-- 
..Cheers
Mark

On 8/8/07, Forrest Taylor <ftaylor@redhat.com> wrote:
>
> You cannot.  You need to run this as a separate command or build it into
> the base module (corenetwork.te).
>
> Forrest
>
> On Wed, 2007-08-08 at 13:12 -0400, Mark wrote:
> > thanks for the information, but how could I add this to my .te file?
> >
> >
> > --
> > ..Cheers
> > Mark
> >
> > On 8/8/07, Forrest Taylor <ftaylor@redhat.com> wrote:
> >         On Wed, 2007-08-08 at 11:40 -0400, Mark wrote:
> >         > I am new to writing policies and have been reading the
> >         reference
> >         > policy files.  I wrote a simple TCP server that listens on a
> >         port for
> >         > connections.  I would like to write a policy that will only
> >         allow my
> >         > program to bind to a specific port(9999).  I looked at the
> >         reference
> >         > policy and see that the ports that programs are allowed to
> >         use is in
> >         > policy/modules/kernel/corenetwork.te.  My questions is, can
> >         I specify
> >         > the port in my programs type enforcement file so that I can
> >         make a
> >         > module instead of listing this in the kernel policy?  If so,
> >         what
> >         > would the syntax be?
> >
> >         portcon is only valid in the base module, not a normal
> >         loadable module.
> >         The command to generate the port entry for the policy is
> >         semanage.  It
> >         should look something like the following:
> >
> >         semanage port -a -t my_port_t -p tcp 9999
> >
> >         Forrest
> >
> >
>
>

------=_Part_4889_21185889.1186593696632
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ok.&nbsp; Thanks.&nbsp; <br><br>So I need to update corenetwork.te, recompile the policy, set the policy to the newly compiled one and reboot?&nbsp; Correct?<br><br><br clear="all"><br>-- <br>..Cheers<br>Mark
<br><br><div><span class="gmail_quote">On 8/8/07, <b class="gmail_sendername">Forrest Taylor</b> &lt;<a href="mailto:ftaylor@redhat.com">ftaylor@redhat.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
You cannot.&nbsp;&nbsp;You need to run this as a separate command or build it into<br>the base module (corenetwork.te).<br><br>Forrest<br><br>On Wed, 2007-08-08 at 13:12 -0400, Mark wrote:<br>&gt; thanks for the information, but how could I add this to my .te file?
<br>&gt;<br>&gt;<br>&gt; --<br>&gt; ..Cheers<br>&gt; Mark<br>&gt;<br>&gt; On 8/8/07, Forrest Taylor &lt;<a href="mailto:ftaylor@redhat.com">ftaylor@redhat.com</a>&gt; wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; On Wed, 2007-08-08 at 11:40 -0400, Mark wrote:
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; I am new to writing policies and have been reading the<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reference<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; policy files.&nbsp;&nbsp;I wrote a simple TCP server that listens on a<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port for<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; connections.&nbsp;&nbsp;I would like to write a policy that will only
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; allow my<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; program to bind to a specific port(9999).&nbsp;&nbsp;I looked at the<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reference<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; policy and see that the ports that programs are allowed to<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use is in
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; policy/modules/kernel/corenetwork.te.&nbsp;&nbsp;My questions is, can<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I specify<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; the port in my programs type enforcement file so that I can<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make a<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; module instead of listing this in the kernel policy?&nbsp;&nbsp;If so,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; what<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; would the syntax be?<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; portcon is only valid in the base module, not a normal<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loadable module.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The command to generate the port entry for the policy is
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; semanage.&nbsp;&nbsp;It<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; should look something like the following:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; semanage port -a -t my_port_t -p tcp 9999<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Forrest<br>&gt;<br>&gt;<br><br></blockquote>
</div><br>

------=_Part_4889_21185889.1186593696632--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
