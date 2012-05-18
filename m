Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4IBMAYp027855
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2012 07:22:10 -0400
Received: by yenl3 with SMTP id l3so2914201yen.12
        for <selinux@tycho.nsa.gov>; Fri, 18 May 2012 04:22:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FB5268F.3010905@redhat.com>
References: <20120516091736.GA10721@siphos.be>
	<4FB5268F.3010905@redhat.com>
Date: Fri, 18 May 2012 13:22:10 +0200
Message-ID: <CAPzO=Nx2SN_7=2-CmEgbmYq=-hRdHDTtvLgv2ZbUuODrVw8QsQ@mail.gmail.com>
Subject: Re: Trying to support Python 3 but fails on libsemanage
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d04478817725fb004c04dc3f2
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d04478817725fb004c04dc3f2
Content-Type: text/plain; charset=ISO-8859-1

On May 17, 2012 6:25 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
> I have not tried to use python3 with semanage yet, did you actually port
the
> python py files to python3?

Yes, and I think that went well (no more failures on print statements or
indentation mismatches), but now I'm quite stuck. I'm going to debug the
libselinux code a bit later (esp. the database handling as that's involved
in this use case) to try and learn about this ;-)

Wkr,
  Sven Vermeulen

--f46d04478817725fb004c04dc3f2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>On May 17, 2012 6:25 PM, &quot;Daniel J Walsh&quot; &lt;<a href=3D"mailt=
o:dwalsh@redhat.com">dwalsh@redhat.com</a>&gt; wrote:<br>
&gt; I have not tried to use python3 with semanage yet, did you actually po=
rt the<br>
&gt; python py files to python3?</p>
<p>Yes, and I think that went well (no more failures on print statements or=
 indentation mismatches), but now I&#39;m quite stuck. I&#39;m going to deb=
ug the libselinux code a bit later (esp. the database handling as that&#39;=
s involved in this use case) to try and learn about this ;-)</p>

<p>Wkr,<br>
=A0 Sven Vermeulen</p>

--f46d04478817725fb004c04dc3f2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
