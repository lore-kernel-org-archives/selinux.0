Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8FIeRUI018377
 for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2015 14:41:07 -0400
Received: by wicfx3 with SMTP id fx3so39679025wic.0
 for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2015 11:41:02 -0700 (PDT)
MIME-Version: 1.0
From: Divya Vyas <dvyas@mvista.com>
Date: Wed, 16 Sep 2015 00:10:42 +0530
Message-ID: <CA+=dQ-8o9gDb9s-Y2m5TzQ-m3yueq=aSOjJPhi2aoRD7r3+o3w@mail.gmail.com>
Subject: Neverallow in http policy
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c26bc61adaf7051fcd860c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c26bc61adaf7051fcd860c
Content-Type: text/plain; charset=UTF-8

Hi,

How do I write a policy rule to stop http server reading /etc/passwd file.

neverallow ~can_read_shadow_passwords httpd_t:file read;

Will this work?

--001a11c26bc61adaf7051fcd860c
Content-Type: text/html; charset=UTF-8

<div dir="ltr"><div>Hi,<br><br></div>How do I write a policy rule to stop http server reading /etc/passwd file.<br><pre>neverallow ~can_read_shadow_passwords httpd_t:file read;
</pre>Will this work? <br><br><br></div>

--001a11c26bc61adaf7051fcd860c--
