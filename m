Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA07198
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 08:46:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA11664
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 12:45:52 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA11660
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 12:45:52 GMT
Date: Mon, 19 Aug 2002 08:46:03 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: type_change rules
In-Reply-To: <20020818215637.B69868906@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208190841390.14458-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 18 Aug 2002, Russell Coker wrote:

> In macros/user.te we have the following line:
> type_change $1_t tty_device_t:chr_file $1_tty_device_t;
>
> However the tty label seems to be that which matches the last usesr logged in
> (a security issue in itself).

login should reset the tty label back to the original type when the user
logs out.  However, if login doesn't exit properly, then it will be left
in the type.  In this case, the tty will be correctly updated on the next
login due to the type_change rules in newrole.te for dealing with the
similar issue when newrole is terminated abruptly.  The real fix is to
have the rc scripts or getty reset the types properly.

> However it also has the issue that when you create a new user role you must
> also create matching type_change rules to allow changes from all other user
> domains (IE the number of rules is proportional to the number of user domains
> squared).  Is there any reason for not doing the following?
> type_change $1_t ttyfile:chr_file $1_tty_device_t;

Aside from the state explosion in the TE rules, no.  But the better
solution would be to have the rc scripts or getty reset the type properly
to avoid the need for these rules.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
