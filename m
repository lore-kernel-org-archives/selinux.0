Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA03796
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2001 19:09:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA26975
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 00:09:39 GMT
Received: from localhost.localdomain ([63.227.56.162])
	by jazzswing.ncsc.mil  with ESMTP id AAA26971
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 00:09:38 GMT
Date: Wed, 7 Nov 2001 17:06:22 -0700 (MST)
From: Dave Nielsen <dave@technogeeks.com>
To: Yanni Kouskoulas <Yanni.Kouskoulas@jhuapl.edu>
cc: "Timothy E. Kohler" <tim@odo.arl.psu.edu>, <selinux@tycho.nsa.gov>
Subject: Re: New SELinux release???
In-Reply-To: <Pine.LNX.4.21.0111071225280.2187-100000@kouskya1.jhuapl.edu>
Message-ID: <Pine.LNX.4.33.0111071703080.17677-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Have you done the Redhat 7.2 Glib updates on these machines???

I have only done the 1st part on my test machine (laptop) with redhat 7.2
but I did apply the glib update 1st.

Tonight I will do the rest. I just might not have gotten to this error as
of yet.

Dave

On Wed, 7 Nov 2001, Yanni Kouskoulas wrote:

|Having now installed the latest selinux on multiple RH7.2 systems, I
|should amend the information in my last e-mail. The errors varies
|depending on what else has been installed.
|
|If the RH7.2 installation gives an error saying that AM_GNU_GETTEXT is
|undefined, then the response given in my previous e-mail is appropriate.
|There are some other tweaks, but those are the main ones.
|
|If the RH7.2 installation gives an error saying that AC_ISC_POSIX is
|multiply defined, then the response is different: zero that file out
|(isc-posix.m4) and it will subsequently complains that config.guess and
|config.sub are missing. Copy these files from the sh-utils directory, and
|that should get people past that part of the compile.
|
|Hope this helps clear up more confusion than it creates.
|
|-Yanni
|
|
|--
|You have received this message because you are subscribed to the selinux list.
|If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
|the words "unsubscribe selinux" without quotes as the message.
|


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
