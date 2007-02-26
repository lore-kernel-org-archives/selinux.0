Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QJjSli018847
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 14:45:28 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1QJknW2027491
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 19:46:49 GMT
Subject: Re: Fix man page
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45E33256.3050506@redhat.com>
References: <45E33256.3050506@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 14:47:07 -0500
Message-Id: <1172519227.22224.17.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 14:17 -0500, Daniel J Walsh wrote:
> plain text document attachment
> (nsaserefpolicy_man_man8_kerberos_selinux.8)
> --- nsaserefpolicy/man/man8/kerberos_selinux.8	2007-02-19 11:32:55.000000000 -0500
> +++ serefpolicy-2.5.5/man/man8/kerberos_selinux.8	2007-02-26 11:04:22.000000000 -0500
> @@ -23,7 +23,7 @@
>  .EX
>  setsebool -P krb5kdc_disable_trans 1
>  service krb5kdc restart
> -setsebool -P kadmind_disable_trans booleans 1
> +setsebool -P kadmind_disable_trans 1
>  service kadmind restart
>  .EE
>  .PP

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
