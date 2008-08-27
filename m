Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7RNWQBH018463
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 19:32:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7RNVuni016514
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 23:31:56 GMT
Message-ID: <48B5E3FF.1090102@redhat.com>
Date: Thu, 28 Aug 2008 09:32:15 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Stephen John Smoogen <smooge@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Introduction" review
References: <48B4EAE2.302@redhat.com> <80d7e4090808270908p1453e001g2c26f8f7b06709f4@mail.gmail.com>
In-Reply-To: <80d7e4090808270908p1453e001g2c26f8f7b06709f4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen John Smoogen wrote:

> Should all (R) be listed at the bottom of the chapter with who owns
> the registered trademark? I only ask because I am trying to figure out
> who has a trademark for the word Enforcement later on.

In the HTML build and on the wiki, there are the following pages:

<http://mdious.fedorapeople.org/drafts/html/chap-SELinux_User_Guide-Important_Trademark_Information.html>
<http://fedoraproject.org/wiki/Docs/Drafts/SELinux_User_Guide/SELinux_Implementation_Phase/Trademarks>

The page was copied from a previous guide, and was first created from 
advice from the legal team here...

> 
>> * Prevention against privilege escalation. Since subjects run in domains,
>> and are therefore separated from each other, and rules determine how
>> subjects access objects and other subjects, if a service is compromised, the
>> attacker only has access to the normal functions of that service, and to
>> files that the service has been configured to have access to. For example,
>> if the Apache HTTP Server is compromised, an attacker is unable to read
>> files in user home directories, unless a specific rule was added or
>> configured to allow such access.
>>
> 
> I worry about the word prevention.. it implies impossibility. Selinux
> discourages privilege escalation but a hole in a policy could still
> allow for privilege escalation.

Great point! I'll work on changing it to something more suitable.

Thanks again.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
