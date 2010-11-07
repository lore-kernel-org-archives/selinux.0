Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA7Ee0FV001235
	for <selinux@tycho.nsa.gov>; Sun, 7 Nov 2010 09:40:00 -0500
Received: from c-sl428.itechfrontiers.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oA7Edx6w005217
	for <selinux@tycho.nsa.gov>; Sun, 7 Nov 2010 14:39:59 GMT
Message-ID: <4CD6BA38.10202@itechfrontiers.com>
Date: Sun, 07 Nov 2010 09:39:52 -0500
From: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: Behnaz Hassanshahi <behnaz.kallen@yahoo.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: temporal role base access control in Linux
References: <182838.53024.qm@web110814.mail.gq1.yahoo.com>
In-Reply-To: <182838.53024.qm@web110814.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

avc_has perm()  is for checking if permissions are granted or not 
(Access Vector Cache),

A proper method of extending security functionality would be using LSM 
APIs and SELinux Hooks  (LSM: Linux Security Module)

http://www.nsa.gov/research/_files/selinux/papers/module/x280.shtml

But TRBAC can be simulated with SELinux even without writing specific 
code or modifying SELinux, by combining appropriate predefined set of 
policies and a scheduler process or hierarchical scheduler with enough 
(higher) privileges to load policies on the fly,

Of course if such usage does not need atomic role/policy entry (I don't 
see any practical use for such atomic role entry anyway)

You can find more on implementation here:
http://selinuxproject.org/page/NB_LSM


I'm sorry but with all due respects, I don't know if helping people in 
Iran on the subject is legal or not (I'm not a Lawyer) but judging from 
sources of your mail (which is Iran), I prefer not to be involved in any 
particular help.

Anyway this is a project develped primarily by the National Security 
Agency of the USA, and its contributors.



Yours,

Patrick K.




On 11/7/2010 7:20 AM, Behnaz Hassanshahi wrote:
> Hi,
> I want to enforce temporal role base access control to Fedora10
> platform. Therefore, I have written a piece of code which receives
> simple temporal policy rules and updates a file in which disallowed
> roles are being kept. In order to attach the code to the fedora core, I
> am making use of SELinux modules. I wonder if avc_has_perm(...) function
> in /libselinex/src/avc.c can be the right place for using my code where
> requests will be granted or denied access. Actually, I had thought about
> getting the role field from the security_id_t (@ssid) and compare it
> with the denied roles that my code computes. If I`m wrong and this will
> not work out, is there any other suggestions for attaching my code to
> SELinux?
>
> Best regards,
> Behnaz
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
