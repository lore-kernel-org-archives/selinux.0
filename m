Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2EfrRb014532
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 09:41:53 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB2EfCp5001080
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 14:41:12 GMT
Received: from sornico (pat.zurich.ibm.com [195.176.20.45])
	by jazzswing.ncsc.mil  with ESMTP id hB2EfBt0001051
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 14:41:12 GMT
Message-ID: <3FCCA48A.8070709@zurich.ibm.com>
Date: Tue, 02 Dec 2003 15:41:14 +0100
From: Chris Vanden Berghe <vbc@zurich.ibm.com>
MIME-Version: 1.0
To: Tom <tom@lemuria.org>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: selinux-policy-default
References: <3FCC831A.1070002@zurich.ibm.com> <20031202145659.C1867@lemuria.org>
In-Reply-To: <20031202145659.C1867@lemuria.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

>On Tue, Dec 02, 2003 at 01:18:34PM +0100, Chris Vanden Berghe wrote:
>  
>
>>I tried installing the new selinux version for kernel 2.6.0-test11 under
>>Debian.  Started by installing libselinux1 from Russells newselinux
>>archives, this worked just fine.  But when afterwards I tried installing
>>selinux-policy-default, then I got the error message below:
>>    
>>
>I had a similiar error when I upgraded. I _think_ you can just manually
>create an empty dir and it should work. Try that. If it doesn't, yell
>again and I'll try to recreate the steps I took to get it running.
>
I tried this, and got the following error (probably stemming from the 
fact that this dir is empty?):

# mkdir /etc/selinux
# dpkg --install 
/var/cache/apt/archives/selinux-policy-default_1%3a1.2.real-13_all.deb
Selecting previously deselected package selinux-policy-default.
(Reading database ... 111806 files and directories currently installed.)
Unpacking selinux-policy-default (from 
.../selinux-policy-default_1%3a1.2.real-13_all.deb) ...
Setting up selinux-policy-default (1.2.real-13) ...
make: *** No rule to make target `file_contexts/file_contexts'.  Stop.
run-parts: /etc/dpkg/postinst.d/selinux exited with return code 2
"/bin/run-parts --arg=selinux-policy-default /etc/dpkg/postinst.d" 
failed: 256
dpkg: error processing selinux-policy-default (--install):
 1Error running trigger postinst: No such file or directory
Errors were encountered while processing:
 selinux-policy-default

I would very much like to hear how you got around this problem!

Cheers,
Chris.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
