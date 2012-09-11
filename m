Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8BKOCrJ013105
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2012 16:24:12 -0400
Received: by wibhm2 with SMTP id hm2so3242390wib.0
        for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2012 13:24:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAN93RkJ63JnR-ajfVtKx772+NsFT=-P2_L7Cv3cr4rEAJxMYDg@mail.gmail.com>
References: <CAN93RkJ63JnR-ajfVtKx772+NsFT=-P2_L7Cv3cr4rEAJxMYDg@mail.gmail.com>
From: Cesar Maiorino <cesar.maiorino@gmail.com>
Date: Tue, 11 Sep 2012 16:23:30 -0400
Message-ID: <CAN93Rk+Q1QSftoKtV=kiJ7gUqq8V-C6uJJmibeUQhjR5-AgiAw@mail.gmail.com>
Subject: Problem with SEManager app on Seandroid 4.0.4
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=00504502d53164b97104c972db38
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00504502d53164b97104c972db38
Content-Type: text/plain; charset=ISO-8859-1

I finally got a version of seandroid (4.0.4) running on my Qualcomm MSM8960
Mobile Development Platform. This required some manual intervention as the
patch files did not all apply cleanly, so it's possible that I've messed
something up in the process.

That being said, the SEManager app does not let me change any settings
aside from toggling "MAC Mode" on and off. So I can't change '"SELinux
Mode" (stuck in permissive), and I can't change any of the Booleans.

AVC and MAC logging seem to be working.

Any ideas?

--00504502d53164b97104c972db38
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I finally got a version of seandroid (4.0.4) running on my Qualcomm MSM8960=
 Mobile Development Platform. This required some manual intervention as the=
 patch files did not all apply cleanly, so it&#39;s possible that I&#39;ve =
messed something up in the process.<br>

<div class=3D"gmail_quote">
<br>That being said, the SEManager app does not let me change any settings =
aside from toggling &quot;MAC Mode&quot; on and off. So I can&#39;t change =
&#39;&quot;SELinux Mode&quot; (stuck in permissive), and I can&#39;t change=
 any of the Booleans.<br>


<br>AVC and MAC logging seem to be working.<br><br>Any ideas?<br>
</div><br>

--00504502d53164b97104c972db38--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
