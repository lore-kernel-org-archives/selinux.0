Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA15626
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 12:48:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA02596
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 16:47:56 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA02587
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 16:47:56 GMT
Date: Mon, 10 Jun 2002 12:47:18 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: multiple user roles/domains
In-Reply-To: <20020609085508.433AF466@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206101242010.13767-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 9 Jun 2002, Russell Coker wrote:

> Next I plan to do the following:
> Have a "user_type" attribute on user_t and every similar domain, and have the
> .te files listed above refer to "user_type" instead of "user_t" wherever
> possible.

There is already a 'userdomain' type attribute on user_t and sysadm_t that
is used in a number of rules, although not everywhere it could be.  While
using it more pervasively would be helpful, there are likely to be cases
where you do not want all of your user domains to be included in such
rules.

> For the rbac file I'm not sure how I can solve it without having to edit that
> file separately in addition to modifying user.te for the new domains and
> roles.

Role allow rules don't have to be centralized in rbac, but it seems
preferable to keep them there.

> Now for /home, I was thinking of having home_root_t, $1_home_dir_t
> (user_home_dir_t) for the main ~user directory, and $1_home_t (user_home_t)
> for the files and directories under ~user.  This means that when I want to
> give a web server access to ~user/www I can grant it access to search
> user_home_dir_t and r_dir_file() access to user_home_www_t.

This seems reasonable.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
