Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA20159
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 23:32:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA25781
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 03:31:21 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id DAA25777
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 03:31:18 GMT
Date: Sat, 27 Jul 2002 13:31:53 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy questions
Message-ID: <20020727033153.GD18313@snoopy.apana.org.au>
References: <20020726030213.GB27354@snoopy.apana.org.au> <20020726104306.F0F6C191F@lyta.coker.com.au> <20020726104858.GA4715@snoopy.apana.org.au> <20020726133842.68F4D18F@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020726133842.68F4D18F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 26, 2002 at 03:38:42PM +0200, Russell Coker wrote:
> Make relabel labels ~/public_html as system_u:object_r:user_home_html_t.
> 
> I create a new subdirectory under my home directory and it gets 
> rjc:object_r:user_home_t.  Then I rename some directories and I can relabel 
> the object from rjc:object_r:user_home_t to rjc:object_r:user_home_html_t.
> 
> However, if the sysadm relabels the file system after I created the new 
> directory (either I created it before they installed SE Linux, or they felt a 
> need to relabel the file system) then the directory gets 
> system_u:object_r:user_home_t and I can't relabel it to 
> rjc:object_r:user_home_html_t!

Is the problem here that you are trying to relabel system_u to rjc?

> So if I made setfiles have special-case code for /home which searches for an 
> identity matching the sub-directory name and uses it as part of the label 
> then this problem would be solved.
> 
> However Steve doesn't even want me to hack setfiles to know ANYTHING about 
> the format of a context string (he didn't like my patch to avoid needing 
> system_u:object_r as a prefix for every type).

Personally, I don't like the idea of relabel touching the home
directory. It seems to have some limitations:

1. I want to setup a ~/untrusted directory on my account to allow
downloads from netscape. The current policy allows me to do this.
However, I don't want relabel to "fix" this.

2. You still have the problem of initially creating the directories
in the first place...

3. Not everyone creates home directories under /home.

Some ideas:

Maybe have some sort of script that the user runs to initially setup the
initial directories and labels for a given program (eg. user runs "setup
netscape"). This script may need special relabel priviledges, if the
user doesn't already have them.

Have adduser automatically label files for new users using the new
SE-Linux user it just created (hmmm... generic hooks into adduser might
be ideal here).

When initially installing selinux set all home directories the "best"
defaults using some sort of hacked script, and tell system adminstrator
to check that this is correct.

Allow users to relabel there files to/from public_html, depending
on local policy.

Otherwise prevent users from renaming the ~/public_html directory (is
this possible?).
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
