Message-ID: <45BE3DDA.4050909@mentalrootkit.com>
Date: Mon, 29 Jan 2007 13:32:58 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Steve G <linux_4ever@yahoo.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: missing avc message field names
References: <49081.83290.qm@web51511.mail.yahoo.com>
In-Reply-To: <49081.83290.qm@web51511.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve G wrote:
>>>> The 4th field could be called "result=".  It has two possible values,
>>>> "denied" or "granted".
>>> That could possibly conflict with syscall auditing which has the same
>>> field. You could be in permissive mode and have denied by syscall
>>> reports success. Maybe "ares", "avcres", "decision", "dec"? Any
>>> other suggestions?
>>>
>>>> The 6th field could be called "perms=".
>>> That name is already taken also. "aperms=" ?
>> Why do you need to de-conflict the field names when they occur in
>> different types of records (AVC vs. SYSCALL)?
> 
> I am creating a data dictionary of field names so that when people see a field
> name, they know exactly what it is, what type of data is in it, and what kinds of
> messages its likely to show up in. This is also needed for the interpretation of
> fields so that each type can be interpretted correctly.
> 
> In this case, both of the avc fields we are discussing are text, so its not quite
> as important from the interpretation perspective. But I am trying to be
> consistent across all message types in order to have a dictionary describing
> audit fields.
> 

I think that it is easier to have unambiguous names across all message 
types, particularly if people are trying to correlate data from multiple 
messages.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
