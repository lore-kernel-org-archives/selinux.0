Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3KJaK7l010950
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 15:36:21 -0400
Received: from mailhub4.stratus.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3KJaKOt016094
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 19:36:20 GMT
Subject: Re: genhomedircon errors with NIS
From: Bandan Das <bandan.das@stratus.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>,
        "Johnson, Richard" <Richard.Johnson@stratus.com>
In-Reply-To: <49ECC813.5050403@redhat.com>
References: <1240253643.7743.78.camel@BSD.mno.stratus.com>
	 <49ECC813.5050403@redhat.com>
Content-Type: text/plain
Date: Mon, 20 Apr 2009 15:36:05 -0400
Message-Id: <1240256165.7743.92.camel@BSD.mno.stratus.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-04-20 at 15:08 -0400, Daniel J Walsh wrote:
> On 04/20/2009 02:54 PM, Bandan Das wrote:
> > Hello,
> >
> > This is a RHEL 5.3 system with SELinux configured in the targeted mode.
> > Whenever genhomedircon is invoked, either as part of loading a new
> > policy module or anything else, genhomedircon will report errors going
> > through the NIS database :
> >
> > bdas homedir /h/bdas or its parent directory conflicts with a
> > defined context in /etc/selinux/targeted/contexts/files/file_contexts,
> > /usr/sbin/genhomedircon will not create a new context. This usually
> > indicates an incorrectly defined system account.  If it is a system
> > account please make sure its login shell is /sbin/nologin.
> >
> > /h is where the NIS home directory is automounted and the above message
> > appears for all the NIS users.
> >
> > As expected, running genhomedircon manually with the "-n" switch will
> > not spew these messages. If I look at file_contexts, I do not find any
> > specified context for /h.
> >
> >
> > Any ideas ?
> >
> >
> >
> genhomedircon is trying to label the directory above /h "/" to be 
> home_root_t.  It sees this directory and complains.  I think the problem 
> here is you actually have a user /h.  
I am sure I don't have a user "/h" on my local system. I also did a
"ypcat passwd" and scanned all the users to see if there is anyone with
name "h" or "\h". 

> What does the homedir of one of 
> the users look like?
Do you mean on the NIS server ?
Here is one of the entries from "ypcat passwd" :

name:x:22832:263:First Last:/h/name:/bin/tcsh

> We have the ability to disable genhomedircon in Fedora 10 and beyond.
> 
Can I somehow prevent genhomedircon from touching /h at all ? Using the
"-n" switch does make things different but I am not sure if it's going
to create any other problems.

Rich, I had found another similar bug :
https://bugzilla.redhat.com/show_bug.cgi?id=186594 but it appears to be
a different problem.

Thanks!
Bandan

-- 
BSD


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
