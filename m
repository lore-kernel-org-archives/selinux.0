Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA00911
	for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2002 20:06:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA20543
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 00:04:56 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id AAA20539 for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 00:04:54 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: selinux-policy
Date: Sun, 14 Jul 2002 02:06:13 +0200
References: <20020713040410.GA1429@snoopy.apana.org.au> <20020713041014.63296766B@lyta.coker.com.au> <20020713232913.GC4027@snoopy.apana.org.au>
In-Reply-To: <20020713232913.GC4027@snoopy.apana.org.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020714000613.9BB86784C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 14 Jul 2002 01:29, you wrote:
> Also, some suggested new attributes (or appropriate macros)
> for domains:
>
> pam_auth     domain needs to use pam authenticate service
> pam_account  domain needs to use pam account service
> pam_session  domain needs to use pam session service
> pam_password domain needs to use pam change password service
>
> and/or
>
> pam		domain needs to use one/or more PAM services
>
> as well as
>
> nss		domain needs to use NSS service
>
> As this would mean if the user changes NSS or PAM configuration, for
> instance to go from /etc/shadow authentication to LDAP authentication
> or kerberos authentication, they don't need to change every service
> that requires these services.

I think that having that many attributes is unnecessary and unweildy.  How 
about having one attribute to take the place of the nss, pam_account, and 
pam_session attributes you suggest, as well as having pam_auth and 
pam_password.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
