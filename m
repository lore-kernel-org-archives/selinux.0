Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2C2f4Do012006
	for <selinux@tycho.nsa.gov>; Fri, 11 Mar 2005 21:41:04 -0500 (EST)
Received: from wproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2C2XHX8001690
	for <selinux@tycho.nsa.gov>; Sat, 12 Mar 2005 02:33:17 GMT
Received: by wproxy.gmail.com with SMTP id 71so1826535wra
        for <selinux@tycho.nsa.gov>; Fri, 11 Mar 2005 18:35:48 -0800 (PST)
Message-ID: <fa8ec5d805031118353197f745@mail.gmail.com>
Date: Fri, 11 Mar 2005 21:35:48 -0500
From: Kodungallur Varma <ramgwu@gmail.com>
Reply-To: Kodungallur Varma <ramgwu@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: problems using setcon()
In-Reply-To: <20050309084655.GC5236@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <fa8ec5d80503082008161e5619@mail.gmail.com>
	 <20050309084655.GC5236@thorium.jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

all,

       I came to know that I cant simply cast a string into a security
identifier as shown below. insted I found out that I have to use
security_compute_create(). I found a relevant conversation in the
mailing list:
----------------------------
On Tue, 2005-02-15 at 17:53, Luke Kenneth Casson Leighton wrote:
> on the setcon(), because i happened to be in sshd_privsep_t, and because
> i happened to be setting the context to user_t, and because it was
> sshd_exec_t doing the setting, i expect an "automatic" transition
> to occur to sshd_privsep_user_t.

That makes no sense.  If you want to compute a derived context to pass
to the setcon() call, you can use security_compute_create() to get one
from policy, e.g. see the corresponding logic in rpm_execcon(3) in
libselinux.
---------------------------

I have absolutely no idea how the security_compute_create() works or
ho to use it. all I need ot do is to dynamically change context into a
domain for which the type enforcement policy file has been written.
the man pages for security_compute_create() has very little
information on how and where to use it. is there an example of how we
can use it? also is rpm_execcon(3) relevant in this context.

any help on this would be great. thank you in advance.

Ram

On Wed, 9 Mar 2005 09:46:56 +0100, Thomas Bleher
<bleher@informatik.uni-muenchen.de> wrote:
> * Kodungallur Varma <ramgwu@gmail.com> [2005-03-09 05:33]:
> > Hi all,
> >
> >  I am trying to dynamically change the context of my program by
> > using the setcon() function. I have a simple program that tries to do
> > that but the setcon() function always returns -1 for the input in the
> > program.
> >
> > #include <stdio.h>
> > #include <selinux/selinux.h>
> >
> > int main()
> > {
> >    int i;
> >    char str[100];
> >    strcpy(str,"system_u:object_r:libselinux_test_t");
>                  ^^^^^^^^^^^^^^^^^
> Your Problem is here. object_r cannot be used for any domains. Further,
> you can't change users (from user_u to system_u) unless you are
> specifically authorized.
> If you use "user_u:user_r:libselinux_test_t" you should be able to get
> it to work (you'll need some additional permissions as dyntransition is
> not covered by domain_auto_trans())
> 
> HTH,
> Thomas
> 
> --
> http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
> GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7
> 
> 
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
