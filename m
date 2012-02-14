Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1EFTSqX026936
	for <selinux@tycho.nsa.gov>; Tue, 14 Feb 2012 10:29:33 -0500
Received: from qmta03.westchester.pa.mail.comcast.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q1EFTRte012108
	for <selinux@tycho.nsa.gov>; Tue, 14 Feb 2012 15:29:27 GMT
Message-ID: <4F3A7DCB.3070208@tresys.com>
Date: Tue, 14 Feb 2012 10:29:15 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Julian Onions <Julian.Onions@nexor.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Building multiple custom modules
References: <36039C79EF8CEC4EA97F96D6B85706420C76E3B1@AMSPRD0302MB107.eurprd03.prod.outlook.com>
In-Reply-To: <36039C79EF8CEC4EA97F96D6B85706420C76E3B1@AMSPRD0302MB107.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2/13/2012 10:04 AM, Julian Onions wrote:
> I’m working on a policy for an application made of several modules. I’d really like the policy to use the other modules interface files.
>
> The standard Makefile for policy building (/usr/share/selinux/devel/Makefile) doesn’t seem to let you include your own .if files, unless they are under /usr/share/selinux/devel/include or alternatively in the current directory (in which case it needs .te files too).
>
> Is there any way to convince it I’d like files that I’m building in project/C/policy to reference the .if files in project/B/policy and project/A/policy without copying them all to project/C/policy?

You should be able to this, with this structure:

policy/layerA/foo.{te,if,fc}
policy/layerB/bar.{te,if,fc}

and then you run the make from the top level (the directory that has the directory named "policy").  BTW, the more appropriate place to ask this type of question would be the Reference Policy list.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
