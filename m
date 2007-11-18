Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAIBqgED008208
	for <selinux@tycho.nsa.gov>; Sun, 18 Nov 2007 06:52:42 -0500
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAIBqeLL002246
	for <selinux@tycho.nsa.gov>; Sun, 18 Nov 2007 11:52:40 GMT
Received: by rv-out-0910.google.com with SMTP id k15so1116503rvb
        for <selinux@tycho.nsa.gov>; Sun, 18 Nov 2007 03:52:34 -0800 (PST)
Message-ID: <f71a82820711180352x5f1c077cnede04682d36f2b28@mail.gmail.com>
Date: Sun, 18 Nov 2007 20:52:34 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "KaiGai Kohei" <kaigai@kaigai.gr.jp>, selinux <selinux@tycho.nsa.gov>
Subject: Re: "semanage login -l" is working on F8?
In-Reply-To: <474024DB.3030803@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f71a82820711180001n24228f18x55410b882f38c98f@mail.gmail.com>
	 <474024DB.3030803@kaigai.gr.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Uhmm, thanks Kohei.

I can try.
Yeh, ascii sounds like problem on locale...
I found that setroubleshoot worked on JP this time, though...

Anyway, all I want to do is configure my home server on F8,
so I may avoid this problem change local at whenever I need to.

But annoying isn't it?
Maybe we non-English speaking people should fix these...


2007/11/18, KaiGai Kohei <kaigai@kaigai.gr.jp>:
> You can avoid this problem with "env LANG=C".
>
> I guess somewhere in semanage depends on the locale.
>
> Shintaro Fujiwara wrote:
> > I typed "semanage login -l" on F8.
> > I got
> >
> > /usr/sbin/semanage: ascii
> >
> > What's this ?
> >
> > I want to manage SELinux user...
> >
>
>
> --
> KaiGai Kohei <kaigai@kaigai.gr.jp>
>


-- 
Shintaro Fujiwara
segatex project (SELinux policy tool)
http://sourceforge.net/projects/segatex/
Home page
http://intrajp.no-ip.com/
Blog
http://intrajp.no-ip.com/nucleus/
CMS
http://intrajp.no-ip.com/xoops/
Wiki
http://intrajp.no-ip.com/pukiwiki/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
