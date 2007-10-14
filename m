Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9EIrBg0027619
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 14:53:11 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l9EIrAmu004828
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 18:53:10 GMT
Message-ID: <4712657A.5010105@manicmethod.com>
Date: Sun, 14 Oct 2007 14:52:42 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: checkmodule and MLS/MCS support
References: <200710142206.29369.russell@coker.com.au>
In-Reply-To: <200710142206.29369.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> http://ramblingfoo.blogspot.com/2007/10/selinux-mlsmcs-support.html
>
> Given that everyone who is working on SE Linux seems to be working on MCS and 
> MLS systems, would it make sense to have the default checkmodule operation be 
> to generate modules for MLS/MCS policy?
>   

Changing defaults is a bad idea. Gentoo, for example, builds policy on 
end systems. Things would all of a sudden blow up on every policy 
installation if the default changed.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
