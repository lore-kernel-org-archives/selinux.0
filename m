From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Joshua Brindle" <JBrindle@snu.edu>, <SELinux@tycho.nsa.gov>
Subject: Re: selinux play machine
Date: Fri, 7 Mar 2003 10:25:39 +0100
References: <se67e0d0.047@atlas.snu.edu>
In-Reply-To: <se67e0d0.047@atlas.snu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303071025.39192.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 7 Mar 2003 06:58, Joshua Brindle wrote:
> Russell, i don't know if you just messed up or forgot to set the sid on
> spasswd but...
>
> > Someone changed the root password, it's a pity they weren't responsible
> > enough to change it back afterwards.  I've changed the SID of the spasswd
> > program to prevent this happening again...
>
>
> root@cose:/# spasswd
> Enter new UNIX password:
> Retype new UNIX password:
> passwd: password updated successfully

Changing the SID was only a temporary measure, and I didn't get around to 
installing a proper fix before I upgraded the "selinux" package (which 
changed the SID back).

I've changed the "users" file so that root now gets domain user_u and 
therefore is prohibited from changing the password.

Also I've changed the policy such that you can't run "passwd" from the command 
line (because the passwd program keeps trying to create a lock file 
indefinately - this is primarily a Debian problem the version of passwd used 
in Red Hat gives up after a reasonable number of tries).  I'll submit the 
changes as soon as the NAI people have dealt with my last policy changes.


In future please send messages about such issues to me, or at least CC me on 
them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
