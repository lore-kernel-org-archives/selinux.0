Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79HYvp3023476
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:34:57 -0400
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l79HYvVe008427
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 17:34:57 GMT
Received: by nz-out-0506.google.com with SMTP id l1so263159nzf
        for <selinux@tycho.nsa.gov>; Thu, 09 Aug 2007 10:34:56 -0700 (PDT)
Message-ID: <9f066ee90708091034x7981a572j3001830d3a8284a8@mail.gmail.com>
Date: Thu, 9 Aug 2007 13:34:56 -0400
From: Mark <elihusmails@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: java error after installing reference policy
Cc: selinux@tycho.nsa.gov,
        "fedora-selinux-list@redhat.com" <fedora-selinux-list@redhat.com>
In-Reply-To: <1186677680.6916.589.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7496_7109088.1186680896491"
References: <9f066ee90708090815t514eddf6k7d02903d806d7c6c@mail.gmail.com>
	 <1186677680.6916.589.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_7496_7109088.1186680896491
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The reason why I did this was to try different things in order to get the
reference policy to compile in SLIDE.  I posted a message to the mailing
list about this.  Sorry, I'm fairly new to SE Linux and am trying to learn
it.  "SE Linux by Example" is on the way :)


On 8/9/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Thu, 2007-08-09 at 11:15 -0400, Mark wrote:
> > I followed the instructions for installing the latest reference
> > policy: http://oss.tresys.com/projects/refpolicy/wiki/UseRefpolicy
>
> Why?  The stock Fedora policy is already refpolicy-based.
> What kind of policy did you build (build.conf settings)?
>
> > After rebooting, I get the following command when I run SLIDE:
> >
> > Java HotSpot(TM) Client VM warning: Attempt to allocate stack guard
> > pages failed.
> > Error occurred during initialization of VM
> > Could not reserve enough space for code cache
> >
> > I then tried just running "java -version", and I get the same error
> > message.
> >
> > I am running Sun's JDK version 1.6 update 2.
>
> Likely need to set booleans for execstack/execmem.  Or make sure java
> runs in a domain that has those permissions.
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
..Cheers
Mark

------=_Part_7496_7109088.1186680896491
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The reason why I did this was to try different things in order to get the reference policy to compile in SLIDE.&nbsp; I posted a message to the mailing list about this.&nbsp; Sorry, I&#39;m fairly new to SE Linux and am trying to learn it.&nbsp; &quot;SE Linux by Example&quot; is on the way :)
<br><br><br><div><span class="gmail_quote">On 8/9/07, <b class="gmail_sendername">Stephen Smalley</b> &lt;<a href="mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Thu, 2007-08-09 at 11:15 -0400, Mark wrote:<br>&gt; I followed the instructions for installing the latest reference<br>&gt; policy: <a href="http://oss.tresys.com/projects/refpolicy/wiki/UseRefpolicy">http://oss.tresys.com/projects/refpolicy/wiki/UseRefpolicy
</a><br><br>Why?&nbsp;&nbsp;The stock Fedora policy is already refpolicy-based.<br>What kind of policy did you build (build.conf settings)?<br><br>&gt; After rebooting, I get the following command when I run SLIDE:<br>&gt;<br>&gt; Java HotSpot(TM) Client VM warning: Attempt to allocate stack guard
<br>&gt; pages failed.<br>&gt; Error occurred during initialization of VM<br>&gt; Could not reserve enough space for code cache<br>&gt;<br>&gt; I then tried just running &quot;java -version&quot;, and I get the same error
<br>&gt; message.<br>&gt;<br>&gt; I am running Sun&#39;s JDK version 1.6 update 2.<br><br>Likely need to set booleans for execstack/execmem.&nbsp;&nbsp;Or make sure java<br>runs in a domain that has those permissions.<br><br>--<br>
Stephen Smalley<br>National Security Agency<br><br></blockquote></div><br><br clear="all"><br>-- <br>..Cheers<br>Mark

------=_Part_7496_7109088.1186680896491--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
