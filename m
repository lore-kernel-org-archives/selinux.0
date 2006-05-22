From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Janak Desai <janak@us.ibm.com>
Subject: Re: pam_namespace improvements ..
Date: Mon, 22 May 2006 11:05:48 +1000
Cc: tmraz@redhat.com, sds@tycho.nsa.gov, valdis.kletnieks@vt.edu,
        serue@us.ibm.com, klaus@atsec.com, selinux@tycho.nsa.gov
References: <44710A40.4060309@us.ibm.com>
In-Reply-To: <44710A40.4060309@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605221105.55104.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 22 May 2006 10:48, Janak Desai <janak@us.ibm.com> wrote:
> After going thorugh the pam_namespace thread again and after talking to
> some of my peeps, I do see that a mode 000 instance parent can thwart
> attacks by non-root daemons and non-polyinstanted users on polyinstanted
> users.

OK.

> The current implementation of pam_namespace already depends on the
> existance of the instance parent and allows the admin to configure the
> names of different instances. I will update the namespace.conf man page,
> and the comment text in the namespace.conf file to guide admins to
> appropriately create a different instance parent (and not use the poly
> dir itself, like the current example suggests). That way, an admin can
> create an intermediate directory like .inst with 000 or create a whole
> different directory with 000.

I'm glad that we have agreement on this issue.  However I would like to go 
further.

I would like to have the default configuration of major distributions (Fedora, 
Debian, and Gentoo) have some changes to make things more secure in this 
regard.

I believe that we need a script run at boot time to create such directories if 
they don't exist and rename a directory with the name but the wrong 
permissions before creating it if necessary.  Having the administrator create 
the directory with mkdir and then chmod it will work for Fedora IFF a 
persistent file system is used for /tmp.  Due to other issues SE Linux 
compels the use of a persistent file system for /tmp at this time (I consider 
this a bug and have long-term plans to fix it), however we also want to 
support non-SE users.

I also believe that pam_namespace should have the optional ability (determined 
by a command-line parameter or a config-file setting) to verify the Unix 
permissions and SE Linux context of the mode 000 directory and reject user 
logins if the permissions are considered to be inappropriate.

Configuration tools to support enabling all this functionality in a convenient 
manner would also be good.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
