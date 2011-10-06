Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9692FNb004228
	for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2011 05:02:15 -0400
Received: from c-sl428.itechfrontiers.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p9692E1d019049
	for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2011 09:02:14 GMT
Message-ID: <4E8D6E84.9090407@itechfrontiers.com>
Date: Thu, 06 Oct 2011 05:01:56 -0400
From: "Patrick K., ITF" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: Hramchenko <hramchenko@bk.ru>
CC: selinux@tycho.nsa.gov
Subject: Re: New HIPS based on SELinux
References: <201110060030.05639.hramchenko@bk.ru>
In-Reply-To: <201110060030.05639.hramchenko@bk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I think you are misusing the term "HIPS" here, (or using your own 
definition actually)

Sorry to be pedantic but, SELinux as you know is an add-on (platform
) to the kernel providing Access Control (RBAC, IBAC, MAC and etc.) and 
MLS (Multi-Level Security)

While encouraging you for your work but I'm afraid it is as you 
explained yourself:

" User Data Defence includes set of template policies, which makes 
process of creation SELinux specifications for user mode applications 
simple .... "

in other words, It is A Graphical user Interface for creating SELinux 
Policies


BUT, Host based Intrusion Prevention System,  (HIPS)

or more accurately Host Based Intrusion Detection and Prevention System 
(HIDPS) requires a method to detect attacks and react upon them or 
interact with them (Preemptive approach), taking into account the server 
or workstation parameters and conditions, utilizing either or 
combination of :

1) Signature based analysis of threats


2) Anomaly based analysis of threats against the server,
in example statistical analysis, Integrity analysis and etc.


3) Protocol Anomaly Analysis


4) Heuristic analysis
combination of methods  using Expert systems or other means in 
Artificial Intelligence/Synthetic Intelligence  such as Petri nets, 
Artificial Neural Networks and etc.


Best Regards,

Patrick K.


On 10/5/2011 2:30 PM, Hramchenko wrote:
> Hi all.
>
> I have created new host intrusion prevention system based on SELinux.
> It's focused on protection user's data.
> One of the main goals was to create lightweight replacement of
> setroubleshootd.
>
> I hope my program will be useful for SELinux users.
>
> The project home page:
> https://github.com/Hramchenko/userdatadefence/
>
> With respect, Hramchenko Vitaliy.
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
