Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i91J0OrT003963
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 15:00:24 -0400 (EDT)
Message-ID: <415DA941.4050500@redhat.com>
Date: Fri, 01 Oct 2004 15:00:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patch to restorecon to add -R switch
References: <41584DCA.7030006@redhat.com>            <1096484920.3270.13.camel@moss-lions.epoch.ncsc.mil> <200410011828.i91ISrN6018074@turing-police.cc.vt.edu>
In-Reply-To: <200410011828.i91ISrN6018074@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Valdis.Kletnieks@vt.edu wrote:

>On Wed, 29 Sep 2004 15:08:40 EDT, James Carter said:
>  
>
>>Everything looks fine, but why does all the output just go to the log
>>file now?  
>>    
>>
>
>  
>
>>>-	rpm -q -l $i | restorecon ${OUTFILES} -n -v -f - 2>&1 | tee $LOGFILE
>>>+	rpm -q -l $i | restorecon ${OUTFILES} -n -v -f - 2>&1 > $LOGFILE
>>>      
>>>
>
>That (and a few other places '| tee' was removed) is the technical reason
>why it goes to the logfile only.  Dan would have to address the logic behind why
>the change was made.
>  
>
It was changed because the the messages were flooding the roots mailer 
and if you ran fixfiles by hand, it would slow down the process
if you were on a slow terminal.  You can still see the output by doing a 
fixfiles -l `tty`

I think this all needs a redesign,  maybe to write its output to syslog, 
but am trying to get test3 out the door now.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
