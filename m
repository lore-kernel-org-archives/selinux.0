Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3S89Ced028103
 for <selinux@tycho.nsa.gov>; Mon, 28 Apr 2014 04:09:12 -0400
Received: by mail-pa0-f50.google.com with SMTP id rd3so5545025pab.9
 for <selinux@tycho.nsa.gov>; Mon, 28 Apr 2014 01:09:12 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.94.231])
 by mx.google.com with ESMTPSA id sy2sm33178519pbc.28.2014.04.28.01.09.10
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 28 Apr 2014 01:09:11 -0700 (PDT)
Message-ID: <535E0C0A.1000501@gmail.com>
Date: Mon, 28 Apr 2014 13:36:34 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: No chance of using SELinux on rootfs without security namespace?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I just realized -- my rootfs doesn't support xattr (reiser4).

Is there any chance I can use SELinux?
