Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA14029
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 06:43:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA10088
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 10:42:25 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id KAA10084 for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 10:42:23 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy questions
Date: Fri, 26 Jul 2002 12:43:04 +0200
References: <20020726030213.GB27354@snoopy.apana.org.au>
In-Reply-To: <20020726030213.GB27354@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <20020726104306.F0F6C191F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 26 Jul 2002 05:02, Brian May wrote:
> I noticed some aspects of Russell's new policy:
>
> ###################
> # Allow httpd to search users diretories
> ######################
> allow httpd_t { user_home_dir_type user_home_type }:dir { getattr search
> };
> allow httpd_t user_home_type:dir read;
> allow httpd_t user_home_type:{ file lnk_file } { getattr read };
>
>
> I think it might be better, by default to only allow httpd (and user
> scripts) to access files under ~/public_html?

I agree totally.  As soon as someone can determine an appropriate way of 
getting that directory labelled in such a fashion then I'll put it in my 
policy.

I guess I could set things up such that the /etc/skel/public_html directory 
has an appropriate label, but then there's the issue of users wanting to do 
an atomic web site update by "mv public_html old ; mv new public_html"!

I was thinking of writing a script to check the user's home directory labels 
and then relabel them automatically for known sub-directories and files that 
they contain (.ssh, .gnupg, public_html, .irc), but due to the constraint 
issue discussed previously that won't work if the files were labelled by a 
"make relabel".  I guess I could put some special case code in setfiles to 
recognise home directories and set the identity to match the name of the home 
directory, but that's probably too ugly.

> In XFree86, why is the commented out by default? I believe X 4.* will
> create a log file regardless of how it is started.
>
> # Uncomment if you are not running an X Display Manager.
> #/var/log/XFree86.*            system_u:object_r:xserver_var_log_t

/var/log/XFree86.*              system_u:object_r:xdm_log_t
#/var/log/XFree86.*             system_u:object_r:xserver_var_log_t

You have one of the above depending on whether you use xdm.  In retrospect 
that's probably a bad idea and I probably should change it.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
