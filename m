Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7V7s4Xg015402
 for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2016 03:54:04 -0400
Subject: Re: SELinux MLS Policies
To: ileyd <ileyd@icloud.com>, selinux@tycho.nsa.gov
References: <"01e601d202e0$7aaf62d0$700e2870$@a.bolton"@m0noc.net>
 <dcfa502a-a210-2815-33a7-825d905e4be6@tycho.nsa.gov>
 <612965bc-952f-9f95-ca14-7c8a8c6e7b6e@m0noc.net>
 <9D586F02-4DA2-450A-9E31-541A97D554BE@icloud.com>
From: Paul Bolton <paul.a.bolton@m0noc.net>
Message-ID: <d63bb241-6166-57cc-475b-131f509fafbf@m0noc.net>
Date: Wed, 31 Aug 2016 08:53:51 +0100
MIME-Version: 1.0
In-Reply-To: <9D586F02-4DA2-450A-9E31-541A97D554BE@icloud.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 31/08/16 07:37, ileyd wrote:
> 
> Have you managed to correct the incorrect labelling of /etc?  When I've tried to use the MLS policy on RHEL/CentOS 7-7.2, that has stopped logins from working when running in enforcing mode.
> 

So if I turn off the dontaudit rules that issue shows up with
unix_chkpwd and mls_constrain AVCs. Admittedly I did notice it was at
s15 but thought that was intentional. Though, as most of the files in
/etc are at s0 that doesn't sound right.

Anyway, changing /etc to s0 allows logins to work; and looks more like
what I would expect an out-of-the-box MLS system to look like.

Thanks for the advice.


-- 
Paul
----
http://blog.m0noc.com/ | https://keybase.io/m0noc
4329 E4C5 71F3 58B2 2246  D04D 25DA 39C2 3876 FE3D
