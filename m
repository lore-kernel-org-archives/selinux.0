Message-ID: <43CE6261.8030204@redhat.com>
Date: Wed, 18 Jan 2006 10:44:33 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest policycoreutils patch
References: <43CD54B9.4030307@redhat.com> <43CD9BDE.8010005@tresys.com> <43CDB89C.4030608@redhat.com> <43CDB8DF.9070100@tresys.com> <43CDBA95.8020308@redhat.com> <43CDBB35.6020209@tresys.com> <43CDE7ED.4020908@cornell.edu>
In-Reply-To: <43CDE7ED.4020908@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>>
>> sounds like the direct_api in libsemanage needs to return an error if 
>> it doesn't think it'll be able to write to the policy store (at 
>> transaction start time, or maybe on request) , and semanage can 
>> handle it gracefully. That way only direct connections are affected 
>> and semanage won't show users any nasty failures.
> It does return a failure... you mean a more specific one?
> Current failure could be for many reasons, and it also writes to the 
> ERR stream complaining about it..
>
Nasty errors when trying to run as a normal user.  Are not pretty.

 python chcat -L -l dwalsh
libsemanage.semanage_create_store: Could not access module store at 
/etc/selinux/targeted/modules, or it is not a directory.
libsemanage.assert_init: A direct or server connection is needed to use 
this function - please call the corresponding connect() method
libsemanage.enter_ro: could not enter read-only section
Traceback (most recent call last):
  File "chcat", line 366, in ?
    sys.exit(listusercats(cmds))
  File "chcat", line 303, in listusercats
    seusers = seobject.loginRecords().get_all()
  File "/usr/lib/python2.4/site-packages/seobject.py", line 175, in get_all
    raise ValueError("Could not list login mappings")
ValueError: Could not list login mappings


This needs to be legal.  What is happening to cause this problem?  Or do 
I need to code around this by reading the seusers file?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
