Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9CCw7ju010300
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 08:58:07 -0400
Received: from c-sl428.itechfrontiers.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p9CCw4MM000052
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 12:58:04 GMT
Message-ID: <4E958ED0.9030306@itechfrontiers.com>
Date: Wed, 12 Oct 2011 08:57:52 -0400
From: "Patrick K., ITF" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: Jason Axelson <jaxelson@referentia.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Writing a program to monitor the SELinux log
References: <CAC9ii1q_EKnM+akoiApESQfcERYKOx+nxX7iurVPbmrgrvd2Cg@mail.gmail.com>
In-Reply-To: <CAC9ii1q_EKnM+akoiApESQfcERYKOx+nxX7iurVPbmrgrvd2Cg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Jason,

I believe you actually gave the answer yourself,

SeTroubleShoot tends to achieve exactly what you want, with much less 
effort if you program in Python,

you can add your plugins,

the raw processing approach requires more effort to achieve what 
SeTroubleshoot already established

Which one is "better" actually depends on what you want to achieve, your 
deadline and programming/scripting language that you want to work with

Sincerely,

Patrick K.

On 10/11/2011 11:07 PM, Jason Axelson wrote:
> Hi,
>
> I am writing a program that will monitor the SELinux log for AVC violations
> and deal with them appropriately. Currently I am looking at approaches to
> monitor the SELinux log.
>
> One approach is to do raw monitoring of /var/log/audit/audit.log with
> something like:
>      tail -f /var/log/audit/audit.log | ausearch -m avc
>
> A second approach may be to implement an SETroubleShoot plugin:
> https://fedorahosted.org/setroubleshoot/wiki/SETroubleShoot%20Overview
>
> I'm kind of leaning towards an SETroubleShoot plugin since it seems like less
> new development and the infrastructure seems to be already there.
>
> Is this a valid approach? Is there a better way?
>
> Thanks,
> Jason
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
