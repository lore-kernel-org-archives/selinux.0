Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA20961
	for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2002 09:56:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA29096
	for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2002 14:55:27 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA29091 for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2002 14:55:25 GMT
Content-Type: text/plain;
  charset="iso-8859-15"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Roberto Nibali <ratz@tac.ch>
Subject: Re: talks about SE Linux
Date: Tue, 26 Mar 2002 15:56:18 +0100
References: <20020326011659.E9F5D22ADE@lyta.coker.com.au> <3CA03523.118E1850@tac.ch>
In-Reply-To: <3CA03523.118E1850@tac.ch>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020326145618.D50971296@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 26 Mar 2002 09:45, you wrote:
> > Also at OLS I would like to arrange a BOF on advanced security (where we
> > can discuss SE Linux, GR Security, OpenWall, LIDS, and anything else that
> > seems appropriate).  This will be entirely separate from the LSM BOF.
> > Another thing I was thinking of was an install-fest for these things.
>
> Excellent. I'll be attending OLS too like every year. I'm not sure if you
> were there last year at the LSM BOF. I'd be very interesting in having

No, last year I wasn't so interested in security.

> a BOF on selinux. I had a long and extensive talk with P. Loscocco last

He must have been having many long and extensive talks!  ;)

> year about several issues they might address before porting to LSM (which
> has already happened). I've been working very closely with B+ systems from
> Argus on Solaris and thus I hope to be able to give some valuable input. I
> also like to talk about a possible clean meta policy configuration
> description for LSM/selinux since I've got a very clean, stripped and
> secure linux distro handy, which has been developed by 3 people over the
> course of 2 years. This is namely the biggest problem when dealing with C2
> and upwards systems. It should be possible though to write a kind of matrix
> and a translation function to reflect the security policy needed for a
> certain application framework. This would leed to widely adaption of
> LSM/<put your favourite MAC/TE/ACL implementation in> for commercial
> purposes.

Sounds interesting.  Writing policy files for SE Linux is really painful at 
the moment, it needs some serious work.

> I certainly hope that Stephen Smalley and Pete Loscocco will be attending
> OLS too so we might have other interesting talks while having a cool beer.

I believe that Stephen will not be able to attend, but Pete will be there.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
