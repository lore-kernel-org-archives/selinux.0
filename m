Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA27157
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2001 08:16:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA19405
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2001 12:16:07 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzswing.ncsc.mil  with ESMTP id MAA19401
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2001 12:16:07 GMT
Date: Wed, 23 May 2001 07:16:14 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200105231216.HAA17913@tomcat.admin.navo.hpc.mil>
To: edm@tycho.ncsc.mil, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: Immunity against Buffer Overflows / exploits
In-Reply-To: <1010522185820.216AAH0H.edm@termpaper>
Cc: edm@tycho.ncsc.mil, selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

edm@tycho.ncsc.mil:
>>Other hardware controls do change this. Even Intel could be better if the
>>memory management hardware had execute capability separate from read; and
>>separate from write. Once that is possible then the initial penetration
>>would fail.
>
>Actually the i386 archtecture (still) does have this capability when you use
>its segementation. Too bad current OS's don't use it.

Perhaps a 2.5 or 2.7 issue to change the memory management to
segmented+paging for designated processes ...?

It's time to get new documentation...

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
