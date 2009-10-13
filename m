Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9DITblS014571
	for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 14:29:37 -0400
Received: from smtp1.toolwire.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9DISj3c005907
	for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 18:28:45 GMT
Received: from ginger.toolwire.com (unknown [10.2.0.40])
	by smtp1.toolwire.com (Postfix) with ESMTP id F1FA548004
	for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 11:29:32 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: what is http authenticated user?
Date: Tue, 13 Oct 2009 11:29:36 -0700
Message-ID: <133A1C67A2D4284A91A113F4D951E8DAF9B0BE@ginger.toolwire.com>
In-Reply-To: <4AD4709A.6050407@kaigai.gr.jp>
References: <bb74313d0910130430l3f9ff448p42efbcfba5c90d4e@mail.gmail.com> <4AD4709A.6050407@kaigai.gr.jp>
From: "Sean Hulbert" <shulbert@toolwire.com>
To: "KaiGai Kohei" <kaigai@kaigai.gr.jp>,
        "michel m" <michel.mcgregor@gmail.com>
Cc: "selinux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello

Lets clear up the context word "USER" when dealing with Unix any flavor users take on different meanings.

As you mentioned Amazon.com they are storing user account information into a SQL table and not using an OS level user account.

"My opinion if anyone uses OS level user accounts they should jail it, by allowing a user to be created on an OS level from a web application is a huge no no"

No main stream daemons should not be running as root.
As you can see I am a huge fan of chroot (Jailing) 

Web user account = anonymous access to httpd service to display meta data
OS level account = sublevel user rights (ls, cd, touch, vi, rm (only those in user group), ext...)
SQL user account = Web or application storage for user access to personal information.  Email, phone, logon account, password, ext....

The difference between SSHD and HTTPD is that SSHD uses OS level user accounts only, as HTTPD can use multiple methods.


Now a lot of what I said here is exactly the same thing KaiGai said, just with a little more clarification and giving different options.

It is also a good idea to document each step you do, (PLAYBOOK) and test that Playbook by having someone follow it on a build or configuration.


Thank You
St. Sean Hulbert
Miraculum Laborat

Complex Systems Integrator
Work Ph:    925.227.8500 x136
Cell:           925.339.2860

www.toolwire.com
 
CONFIDENTIALITY NOTICE: This communication with its contents may contain confidential and/or legally privileged information. It is solely for the use of the intended recipient(s). Unauthorized interception, review, use or disclosure is prohibited and may violate applicable laws including the Electronic Communications Privacy Act. If you are not the intended recipient, please contact the sender and destroy all copies of the communication.
 
igitur qui desiderat pacem, praeparet bellum!!!
 
Epitoma Rei Militaris


-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On Behalf Of KaiGai Kohei
Sent: Tuesday, October 13, 2009 5:21 AM
To: michel m
Cc: selinux
Subject: Re: what is http authenticated user?

michel m wrote:
> Hi,
> 
> in my last mail, I had asked how to get context for incoming requests. 
> meanwhile studying replies, I got familiar with apache/selinux plus 
> which labels threads based on identity of user. but I can not understand 
> how users are authenticated from http requests. who does this 
> authentication ( is it a service special to apache/httpd that analyzes 
> http requests) ? I think, an http request in normal form does not 
> contain any information by which remote user can be authenticated.
> 
> may some one explain me more or redirect me to some resources that 
> clarify things more?

You need to distinguish a web-user from a OS-user.

When you have a shopping at amazon.com, you were supposed to provide
your account information (e.g e-mail address and password), but it
does not mean that a new user account is available on the operating
system of amazon.com, because all the http requests are handled by
httpd server process from the viewpoint of operating system.

A web-user is a concept in web or application layer, not OS.
Its account information is implicitly sent for each http request basically,
then the http server parses it and applies its authentication.
(if failed, http server returns an error prior to page references.)

Apache/SELinux Plus is a module to assign a certain security context
based on the authorized web-user, not OS-user.

However, here is no fundamental differences between httpd and sshd.
When we connect a host using ssh, we have to provide my account information
(e.g username/password or public key), then ssh authorizes the connection
using the given account info, and assigns a certain security context on the
user login shell.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
