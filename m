Message-Id: <200204252010.g3PKAU823336@numbat.Os2.Ami.Com.Au>
To: SELinux@tycho.nsa.gov
Subject: Re: SELinux RPM Version 
In-Reply-To: Your message of "Thu, 25 Apr 2002 15:51:10 +0200."
             <20020425135110.E75773943@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Apr 2002 04:10:30 +0800
From: John Summerfield <summer@os2.ami.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Thu, 25 Apr 2002 14:48, Westerman, Mark wrote:
> > In the Filesystem Hierarchy Standard (FHS) document for the
> > Linux Standard Base.
> >
> > "Any program or package which contains or requires data the doesn't
> > need to modified should store that data in /usr/share. "
> >
> > the doc subdirectory if for "Miscellaneous documentation"
> 
> IMHO that means that /usr/share/selinux is better than /usr/share/doc/selinux
>  
> for the sample policy files.
> 
> Sample policy files are not documentation, they don't even have much in the 
> way of comments!

Surely they are not data required for the application's operation!

I agree with Mark that they are documentation regardless of the commentary, and 
that they belong in /usr/share/doc/selinux (or /usr/share/doc/selinux-%{release}-
%{release})

qt-devel is one of many packages that does this, and 
/usr/share/doc/qt-devel-2.3.1/examples/examples.pro is not exactly replete with 
comments.




-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my disposition.

==============================
If you don't like being told you're wrong,
	be right!




-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my disposition.

==============================
If you don't like being told you're wrong,
	be right!




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
