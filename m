From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: Adding alternate root patch to restorecon (setfiles?)
Date: Tue, 26 Oct 2004 01:38:19 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <41741A2C.8040408@redhat.com> <20041018205136.GA2536@jmh.mhn.de>
In-Reply-To: <20041018205136.GA2536@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410260138.19426.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Oct 2004 06:51, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> One thing to note here is that restorecon becomes more dangerous with
> your changes. Right now restorecon is relatively safe in that you can
> only change file labels to their system default. It would probably be
> acceptable in most environments to give users access to restorecon so
> they could properly set labels for files in their home dir.
>
> With your changes and this scenario, users could do something like
>         restorecon -p /home/foo /home/foo/sbin/unix_chkpwd

If the user is to run restorecon then they must run it in their own domain.  
There is no harm in allowing a user to run restorecon as user_t.  They can 
only relabel files that have their own identity and a certain set of types.

Maybe we should even have a script to run restorecon -R on the user's home 
directory that they can run at any time if SE Linux stops them doing what 
they want?

If user_t can run restorecon as restorecon_t then you will lose even if there 
is no -p option.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
