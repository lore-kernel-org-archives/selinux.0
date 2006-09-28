Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8S14jTb004585
	for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2006 21:04:45 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8S14AnG009993
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 01:04:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Klaus Weidner <klaus@atsec.com>
Subject: Re: MLS and Biba
Date: Thu, 28 Sep 2006 11:05:09 +1000
Cc: Salvo Giuffrida <giuffsalvo@hotmail.it>, selinux@tycho.nsa.gov
References: <BAY114-F93133EE31869D548BEF16AF250@phx.gbl> <200609270924.31088.russell@coker.com.au> <20060927220346.GA10204@w-m-p.com>
In-Reply-To: <20060927220346.GA10204@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609281105.11769.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 28 September 2006 08:03, Klaus Weidner <klaus@atsec.com> wrote:
> On Wed, Sep 27, 2006 at 09:24:28AM +1000, Russell Coker wrote:
> > SE Linux only supports one MLS range per object, so having Biba and
> > Bell-laPadula is not really possible.  I guess you could misuse the high
> > and low fields of the range such that one of them represents integrity
> > and the other confidentiality, but that is too horrible to seriously
> > contemplate.
>
> A more flexible approach would be to split up the category bits into MLS,
> MCS, and MIC (integrity) sets, so that you could use all the models
> within a single policy. It's not very pretty but I think not as bad
> as having completely separate policies.

type high_t, domain;
type medium_t, domain;
type low_t, domain;
type high_file_t, file_type;
type medium_file_t, file_type;
type low_file_t, file_type;

can_exec(high_t, high_file_t)
can_exec(medium_t, { medium_file_t, high_file_t })
can_exec(low_t, file_type)
create_dir_file(high_t, high_file_t)
create_dir_file(medium_t, medium_file_t)
create_dir_file(low_t, low_file_t)
allow high_t { medium_t low_t }:file w_file_perms;
...

It seems that we can do BIBA stuff with the domain-type model.  The above is a 
demonstration of how it might start.  Probably the best thing to do would be 
to have a set of N levels and N-1 attributes for all possible <X and >X 
values and a set of macros to define the BIBA policy.

As has been mentioned in the past, the domain-type model is flexible enough to 
implement MLS etc.  It's just a matter of whether you would want to.

I might have some spare time in a couple of weeks.  Maybe I'll hack something 
up for fun.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
