Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nB22clSq028513
	for <selinux@tycho.nsa.gov>; Tue, 1 Dec 2009 21:38:47 -0500
Received: from smtp105.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id nB22beD1024945
	for <selinux@tycho.nsa.gov>; Wed, 2 Dec 2009 02:37:41 GMT
Message-ID: <4B15D331.7090903@schaufler-ca.com>
Date: Tue, 01 Dec 2009 18:38:41 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
CC: "David P. Quigley" <dpquigl@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        selinux@tycho.nsa.gov, "George S. Coker, II" <gscoker@alpha.ncsc.mil>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] Dynamic port labeling V2
References: <1259616460.2444.9.camel@moss-stripedbass.epoch.ncsc.mil>	 <4B14A111.2000703@schaufler-ca.com>	 <1259679974.2365.29.camel@moss-terrapins.epoch.ncsc.mil> <1259681350.2444.20.camel@moss-stripedbass.epoch.ncsc.mil>
In-Reply-To: <1259681350.2444.20.camel@moss-stripedbass.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Nuzzi wrote:
> Dave brought up some good questions.

He often does. He's like that.

>  A pseudo file-system based on ports
> seems like a good idea but I think there is going be scaling issues.
>   

I'm curious what those scaling issues might be, given the success
of /proc which deals with many processes.

> SELinux also supports multiple labels for ports.

Is there a fixed set? There's no reason you couldn't do what Smack
does with sockets, which is multiple well known attribute names.
That will work even if there isn't a fixed set, come to think of
it.

>  Port 22 can be labeled
> as ssh_port and if the label is removed, reverts to reserved_port. Do
> you know of a way xattrs can handle this? 
>   

setxattr SELINIX_PORTXATTR_UNLABELED_CONTEXT reserved_port
setxattr SELINIX_PORTXATTR_CONTEXT ssh_port

if you delete the SELINIX_PORTXATTR_CONTEXT attribute it gets
reset to SELINIX_PORTXATTR_UNLABELED_CONTEXT. Simple.

> On Tue, 2009-12-01 at 10:06 -0500, David P. Quigley wrote:
>   
>> I have several questions about this.
>>
>> 1) Where is it located?
>>     

Don't know, don't much care. /sys or /sysfs or /security or /dev.

>> 2) Is your proposal to implement it as a new fs with a name something
>> like portfs?
>>     

Yes. Alternatively it could be an extension to an existing special
purpose filesystem, but I don't have a favorite candidate.

>> 3) How does it get populated initially? Do you have a file for each port
>> right off the bat? Do you only have files for ports with policy or whose
>> permissions differ from the default?
>>     

I like the notion of populating it all at once, but I expect
that there are those who'd holler for doing in on demand.

>> 4) How do I assign a label to the port? You have an issue here that
>> these files are objects themselves. You can't just label the file with
>> what you want the port labeled because now you can't mediate access to
>> these file objects outside of the label on the port itself.
>>     

On some systems you could in fact put the label of the bound process
on the object and be very happy, but I understand that SELinux is
not an example of such a system.

Put as many xattrs on the object as you like and let the LSM decide
which matters to what purpose. setxattr to put labels explicitly on
the port, and the LSM gets to decide what xattr to put on the port
when it is bound or closed. Of course, there will need to be a way
to associate the portfs entry with the port (I don't know, maybe the
port number gets you the inode number as /proc maps pid to inode?)
Yes, that implies LSM specific code in portfs, or maybe portfs
specific code in the LSM. Smack already treats attribute setting
specially on socket fd's, and it's not so terrible.

>> On Mon, 2009-11-30 at 20:52 -0800, Casey Schaufler wrote:
>>     
>>> Paul Nuzzi wrote:
>>>       
>>>> Second version of the dynamic port labeling patch.
>>>>         
>>> So I've looked through both versions of this patch and I can't
>>> help but think that you'd get better mileage out of a file system
>>> interface than this SELinux specific implementation. If you had
>>> something like
>>>
>>>     /port/22
>>>
>>> with default owner root and mode rw-------
>>>
>>>     /port/3306
>>>
>>> with default owner root and mode rw-rw-rw-
>>>
>>> you could address a bunch of the complaints about port ownership that
>>> you hear every day. Further, if the port filesystem supported xattrs
>>> you could tie in SELinux as easily as you are doing it below and get
>>> Smack for an extra $1.98, not to mention saving every other LSM the
>>> grief of defining Yet Another way to define port accesses.
>>>
>>> It bothers me that there is a perfectly reasonable way to provide the
>>> specific behavior you're looking for (SELinux label on a port) that
>>> generalizes so cleanly and that it's not being proposed.
>>>
>>>
>>>       
>>>>   Changed the name of
>>>> the selinuxfs interface to portcon and changed the interface to only
>>>> allow five arguments instead of the variable four or five.   
>>>>
>>>> Added a mechanism to add/delete/update port labels with an interface in 
>>>> the selinuxfs filesystem.  This will give administrators the ability to
>>>> update port labels faster than reloading the entire policy with
>>>> semanage.  The administrator will also need less privilege since they
>>>> don't have to be authorized to reload the full policy.
>>>>
>>>> A listing of all port labels will be output if the file /selinux/portcon
>>>> is read.  Labels could be added or deleted with the following commands 
>>>>
>>>> echo -n "del system_u:object_r:ssh_port_t:s0 6 22 22" > /selinux/portcon
>>>> echo -n "add system_u:object_r:telnetd_port_t:s0 6 22 22" > /selinux/portcon
>>>>
>>>> Labels can be atomically changed with the add command.  
>>>>
>>>>
>>>> Signed-off-by: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
>>>>
>>>>         
>
>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
