Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA02739
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 17:46:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA19811
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 22:44:16 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id WAA19807
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 22:44:16 GMT
Date: Wed, 30 Oct 2002 17:45:48 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: the new default_contexts file
In-Reply-To: <200210302336.21769.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210301745000.25777-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 30 Oct 2002, Russell Coker wrote:

> The idea of having key-value pairs where the key is the partial context of the
> daemon is good.
>
> However only being able to specify an order is not good.
>
> I would like to be able to have two users, user "a" gets user_r:user_t by
> default while user "b" gets second_r:second_t by default even though both
> users are authorised for both roles.

This can be customized on a per-user basis by the user via a
$HOME/.default_contexts file.  Same syntax as the main configuration file,
and it takes precedence.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
