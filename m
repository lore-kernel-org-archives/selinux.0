Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8BE6otj017777
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 10:06:50 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8BE6PEI015884
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 14:06:26 GMT
Subject: Re: Supporting multiple python versions
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: Erich Schubert <erich@debian.org>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200609091116.10256.russell@coker.com.au>
References: <1157729493.31336.14.camel@wintermute.xmldesign.de>
	 <200609091116.10256.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 10:09:21 -0400
Message-Id: <1157983761.26420.46.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-09-09 at 11:16 +1000, Russell Coker wrote:
> On Saturday 09 September 2006 01:31, Erich Schubert <erich@debian.org> wrote:
> > However this means that many applications that so far only needed access
> > to usr_t will now need (read) access to var_lib_python_t.
> 
> One option is to relabel /var/lib/python-support as usr_t.  It's a little 
> ugly, but I think that naming types after directories was a mistake anyway 
> and this is just the symptom.

I agree on types like python_var_lib_t, but not something like usr_t
where the contents are so varied.

> Another option is to have a new type python_compiled_t that can be used for 
> all distributions.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
