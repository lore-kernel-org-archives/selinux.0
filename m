Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA27938
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 09:21:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA01692
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 13:20:57 GMT
Received: from web40008.mail.yahoo.com (web40008.mail.yahoo.com [66.218.78.26])
	by jazzswing.ncsc.mil  with SMTP id NAA01688
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 13:20:56 GMT
Message-ID: <20020812132144.97044.qmail@web40008.mail.yahoo.com>
Date: Mon, 12 Aug 2002 06:21:44 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Swollen su_macros.te file
To: Brian May <bam@snoopy.apana.org.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020812065057.GP2149@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. May,

--- Brian May <bam@snoopy.apana.org.au> wrote:
> On Sun, Aug 11, 2002 at 11:56:07AM -0700, Brad Chapman wrote:
> >       Lately I have noticed that my su_macros.te file is becoming
> unmanageable
> > due to the enormous amount of stuff that I use su for. Could you (and the
> list)
> > please review my su_macros.te file and tell me how to make it smaller?
> 
> Assuming Russell does not help you with his line of questioning (which I
> won't duplicate here), how do you use su to get root access?

        By typing plain 'su', not 'su -l'.

> 
> What is the output of "id"[1] before and after the su command?

        A-HA!

        Before: uid=500(Brad) gid=500(Brad)
                groups=500(Brad),4(adm),20(games),100(users)
 
                context=Brad:sysadm_r:sysadm_t sid=243

        After: uid=0(root) gid=0(root)        
               groups=0(root),1(bin),2(daemon),3(sys),4(adm),
               6(disk),10(wheel),20(games)

                context=Brad:sysadm_r:sysadm_t sid=243

        The context REMAINS THE SAME! Even when I use 'su -l' !!!

        What does this mean?  

> 
> Note:
> [1] I am assuming your version of su has been modified to display
> the SE-Linux label here.
> -- 
> Brian May <bam@snoopy.apana.org.au>

Brad


=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
