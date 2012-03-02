MIME-Version: 1.0
From: =?ISO-8859-1?Q?Kovacsics_R=F3bert?= <kovirobi@gmail.com>
Date: Fri, 2 Mar 2012 23:00:26 +0000
Message-ID: <CABPkNKmytMBPwsY_HV5YLbaBzTThGY1KaRFkD0ujt7h1ReA6yA@mail.gmail.com>
Subject: SETools not compiling, refpolicy modules not loading
To: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

It is me again, and after compiling SELinux, I went on to try to
compile SETools, as I read, stuff like audit2allow needs it because of
the python, so anyway it does not want to compile, saying that
"checking for corrected libsepol boolean expand behavior... configure:
error: this version of libsepol is incompatible with SETools", and I
have the latest SELinux, downloaded from the website. I did also try
with the latest SETools downloaded from SVN.

Also, another problem I have been having, is that when I try to load
refpolicy, it uses a lot of CPU (about the amount required for
compilation, then it just hangs there with low CPU after 5 minutes,
and anything I do to it ends with segfault.

Thank you for helping me,
Kovacsics Robert

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
