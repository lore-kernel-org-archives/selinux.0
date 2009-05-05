Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n45KC8h6025017
	for <selinux@tycho.nsa.gov>; Tue, 5 May 2009 16:12:08 -0400
Received: from mailhub4.stratus.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n45KC8c8008654
	for <selinux@tycho.nsa.gov>; Tue, 5 May 2009 20:12:08 GMT
Subject: Re: Using interfaces defined elsewhere
From: Bandan Das <bandan.das@stratus.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>,
        "Johnson, Richard" <Richard.Johnson@stratus.com>
In-Reply-To: <4A009A68.9000101@redhat.com>
References: <1241551556.23813.80.camel@BSD.mno.stratus.com>
	 <4A009A68.9000101@redhat.com>
Content-Type: text/plain
Date: Tue, 05 May 2009 16:11:52 -0400
Message-Id: <1241554312.23813.87.camel@BSD.mno.stratus.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-05-05 at 15:58 -0400, Daniel J Walsh wrote:
> On 05/05/2009 03:25 PM, Bandan Das wrote:
> > Hello,
> >
> > Here's what I am trying to do :
> >
> > I have a mySNMP policy with sources: mysnmp.te mysnmp.fc mysnmp.if and a
> > dummyapp policy with sources: dummyapp.te dummyapp.fc and dummyapp.if.
> > The SNMP policy interface file has an interface called
> > mysnmp_config_read_access() and I would like to use it in my dummyapp
> > policy sources : mysnmp_config_read_access(dummyapp_t)
> >
> > What's the best way to do this ? Not just for the above example for a
> > case where I have multiple custom interface files.
> >
> > I tried copying the SNMP interface file
> > to /usr/share/selinux/include/mysnmp. But the problem with this approach
> > is that I have to be root to be able to do this. Can I ask make to use
> > multiple interface files (dummyapp.if and mysnmp.if) when compiling the
> > dummyapp policy module ?
> >
> > Thanks,
> > Bandan
> >
> >
> The make file will also look in the current directory for .if files.

So, that means every time I compile a new module that uses custom
interfaces that are defined in separate if files, I will have to copy
over all these interface files to the current directory.  

I think a better approach would be to ask make to look at a specific
location for interface files. But, then I didn't want to alter the
makefile. So, what you suggested seems to be my only option.

Bandan

 

-- 
BSD


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
