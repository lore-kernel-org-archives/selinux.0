MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Fwd: Re: libsemanage swig problem]
Date: Mon, 8 May 2006 14:11:15 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158817013D@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>,
        "Karl MacMillan" <kmacmillan@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > To: Joshua Brindle <method@gentoo.org>
> > Hmmm...just tried doing a make distclean swigify pywrap here, and 
> > had no problems (and nothing changed in the generated files).  
> > Possibly tied to swig version?  swig 1.3.29 here.
> 
> Defined in /usr/share/swig/x.y.z/python/pyrun.swg.
> It replaced t_output_helper, which is deprecated, in libsemanage 1.6.4

> 2006-04-12.
> 

Hrm
[root@joker-rawhide yum.repos.d]# grep SWIG_Python_AppendOutput
/usr/share/swig/1.3.24/python/*
[root@joker-rawhide yum.repos.d]# 

Interestingly my rawhide machine stopped using development repositories
because all the development repos changed or something and rpm moved my
-devel.repo files to .rpmsave

So I got this fixed and upgraded swig and now it works.. Fun.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
