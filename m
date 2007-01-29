Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0THQWG9020026
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 12:26:32 -0500
Received: from web51511.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l0THRXUJ019993
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 17:27:34 GMT
Date: Mon, 29 Jan 2007 09:27:31 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: missing avc message field names
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1170083582.8720.70.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <49081.83290.qm@web51511.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> >The 4th field could be called "result=".  It has two possible values,
>> >"denied" or "granted".
>> 
>> That could possibly conflict with syscall auditing which has the same
>> field. You could be in permissive mode and have denied by syscall
>> reports success. Maybe "ares", "avcres", "decision", "dec"? Any
>> other suggestions?
>> 
>> >The 6th field could be called "perms=".
>> 
>> That name is already taken also. "aperms=" ?
>
>Why do you need to de-conflict the field names when they occur in
>different types of records (AVC vs. SYSCALL)?

I am creating a data dictionary of field names so that when people see a field
name, they know exactly what it is, what type of data is in it, and what kinds of
messages its likely to show up in. This is also needed for the interpretation of
fields so that each type can be interpretted correctly.

In this case, both of the avc fields we are discussing are text, so its not quite
as important from the interpretation perspective. But I am trying to be
consistent across all message types in order to have a dictionary describing
audit fields.

-Steve


 
____________________________________________________________________________________
Don't pick lemons.
See all the new 2007 cars at Yahoo! Autos.
http://autos.yahoo.com/new_cars.html 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
