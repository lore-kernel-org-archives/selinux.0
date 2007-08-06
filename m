Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l76CDe1g015376
	for <selinux@tycho.nsa.gov>; Mon, 6 Aug 2007 08:13:41 -0400
Received: from mail.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l76CDakZ009744
	for <selinux@tycho.nsa.gov>; Mon, 6 Aug 2007 12:13:38 GMT
Message-ID: <46B71093.1050106@kaigai.gr.jp>
Date: Mon, 06 Aug 2007 21:14:11 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: cpebenito@tresys.com
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: Fedora/SE-PostgreSQL
References: <46B079EF.9050909@kaigai.gr.jp>
In-Reply-To: <46B079EF.9050909@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> A week ago, I submitted a review request of SE-PostgreSQL to
> the Fedora project as follows:
>   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=249522
> 
> The biggest issue is lack of definitions of new object classes
> and access vectors related to database.
> Rest of policies can be installed as a binary security policy module
> packed within the RPM package, but these definitions and MLS/MCS rules
> cannot be moduled.
> 
> The attached patch adds these definitions to the base policy.

Don't neglect it please, although we got a bit heavy traffic in some days.

I want any comment, to make clear the direction of SE-PostgreSQL.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
