Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3M625SD029996
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 02:02:05 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so4552754pbc.37
 for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2014 23:02:04 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.93.83])
 by mx.google.com with ESMTPSA id te2sm196647048pac.25.2014.04.21.23.02.02
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 21 Apr 2014 23:02:03 -0700 (PDT)
Message-ID: <5356053E.9080302@gmail.com>
Date: Tue, 22 Apr 2014 11:29:26 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Cannot enable selinux.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I've SECURITY_SELINUX enabled on my custom kernel, however on mounting 
with selinuxfs --

mount: unknown filesystem type 'selinuxfs'

As a result, I cant get sestatus enabled.
