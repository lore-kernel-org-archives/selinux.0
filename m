From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bartlomiej Balcerek <Bartlomiej.Balcerek@pwr.wroc.pl>
Subject: Re: Assigning user context to files out of home dir.
Date: Fri, 25 Feb 2005 23:34:52 +1100
Cc: SELinux@tycho.nsa.gov
References: <Pine.GSO.4.44.0502231318520.3577-100000@sun1000.pwr.wroc.pl>
In-Reply-To: <Pine.GSO.4.44.0502231318520.3577-100000@sun1000.pwr.wroc.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502252334.55705.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 23 February 2005 23:48, Bartlomiej Balcerek 
<Bartlomiej.Balcerek@pwr.wroc.pl> wrote:
> Recently I've tried to define labeling for files, which are located out of
> user home, with user context, such as in user home. I want to label
> directories and files according to all user roles.
>
> There is now in "types.fc":
>
> /scratch      -d system_u:object_r:scratch_root_t
> /scratch/.+     system_u:object_r:ROLE_scratch_t

It is not valid to use ROLE in the type specification if you don't use 
HOME_DIR in the directory-name specification.  The genhomedircon program 
expects things that way.

What are you trying to do anyway?  Home directories under /scratch will get 
labeled correctly by genhomedircon if the users in question have entries in 
the users file in the policy source directory.


PS  I'm speaking at the Open Source Security conference in Warsaw.  
http://www.oss.org.pl/en/  Let me know if you are in Warsaw or attending the 
conference.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
