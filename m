Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAM1c4Rb001380
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 20:38:04 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAM1bVp5003202
	for <selinux@tycho.nsa.gov>; Sat, 22 Nov 2003 01:37:31 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hAM1bTt0003194
	for <selinux@tycho.nsa.gov>; Sat, 22 Nov 2003 01:37:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Nick <nagray@austin.rr.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: First attempt at "Configuring the SELinux Policy" - I Think I got it !
Date: Sat, 22 Nov 2003 12:37:50 +1100
References: <1069454857.2867.42.camel@hawaii>
In-Reply-To: <1069454857.2867.42.camel@hawaii>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311221237.50457.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 22 Nov 2003 09:47, Nick <nagray@austin.rr.com> wrote:
> Nov 21 15:39:20 selinux kernel: avc:  denied  { read } for  pid=1012
> exe=/usr/sbin/httpd name=logs dev=03:03 ino=180255
> scontext=system_u:system_r:httpd_t
> tcontext=system_u:object_r:httpd_log_files_t tclass=lnk_file
> N
>
> My interpretation is: (try not to laugh)
>
> the httpd daemon (system_u:system_r:httpd_t) is trying to read a file
> named logs (system_u:object_r:httpd_log_files_t) but  does not have
> {read} access.

The class is "lnk_file" which means that it's a symbolic link that the httpd 
is not permitted to read.

> So what I did was look, look for this file called logs that the process
> is trying to access.  After I found it, and realized what was going on,
> I changed the config to write the files to /var/log/httpd/ dir, where
> the policy expected to see them.

Yes.  The problem was that you had used a sym-link to redirect where Apache 
was to write logs and not granted permission to read it.

> The question is, is this pretty much the method required for this type
> of thing?

Yes, similar things will be required to get other services working.  However 
one thing to note is that if you use a default configuration of a major 
distribution then things should just work.  So if you make sure that you keep 
files in the same locations as the default config then it should not be very 
difficult to get it to operate as desired with SE Linux.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
