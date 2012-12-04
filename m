Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qB4Bc2VL002597
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2012 06:38:02 -0500
Received: from sander.oxilion (kantoor.oxilion.nl [93.186.176.113])
	by vds-1069.hoentjen.eu (Postfix) with ESMTPSA id 1A658E1343
	for <selinux@tycho.nsa.gov>; Tue,  4 Dec 2012 12:37:57 +0100 (CET)
Message-ID: <50BDE094.9010405@hoentjen.eu>
Date: Tue, 04 Dec 2012 12:37:56 +0100
From: Sander Hoentjen <sander@hoentjen.eu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: policy for PowerDNS
References: <50BCB590.8010602@hoentjen.eu> <1354547319.13093.2.camel@localhost>
In-Reply-To: <1354547319.13093.2.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/03/2012 04:08 PM, grift wrote:
> On Mon, 2012-12-03 at 15:22 +0100, Sander Hoentjen wrote:
>> Hi all,
>>
>> I had created a policy for PowerDNS (pdns package in Fedora), but after
>> e-mailing with dwalsh he told me it might be better to just adapt the
>> named policy a bit. Here is what I have so far:
>> ======pdns.fc======
>> /usr/sbin/pdns_server  -- gen_context(system_u:object_r:named_exec_t,s0)
>> /etc/pdns/pdns.conf    -- gen_context(system_u:object_r:named_conf_t,s0)
>> /var/run/pdns.controlsocket -s
>> gen_context(system_u:object_r:named_var_run_t,s0)
>> /var/run/pdns.pid   -- gen_context(system_u:object_r:named_var_run_t,s0)
>> ===================
>> ======pdns.te======
>> policy_module(pdns,0.0.1)
>>
>> require{
>>       type named_t;
>> }
>>
>> #gmysql backend:
>> bool pdns_can_connect_db true;
>> tunable_policy(`pdns_backend_mysql', `
>>       mysql_read_config(named_t)
>>       #socket
>>       mysql_stream_connect(named_t)
>> ')
>> ===================
>> With this added pdns works with both the bind-backend and the
>> mysql-backend (pdns-backend-mysql in Fedora). I do still get some
>> denials, first 2 with both backends:
>> type=AVC msg=audit(12/03/2012 14:30:26.767:597) : avc:  denied  { fsetid
>> } for  pid=23063 comm=pdns_server capability=fsetid
>> scontext=system_u:system_r:named_t:s0
>> tcontext=system_u:system_r:named_t:s0 tclass=capability
>>
>> type=AVC msg=audit(12/03/2012 14:30:26.735:595) : avc:  denied  { kill }
>> for  pid=20597 comm=pdns_server capability=kill
>> scontext=system_u:system_r:named_t:s0
>> tcontext=system_u:system_r:named_t:s0 tclass=capability
>>
>> For this I can add:
>> allow named_t self:capability { fsetid kill };
>> but I am not sure if that is okay, can anyone please advise?
>>
>> Last one I get with the mysql backend:
>> type=AVC msg=audit(12/03/2012 13:37:52.315:545) : avc:  denied  {
>> getattr } for  pid=20772 comm=pdns_server
>> path=/usr/share/mysql/charsets/Index.xml dev="dm-0" ino=8936
>> scontext=system_u:system_r:named_t:s0
>> tcontext=system_u:object_r:usr_t:s0 tclass=file
>> To allow this I will have to allow read access from named_t to usr_t,
>> would that be okay?
>
> Yes, the capabilities are a pity, but it is give and take, so all
> considering this looks ok to me
>
Ok, thank you.
I was a bit surprised that named_t already had access to a mysql 
database by the way.

PowerDNS has some more backends, next I have a question about is the 
pipe backend:
This backend executes a file specified in the config, that will echo the 
response to STDOUT. Should there be a seperate domain for that pipe 
command, or is it okay to allow exec to bin_t? For now I chose the 
latter, and my .te looks like this:
======pdns.te======
policy_module(pdns,0.0.1)

require{
	type named_t;
}

allow named_t self:capability { kill fsetid };

#gmysql backend:
bool pdns_backend_mysql true;
tunable_policy(`pdns_backend_mysql', `
	mysql_read_config(named_t)
	files_read_usr_files(named_t)
	#socket
	mysql_stream_connect(named_t)
')

bool pdns_backend_pipe false;
tunable_policy(`pdns_backend_pipe', `
	corecmd_exec_bin(named_t)
	files_read_usr_files(named_t)
')
===================
This, together with the .fc results in a working powerdns for me. If 
there are no further objections, what would be the next step to get this 
accepted in the (Fedora?) policy?
-- 
Sander

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
