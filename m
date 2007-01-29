Message-ID: <45BE3F69.1000508@mentalrootkit.com>
Date: Mon, 29 Jan 2007 13:39:37 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Steve G <linux_4ever@yahoo.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: missing avc message field names
References: <20070129150941.41400.qmail@web51505.mail.yahoo.com>
In-Reply-To: <20070129150941.41400.qmail@web51505.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve G wrote:
>> I don't think it is "impossible", but it would require updating of e.g.
>> audit2allow, audit2why, madison/sepolgen, setroubleshoot and seaudit
>> (setools).
> 
> At some point, I'm hoping all those tools can migrate to this new API. This is to
> insulate them from other changes that are coming like zlib compression and/or
> binary formats.
> 
>> Are you proposing changing the raw kernel output format as well, or just
>> the auditd-generated output format?
> 
> The audit daemon shouldn't really do any changing. It really should just log
> exactly what it gets. If we agree that this can be changed, what we could do is
> wait until the next kernel development cycle and then make this change (this
> allows for some migration time). I can special case the avc message for a while
> so there is some backwards compatibility.
> 

I think that having the audit library available is a good idea to make 
it easier to make changes to the audit data. However, there is no way 
that all tools will migrate by the time the next kernel cycle comes 
around. I actually wouldn't count on everyone moving *ever* and would 
assume that any format change will cause breakage.

If you have to include code for parsing the current format, why the rush 
to change the kernel output? Why not just wait until there is a more 
pressing reason to make the change? That will give the library time to 
gain acceptance and will make any changes less painful.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
