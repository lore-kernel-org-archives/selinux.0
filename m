Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA02820
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 20:26:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA12229
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 00:24:42 GMT
Received: from web40008.mail.yahoo.com (web40008.mail.yahoo.com [66.218.78.26])
        by jazzband.ncsc.mil  with SMTP id AAA12225 for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 00:24:41 GMT
Message-ID: <20020813002617.72875.qmail@web40008.mail.yahoo.com>
Date: Mon, 12 Aug 2002 17:26:17 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Swollen su_macros.te file
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020812222957.674718732@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Russell,

--- Russell Coker <russell@coker.com.au> wrote:
> On Mon, 12 Aug 2002 15:21, Brad Chapman wrote:
> >         The context REMAINS THE SAME! Even when I use 'su -l' !!!
> >
> >         What does this mean?
> 
> This means that su is operating correctly on your system.

        Um.... OK. Could you explain that?

> 
> 
> So how do you cause the situation where your programs are running in the su 
> domain and causing the errors to be logged?
 
        I don't know. Does it have anything to do with the domain_auto_trans()
m4 macro, or does it have to do with the use of su at all?

Brad


=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
