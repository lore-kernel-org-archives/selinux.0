Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5GJbIi000825
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 11:19:39 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5GIHgk029822
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 16:18:18 GMT
Date: Fri, 5 Nov 2004 16:29:51 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Frank Mayer <mayerf@tresys.com>, "'Colin Walters'" <walters@verbum.org>,
   "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
Message-ID: <20041105162951.GD5565@lkcl.net>
References: <01df01c4c336$4facc6f0$1e0c010a@columbia.tresys.com> <418B968F.3070700@trustedcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <418B968F.3070700@trustedcs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Nov 05, 2004 at 09:04:47AM -0600, Darrel Goeddel wrote:

> For now, the policy writer has complete control over all dynamic 
> transitions, just as he/she has control over other allow rules.  One could 
> write policy that allows a dynamic transition to user_t, but one could also 
> write policy that allows access to virtually (restricted by asserts) 

 eek!

 however, are there already asserts covering domain_auto_trans?

 the same logic would apply, yes?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
