Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2OHrx1S029556
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 13:53:59 -0400
Received: from el-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2OHrsQR029899
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 17:53:54 GMT
Received: by el-out-1112.google.com with SMTP id v27so1351362ele.17
        for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 10:53:46 -0700 (PDT)
Message-ID: <50771f160803241053i34e6eb7cqf3e3df64b8e90ab3@mail.gmail.com>
Date: Mon, 24 Mar 2008 14:53:45 -0300
From: "cinthya aranguren" <cinthya.aranguren@gmail.com>
To: russell@coker.com.au
Subject: Re: Removing DAC.
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200803240934.16380.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <50771f160803230854n18bd2a07q34eb154fc016f351@mail.gmail.com>
	 <200803240934.16380.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Mar 23, 2008 at 7:34 PM, Russell Coker <russell@coker.com.au> wrote:
> On Monday 24 March 2008 02:54, "cinthya aranguren"
>
> <cinthya.aranguren@gmail.com> wrote:
>
> > Is there any way to avoid o remove DAC controls ? I'd like to have only one
>  > security scheme in my system. I mean a pure SElinux system. not DAC + MAC.
>  > only MAC.
>
>  Back in about 2003 as an experiment I changed the ownership of all files on a
>  SE Linux strict system to root and changed the permission to 777.  It didn't
>  work very well.  One problem was that many programs rely on the Unix
>  permissions to identify the difference between a configuration file and a
>  shell script.  In directories such as /etc there is not sufficiently
>  fine-grained SE Linux labelling to replace this use of Unix permissions.


Ok, I understand. In a pure SELinux ditribution this would be fixed or
patched. It does not seems to be a problem. I mean .. a security
issue.



>
>  It's possible that in the last 5 years things have changed significantly, but
>  my last experiments showed enough obstacles to make me not want to bother
>  going further with it.
>

don't lost your faith :-)

>  --
>  russell@coker.com.au
>  http://etbe.coker.com.au/          My Blog
>
>  http://www.coker.com.au/sponsorship.html Sponsoring Free Software development
>

Cinthya.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
