Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7HEUwYd005141
	for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 10:30:58 -0400
Received: from mail-iy0-f173.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7HEUvU6005943
	for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 14:30:58 GMT
Received: by iyk2 with SMTP id 2so2010065iyk.32
        for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 07:30:57 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 17 Aug 2011 09:30:57 -0500
Message-ID: <CAFPpqQEqJChweFaz-HyKVoUeBoL4ibER-dz=+p-FKYczyEFBKg@mail.gmail.com>
Subject: su vs runuser
From: Ted Toth <txtoth@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/alternative; boundary=0015176f0f343378f504aab458e1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0015176f0f343378f504aab458e1
Content-Type: text/plain; charset=ISO-8859-1

I've read that I should use runuser instead of su and I was having a problem
getting a script to transition properly until I changed it to use runuser
but I'm not clear on why this is. Can someone help me with an elevator
speech that I can use when trying to explain this to others?

Ted

--0015176f0f343378f504aab458e1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I&#39;ve read that I should use runuser instead of su and I was having a pr=
oblem getting a script to transition properly until I changed it to use run=
user but I&#39;m not clear on why this is. Can someone help me with an elev=
ator speech that I can use when trying to explain this to others?<br>
<br>Ted<br>

--0015176f0f343378f504aab458e1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
