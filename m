Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8196U5J025771
	for <selinux@tycho.nsa.gov>; Mon, 1 Sep 2008 05:06:30 -0400
Received: from wr-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8195ut8023077
	for <selinux@tycho.nsa.gov>; Mon, 1 Sep 2008 09:05:56 GMT
Received: by wr-out-0506.google.com with SMTP id c37so1502716wra.26
        for <selinux@tycho.nsa.gov>; Mon, 01 Sep 2008 02:06:30 -0700 (PDT)
Message-ID: <f71a82820809010206w21a07f7fya77e4ac89d6f938f@mail.gmail.com>
Date: Mon, 1 Sep 2008 18:06:29 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: How can I know violations in denied timing ?
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_55670_13801121.1220259989419"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_55670_13801121.1220259989419
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, I'm Shintaro, Fujiwara writer of segatex.

I wrote a small c program in latest segatex which pops up a widget when
violation occurs but,
it only reads audit.log and make another file and periodically compare old
one and new one.
If new one differs from old one, it pops up a widget.

But what I really want to do is that something like setroubleshoot, which I
imagine reads kernel directly.

I'm making segatex not to alternate Redhat's one, but for my own pleasure
and my study.

I have no experiences reading kernel and don't know how to read kernel files
at all.

So, if you have time to spare for me, please let me know how to read kernel
files.

This time, I want to make a small program like setroubleshoot.

Thank you very much in advance.

-- 
http://intrajp.no-ip.com/ Home Page

------=_Part_55670_13801121.1220259989419
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hello, I&#39;m Shintaro, Fujiwara writer of segatex.<br><br>I wrote a small c program in latest segatex which pops up a widget when violation occurs but, <br>it only reads audit.log and make another file and periodically compare old one and new one.<br>

If new one differs from old one, it pops up a widget.<br><br>But what I really want to do is that something like setroubleshoot, which I imagine reads kernel directly.<br><br>I&#39;m making segatex not to alternate Redhat&#39;s one, but for my own pleasure and my study.<br>

<br>I have no experiences reading kernel and don&#39;t know how to read kernel files at all.<br><br>So, if you have time to spare for me, please let me know how to read kernel files.<br><br>This time, I want to make a small program like setroubleshoot.<br>

<br>Thank you very much in advance.<br clear="all"><br>-- <br><a href="http://intrajp.no-ip.com/">http://intrajp.no-ip.com/</a> Home Page<br>
</div>

------=_Part_55670_13801121.1220259989419--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
