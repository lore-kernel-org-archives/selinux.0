Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA15985
	for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2002 17:27:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA18326
	for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2002 21:27:24 GMT
Received: from rj.sgi.com (rj.SGI.COM [192.82.208.96])
	by jazzswing.ncsc.mil  with ESMTP id VAA18322
	for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2002 21:27:23 GMT
Date: Fri, 14 Jun 2002 14:27:04 -0700
From: richard offer <offer@sgi.com>
To: Russell Coker <russell@coker.com.au>, forrest whitcher <fw@fwsystems.com>
cc: Robert Hartley <rhartley@ics.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: What is the story on patents and SELinux?
Message-ID: <1109210000.1024090024@changeling.engr.sgi.com>
In-Reply-To: <20020614202749.418E7779B@lyta.coker.com.au>
References: <3D098B97.7030903@evoworks.evoserve.com>
 <20020614165205.E804676C9@lyta.coker.com.au>
 <20020614153011.43908d6c.fw@fwsystems.com>
 <20020614202749.418E7779B@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



* frm russell@coker.com.au "06/14/02 22:27:48 +0200" | sed '1,$s/^/* /'
*
* On Fri, 14 Jun 2002 21:30, forrest whitcher wrote:
*> On Fri, 14 Jun 2002 18:52:05 +0200 (unchecked - local sync NTPstrat4)
*> 
*> Russell Coker <russell@coker.com.au> did inscribe thusly:
*> > Any patent rights that the NSA had were given away by the GPL release.
*> 
*> I rather doubt this is the inevitable outcome. GPL is clear that where
*> there is a conflict between patent and GPL - which are unrelated areas
*> of the law - the requirements of GPL are essentially a disjoint set
*> wrt patent requirements and each must be separately addressed.
* 
* GPL makes it clear that anyone can use the software for any cause without 
* payment or license conditions.  It is incompatable with anything that 
* prevents that (including patents).  So if you own a patent that covers
* some  software and then later release the software in question under the
* GPL then  the patent will not be enforcable.  

If you use the exact text from the GPL this is true, but it is possible to
have patents release code that uses them as GPL and still limit it (I
think). This is the text in XFS

/* 
 * Further, this software is distributed without any warranty that it is
 * free of the rightful claim of any third person regarding infringement
 * or the like.  Any license provided herein, whether implied or
 * otherwise, applies only to this software file.  Patent licenses, if
 * any, provided herein do not apply to combinations of this program with
 * other software, or any other product whatsoever.
 */

I read that as, if the code is patented, then you can use in in this
product. If you take the code and re-use it in another product, you then
need a patent license.


According to http://oss.sgi.com/projects/GenInfo/SGIGPLNoticeExplan/, this
has FSF approval.


richard.


-- 
-----------------------------------------------------------------------
Richard Offer                     Technical Lead, Trust Technology, SGI
"Specialization is for insects"
_______________________________________________________________________


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
