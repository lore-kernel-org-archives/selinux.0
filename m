Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8AHoaO8023824
	for <selinux@tycho.nsa.gov>; Sun, 10 Sep 2006 13:50:36 -0400
Received: from pop05.mail.atl.earthlink.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8AHoCSZ015708
	for <selinux@tycho.nsa.gov>; Sun, 10 Sep 2006 17:50:13 GMT
Message-ID: <45045046.40905@mindspring.com>
Date: Sun, 10 Sep 2006 13:49:58 -0400
From: Richard Hally <rhally@mindspring.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
CC: selinux@tycho.nsa.gov
Subject: Re: [RFC] SELinux and PostgreSQL (draft v2)
References: <44FFEB42.90203@kaigai.gr.jp> <45039AC2.3040309@kaigai.gr.jp>
In-Reply-To: <45039AC2.3040309@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> In recent days, I'm making a plan to enhance PostgreSQL with SELinux.
> I posted the first draft of this plan a few days ago, and I got many
> response. Thanks for your comments so much.
> (Especially, Joshua and Russell)
> 
> The followings are the revised and summarized plan (draft v2).
> I'm welcoming any comments to improve the project.
> 

Please help me understand why this addition is needed.
Would it be more appropriate to extend the existing roles and privileges
mechanism that already exists in PostgreSQL rather than adding all this
additional burden to the kernel object classes and access vector cache?
I can understand the need to extend access control the columns and rows
but most of the higher level controls already exist.

Thank you for your help,
Richard Hally


> * New object classes and access vectors
> 
<snip>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
