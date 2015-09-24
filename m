Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8O4gp6w024107
 for <selinux@tycho.nsa.gov>; Thu, 24 Sep 2015 00:42:51 -0400
To: selinux@tycho.nsa.gov
From: Dan <dtdevore64@yahoo.com>
Subject: Cil Macros
Message-ID: <56037F3F.4050200@yahoo.com>
Date: Thu, 24 Sep 2015 00:42:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello everyone, I've been trying to play around with macros with the CIL 
language and have come across some problems on how they work. I'm just 
trying to simple create a macro that will do a type transition with a 
process called mytest_t domain.

Here is what I have so far:




(macro mytest_t_domain_auto_trans ((ARG1))
   (typeattributeset cil_gen_require application_domain_type)
   (call domain_trans (ARG1))
   (allow ARG1 mytest_t (process (exec read write getattr transition)))
)



...but when I try to run it it obviously doesn't work. If anyone has any 
input on what I am doing wrong I'm all ears. Thanks.
