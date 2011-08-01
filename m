Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p71FWg6M020881
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 11:32:42 -0400
Received: from mail-ey0-f174.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p71FWfhH009131
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 15:32:41 GMT
Received: by eyx24 with SMTP id 24so6683249eyx.33
        for <selinux@tycho.nsa.gov>; Mon, 01 Aug 2011 08:32:40 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 1 Aug 2011 10:32:40 -0500
Message-ID: <CAFPpqQEYmrYQWDS8t0Y2DcF3jXoyO=2f929jNuvFKyXjNG=OhQ@mail.gmail.com>
Subject: chown affecting type_transition?
From: Ted Toth <txtoth@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=0015174c40c4798a3604a9735776
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0015174c40c4798a3604a9735776
Content-Type: text/plain; charset=ISO-8859-1

I'm writing policy for some scripts. Script 'a' runs script 'b' and they
each have their own entry file and domain type. There is a type transition
for a_t through b_exec_t to b_t in the policy. However the transition
doesn't happen. Script 'a' does a chown on script 'b' prior to running it.
If I remove the chown the transition does happen as expected. Can chown
somehow affect the file label? 'ls -Z' doesn't show any change.

Ted

--0015174c40c4798a3604a9735776
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I&#39;m writing policy for some scripts. Script &#39;a&#39; runs script &#3=
9;b&#39; and they each have their own entry file and domain type. There is =
a type transition for a_t through b_exec_t to b_t in the policy. However th=
e transition doesn&#39;t happen. Script &#39;a&#39; does a chown on script =
&#39;b&#39; prior to running it. If I remove the chown the transition does =
happen as expected. Can chown somehow affect the file label? &#39;ls -Z&#39=
; doesn&#39;t show any change.<br>
<br>Ted<br>

--0015174c40c4798a3604a9735776--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
