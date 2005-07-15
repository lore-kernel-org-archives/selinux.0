Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FDMpgA011142
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 09:22:51 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FDJHrE012491
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 13:19:17 GMT
Message-ID: <42D7B7D5.6070009@tresys.com>
Date: Fri, 15 Jul 2005 09:19:17 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Alexander Kabanov <shurikk@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: apache virtualhost and selinux
References: <856763c80507142226142e4159@mail.gmail.com>
In-Reply-To: <856763c80507142226142e4159@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Alexander Kabanov wrote:

>Hi All,
>
>I'm new to SELinux, would like to solve the following
>problem (not sure I can do this with SELinux)
>
>so, here is the description:
>
>- httpd (apache, let say it has some modules like mod_perl, mod_php,
>mod_jk etc.)
>- virtual hosts like
> /path/host1
> /path/host2
> etc.
>
>is there a way to contol access of  /path/host1/script1.php to
>/path/host2 files using SELinux policies?
>
>suexec (works for CGI scripts only not for similar to mod_php modules)
>is know solution, is it possible to implement this with SELinux
>policies?
>  
>
It's possible but unfortunatly not yet implemented. A long time ago I 
was playing with the idea of patching fastcgi (it's a wrapper around 
interpreted languages thats not quite as fast as running them via a 
module but much faster than running them as cgi) to get the context of a 
script, find out what the transition would be and then execute the 
interpreter in that context.

I got distracted and never finished this but it shouldn't be hard, if I 
recall correctly fastcgi already does setuid for basically the same 
thing. The additional SELinux code could just be put there.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
