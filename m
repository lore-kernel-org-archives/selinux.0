Message-ID: <45749461.7050405@mentalrootkit.com>
Date: Mon, 04 Dec 2006 16:34:25 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Subject: Re: [RFC] Ability to allow unknown class and permissions
References: <6FE441CD9F0C0C479F2D88F959B015885C82ED@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885C82ED@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
>>
>> Joshua Brindle wrote:

<snip>

>>
>>   Or Why would you need #1 if you have
>>> #2? I thought the config flag was for the kernel..
>> To allow the policy file to be analyzed without external reference.
>>
> 
> Second time analysis was mentioned and still wrong (IMO). You can't
> analyze unknown permissions since the kernel which the kernel is
> inserted into also decides whether the permissions are checked.
> 

But you can tell if unknown permissions will be allowed (and even which 
object classes and permissions for a specific kernel) without reference 
to the _configuration_ of a specific system. You only need to look at 
the policy and the version of the kernel / userspace components. That 
is, in my opinion, an important difference.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
