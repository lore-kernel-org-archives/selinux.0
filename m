Message-ID: <463B5A4B.2090004@redhat.com>
Date: Fri, 04 May 2007 12:07:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: rob myers <rob.myers@gtri.gatech.edu>
CC: SELinux@tycho.nsa.gov
Subject: Re: oracle policy
References: <1177969059.1731.46.camel@rxm-581b.stl.gtri.gatech.edu>
In-Reply-To: <1177969059.1731.46.camel@rxm-581b.stl.gtri.gatech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

rob myers wrote:
> hello
>
> i am working on writing some SELinux policy that will confine oracle to
> its own domain on a RHEL5 machine running targeted policy.  my security
> goal is to limit risk to the rest of the system from any potential
> compromise of oracle.  as far as i know, no such policy exists publicly
> yet.  i'd like to collaborate with anyone else that has an interest in
> writing a similar policy for oracle.  my initial efforts are attached.
> tips, pointers, and constructive criticism requested!
>
> one of the problems with writing a general oracle policy is that
> different people may install the software in different locations.  i've
> chosen /opt/oracle/10.2.0, but maybe there is a more appropriate place
> for it?
>
> rob.
>   

First off I have never run oracle (They don't like my company much :^) ...

Lets start by looking at your file context file. 

Eliminate the version number from the file path.  You can use a regular 
expression to handle this or you are going to have problems with 9.3 
comes out.

I like to minimize the number of context in the file context,  The more 
files in the context the more likely you are to get one wrong.  
One general rule I use is if you domain does not need to modify a 
file/directory, you should use the system defaults.  (Unless you want to 
prevent other confined domains from reading the files, for security 
purposes).  So do you really need  oracle_ro_t?

Remove these
/opt/oracle(/.*)?          gen_context(system_u:object_r:oracle_ro_t,s0)
/etc/oracle-9iR2(/.*)?          
gen_context(system_u:object_r:oracle_ro_t,s0)
/etc/oracle-10gR2(/.*)?          
gen_context(system_u:object_r:oracle_ro_t,s0)

Add this
files_read_usr_files(oracle_t)

The only file that should be labeled oracle_exec_t is the domains entry 
point.  Helper apps should be just labeled bin_t.  Or even better break 
the helper apps and write policy for their specific tasks.  But this is 
a lot more work.

Your jar files should be labeled shlib_t so they will work on MLS/Strict 
policy machines.

You should not specify lib_t if the system default would have been lib_t.


As for the te file.  You want to eliminate the entire require block from 
the file.  Any of the types you are defining there should be removed and 
allow rules that use these types should be replaced with interfaces.

For example

allow oracle_t proc_t:file read;

Should be replaced with

kernel_read_system_state(oracle_t)

I would bet oracle is using nsswitch  so you can add
auth_use_nsswitch(oracle_t)

And eliminate a lot of other rules. Like (nscd, netlink_route_socket)

I like to avoid
domain_auto_trans(unconfined_t, oracle_exec_t, oracle_t)

And only have the transition happen in the init scripts.  Transitioning 
directly from unconfined_t ends up with lots of avcs when users do stuff 
like

confined_app >> ~/mylog

Also you might be able to eliminate the ability to write to terminals by 
doing this.







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
