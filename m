Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s635TTv8003679
 for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2014 01:29:29 -0400
Received: by mail-pd0-f182.google.com with SMTP id y13so13125313pdi.41
 for <selinux@tycho.nsa.gov>; Wed, 02 Jul 2014 22:29:29 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.17.125])
 by mx.google.com with ESMTPSA id pz10sm39433153pbb.33.2014.07.02.22.29.27
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 02 Jul 2014 22:29:29 -0700 (PDT)
Message-ID: <53B4E97D.20401@gmail.com>
Date: Thu, 03 Jul 2014 10:56:21 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Enforcing default_user, default_role, default_type, default_range
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

These rules are not enforced by the object manager, but does restorecon 
read these?

Also what's the effect of these statements on SELinux aware applications?

Are there tools to list these statements? I didn't find anything in 
sesearch man page, and seinfo is silent on this.
