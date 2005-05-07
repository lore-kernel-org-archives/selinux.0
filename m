From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: ivg2@cornell.edu
Subject: Re: [Fwd: Latest Diff]
Date: Sun, 8 May 2005 09:01:48 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
References: <427A757F.9040009@redhat.com> <200505072351.04728.russell@coker.com.au> <1115485468.21610.8.camel@localhost.localdomain>
In-Reply-To: <1115485468.21610.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200505080901.52690.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 08 May 2005 03:04, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> > One possibility would be to allow tmpwatch to go through user (not
> > sysadm) home directories but not have search access to home_root_t.  But
> > this makes the protection of user home directories from tmpwatch
> > dependant on the label of home_root_t, I'm not certain that in all cases
> > of automounting and strange configuration of home directories we can rely
> > on the label of home_root_t being assigned to /home to protect
> > sub-directories.
>
> I am a bit confused - /tmp/orbit-$USER is not in /home...
> I was just wondering whether the orbit folder should be allowed to
> be erased by tmpwatch due to inactivity... If so, it will need to
> be recreated (without rebooting), and that's why I was saying that
> in that case, libORBit probably needs to set the correct context itself,
> as opposed to a startup script solution that creates this folder.

Tmpwatch should be allowed to erase it along with every other type that is 
used by default for object creation under /tmp.

Users can create files with type user_home_t under /tmp by setting the 
fscreatecon.

Files of type user_home_t under /tmp can not be removed by tmpwatch.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
