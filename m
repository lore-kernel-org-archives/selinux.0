Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBT7C5kB005880
	for <selinux@tycho.nsa.gov>; Mon, 29 Dec 2008 02:12:05 -0500
Received: from yw-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBT7C4k6001601
	for <selinux@tycho.nsa.gov>; Mon, 29 Dec 2008 07:12:05 GMT
Received: by yw-out-1718.google.com with SMTP id 6so1496319ywa.84
        for <selinux@tycho.nsa.gov>; Sun, 28 Dec 2008 23:12:04 -0800 (PST)
Message-ID: <707f057d0812282312r19e324a8y4ace684ed1646812@mail.gmail.com>
Date: Mon, 29 Dec 2008 15:12:03 +0800
From: "xing li" <lixing.1006@gmail.com>
To: "domg472 g472" <domg472@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Where can i find the source code of Userspace Packages with modifications for SELinux?
In-Reply-To: <5aebb9fb0812270551g49c21fdm9bc7dd156182cf53@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_26261_17925922.1230534723610"
References: <707f057d0812270525t1f6fa095i9ace0cc6e4d3bd6e@mail.gmail.com>
	 <5aebb9fb0812270551g49c21fdm9bc7dd156182cf53@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_26261_17925922.1230534723610
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have download the upstart source code from ubuntu
http://packages.ubuntu.com/,  (hardy)
but i have't found the selinux relevant code in it. I am so  confused that
how the /sbin/init invoke
the "load_policy" function during system initialization?

2008/12/27 domg472 g472 <domg472@gmail.com>

> Most if not everything should be upstream. so if you would want to edit
> "cp" then you would get the source code for coreutils on the project site
> for coreutils.
>
> selinux userland tools source is here:
>
> http://userspace.selinuxproject.org/trac/browser/policycoreutils
>

------=_Part_26261_17925922.1230534723610
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I have download the upstart source code from ubuntu <a href="http://packages.ubuntu.com/">http://packages.ubuntu.com/</a>,&nbsp; (hardy)</div>
<div>but i have&#39;t found the selinux relevant code in it.&nbsp;I am so&nbsp;&nbsp;confused that how the /sbin/init invoke </div>
<div>the &quot;load_policy&quot; function during system initialization?<br><br></div>
<div class="gmail_quote">2008/12/27 domg472 g472 <span dir="ltr">&lt;<a href="mailto:domg472@gmail.com">domg472@gmail.com</a>&gt;</span><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Most if not everything should be upstream. so if you would want to edit &quot;cp&quot; then you would get the source code for coreutils on the project site for coreutils.<br>
<br>selinux userland tools source is here:<br><br><a href="http://userspace.selinuxproject.org/trac/browser/policycoreutils" target="_blank">http://userspace.selinuxproject.org/trac/browser/policycoreutils</a><br></blockquote>
</div><br>

------=_Part_26261_17925922.1230534723610--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
