Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA15125
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 09:38:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA19567
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 13:38:00 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA19563
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 13:37:59 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: Policy questions
Date: Fri, 26 Jul 2002 15:38:42 +0200
References: <20020726030213.GB27354@snoopy.apana.org.au> <20020726104306.F0F6C191F@lyta.coker.com.au> <20020726104858.GA4715@snoopy.apana.org.au>
In-Reply-To: <20020726104858.GA4715@snoopy.apana.org.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020726133842.68F4D18F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 26 Jul 2002 12:48, you wrote:
> On Fri, Jul 26, 2002 at 12:43:04PM +0200, Russell Coker wrote:
> > I was thinking of writing a script to check the user's home directory
> > labels and then relabel them automatically for known sub-directories and
> > files that they contain (.ssh, .gnupg, public_html, .irc), but due to the
> > constraint issue discussed previously that won't work if the files were
> > labelled by a "make relabel".  I guess I could put some special case code
> > in setfiles to
>
> What is the problem here?

Make relabel labels ~/public_html as system_u:object_r:user_home_html_t.

I create a new subdirectory under my home directory and it gets 
rjc:object_r:user_home_t.  Then I rename some directories and I can relabel 
the object from rjc:object_r:user_home_t to rjc:object_r:user_home_html_t.

However, if the sysadm relabels the file system after I created the new 
directory (either I created it before they installed SE Linux, or they felt a 
need to relabel the file system) then the directory gets 
system_u:object_r:user_home_t and I can't relabel it to 
rjc:object_r:user_home_html_t!

avc:  denied  { relabelfrom } for  pid=27187 exe=/usr/bin/chsid 
path=/rjc/public_html dev=03:07 ino=247 scontext=rjc:user_r:user_t 
tcontext=system_u:object_r:user_home_t tclass=file

So if I made setfiles have special-case code for /home which searches for an 
identity matching the sub-directory name and uses it as part of the label 
then this problem would be solved.

However Steve doesn't even want me to hack setfiles to know ANYTHING about 
the format of a context string (he didn't like my patch to avoid needing 
system_u:object_r as a prefix for every type).

The alternative of having a special set of entries in types.fc for each user 
(5 lines for ~, ~/.gnupg, ~/.ssh, ~/public_html, and ~/*) is just too painful.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
