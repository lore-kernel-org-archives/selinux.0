Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAH7r0xJ019459
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2008 02:53:00 -0500
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAH7p8ll016082
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2008 07:51:09 GMT
Message-ID: <49212273.2070208@ak.jp.nec.com>
Date: Mon, 17 Nov 2008 16:51:15 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: dev@httpd.apache.org
CC: webstack-discuss <webstack-discuss@opensolaris.org>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: Introducing mod_privileges for Apache HTTPD
References: <491D5159.2080209@webthing.com>
In-Reply-To: <491D5159.2080209@webthing.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, Nick

It seems to me we have similar ideas to enhance web-application
security. I've focused on SELinux to utilize security features
of operating system.

I had a plan to start discussion after my PostgreSQL works are
closed, but, it is a good time to start discussion to utilize
them for web-applications.

I have a modified version of apache/httpd, as a proof of concept.

   http://code.google.com/p/sepgsql/source/browse/misc/httpd-selinux/
   (*) Please copy the "2.2.x" directory as "server/mpm/selinux",
       and append "--with-mpm=selinux"

It enables to invoke request handlers with individual privilege set
based on http-authenticated username, source IP addresses and so on.
The typical flow of operations are as follows:

  1. It receives a HTTP request come from client.

  2. It generates a one-time thread to handle the request.
     The parent side wait for completion of the thread.

  3. The one-time thread assigns itself a proper privilege set
     based on the http-authentication and so on.

  4. It invokes request handlers to process the given request.
     The request handler works within more restricted privileges.
     When it kick PHP scripts or static contents handlers, the
     restricted privileges are inherited.

  5. The one-time thread returns a http response to the client,
     then it dies soon.

  6. The parent wakes up, and returns to (1).

(*) Please note that SELinux disallow to revert privileges,
     because it can be a vulnerability of unexpected escalation.

Your "mod_privileges" is implemented on the "perchild" MPM.
It is suitable to achieve per VirtualHost privileges.
In addition, I think per user/request/network privileges
enforced by operating system is more worthwhile feature.

A security focused MPM is a key facility to enable the idea.
I assume it does not give first priority for performances,
but it enables to resolves some kinds of security nightmares.

How do you think the concept?

Please any comment,

Thanks,

Nick Kew wrote:
> I've just introduced mod_privileges to Apache HTTPD trunk.
> 
> This is a platform-specific module for Solaris 10 and OpenSolaris,
> that makes the webserver privileges(5)-aware.  This enables the
> server to be run with enhanced security, and with different
> settings per virtual host.
> 
> The feature likely to be of most interest is that it enables
> different virtual hosts to run under different Unix user and
> group IDs, using the VHostUser and VHostGroup directives.
> This is the capability once promised by the "perchild" MPM.
> 
> It has one major drawback: it is not suitable for a threaded MPM.
> However, it is ideally suited for use with PHP, which of course
> also precludes threads.  It should also be of interest to anyone
> hosting other in-process scripting environments such as mod_perl,
> mod_python or mod_ruby, or application modules.
> 
> http://svn.apache.org/viewvc/httpd/httpd/trunk/modules/arch/unix/mod_privileges.c 
> 
> http://svn.apache.org/viewvc/httpd/httpd/trunk/docs/manual/mod/mod_privileges.xml 

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
