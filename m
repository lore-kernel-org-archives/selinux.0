Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l91HcxJa003991
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 13:38:59 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l91HcvEn029672
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 17:38:57 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] ustr cleanups (policyrep branch)
Date: Mon, 1 Oct 2007 13:35:16 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588010FFCDC@exchange.columbia.tresys.com>
In-Reply-To: <1191221196.29631.44.camel@code.and.org>
References: <1191221196.29631.44.camel@code.and.org>
From: "Todd Miller" <Tmiller@tresys.com>
To: "James Antill" <jantill@redhat.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Antill wrote:
>  Here are two cleanups for ustr usage within libsemanage on the
> policyrep branch.
> 
>  The first is a corner case where you have two or more replacements in
> the "replace_all" function of genhomedircon, previously one of those
> multiple replacements (in theory) could fail due to malloc() returning
> NULL and that would be missed. The fix probably makes the free test
> more readable too.
> 
>  The second is that semanage_is_prefix() was previously defined by
> calling ustr functions (inefficiently, even), and so had to allocate a
> ustr to do it's work ... the fix just calls strncmp() directly.

That looks sane to me.  Is there a reason you based this off of
policyrep instead of trunk?

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
