Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4I6R5Rb029420
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 02:27:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4I6R3AR003444
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 06:27:03 GMT
Received: from mxlx1.surveysavvy.com (mxlx1.surveysavvy.com [63.108.92.46])
        by jazzband.ncsc.mil  with SMTP id i4I6R2Hn003441 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 06:27:02 GMT
Message-ID: <4461.68.6.187.64.1084861241.squirrel@mxlx1.surveysavvy.com>
Date: Mon, 17 May 2004 23:20:41 -0700 (PDT)
Subject: Re: suggestion to help transition to selinux: dynamic loading of   
       libselinux
From: "Chris Babcock" <cbabcock@luthresearch.com>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> idea: make all the modifications to e.g. coreutils, login etc.
> compile with the header files but not necessarily _need_
> libselinux at run-time.
>
...
> the suggestion is based on the premise that if you have a
> non-selinux kernel, and no libselinux installed, the programs
> (pam, coreutils, login etc.) will attempt to dynamically load
> libselinux (with dlopen), find it missing, _won't care_
> and will adapt and proceed knowing that there's no security
> enhancements - i.e. as if they had never been patched to
> deal with selinux in the first place;
>
> whilst if they _do_ detect that libselinux is available, an
> init function is called which returns a pointer to a vector
> table of all the functions needed, which are then used;
>
Does this sound dangerous to anybody else?

This seems pretty harmless on a working se system, but on a non-se system,
I suspect this dependency could be exploited.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
