Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i84BcrrT013690
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 07:38:53 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i84Bc2AJ016960
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 11:38:03 GMT
Subject: Re: [idea] file contexts "alternate" keyword
From: Erich Schubert <erich@debian.org>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200409041748.38442.russell@coker.com.au>
References: <20040903165723.GA31857@lkcl.net>
	 <20040903205348.GA4084@lkcl.net>
	 <1094258021.29689.32.camel@wintermute.xmldesign.de>
	 <200409041748.38442.russell@coker.com.au>
Content-Type: text/plain
Date: Sat, 04 Sep 2004 13:38:50 +0200
Message-Id: <1094297930.6427.7.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> This sounds like a reasonable feature request.  But we need a good way of 
> implementing it.

We could require that they have the exact same pattern and follow each
other in the file_contexts file.
Maybe adding some flag as suggested earlier, like "alternate".

/var/www(/.*)?      system_u:object_r:httpd_sys_script_exec_t  alternate
/var/www(/.*)?      system_u:object_r:httpd_sys_content_t

(maybe adding "default" to the second, to make it more userfriendly)

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
    Go away or i'll replace you with a very small shell script.     //\
           Es ist besser, geliebt und verloren zu haben,            V_/_
                   als niemals geliebt zu haben.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
