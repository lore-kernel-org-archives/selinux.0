Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA23799
	for <selinux@tycho.nsa.gov>; Wed, 7 Aug 2002 08:36:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA23186
	for <selinux@tycho.nsa.gov>; Wed, 7 Aug 2002 12:34:37 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
        by jazzband.ncsc.mil  with ESMTP id MAA23182 for <selinux@tycho.nsa.gov>; Wed, 7 Aug 2002 12:34:36 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "Russell Coker" <russell@coker.com.au>,
        "Samarth Sharma" <samarth7880@rediffmail.com>, <selinux@tycho.nsa.gov>
Subject: RE: adduser??
Date: Wed, 7 Aug 2002 08:36:59 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIIEDHKFAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20020807110516.851CE19A4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Also you may want to change the file_context/types.fc to use the
> sysadm_home_t for the home directory of the user in question and
> use setfiles
> to apply the change.

I think I would use "chcon <user>:object_r:sysadm_hom_t" if you wanted to
change the user's home directory.  Running setfiles seems like overkill.

Of course one should also edit file_context/types.fc as suggested so that if
setfiles is re-run at some future date, the appropriate labels are applied.
What we're doing for labeling in install scripts for new stuff after the
system has been installed is: 1) add, install, and load our policy updates,
2) use install -X or chcon to fix those labels we care about, and 3)
change/add the appropriate *.fc files to make those labeling changes
permanent in case setfiles is run again.

Once we get out the prototype development mode, I would expect setfiles to
be run during system install, and then only rarely maybe as part of some
recovery process.

Frank



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
