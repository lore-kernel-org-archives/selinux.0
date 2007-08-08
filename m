Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l78HCZ8a018569
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 13:12:35 -0400
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l78HCYSH020264
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 17:12:34 GMT
Received: by nz-out-0506.google.com with SMTP id l1so97970nzf
        for <selinux@tycho.nsa.gov>; Wed, 08 Aug 2007 10:12:34 -0700 (PDT)
Message-ID: <9f066ee90708081012q6d70d876la8f1a4fd2db69c53@mail.gmail.com>
Date: Wed, 8 Aug 2007 13:12:33 -0400
From: Mark <elihusmails@gmail.com>
To: "Forrest Taylor" <ftaylor@redhat.com>
Subject: Re: only allow 1 port for listening
Cc: selinux@tycho.nsa.gov,
        "fedora-selinux-list@redhat.com" <fedora-selinux-list@redhat.com>
In-Reply-To: <1186591749.21910.74.camel@papa.taylor.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4697_18436880.1186593153963"
References: <9f066ee90708080840q627adbbavb9e83b45a9f017e8@mail.gmail.com>
	 <1186591749.21910.74.camel@papa.taylor.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_4697_18436880.1186593153963
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

thanks for the information, but how could I add this to my .te file?


-- 
..Cheers
Mark

On 8/8/07, Forrest Taylor <ftaylor@redhat.com> wrote:
>
> On Wed, 2007-08-08 at 11:40 -0400, Mark wrote:
> > I am new to writing policies and have been reading the reference
> > policy files.  I wrote a simple TCP server that listens on a port for
> > connections.  I would like to write a policy that will only allow my
> > program to bind to a specific port(9999).  I looked at the reference
> > policy and see that the ports that programs are allowed to use is in
> > policy/modules/kernel/corenetwork.te.  My questions is, can I specify
> > the port in my programs type enforcement file so that I can make a
> > module instead of listing this in the kernel policy?  If so, what
> > would the syntax be?
>
> portcon is only valid in the base module, not a normal loadable module.
> The command to generate the port entry for the policy is semanage.  It
> should look something like the following:
>
> semanage port -a -t my_port_t -p tcp 9999
>
> Forrest
>
>

------=_Part_4697_18436880.1186593153963
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

thanks for the information, but how could I add this to my .te file?<br><br clear="all"><br>-- <br>..Cheers<br>Mark
<br><br><div><span class="gmail_quote">On 8/8/07, <b class="gmail_sendername">Forrest Taylor</b> &lt;<a href="mailto:ftaylor@redhat.com">ftaylor@redhat.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Wed, 2007-08-08 at 11:40 -0400, Mark wrote:<br>&gt; I am new to writing policies and have been reading the reference<br>&gt; policy files.&nbsp;&nbsp;I wrote a simple TCP server that listens on a port for<br>&gt; connections.&nbsp;&nbsp;I would like to write a policy that will only allow my
<br>&gt; program to bind to a specific port(9999).&nbsp;&nbsp;I looked at the reference<br>&gt; policy and see that the ports that programs are allowed to use is in<br>&gt; policy/modules/kernel/corenetwork.te.&nbsp;&nbsp;My questions is, can I specify
<br>&gt; the port in my programs type enforcement file so that I can make a<br>&gt; module instead of listing this in the kernel policy?&nbsp;&nbsp;If so, what<br>&gt; would the syntax be?<br><br>portcon is only valid in the base module, not a normal loadable module.
<br>The command to generate the port entry for the policy is semanage.&nbsp;&nbsp;It<br>should look something like the following:<br><br>semanage port -a -t my_port_t -p tcp 9999<br><br>Forrest<br><br></blockquote></div><br>

------=_Part_4697_18436880.1186593153963--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
