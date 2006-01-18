Message-ID: <43CE824E.6010904@cornell.edu>
Date: Wed, 18 Jan 2006 11:00:46 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest policycoreutils patch
References: <43CD54B9.4030307@redhat.com> <43CD9BDE.8010005@tresys.com> <43CDB89C.4030608@redhat.com> <43CDB8DF.9070100@tresys.com> <43CDBA95.8020308@redhat.com> <43CDBB35.6020209@tresys.com> <43CDE7ED.4020908@cornell.edu> <43CE6261.8030204@redhat.com>
In-Reply-To: <43CE6261.8030204@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> python chcat -L -l dwalsh
> libsemanage.semanage_create_store: Could not access module store at 
> /etc/selinux/targeted/modules, or it is not a directory.
> libsemanage.assert_init: A direct or server connection is needed to 
> use this function - please call the corresponding connect() method
> libsemanage.enter_ro: could not enter read-only section
> Traceback (most recent call last):
>  File "chcat", line 366, in ?
>    sys.exit(listusercats(cmds))
>  File "chcat", line 303, in listusercats
>    seusers = seobject.loginRecords().get_all()
>  File "/usr/lib/python2.4/site-packages/seobject.py", line 175, in 
> get_all
>    raise ValueError("Could not list login mappings")
> ValueError: Could not list login mappings
>
>
> This needs to be legal.  What is happening to cause this problem?  Or 
> do I need to code around this by reading the seusers file?
It's a permissions problem - you have to be root to create the store, 
because you're writing to /etc/selinux/targeted/modules (or reading from 
it, it doesn't really matter), and at least on my machine all folders 
and files under that folder are owned by root, and not writable/readable 
by anyone else. Of course, it should fail on connect  and stop there, 
but you're still not checking rc values where necessary.

Btw, it seems that handle_create can also fail in a variety of ways, 
while that is undocumented in the headers - should change the headers. 
It returns NULL on failure.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
