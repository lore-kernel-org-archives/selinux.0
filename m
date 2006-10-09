Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k99DXphd017068
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 09:33:52 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k99DXDjU023752
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 13:33:13 GMT
Subject: Re: MMCS patch against subversion policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200610072113.18735.russell@coker.com.au>
References: <200610062109.51031.russell@coker.com.au>
	 <200610071118.18718.russell@coker.com.au> <452780C3.3090809@redhat.com>
	 <200610072113.18735.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 08:54:02 -0400
Message-Id: <1160398442.8690.41.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-10-07 at 21:13 +1000, Russell Coker wrote:
> On Saturday 07 October 2006 20:26, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > There is only 
> > unconfined users.  All users in by default login with s0, not
> > SystemLow-SystemHigh.  We could make that change but then it would get
> > harder to turn on MCS as you would need to start thinking in terms of
> > administators.
> 
> Maybe we need to modify useradd to manage the SE Linux identity.  We could do 
> something like have membership of group wheel mean that by default a login 
> entry will be created with SE Linux identity "root".

A more general solution would be to enhance the user mapping to be able
to map based on the group, rather than modifying useradd.  So then the
mapping would match up in the order (first match wins):

username match
group match
__default__

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
