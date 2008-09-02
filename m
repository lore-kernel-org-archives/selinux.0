Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m82DPuDP006300
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2008 09:25:56 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m82DPukR002377
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2008 13:25:56 GMT
Received: by wr-out-0506.google.com with SMTP id c37so1924966wra.26
        for <selinux@tycho.nsa.gov>; Tue, 02 Sep 2008 06:25:56 -0700 (PDT)
Message-ID: <f71a82820809020625h9fedc13nb196acf91dbcda9f@mail.gmail.com>
Date: Tue, 2 Sep 2008 22:25:56 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Subject: Re: How can I know violations in denied timing ?
In-Reply-To: <1220360475.26711.35.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7183_12158442.1220361956246"
References: <f71a82820809010206w21a07f7fya77e4ac89d6f938f@mail.gmail.com>
	 <1220360475.26711.35.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_7183_12158442.1220361956246
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks.

I will check setroubleshootd's plugins and also ask maybe Mr. G, Steve.

I thought reading audit.log was not a good idea, but I couldn't do other
way.
It pops up every time when file-size differs the problem is the timing whent
the program reading the size of the file which is in the very time making
it.

So, it's best to pops up the 'the exact time' when violation occurs like
setroubleshoot.

Yes, I know some friends in JP doing same kind of thing and I will ask them,
too.

Setroubleshoot itself looks perfect, but I want to make it my own just for
my study.

I will work hard and want to contribute SELinux itself someday...




2008/9/2 Stephen Smalley <sds@tycho.nsa.gov>

>
> On Mon, 2008-09-01 at 18:06 +0900, Shintaro Fujiwara wrote:
> > Hello, I'm Shintaro, Fujiwara writer of segatex.
> >
> > I wrote a small c program in latest segatex which pops up a widget
> > when violation occurs but,
> > it only reads audit.log and make another file and periodically compare
> > old one and new one.
> > If new one differs from old one, it pops up a widget.
> >
> > But what I really want to do is that something like setroubleshoot,
> > which I imagine reads kernel directly.
> >
> > I'm making segatex not to alternate Redhat's one, but for my own
> > pleasure and my study.
> >
> > I have no experiences reading kernel and don't know how to read kernel
> > files at all.
> >
> > So, if you have time to spare for me, please let me know how to read
> > kernel files.
> >
> > This time, I want to make a small program like setroubleshoot.
> >
> > Thank you very much in advance.
>
> I believe that setroubleshootd uses an audispd (audit dispatcher) plugin
> in order to directly receive copies of audit messages in "real time".
> Given that setroubleshootd source code is readily available, you should
> be able to study it.  You don't need to directly read the audit log
> file, nor should you do so.
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
http://intrajp.no-ip.com/ Home Page

------=_Part_7183_12158442.1220361956246
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Thanks.<br><br>I will check setroubleshootd&#39;s plugins and also ask maybe Mr. G, Steve.<br><br>I thought reading audit.log was not a good idea, but I couldn&#39;t do other way.<br>It pops up every time when file-size differs the problem is the timing whent<br>
the program reading the size of the file which is in the very time making it.<br><br>So, it&#39;s best to pops up the &#39;the exact time&#39; when violation occurs like setroubleshoot.<br><br>Yes, I know some friends in JP doing same kind of thing and I will ask them, too.<br>
<br>Setroubleshoot itself looks perfect, but I want to make it my own just for my study.<br><br>I will work hard and want to contribute SELinux itself someday...<br><br><br>&nbsp;<br><br><div class="gmail_quote">2008/9/2 Stephen Smalley <span dir="ltr">&lt;<a href="mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;</span><br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><div class="Wj3C7c"><br>
On Mon, 2008-09-01 at 18:06 +0900, Shintaro Fujiwara wrote:<br>
&gt; Hello, I&#39;m Shintaro, Fujiwara writer of segatex.<br>
&gt;<br>
&gt; I wrote a small c program in latest segatex which pops up a widget<br>
&gt; when violation occurs but,<br>
&gt; it only reads audit.log and make another file and periodically compare<br>
&gt; old one and new one.<br>
&gt; If new one differs from old one, it pops up a widget.<br>
&gt;<br>
&gt; But what I really want to do is that something like setroubleshoot,<br>
&gt; which I imagine reads kernel directly.<br>
&gt;<br>
&gt; I&#39;m making segatex not to alternate Redhat&#39;s one, but for my own<br>
&gt; pleasure and my study.<br>
&gt;<br>
&gt; I have no experiences reading kernel and don&#39;t know how to read kernel<br>
&gt; files at all.<br>
&gt;<br>
&gt; So, if you have time to spare for me, please let me know how to read<br>
&gt; kernel files.<br>
&gt;<br>
&gt; This time, I want to make a small program like setroubleshoot.<br>
&gt;<br>
&gt; Thank you very much in advance.<br>
<br>
</div></div>I believe that setroubleshootd uses an audispd (audit dispatcher) plugin<br>
in order to directly receive copies of audit messages in &quot;real time&quot;.<br>
Given that setroubleshootd source code is readily available, you should<br>
be able to study it. &nbsp;You don&#39;t need to directly read the audit log<br>
file, nor should you do so.<br>
<font color="#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></blockquote></div><br><br clear="all"><br>-- <br><a href="http://intrajp.no-ip.com/">http://intrajp.no-ip.com/</a> Home Page<br>
</div>

------=_Part_7183_12158442.1220361956246--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
