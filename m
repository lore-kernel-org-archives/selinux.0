Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27448
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 11:55:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA24266
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 15:54:02 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA24252 for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 15:54:01 GMT
Date: Fri, 16 Aug 2002 11:55:11 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ryan Bergauer <privateryan@mindspring.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: CVS install error
In-Reply-To: <001201c23cc7$ef2bd1a0$0300a8c0@donkey>
Message-ID: <Pine.GSO.4.33.0208161153510.29385-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 5 Aug 2002, Ryan Bergauer wrote:

> Making all in po
> make[3]: Entering directory `/usr/src/selinux/utils/tar-1.13.19/po'
> file=./`echo ko | sed 's,.*/,,'`.gmo \
>   && rm -f $file && PATH=../src:$PATH /usr/bin/msgfmt -o $file ko.po
> ko.po:1431:17: invalid multibyte sequence
> ko.po:1434:6: invalid multibyte sequence
> /usr/bin/msgfmt: found 2 fatal errors
> make[3]: *** [ko.gmo] Error 1

This should now be fixed in the CVS tree.  Thanks to David Caplan of
Tresys for the fix.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
