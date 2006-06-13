From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: janak@us.ibm.com
Subject: Re: polyinstantiating /tmp and gdm
Date: Wed, 14 Jun 2006 00:00:44 +1000
Cc: dwalsh@redhat.com, sgrubb@redhat.com, tmraz@redhat.com, klaus@atsec.com,
        Valdis.Kletnieks@vt.edu, sds@tycho.nsa.gov, selinux@tycho.nsa.gov
References: <1150206426.18955.17.camel@localhost.localdomain>
In-Reply-To: <1150206426.18955.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200606140000.44403.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 13 June 2006 23:47, Janak Desai <janak@us.ibm.com> wrote:
> I have figured out a way to get gdm/X to work with a polyinstantiated
> /tmp. In my previous attempts I was bind mounting original /tmp/.X11-unix
> on /instance/.X11-unix and then expecting the socket to be visible
> after bind mounting the instance on the original /tmp. Now I understand
> why that doesn't work. What we need is to make the original /tmp (or
> in our case just the /tmp/.X11-unix) available from alternative location
> outside of /tmp before it is mounted over. If you remember, this was
> in Stephen's original design but we removed it because we couldn't find
> any use for it. Now we have :-). This is still a very specific use, so
> I am going to special case it with instance.init script and NOT bring
> back the "original" directory code that was present in the earlier
> incarnation of the pam_namespace. The only change to pam_namespace module
> will be to always execute the instance.init script as opposed to only at
> the time of the instance creation.

We seem to be spending a lot of effort on supporting what was always a bad 
idea (putting such things under /tmp).

Maybe a better option is to have the socket created under /var/run/.X11-unix 
and have /tmp/.X11-unix be a sym-link to /var/run/.X11-unix.  Creating a new 
sym-link under each poly directory is less work than doing yet another mount.  
Note that this doesn't only apply to .X11-unix, there's .font-unix as well 
and probably some other daemons out there doing other things.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
