Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2GA9sDo005807
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 05:09:54 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2GA1LbS001298
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 10:01:21 GMT
Date: Wed, 16 Mar 2005 10:13:39 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
Subject: Re: [RFC & PATCH] inherited type definition.
Message-ID: <20050316101339.GK6055@lkcl.net>
References: <200503151400.j2FE0t8R014737@gotham.columbia.tresys.com> <4237B798.5010303@ak.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4237B798.5010303@ak.jp.nec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 16, 2005 at 01:35:36PM +0900, Kaigai Kohei wrote:
> Hi Karl, Thanks for your comments.
> 
> > Not exactly - that is certainly one problem, but the main problem is that I want
> > the ability to create a group of types based on another group of types, e.g. I
> > want to create staff_ssh_t and staff_home_ssh_t based on the corresponding user
> > types. In this model staff_ssh_t wouldn't have any access to user_home_ssh_t,
> > instead it will have the same access that user_ssh_t has to user_home_ssh_t
> > except to staff_home_ssh_t.
> 

 oh _drat_.

 you might be running into almost exactly the same stupid
 pre-processor issues i ran into in gcc with c++ (if you pre-process,
 how can you use c++ templates on macro-pre-processed code???)


 *thinks some more*.

 karl, could you elaborate with an example?

 if you put the inheritance statement into the macro, such that it gets
 expanded out, why is there a problem?

 $1_t extends $1_something_t

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
