Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8QNOHQx000776
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 19:24:18 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8QNNiXe012606
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 23:23:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
Subject: Re: MLS and Biba
Date: Wed, 27 Sep 2006 09:24:28 +1000
Cc: selinux@tycho.nsa.gov
References: <BAY114-F93133EE31869D548BEF16AF250@phx.gbl>
In-Reply-To: <BAY114-F93133EE31869D548BEF16AF250@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609270924.31088.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 27 September 2006 08:39, "Salvo Giuffrida" 
<giuffsalvo@hotmail.it> wrote:
> Good morning, is it possible to configure the MLS policy, using
> mlsconstraint, to enforce a Biba integrity model of security (no read down,
> no write up), instead of the Bell-LaPadula (no read up, no write down)? I'm
> reading the book "SELinux by example", and there there's written that the
> MLS facility in the Security Server is not very flexible, and allows only
> to enforce the rules "no read up, no write down". But, if I'm the one
> configuring the policy in the file "mls", shouldn't I be able to change the
> rules to the opposite?

Sure you can change it to do that.

Almost everyone who is involved in SE Linux development believes that 
domain-type is the best way of ensuring system integrity and that MLS is only 
needed for confidentiality.  So all the work has progressed in that 
direction.

SE Linux only supports one MLS range per object, so having Biba and 
Bell-laPadula is not really possible.  I guess you could misuse the high and 
low fields of the range such that one of them represents integrity and the 
other confidentiality, but that is too horrible to seriously contemplate.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
