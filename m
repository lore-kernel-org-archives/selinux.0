Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4P9PbGv023607
 for <selinux@tycho.nsa.gov>; Sun, 25 May 2014 05:25:37 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so6743935wgg.24
 for <selinux@tycho.nsa.gov>; Sun, 25 May 2014 02:25:37 -0700 (PDT)
Received: from [192.168.1.101] ([84.245.1.4])
 by mx.google.com with ESMTPSA id ba9sm16782047wib.24.2014.05.25.02.25.36
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=RC4-SHA bits=128/128);
 Sun, 25 May 2014 02:25:36 -0700 (PDT)
Message-ID: <1401009935.20666.14.camel@x220.localdomain>
Subject: secilc: issues with policy compiled by secilc
From: Dominick Grift <dominick.grift@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Date: Sun, 25 May 2014 11:25:35 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

You may or may not know that i have been writing some policy using
secilc.

My first endeavor was basically writing policy in CIL the refpolicy way:

https://github.com/doverride/monogam

This policy works *fine*
Note though that i abandoned this and so it is not tested using the
latest secilc revision.

My latest attempt involves using secilc specific techniques like
namespaces/containers. I also use some other ideas in this policy like
defaultrole to override object_r role identifier

This policy is *tested* using the latest available secilc revision.

https://github.com/doverride/bugexamplepolicy

With this latest policy i am encountering issues which are described
here:

https://github.com/doverride/bugexamplepolicy/commit/8948468038509b075960658aa161eab883ff4c94

One of the two issues described in above URL is demo'd here:

http://www.youtube.com/watch?v=g16sj92V3hA&list=UU4xxwsgGTUgFkEHJSQcf7AA

I hope to have provided you with sufficient information to allow you to
identify the issues.

All the source files are there. If you need further information please
do not hesitate to ask.

 
