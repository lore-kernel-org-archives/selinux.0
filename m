From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: [Fwd: Re: avc_toggle and avc_enforcing]
Date: Fri, 17 Oct 2003 01:55:19 +1000
References: <3F8E9DB7.5030903@redhat.com>
In-Reply-To: <3F8E9DB7.5030903@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310170155.19538.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 16 Oct 2003 23:31, Daniel J Walsh wrote:
> on a SELinux machine.  A system administrator should be able to manage
> the machine with limited knowlege of the way policy works.

I guess that the next thing we want is per-role instantiations for run_init.  
So for example we could have:
full_user_role(dba)
run_program(dba_t, dba_r, dba, initrc_exec_t, postgresql_t)
allow run_dba_t self:capability setuid;

Then the Database administrator could login as user:dba_r:dba_t to run all 
unix programs, and they could have a SUID root program with type 
run_dba_exec_t which would run /etc/init.d/postgresql with specified 
parameters.  That combined with a few rules relating to file access would 
give them full control over the database server without granting any access 
to the rest of the system.

NB It's quite important that such uses of run_program which have something 
other than sysadm_t as the first parameter do not have initrc_t as the last 
parameter!  It is very important that we restrict initrc_t.

Also it's very important that the program which has run_dba_exec_t is a very 
simple program that sets it's UID, sets the execute context, and executes the 
script.  As it has privrole we want to be very sure that it does not do the 
wrong thing.  Privrole is necessary as it has to start the daemon as 
system_r.


I've been meaning to write policy for this for some time, but have lacked 
suitable opportunities for testing.  The machines I've been involved in 
running recently have all had a boolean policy regarding administrative 
privs...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
