Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5GwIIi001148
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 11:58:18 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5Guwgk002266
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 16:56:58 GMT
Date: Fri, 5 Nov 2004 16:33:32 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'Colin Walters'" <walters@verbum.org>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
Message-ID: <20041105163332.GE5565@lkcl.net>
References: <1099660413.6373.55.camel@moss-spartans.epoch.ncsc.mil> <01f701c4c34f$e4c56170$1e0c010a@columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01f701c4c34f$e4c56170$1e0c010a@columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Nov 05, 2004 at 10:55:37AM -0500, Frank Mayer wrote:

> To me this is not policy, but definition of domain.  The notion of domain type
> entry only via exec isn't a policy decision, and neither would this.
> 
> In fact we don't even have to have a permission to allow context change, there's
> no reason to prevent any process from dropping down the type tree as long as
> there are guarantees that the sub-domains are always less privileged.  Seems a
> lot simpler and still responsive.
 
 sounds to me like a job for automatic (macro-based) generation of assertions.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
