Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA13467
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 18:09:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA17458
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 22:09:03 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
	by jazzswing.ncsc.mil  with ESMTP id WAA17454
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 22:09:03 GMT
Date: Mon,  5 Aug 2002 18:09:54 -0400
Message-Id: <200208051809.AA1361051876@mail.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "david caplan" <dac@mail.tresys.com>
Reply-To: <dac@mail.tresys.com>
To: <selinux@tycho.nsa.gov>, "Ryan Bergauer"  <privateryan@mindspring.com>
Subject: Re: CVS tree make error
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The problem is with the ko.po and ja.po files in the tar package.  There's some kind of incompatability with the msgfmt utility and the fonts/chars in the file.  In the files (twice in the ko and once in the ja file - or maybe it was the other way around) you'll find that the name Francois (can't recall the last name) has a cedilla under the 'c'.  Just replace it with a 'c' and it will build fine.  

I asked Steve about this and I think his theory was that it had something to do with the dates on the files when you download via cvs, and that normally these files (i.e., .po -> .gmo) would not get rebuilt.

David

---------- Original Message ----------------------------------
From: "Ryan Bergauer" <privateryan@mindspring.com>
Date: Mon, 5 Aug 2002 16:35:43 -0500

>Just as a heads up, when I make selinux/utils from the current CVS tree
>I get:
> 
>Making all in po
>make[3]: Entering directory `/usr/src/selinux/utils/tar-1.13.19/po'
>file=./`echo ko | sed 's,.*/,,'`.gmo \
>  && rm -f $file && PATH=../src:$PATH /usr/bin/msgfmt -o $file ko.po
>ko.po:1431:17: invalid multibyte sequence
>ko.po:1434:6: invalid multibyte sequence
>/usr/bin/msgfmt: found 2 fatal errors
>make[3]: *** [ko.gmo] Error 1
> 
>This is on a barebones Red Hat 7.3 install. The July 3 release doesn't
>give this error.
> 
>-Ryan 
> 
>
>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
