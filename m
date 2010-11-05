Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA5C7C3h031816
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2010 08:07:12 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id oA5C7BT2014609
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2010 12:07:11 GMT
Message-ID: <4CD3F36E.3040309@tresys.com>
Date: Fri, 05 Nov 2010 08:07:10 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: sure <mengshuo@gmail.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: About compile an appplication's policy
References: <AANLkTiknqsWLqo2M+dpr75rDHG4jE-ei+Rm4mDC61PS3@mail.gmail.com>
In-Reply-To: <AANLkTiknqsWLqo2M+dpr75rDHG4jE-ei+Rm4mDC61PS3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/04/10 22:19, sure wrote:
> Hi :    
>       I am trying to create my own policy module, but i met with a
> problem: after i finished the myapp.te, myapp.if and myapp.fc in my
> directory named mypolicy, I copied the uncompress
> refpolicy-20070928.tar.bz2 dir ../refpolicy/doc/Makefile.example to
> ../mypolicy and renamed Makefile, then i tried to "make" , it gave such
> wrong info:
> 
> Makefile:8: /usr/share/selinux/devel/mls/include/Makefile: No such file
> or directory
> make: *** No rule to make target
> `/usr/share/selinux/devel/mls/include/Makefile'.  Stop.
> 
> then i check the dir /usr/share/selinux/devel/mls/ , there are many *.pp
> files in, but  no directory named include, should i install some other
> package or find it in somewhere else.

What version of Red Hat/Fedora are you using?  I believe some of the
older ones had these files in the selinux-policy-devel package.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
