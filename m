Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j36HnHDo019817
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 13:49:17 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j36HknkY021929
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 17:46:51 GMT
Date: Wed, 6 Apr 2005 18:55:57 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: russell@coker.com.au, SELinux Mail List <selinux@tycho.nsa.gov>,
   kaigai@ak.jp.nec.com
Subject: Re: [RFC & PATCH] inherited type definition.
Message-ID: <20050406175557.GJ19784@lkcl.net>
References: <42346C17.3090301@kaigai.gr.jp> <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil> <4236CC03.5010104@kaigai.gr.jp> <200504062249.14886.russell@coker.com.au> <4253F745.9070609@kaigai.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4253F745.9070609@kaigai.gr.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 06, 2005 at 11:50:45PM +0900, KaiGai Kohei wrote:

> But I understand your concern about an inherited domain.
> My original idea was started from 'inherited domain', but I noticed
> the worth of 'unified type' via this discussion.
> 
> This statement can't ban an 'inherited domain', but it will not be

 that's the reason why i suggested the inheritable(...) { } syntax.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
